//
//  PuzzleAnimator.swift
//  2048
//
//  Created by 吉乞悠 on 2020/2/24.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import Foundation
import UIKit

class PuzzleAnimator {
    
    func expandCubeView(_ cubeView: PuzzleCubeView, expandCubeViewCompletion: @escaping () -> Void) {
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 20,
            options: [],
            animations:
        {   // Animation Content
            assert(cubeView.cubeStatus == .Shrinked , "cubeStatus should be .Shrinked")
            cubeView.cubeStatus = .Expanded
        }, completion: { (isFinished) in
            expandCubeViewCompletion()
        })
    }
    
    func expandCubeViews(_ cubeViews: [PuzzleCubeView], expandCubeViewsCompletion: @escaping () -> Void) {
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 20,
            options: [],
            animations:
        {   // Animation Content
            cubeViews.forEach { (cubeView) in
                assert(cubeView.cubeStatus == .Shrinked , "cubeStatus should be .Shrinked")
                cubeView.cubeStatus = .Expanded
            }
        }, completion: { (isFinished) in
            expandCubeViewsCompletion()
        })
    }
    
    func vanishAllCubeViews(_ cubeViews: [[PuzzleCubeView?]], vanishAllCubeViewsCompletion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5,
                       delay: 2,
                       options: [],
                       animations:
        {   // Animation Content
            for cubeViewLine in cubeViews {
                for cubeView in cubeViewLine {
                    if let cubeView = cubeView {
                        cubeView.alpha = 0
                    }
                }
            }
        }) { (finish) in
            vanishAllCubeViewsCompletion()
        }
    }
    
    func moveCubeViews(_ cubeViews: [[PuzzleCubeView?]],
                       targetPosition: [[CGPoint?]],
                       moveCubeViewsCompletion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.15, delay: 0, options: [], animations: {
            for i in 0...cubeViews.count - 1 {
                for j in 0...cubeViews[i].count - 1 {
                    if let position = targetPosition[i][j] {
                        cubeViews[i][j]?.center = position
                    }
                }
            }
        }) { (finish) in
            moveCubeViewsCompletion()
        }
    }
    
}
