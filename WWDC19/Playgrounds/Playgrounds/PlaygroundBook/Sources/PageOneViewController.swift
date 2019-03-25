//
//  PageOneViewController.swift
//  Book_Sources
//
//  Created by 吉乞悠 on 2019/3/21.
//

import UIKit
import PlaygroundSupport

@objc(Book_Sources_PageOneViewController)
public class PageOneViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer, CAAnimationDelegate {
    
    typealias FilteringCompletion = ((UIImage?, Error?) -> ())
    
    @IBOutlet weak var defaultCamera: UIImageView!
    @IBOutlet weak var starryCamera: UIImageView!
    @IBOutlet weak var hintLabel: UILabel!
    
    let targetImage = UIImageView()
    
    var currentSize: CGSize = CGSize() {
        didSet {
            centerCircleFrame = CGRect(x: currentSize.width/2 - 15, y: currentSize.height/2, width: 2, height: 2)
            starryCameraMask.path = UIBezierPath(ovalIn: centerCircleFrame).cgPath
        }
    }
    
    let starryCameraMask = CAShapeLayer()
    
    var centerCircleFrame = CGRect()
    var isProcessing = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyStyleTransfer()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.showStarryCamera()
        }
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if !isProcessing {
            currentSize = CGSize(width: view.frame.width, height: view.frame.height)
            hintLabel.text = "Launching..."
        }
    }
    
    func setupUI() {
        starryCamera.layer.mask = starryCameraMask
    }

    func showStarryCamera() {
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
        starryCameraMask.path = path.cgPath

        let maskAnimation = CABasicAnimation(keyPath: "path")
        maskAnimation.delegate = self
        maskAnimation.fromValue = UIBezierPath(ovalIn: centerCircleFrame).cgPath
        maskAnimation.toValue = path
        maskAnimation.duration = 3;

        //添加动画
        starryCameraMask.add(maskAnimation, forKey: "path")
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        hintLabel.text = "Switch Success!"
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.shiningAndClip()
        }
    }
    
    public func animationDidStart(_ anim: CAAnimation) {
        isProcessing = true
    }
    
    func shiningAndClip() {
        let shiningView = UIView(frame: CGRect(x: 0, y: 0, width: currentSize.width, height: currentSize.height))
        shiningView.backgroundColor = UIColor.white
        shiningView.alpha = 0
        view.addSubview(shiningView)
        // 1
        shiningView.alpha = 0.4
        UIView.animate(withDuration: 0.28, animations: {
            shiningView.alpha = 0
        }) { (isFinished) in
            // 2
            shiningView.alpha = 0.6
            UIView.animate(withDuration: 0.26, animations: {
                shiningView.alpha = 0
            }) { (isFinished) in
                // 3
                shiningView.alpha = 0.8
                UIView.animate(withDuration: 0.24, animations: {
                    shiningView.alpha = 0
                }) { (isFinished) in
                    // 4
                    self.defaultCamera.removeFromSuperview()
                    shiningView.alpha = 1
                    UIView.animate(withDuration: 2, animations: {
                        shiningView.alpha = 0
                    }) { (isFinished) in
                        self.printTargetImage()
                        self.hintLabel.text = "Printing..."
                    }
                }
            }
        }
    }
    
    func printTargetImage() {
        var imageH: CGFloat = 0
        var imageW: CGFloat = 0
        if currentSize.height > currentSize.width {
            imageW = currentSize.width - 150
            imageH = imageW/28*22
        } else {
            imageH = currentSize.height - 225
            imageW = imageH*28/22
        }
        targetImage.frame = CGRect(x: currentSize.width/2-imageW/3*2/2,
                                   y: currentSize.height/2-imageH/3*2/2,
                                   width: imageW/3*2,
                                   height: imageH/3*2)
        targetImage.contentMode = .scaleAspectFit
        targetImage.layer.shadowColor = UIColor.black.cgColor
        targetImage.layer.shadowRadius = 5
        targetImage.layer.shadowOpacity = 0.5
        targetImage.layer.shadowOffset = CGSize()
        view.insertSubview(targetImage, belowSubview: starryCamera)
        
        UIView.animate(withDuration: 2, animations: {
            self.starryCamera.transform = CGAffineTransform(translationX: 0, y: -imageH/2/6*5)
            self.targetImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.targetImage.transform = self.targetImage.transform.translatedBy(x: 0, y: imageH/2/6*5)
        }) { (isFinished) in
            UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
                self.targetImage.transform = CGAffineTransform.identity
                self.starryCamera.alpha = 0
            }, completion: { (isFinished) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.targetImage.transform = self.targetImage.transform.scaledBy(x: 1.5, y: 1.5)
                }, completion: { (isFinished) in
                    self.hintLabel.text = "Woooooooooo!!!"
                    PlaygroundPage.current.assessmentStatus = .pass(message: "Great job! You used this camera to generate **a StarryNight style photo**! Now go to [The Next Page](@next)")
                })
            })
        }
    }
    
}

extension PageOneViewController {
    @objc func applyStyleTransfer() {
        if #available(iOS 12.0, *) {
            guard let image = UIImage(named: "defaultImage.jpg") else { return }
            self.process(input: image) { filteredImage, error in
                if let filteredImage = filteredImage {
                    self.targetImage.image = filteredImage
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
    
    // MARK: - ProcessTheImage
    @available(iOS 12.0, *)
    func process(input: UIImage, completion: @escaping FilteringCompletion) {
        
        let fixedInput = input.updateImageOrientionUpSide()
        
        //let startTime = CFAbsoluteTimeGetCurrent()
        
        // Initialize the NST model
        let model = StarryNightMLModel()
        
        // Next steps are pretty heavy, better process them on another thread
        DispatchQueue.global().async {
            
            // 1 - Resize our input image
            guard let inputImage = fixedInput!.resize(to: CGSize(width: 720, height: 720)) else {
                completion(nil, NSTError.resizeError)
                return
            }
            
            // 2 - Transform our UIImage to a PixelBuffer of appropriate size
            guard let cvBufferInput = inputImage.pixelBuffer() else {
                completion(nil, NSTError.pixelBufferError)
                return
            }
            
            // 3 - Feed that PixelBuffer to the model (this is where the actual magic happens)
            guard let output = try? model.prediction(inputImage: cvBufferInput) else {
                completion(nil, NSTError.predictionError)
                return
            }
            
            // 4 - Transform PixelBuffer output to UIImage
            guard let outputImage = UIImage(pixelBuffer: output.outputImage) else {
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
                
                //let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
                //print("Time elapsed for NST process: \(timeElapsed) s.")
                
                completion(finalImage, nil)
            }
        }
    }
}
