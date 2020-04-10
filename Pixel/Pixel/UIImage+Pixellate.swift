//
//  UIImage+Pixellate.swift
//  Pixel
//
//  Created by 吉乞悠 on 2020/4/7.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

extension UIImage {
    
    func pixellated(scale: Int = 8) -> UIImage? { guard
        let ciImage = CIImage(image: self),
        let filter = CIFilter(name: "CIPixellate")
        else { return nil }
        
        filter.setValue(ciImage, forKey: "inputImage")
        filter.setValue(scale, forKey: "inputScale")
        
        guard let output = filter.outputImage else { return nil }
        return UIImage(ciImage: output)
    }
    
}
