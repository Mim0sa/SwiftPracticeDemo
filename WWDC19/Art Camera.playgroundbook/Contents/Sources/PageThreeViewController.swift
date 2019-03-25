//
//  PageTwoViewController.swift
//  Book_Sources
//
//  Created by 吉乞悠 on 2019/3/23.
//

import UIKit
import PlaygroundSupport

@objc(Book_Sources_PageThreeViewController)
public class PageThreeViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer, CAAnimationDelegate {
    
    typealias FilteringCompletion = ((UIImage?, Error?) -> ())
    
    @IBOutlet weak var defaultCamera: UIImageView!
    @IBOutlet weak var targetCamera: UIImageView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var parentBtn: UIButton!
    
    @IBOutlet weak var pickedImageView: UIImageView!
    
    public var passImage = UIImage()
    
    let targetImage = UIImageView()
    let imagePicker = UIImagePickerController()
    
    var currentSize: CGSize = CGSize() {
        didSet {
            centerCircleFrame = CGRect(x: currentSize.width/2 - 15, y: currentSize.height/2, width: 2, height: 2)
            targetCameraMask.path = UIBezierPath(ovalIn: centerCircleFrame).cgPath
        }
    }
    
    let targetCameraMask = CAShapeLayer()
    var centerCircleFrame = CGRect()
    var isProcessing = false
    
    public var type: Type?
    public var source: Source?
    public var level: Level?
    
    public var photoPaper: PhotoPaper?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        parentBtn.isEnabled = false
        parentBtn.addTarget(self, action: #selector(gotoAR), for: .touchUpInside)
        
//        type = Type.Muse
//        source = Source.fromLibrary
//        level = Level.aLittleBit
//        launch()
    }
    
    @objc func gotoAR() {
        if #available(iOS 11.0, *) {
            let vc = ARViewController()
            self.present(vc, animated: true) {
                vc.passImage = self.passImage
                vc.photoPaper = self.photoPaper
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    public func launch() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.launchAfter(self.source!, sticker: self.type!)
        }
    }
    
    public func launchAfter(_ imageSource:Source, sticker:Type) {
        var imgStr = ""
        switch sticker {
        case .Wave:
            imgStr = "camera_wave"
        case .Princess:
            imgStr = "camera_princess"
        case .StarryNight:
            imgStr = "camera_starry"
        case .Scream:
            imgStr = "camera_scream"
        case .Wreck:
            imgStr = "camera_wreck"
        case .Muse:
            imgStr = "camera_muse"
        case .Udnie:
            imgStr = "camera_udnie"
        }
        self.targetCamera.image = UIImage(named: imgStr)
        self.showTargetCamera()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if !isProcessing {
            currentSize = CGSize(width: view.frame.width, height: view.frame.height)
            hintLabel.text = "Launching..."
        }
    }
    
    func setupUI() {
        targetCamera.layer.mask = targetCameraMask
    }
    
    func showTargetCamera() {
        hintLabel.text = "Switching the camera..."
        
        var newR: CGFloat = 0
        if currentSize.height > currentSize.width {
            newR = currentSize.width
        } else {
            newR = currentSize.height
        }
        
        //path是大圆的路径
        let path = UIBezierPath(ovalIn: centerCircleFrame.insetBy(dx: -newR, dy: -newR))
        
        //设置mask路径，保持动画完成后的状态
        targetCameraMask.path = path.cgPath
        
        let maskAnimation = CABasicAnimation(keyPath: "path")
        maskAnimation.delegate = self
        maskAnimation.fromValue = UIBezierPath(ovalIn: centerCircleFrame).cgPath
        maskAnimation.toValue = path
        maskAnimation.duration = 3;
        
        //添加动画
        targetCameraMask.add(maskAnimation, forKey: "path")
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        hintLabel.text = "Switch Success!"
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.importFromCamera()
        }
    }
    
    @objc func importFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            if source == .fromCamera {
                imagePicker.sourceType = .camera
            } else {
                imagePicker.sourceType = .photoLibrary
            }
            imagePicker.modalTransitionStyle = .flipHorizontal
            present(self.imagePicker, animated: true)
        } else {
            print("Photo Library not available")
        }
    }
    
    public func animationDidStart(_ anim: CAAnimation) {
        isProcessing = true
    }
    
    func getOriginImage(image: UIImage) {
        self.defaultCamera.removeFromSuperview()
        self.targetCamera.removeFromSuperview()
        
        applyStyleTransfer(image: image)
        pickedImageView.alpha = 1
        pickedImageView.image = image
        hintLabel.text = "processing..."
    }
    
    func filterImage(imageView: UIImageView, filteredImage: UIImage) {
        let rct = imageView.frame
        let filteredView = UIView()
        filteredView.backgroundColor = UIColor.clear
        filteredView.frame = CGRect(x: 0, y: 0, width: 0, height: rct.height)
        filteredView.clipsToBounds = true
        pickedImageView.addSubview(filteredView)
        let filteredImageView = UIImageView()
        filteredImageView.image = filteredImage
        filteredImageView.frame = CGRect(x: 0, y: 0, width: rct.width, height: rct.height)
        filteredImageView.contentMode = .scaleAspectFit
        filteredView.addSubview(filteredImageView)
        
        UIView.animate(withDuration: 5, animations: {
            filteredView.frame = CGRect(x: 0, y: 0, width: rct.width, height: rct.height)
        }) { (isFinished) in
            //self.applyStyleTransfer(image: filteredImage)
            self.pickedImageView.image = filteredImageView.image
            filteredView.removeFromSuperview()
            self.parentBtn.isEnabled = true
            self.passImage = filteredImage
            self.hintLabel.text = "Click the picture!"
        }
    }
    
}

