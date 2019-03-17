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
    
    let imageView = UIImageView()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.backgroundColor = UICOLOR_EEEEEE
        imageView.frame = CGRect(x: view.center.x - 160, y: view.center.y - 120, width: 320, height: 240)
        view.addSubview(imageView)
        
        imageView.image = UIImage(named: "defaultImage")

        guard let image = imageView.image else { return }
        
        self.process(input: image) { filteredImage, error in
            
            if let filteredImage = filteredImage {
                self.imageView.image = filteredImage
            } else if let error = error {
                //self.showError(error)
            } else {
                //self.showError(NSTError.unknown)
            }
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
