//
//  MainViewController.swift
//  YiShe
//
//  Created by 吉乞悠 on 2019/3/16.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    typealias FilteringCompletion = ((UIImage?, Error?) -> ())
    let imagePicker = UIImagePickerController()
    
    let imageView = UIImageView()
    let applyBtn = UIButton()
    let pickerBtn = UIButton()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Methods
    func setupUI() {
        imageView.backgroundColor = UICOLOR_EEEEEE
        imageView.frame = CGRect(x: view.center.x - 160, y: view.center.y - 180, width: 320, height: 240)
        view.addSubview(imageView)
        imageView.image = UIImage(named: "defaultImage")
        imageView.contentMode = .scaleAspectFit
        
        applyBtn.backgroundColor = UICOLOR_EEEEEE
        applyBtn.frame = CGRect(x: view.center.x - 60, y: view.center.y + 150, width: 120, height: 50)
        view.addSubview(applyBtn)
        applyBtn.addTarget(self, action: #selector(applyStyleTransfer), for: .touchUpInside)
        
        pickerBtn.backgroundColor = UICOLOR_EEEEEE
        pickerBtn.frame = CGRect(x: view.center.x - 60, y: view.center.y + 80, width: 120, height: 50)
        view.addSubview(pickerBtn)
        pickerBtn.addTarget(self, action: #selector(importFromLibrary), for: .touchUpInside)
    }
    
    // MARK: - Targets
    @objc func applyStyleTransfer() {
        guard let image = imageView.image else { return }
        
        self.process(input: image) { filteredImage, error in
            
            if let filteredImage = filteredImage {
                self.imageView.image = filteredImage
            } else if let error = error {
                print(error)
            } else {
                print(NSTError.unknown)
            }
        }
    }
    
    @objc func importFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true)
        } else {
            print("Photo Library not available")
        }
    }
    
    // MARK: - ProcessTheImage
    func process(input: UIImage, completion: @escaping FilteringCompletion) {
        
        
        let startTime = CFAbsoluteTimeGetCurrent()
        
        // Initialize the NST model
        let model = STMuseMLModel()
        
        // Next steps are pretty heavy, better process them on another thread
        DispatchQueue.global().async {
            
            // 1 - Resize our input image
            guard let inputImage = input.resize(to: CGSize(width: 480, height: 640)) else {
                completion(nil, NSTError.resizeError)
                return
            }
            
            // 2 - Transform our UIImage to a PixelBuffer of appropriate size
            guard let cvBufferInput = inputImage.pixelBuffer() else {
                completion(nil, NSTError.pixelBufferError)
                return
            }
            
            // 3 - Feed that PixelBuffer to the model (this is where the actual magic happens)
            guard let output = try? model.prediction(input1: cvBufferInput) else {
                completion(nil, NSTError.predictionError)
                return
            }
            
            // 4 - Transform PixelBuffer output to UIImage
            guard let outputImage = UIImage(pixelBuffer: output.output1) else {
                completion(nil, NSTError.pixelBufferError)
                return
            }
            
            // 5 - Resize result back to the original input size
            guard let finalImage = outputImage.resize(to: input.size) else {
                completion(nil, NSTError.resizeError)
                return
            }
            
            // 6 - Hand result to main thread
            DispatchQueue.main.async {
                
                let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
                print("Time elapsed for NST process: \(timeElapsed) s.")
                
                completion(finalImage, nil)
            }
        }
    }
    
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let pickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            self.imageView.image = pickedImage
            self.imageView.backgroundColor = .clear
        }
        self.dismiss(animated: true)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
