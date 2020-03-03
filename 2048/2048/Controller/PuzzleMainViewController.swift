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
    
    // MARK: - Model
    var puzzleModel = PuzzleModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.pzBackgroundUIColor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        puzzleBoardCoordinator.generateAllCubes()
        launchGame()
    }
    
    // MARK: - Control Flows
    func launchGame() {
        puzzleModel.cleanTheBoardData()
        puzzleBoardCoordinator.cleanTheBoard {
            let initialData = self.puzzleModel.generateInitialData()
            self.puzzleBoardCoordinator.showTwoInitialCube(initialData) {
                print("finished")
            }
        }
    }
    
}

