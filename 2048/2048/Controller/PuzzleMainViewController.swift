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
    lazy var puzzleBoardCoordinator = PuzzleBoardCoordinator(with: puzzleBoardView)
    lazy var puzzleGestureManager   = PuzzleGestureManager(with: puzzleBoardView)
    
    // MARK: - Model
    var puzzleModel = PuzzleModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.pzBackgroundUIColor
        
        puzzleGestureManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        puzzleBoardCoordinator.generateAllCubes()
        launchGame()
    }
    
    // MARK: - Control Flows
    func launchGame() {
        puzzleGestureManager.isGesturesEnabled = false
        puzzleModel.cleanTheBoardData()
        puzzleBoardCoordinator.cleanTheBoard {
            let initialData = self.puzzleModel.generateInitialData()
            self.puzzleBoardCoordinator.showTwoInitialCube(initialData) {
                self.puzzleGestureManager.isGesturesEnabled = true
                print("-- launchGame() finished --")
            }
        }
    }
    
}

extension PuzzleMainViewController: PuzzleGestureManagerDelegate {
    
    func puzzleGestureRecognizerResponse(with direction: PuzzleDirection) {
        print(puzzleModel.boardData)
        print(puzzleModel.mergeData(with: direction))
    }

}

