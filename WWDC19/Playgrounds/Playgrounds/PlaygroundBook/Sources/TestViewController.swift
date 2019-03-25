//
//  TestViewController.swift
//  Book_Sources
//
//  Created by 吉乞悠 on 2019/3/18.
//

import UIKit
import PlaygroundSupport

@objc(Book_Sources_TestViewController)
public class TestViewController: UIViewController,PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    
    typealias FilteringCompletion = ((UIImage?, Error?) -> ())
    let imagePicker = UIImagePickerController()
    
    let imageView = UIImageView()
    let applyBtn = UIButton()
    let pickerBtn = UIButton()
    
    // MARK: - LifeCycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    public func changeBgColor() {
        self.view.backgroundColor = UIColor.red
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        applyBtn.setTitle("\(self.view.frame.width)", for: .normal)
        if self.view.frame.width == 1032 {
            //view.backgroundColor = UIColor.randomColor
        } else {
            //view.backgroundColor = UIColor.black
        }
        applyBtn.backgroundColor = UIColor.randomColor
        
        applyBtn.frame = CGRect(x: 50, y: 50, width: 120, height: 50)
        pickerBtn.frame = CGRect(x: view.frame.width - 170, y: 50, width: 120, height: 50)
        imageView.frame = CGRect(x: view.center.x - 160, y: view.center.y - 120, width: 320, height: 240)
    }
    
    // MARK: - Methods
    func setupUI() {
        imageView.backgroundColor = UIColor.eeeeee
        view.addSubview(imageView)
        imageView.image = UIImage(named: "defaultImage.jpg")
        imageView.contentMode = .scaleAspectFit
        
        applyBtn.backgroundColor = UIColor.eeeeee
        view.addSubview(applyBtn)
        applyBtn.setTitle("?", for: .normal)
        applyBtn.setTitleColor(UIColor.red, for: .normal)
        applyBtn.addTarget(self, action: #selector(applyStyleTransfer), for: .touchUpInside)
        
        pickerBtn.backgroundColor = UIColor.eeeeee
        view.addSubview(pickerBtn)
        pickerBtn.addTarget(self, action: #selector(importFromLibrary), for: .touchUpInside)
    }
    
    // MARK: - Targets
    @objc func applyStyleTransfer() {
        if #available(iOS 12.0, *) {
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
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func importFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            imagePicker.modalTransitionStyle = .flipHorizontal
            present(self.imagePicker, animated: true)
        } else {
            print("Photo Library not available")
        }
    }
    
    
    // MARK: - ProcessTheImage
    @available(iOS 12.0, *)
    func process(input: UIImage, completion: @escaping FilteringCompletion) {
        
        let fixedInput = input.updateImageOrientionUpSide()
        
        let startTime = CFAbsoluteTimeGetCurrent()
        
        // Initialize the NST model
        let model = MuseMLModel()
        
        // Next steps are pretty heavy, better process them on another thread
        DispatchQueue.global().async {
            
            // 1 - Resize our input image
            guard let inputImage = fixedInput!.resize(to: CGSize(width: 480, height: 640)) else {
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

extension TestViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
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


