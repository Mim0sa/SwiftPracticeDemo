//
//  YZDotButton.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/6/12.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class YZDotButton: UIControl {
    
    override func draw(_ rect: CGRect) {
        
        UIColor(withHex: 0xdddddd).set()
        
        let lineWidth: CGFloat = rect.width / 10
        let area = CGRect(x: rect.minX + lineWidth / 2,
                          y: rect.minY + lineWidth / 2,
                          width: rect.width - lineWidth,
                          height: rect.height -  lineWidth)
        
        let path = UIBezierPath(ovalIn: area)
        path.fill(with: .overlay, alpha: 1)
        path.lineWidth = lineWidth
        path.stroke()
        
        UIColor(withHex: 0xdddddd).set()
        
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: rect.width / 4.5, y: rect.height / 1.9))
        path2.addLine(to: CGPoint(x: rect.width / 2.3, y: rect.height / 1.4))
        path2.addLine(to: CGPoint(x: rect.width / 1.4, y: rect.height / 2.9))
        path2.lineWidth = lineWidth
        path2.lineCapStyle = .round
        path2.lineJoinStyle = .round

        path2.stroke()
    }

}
