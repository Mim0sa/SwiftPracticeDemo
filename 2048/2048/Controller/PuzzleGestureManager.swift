//
//  PuzzleGestureManager.swift
//  2048
//
//  Created by 吉乞悠 on 2020/3/4.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import Foundation
import UIKit

protocol PuzzleGestureManagerDelegate: class {
    
    func puzzleGestureRecognizerResponse(with direction: PuzzleDirection)
    
}

class PuzzleGestureManager {
    
    // MARK: - Outlets
    let boardView: PuzzleBoardView
    
    // MARK: - Gesture Recognizer
    var swipeGestures: [UISwipeGestureRecognizer] = []
    
    var isGesturesEnabled: Bool = false {
        willSet {
            swipeGestures.forEach { (gestureRecognizer) in
                gestureRecognizer.isEnabled = newValue
            }
        }
    }
    
    // MARK: - Dekegate
    weak var delegate: PuzzleGestureManagerDelegate?
    
    // MARK: - Initialize
    init(with boardView: PuzzleBoardView) {
        self.boardView = boardView
        
        configureGestureRecognizer()
    }
     
    // MARK: - Configure GestureRecognizer
    func configureGestureRecognizer() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.up, .down, .left, .right]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
            gesture.numberOfTouchesRequired = 1
            gesture.direction = direction
            gesture.isEnabled = false
            swipeGestures.append(gesture)
            boardView.addGestureRecognizer(gesture)
        }
    }
    
    // MARK: - Target Actions
    @objc func respondToSwipeGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.state == .ended {
            let puzzleDirection = PuzzleDirection(rawValue: gesture.direction.rawValue)
            delegate?.puzzleGestureRecognizerResponse(with: puzzleDirection!)
        }
    }
    
}
