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
            delay: 1,
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
    
}