extension PageThreeViewController {
    @objc func applyStyleTransfer(image: UIImage?) {
        if #available(iOS 12.0, *) {
            guard let image = image else { return }
            //starry
            self.process(input: image) { filteredImage, error in
                if let filteredImage = filteredImage {
                    if self.level!.rawValue != 1 {
                        self.level = Level(rawValue: self.level!.rawValue - 1)
                        self.applyStyleTransfer(image: filteredImage)
                    } else {
                        self.filterImage(imageView: self.pickedImageView, filteredImage: filteredImage)
                    }
                } else if let error = error {
                    print(error)
                } else {
                    print(NSTError.unknown)
                }
            }
            //others
        } else {
            // Fallback on earlier versions
        }
    }
    
    // MARK: - ProcessTheImage
    //    @available(iOS 12.0, *)
    //    func process(input: UIImage, completion: @escaping FilteringCompletion) {
    //
    //        let fixedInput = input.updateImageOrientionUpSide()
    //
    //        //let startTime = CFAbsoluteTimeGetCurrent()
    //
    //        // Initialize the NST model
    //        let model = StarryNightMLModel()
    //
    //        // Next steps are pretty heavy, better process them on another thread
    //        DispatchQueue.global().async {
    //
    //            // 1 - Resize our input image
    //            guard let inputImage = fixedInput!.resize(to: CGSize(width: 720, height: 720)) else {
    //                completion(nil, NSTError.resizeError)
    //                return
    //            }
    //
    //            // 2 - Transform our UIImage to a PixelBuffer of appropriate size
    //            guard let cvBufferInput = inputImage.pixelBuffer() else {
    //                completion(nil, NSTError.pixelBufferError)
    //                return
    //            }
    //
    //            // 3 - Feed that PixelBuffer to the model (this is where the actual magic happens)
    //            guard let output = try? model.prediction(inputImage: cvBufferInput) else {
    //                completion(nil, NSTError.predictionError)
    //                return
    //            }
    //
    //            // 4 - Transform PixelBuffer output to UIImage
    //            guard let outputImage = UIImage(pixelBuffer: output.outputImage) else {
    //                completion(nil, NSTError.pixelBufferError)
    //                return
    //            }
    //
    //            // 5 - Resize result back to the original input size
    //            guard let finalImage = outputImage.resize(to: input.size) else {
    //                completion(nil, NSTError.resizeError)
    //                return
    //            }
    //
    //            // 6 - Hand result to main thread
    //            DispatchQueue.main.async {
    //
    //                //let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    //                //print("Time elapsed for NST process: \(timeElapsed) s.")
    //
    //                completion(finalImage, nil)
    //            }
    //        }
    //    }
    
    @available(iOS 12.0, *)
    func process(input: UIImage, completion: @escaping FilteringCompletion) {
        
        let fixedInput = input.updateImageOrientionUpSide()
        
        //let startTime = CFAbsoluteTimeGetCurrent()
        
        // Initialize the NST model
        let sticker: Type = type!
        
        switch sticker {
        case .Wave:
            let model = WaveMLModel()
            DispatchQueue.global().async {
                guard let inputImage = fixedInput!.resize(to: CGSize(width: 480, height: 640)) else {
                    completion(nil, NSTError.resizeError);return}
                guard let cvBufferInput = inputImage.pixelBuffer() else {
                    completion(nil, NSTError.pixelBufferError);return}
                guard let output = try? model.prediction(input1: cvBufferInput) else {
                    completion(nil, NSTError.predictionError);return}
                guard let outputImage = UIImage(pixelBuffer: output.output1) else {
                    completion(nil, NSTError.pixelBufferError);return}
                guard let finalImage = outputImage.resize(to: input.size) else {
                    completion(nil, NSTError.resizeError);return}
                DispatchQueue.main.async { completion(finalImage, nil) }
            }
        case .Princess:
            let model = PrincessMLModel()
            DispatchQueue.global().async {
                guard let inputImage = fixedInput!.resize(to: CGSize(width: 480, height: 640)) else {
                    completion(nil, NSTError.resizeError);return}
                guard let cvBufferInput = inputImage.pixelBuffer() else {
                    completion(nil, NSTError.pixelBufferError);return}
                guard let output = try? model.prediction(input1: cvBufferInput) else {
                    completion(nil, NSTError.predictionError);return}
                guard let outputImage = UIImage(pixelBuffer: output.output1) else {
                    completion(nil, NSTError.pixelBufferError);return}
                guard let finalImage = outputImage.resize(to: input.size) else {
                    completion(nil, NSTError.resizeError);return}
                DispatchQueue.main.async { completion(finalImage, nil) }
            }
        case .StarryNight:
            let model = StarryNightMLModel()
            DispatchQueue.global().async {
                guard let inputImage = fixedInput!.resize(to: CGSize(width: 720, height: 720)) else {
                    completion(nil, NSTError.resizeError);return}
                guard let cvBufferInput = inputImage.pixelBuffer() else {
                    completion(nil, NSTError.pixelBufferError);return}
                guard let output = try? model.prediction(inputImage: cvBufferInput) else {
                    completion(nil, NSTError.predictionError);return}
                guard let outputImage = UIImage(pixelBuffer: output.outputImage) else {
                    completion(nil, NSTError.pixelBufferError);return}
                guard let finalImage = outputImage.resize(to: input.size) else {
                    completion(nil, NSTError.resizeError);return}
                DispatchQueue.main.async { completion(finalImage, nil) }
            }
        case .Scream:
            let model = ScreamMLModel()
            DispatchQueue.global().async {
                guard let inputImage = fixedInput!.resize(to: CGSize(width: 480, height: 640)) else {
                    completion(nil, NSTError.resizeError);return}
                guard let cvBufferInput = inputImage.pixelBuffer() else {
                    completion(nil, NSTError.pixelBufferError);return}
                guard let output = try? model.prediction(input1: cvBufferInput) else {
                    completion(nil, NSTError.predictionError);return}
                guard let outputImage = UIImage(pixelBuffer: output.output1) else {
                    completion(nil, NSTError.pixelBufferError);return}
                guard let finalImage = outputImage.resize(to: input.size) else {
                    completion(nil, NSTError.resizeError);return}
                DispatchQueue.main.async { completion(finalImage, nil) }
            }
        case .Wreck:
            let model = ShipwreckMLModel()
            DispatchQueue.global().async {
                guard let inputImage = fixedInput!.resize(to: CGSize(width: 480, height: 640)) else {
                    completion(nil, NSTError.resizeError);return}
                guard let cvBufferInput = inputImage.pixelBuffer() else {
                    completion(nil, NSTError.pixelBufferError);return}
                guard let output = try? model.prediction(input1: cvBufferInput) else {
                    completion(nil, NSTError.predictionError);return}
                guard let outputImage = UIImage(pixelBuffer: output.output1) else {
                    completion(nil, NSTError.pixelBufferError);return}
                guard let finalImage = outputImage.resize(to: input.size) else {
                    completion(nil, NSTError.resizeError);return}
                DispatchQueue.main.async { completion(finalImage, nil) }
            }
        case .Udnie:
            let model = UdnieMLModel()
            DispatchQueue.global().async {
                guard let inputImage = fixedInput!.resize(to: CGSize(width: 480, height: 640)) else {
                    completion(nil, NSTError.resizeError);return}
                guard let cvBufferInput = inputImage.pixelBuffer() else {
                    completion(nil, NSTError.pixelBufferError);return}
                guard let output = try? model.prediction(input1: cvBufferInput) else {
                    completion(nil, NSTError.predictionError);return}
                guard let outputImage = UIImage(pixelBuffer: output.output1) else {
                    completion(nil, NSTError.pixelBufferError);return}
                guard let finalImage = outputImage.resize(to: input.size) else {
                    completion(nil, NSTError.resizeError);return}
                DispatchQueue.main.async { completion(finalImage, nil) }
            }
        case .Muse:
            let model = MuseMLModel()
            DispatchQueue.global().async {
                guard let inputImage = fixedInput!.resize(to: CGSize(width: 480, height: 640)) else {
                    completion(nil, NSTError.resizeError);return}
                guard let cvBufferInput = inputImage.pixelBuffer() else {
                    completion(nil, NSTError.pixelBufferError);return}
                guard let output = try? model.prediction(input1: cvBufferInput) else {
                    completion(nil, NSTError.predictionError);return}
                guard let outputImage = UIImage(pixelBuffer: output.output1) else {
                    completion(nil, NSTError.pixelBufferError);return}
                guard let finalImage = outputImage.resize(to: input.size) else {
                    completion(nil, NSTError.resizeError);return}
                DispatchQueue.main.async { completion(finalImage, nil) }
            }
        }
        
    }
}

extension PageThreeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let pickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            self.getOriginImage(image: pickedImage)
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
