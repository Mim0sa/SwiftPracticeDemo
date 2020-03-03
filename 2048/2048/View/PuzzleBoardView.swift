//
//  PuzzleBoardView.swift
//  2048
//
//  Created by 吉乞悠 on 2020/2/28.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import Foundation
import UIKit

class PuzzleBoardView: UIView {
    
    // MARK: - Constants
    var cubeGap: CGFloat = 0
    var cubeEdge: CGFloat = 0
    
    // MARK: - Varibles
    var locationPionts: [CGPoint] = []
    var backLayers: [CALayer] = []
    
    // MARK: - Initialize
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        cubeGap = frame.width / 23
        cubeEdge = cubeGap * 4.5
        
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 3
        layer.cornerRadius = 14
        
        locationPionts = generateLocationPionts()
        backLayers = generateBackLayer()
    }
    
    // MARK: - LayoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = UIColor("BoardView_Shadow")?.cgColor(with: traitCollection)
        backLayers.forEach { (layer) in
            layer.backgroundColor = UIColor("CubeLayer_Background")?.cgColor(with: traitCollection)
        }
    }
    
    // MARK: - UI Prep
    func generateLocationPionts() -> [CGPoint] {
         var locationPionts: [CGPoint] = []
         for j in 1...4 {
             for i in 1...4 {
                 let position = CGPoint(x: cubeGap * CGFloat(i) + cubeEdge * (CGFloat(i) - 0.5),
                                        y: cubeGap * CGFloat(j) + cubeEdge * (CGFloat(j) - 0.5))
                 locationPionts.append(position)
             }
         }
         return locationPionts
     }
    
    func generateBackLayer() -> [CALayer] {
        var backLayers: [CALayer] = []
        for i in 1...16 {
            let backLayer = CALayer()
            backLayer.cornerRadius = 14
            backLayer.frame.size = CGSize(width: cubeEdge - 2, height: cubeEdge - 2)
            backLayer.position = locationPionts[i - 1]
            layer.addSublayer(backLayer)
            backLayers.append(backLayer)
        }
        return backLayers
    }
    
}
