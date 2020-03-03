//
//  ViewController.swift
//  2048
//
//  Created by 吉乞悠 on 2020/2/22.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PuzzleMainViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var puzzleBoardView: PuzzleBoardView!
    
    // MARK: - Controller
    let puzzleAnimator = PuzzleAnimator()
    lazy var puzzleBoardCoordinator = PuzzleBoardCoordinator(with: puzzleBoardView)
    
    // MARK: - Model
    var puzzleModel = PuzzleModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        puzzleBoardCoordinator.boardView.generateAllCubes()
//        print(puzzleModel.mergeData(with: .Up))
        view.backgroundColor = backgroundColor
    }
    
    let backgroundColor = UIColor { (trainCollection) -> UIColor in
        if trainCollection.userInterfaceStyle == .dark {
            return UIColor.black
        } else {
            return UIColor.white
        }
    }
    
}

