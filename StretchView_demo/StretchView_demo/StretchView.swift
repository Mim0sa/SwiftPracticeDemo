//
//  StretchView.swift
//  StretchView_demo
//
//  Created by 吉乞悠 on 2018/11/19.
//  Copyright © 2018 吉乞悠. All rights reserved.
//

import UIKit

class StretchView: UIView {
    
    //缩放倍率
    private let scalingRatio:CGFloat = 1.5
    
    //动画时间
    private let animationDuration = 0.4
    
    //是否拉伸
    private var isStretch = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //给UIView添加点击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scale))
        self.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func scale(){
        //根据isStretch来判断拉伸还是缩小
        isStretch ? shrinkTheView() : stretchTheView()
    }
    
    @objc private func stretchTheView(){
        //置顶选中view的层级
        self.superview?.bringSubviewToFront(self)
        
        //获取当前尺寸
        let x = self.frame.origin.x
        //let y = self.frame.origin.y
        let width = self.frame.width
        let height = self.frame.height
        
        //拉伸动画
        UIView.animate(withDuration: animationDuration, animations: {
            //frame形变
            self.frame.origin.x = x - (self.scalingRatio - 1) / 2 * width
            self.frame.size.width = self.scalingRatio * width
            self.frame.size.height = self.scalingRatio * height
            
            //阴影（没有动画）???
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize()
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2
            
            //圆角
            self.layer.cornerRadius = 15
            
        })
        
        isStretch = !isStretch
        
    }
    
    @objc private func shrinkTheView(){
        //获取当前尺寸
        let x = self.frame.origin.x
        //let y = self.frame.origin.y
        let width = self.frame.width
        let height = self.frame.height
        
        //缩小动画
        UIView.animate(withDuration: animationDuration, animations: {
            //frame形变
            self.frame.origin.x = x + (width - width / self.scalingRatio) / 2
            self.frame.size.width = width / self.scalingRatio
            self.frame.size.height = height / self.scalingRatio
            
            //阴影（没有动画）???
            self.layer.shadowRadius = 0
            
            //圆角
            self.layer.cornerRadius = 0
            
        })
        
        isStretch = !isStretch
        
    }
    
}
