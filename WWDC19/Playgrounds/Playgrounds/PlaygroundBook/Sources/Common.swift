//
//  Common.swift
//  Book_Sources
//
//  Created by 吉乞悠 on 2019/3/17.
//

import Foundation
import PlaygroundSupport
import UIKit
import VideoToolbox

public enum Type {
    case Wave
    case Princess
    case StarryNight
    case Scream
    case Wreck
    case Udnie
    case Muse
}

public enum Source {
    case fromCamera
    case fromLibrary
}

public enum Level: Int {
    case aLittleBit = 1
    case better = 2
    case muchMore = 3
}

public enum PhotoPaper {
    case twitter
    case polaroid
    case photoFrame
}

// MARK: - Constant
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

// MARK: - UIColor
extension UIColor {
    static var randomColor: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
    static var eeeeee = UIColor.init(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
}

// MARK: - NSTError
public enum NSTError : Error {
    case unknown
    case resizeError
    case pixelBufferError
    case predictionError
}

extension NSTError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .resizeError:
            return "Resizing failed"
        case .pixelBufferError:
            return "Pixel Buffer conversion failed"
        case .predictionError:
            return "CoreML prediction failed"
        }
    }
}

// MARK: - UIImage + Resize
extension UIImage {
    
    // Resizeing using CoreGraphics
    func resize(to newSize:CGSize) -> UIImage? {
        
        var resultImage = self
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, 1.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else { return resultImage }
        resultImage = resizedImage
        UIGraphicsEndImageContext()
        
        return resultImage
    }
}

// MARK: - UIImage + FixOrientation
extension UIImage {
    func updateImageOrientionUpSide() -> UIImage? {
        if self.imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        UIGraphicsEndImageContext()
        return nil
    }
}

// MARK: - UIImage + CoreML
extension UIImage {
    
    /**
     Resizes the image to width x height and converts it to an RGB CVPixelBuffer.
     */
    public func pixelBuffer() -> CVPixelBuffer? {
        return pixelBuffer(width: Int(self.size.width), height: Int(self.size.height))
    }
    
    /**
     Resizes the image to width x height and converts it to an RGB CVPixelBuffer.
     */
    public func pixelBuffer(width: Int, height: Int) -> CVPixelBuffer? {
        return pixelBuffer(width: width, height: height,
                           pixelFormatType: kCVPixelFormatType_32ARGB,
                           colorSpace: CGColorSpaceCreateDeviceRGB(),
                           alphaInfo: .noneSkipFirst)
    }
    
    func pixelBuffer(width: Int, height: Int, pixelFormatType: OSType,
                     colorSpace: CGColorSpace, alphaInfo: CGImageAlphaInfo) -> CVPixelBuffer? {
        var maybePixelBuffer: CVPixelBuffer?
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
                     kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue]
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                         width,
                                         height,
                                         pixelFormatType,
                                         attrs as CFDictionary,
                                         &maybePixelBuffer)
        
        guard status == kCVReturnSuccess, let pixelBuffer = maybePixelBuffer else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer)
        
        guard let context = CGContext(data: pixelData,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer),
                                      space: colorSpace,
                                      bitmapInfo: alphaInfo.rawValue)
            else {
                return nil
        }
        
        UIGraphicsPushContext(context)
        context.translateBy(x: 0, y: CGFloat(height))
        context.scaleBy(x: 1, y: -1)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        UIGraphicsPopContext()
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        return pixelBuffer
    }
    
    /**
     Creates a new UIImage from a CVPixelBuffer.
     NOTE: This only works for RGB pixel buffers, not for grayscale.
     */
    public convenience init?(pixelBuffer: CVPixelBuffer) {
        var cgImage: CGImage?
        VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &cgImage)
        
        if let cgImage = cgImage {
            self.init(cgImage: cgImage)
        } else {
            return nil
        }
    }
    
    /**
     Creates a new UIImage from a CVPixelBuffer, using Core Image.
     */
    public convenience init?(pixelBuffer: CVPixelBuffer, context: CIContext) {
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let rect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer),
                          height: CVPixelBufferGetHeight(pixelBuffer))
        if let cgImage = context.createCGImage(ciImage, from: rect) {
            self.init(cgImage: cgImage)
        } else {
            return nil
        }
    }
    
    /**
     Creates a new UIImage from an array of RGBA bytes.
     */
    @nonobjc public class func fromByteArrayRGBA(_ bytes: [UInt8],
                                                 width: Int,
                                                 height: Int,
                                                 scale: CGFloat = 0,
                                                 orientation: UIImage.Orientation = .up) -> UIImage? {
        return fromByteArray(bytes, width: width, height: height,
                             scale: scale, orientation: orientation,
                             bytesPerRow: width * 4,
                             colorSpace: CGColorSpaceCreateDeviceRGB(),
                             alphaInfo: .premultipliedLast)
    }
    
    @nonobjc class func fromByteArray(_ bytes: [UInt8],
                                      width: Int,
                                      height: Int,
                                      scale: CGFloat,
                                      orientation: UIImage.Orientation,
                                      bytesPerRow: Int,
                                      colorSpace: CGColorSpace,
                                      alphaInfo: CGImageAlphaInfo) -> UIImage? {
        var image: UIImage?
        bytes.withUnsafeBytes { ptr in
            if let context = CGContext(data: UnsafeMutableRawPointer(mutating: ptr.baseAddress!),
                                       width: width,
                                       height: height,
                                       bitsPerComponent: 8,
                                       bytesPerRow: bytesPerRow,
                                       space: colorSpace,
                                       bitmapInfo: alphaInfo.rawValue),
                let cgImage = context.makeImage() {
                image = UIImage(cgImage: cgImage, scale: scale, orientation: orientation)
            }
        }
        return image
    }
}
