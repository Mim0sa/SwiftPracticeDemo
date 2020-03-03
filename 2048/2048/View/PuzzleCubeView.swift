//
//  PuzzleCubeView.swift
//  2048
//
//  Created by 吉乞悠 on 2020/2/22.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PuzzleCubeView: UIView {
    
    // MARK: - Outlets
    private var cubeShadowView: UIView
    private var cubeShapeView:  UIView
    private var cubeTitleLabel: UILabel
    
    // MARK: - Varibles
    let cubeEdge: CGFloat
    let puzzleValue: PuzzleValue
    
    var cubeStatus: PuzzleCubeViewStatus {
        willSet {
            switch newValue {
            case .Expanded:
                expandCubeView(with: cubeEdge)
            case .Shrinked:
                break
            }
        }
    }
    
    // MARK: - initialize
    init(position: CGPoint,
         cubeEdge: CGFloat,
         cubeStatus: PuzzleCubeViewStatus,
         puzzleValue: PuzzleValue) {
        
        self.cubeStatus  = cubeStatus
        self.puzzleValue = puzzleValue
        self.cubeEdge    = cubeEdge
        
        let currentCubeEdge = (cubeStatus == .Expanded) ? cubeEdge : cubeEdge - 30
        
        cubeShadowView = UIView(frame: CGRect(x: 0, y: 0, width: currentCubeEdge, height: currentCubeEdge))
        cubeShapeView  = UIView(frame: CGRect(x: 0, y: 0, width: currentCubeEdge, height: currentCubeEdge))
        cubeTitleLabel = UILabel(frame: CGRect(x: 8, y: 0, width: currentCubeEdge - 16, height: currentCubeEdge))
        
        super.init(frame: CGRect(x: position.x - currentCubeEdge / 2,
                                 y: position.y - currentCubeEdge / 2,
                                 width: currentCubeEdge,
                                 height: currentCubeEdge))
        setupCubeViewUI()
    }
    
    func setupCubeViewUI() {
        backgroundColor = .clear
        if cubeStatus == .Shrinked { alpha = 0.5 }
        
        //setupCubeShadowView()
        setupCubeShapeView()
        setupCubeTitleLabel()
    }
    
    func setupCubeShadowView() {
        cubeShadowView.backgroundColor = .white
        cubeShadowView.layer.shadowColor = UIColor("CubeView_Shadow")?.cgColor(with: traitCollection)
        cubeShadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cubeShadowView.layer.shadowOpacity = 0.5
        cubeShadowView.layer.shadowRadius = 3
        cubeShadowView.layer.cornerRadius = 14
        addSubview(cubeShadowView)
    }
    
    func setupCubeShapeView() {
        cubeShapeView.backgroundColor = UIColor.pzCubeUIColor(puzzleValue)
        cubeShapeView.layer.cornerRadius = 14
        addSubview(cubeShapeView)
    }
    
    func setupCubeTitleLabel() {
        cubeTitleLabel.textAlignment = .center
        cubeTitleLabel.contentMode = .scaleAspectFill
        cubeTitleLabel.text = "\(puzzleValue.rawValue)"
        cubeTitleLabel.adjustsFontSizeToFitWidth = true
        cubeTitleLabel.baselineAdjustment = .alignCenters
        cubeTitleLabel.textColor = UIColor.pzTextUIColor(puzzleValue)
        cubeTitleLabel.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        addSubview(cubeTitleLabel)
    }
    
    func expandCubeView(with cubeEdge: CGFloat) {
        alpha = 1
        
        let newFrame = (center: center, size: CGSize(width: cubeEdge, height: cubeEdge))
        frame.size = newFrame.size
        center = newFrame.center

        cubeShapeView.frame.size = newFrame.size
        cubeShadowView.frame.size = newFrame.size
        cubeTitleLabel.frame = CGRect(x: 8, y: 0,
                                      width: cubeEdge - 16,
                                      height: cubeEdge)
    }
    
    // MARK: - Preference
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum PuzzleCubeViewStatus {
    case Expanded
    case Shrinked
}
