//
//  PixelImage.swift
//  Pixel
//
//  Created by 吉乞悠 on 2020/4/8.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import Foundation
import UIKit

struct PixelImage {
    
    var size: CGSize
    var lattice: [[UInt8]]
    
    init(size: CGSize, lattice: [[UInt8]]) {
        self.size = size
        self.lattice = lattice
    }
    
}

extension UIView {
    
    /// 获取特定位置的颜色
    ///
    /// - parameter at: 位置
    ///
    /// - returns: 颜色
    func pickColor(at position: CGPoint) -> UIColor? {
        
        // 用来存放目标像素值
        var pixel = [UInt8](repeatElement(0, count: 4))
        // 颜色空间为 RGB，这决定了输出颜色的编码是 RGB 还是其他（比如 YUV）
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        // 设置位图颜色分布为 RGBA
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        guard let context = CGContext(data: &pixel, width: 1, height: 1,
                                      bitsPerComponent: 8, bytesPerRow: 4,
                                      space: colorSpace, bitmapInfo: bitmapInfo) else {
            return nil
        }
        // 设置 context 原点偏移为目标位置所有坐标
        context.translateBy(x: -position.x, y: -position.y)
        // 将图像渲染到 context 中
        layer.render(in: context)
        
        return UIColor(red: CGFloat(pixel[0]) / 255.0,
                       green: CGFloat(pixel[1]) / 255.0,
                       blue: CGFloat(pixel[2]) / 255.0,
                       alpha: CGFloat(pixel[3]) / 255.0)
    }
}
