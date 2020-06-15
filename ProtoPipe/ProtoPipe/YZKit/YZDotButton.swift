//
//  YZDotButton.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/6/12.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class YZDotButton: UIControl {
    
    var isChosen: Bool = false {
        willSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(clicked(sender:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clicked(sender: UIControl) {
        isChosen = !isChosen
    }
    
    override func draw(_ rect: CGRect) {
        
        let lineWidth: CGFloat = rect.width / 8
        let dotArea = CGRect(x: rect.minX + lineWidth / 2,
                             y: rect.minY + lineWidth / 2,
                             width: rect.width - lineWidth,
                             height: rect.height -  lineWidth)
        
        let dotBorder = UIBezierPath(ovalIn: dotArea)
        dotBorder.lineWidth = lineWidth
        
        UIColor(withHex: 0xcccccc).set()
        dotBorder.stroke()
        
        if isChosen {
            dotBorder.fill()

            let tick = UIBezierPath()
            tick.move(to: CGPoint(x: rect.width / 4, y: rect.height / 1.9))
            tick.addLine(to: CGPoint(x: rect.width / 2.3, y: rect.height / 1.4))
            tick.addLine(to: CGPoint(x: rect.width / 1.4, y: rect.height / 2.8))
            tick.lineWidth = lineWidth
            tick.lineCapStyle = .round
            tick.lineJoinStyle = .round
            
            UIColor(withHex: 0x191B1D).set()
            tick.stroke()
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // MARK: If size lower than 44
        if !(bounds.width < 44 && bounds.height < 44) {
            return self
        }
        
        let newRect = bounds.insetBy(dx: -8, dy: -8)
        if newRect.contains(point) {
            return self
        } else {
            return nil
        }
    }
    
}
