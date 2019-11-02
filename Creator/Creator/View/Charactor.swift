//
//  Charactor.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/10/21.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit
import SpriteKit

class Charactor: SKSpriteNode {
    
    let chapter: Int
    
    let length: CGFloat
    
    var direction: CharactorDirection = .Right

    init(chapter: Int, size: CGSize) {
        self.chapter = chapter
        self.length = size.width
        let texture = SKTexture(imageNamed: "Chapter"+"\(chapter)"+"_Charactor_1")
        super.init(texture: texture, color: UIColor.clear, size: size)

        animateRun()
    }
    
    func animateRun() {
        var textureArray: [SKTexture] = []
        for i in 1...6 {
            textureArray.append(SKTexture(imageNamed: "Chapter"+"\(chapter)"+"_Charactor_\(i)"))
        }

        let animate = SKAction.animate(with: textureArray, timePerFrame: 0.1)

        run(SKAction.repeatForever(animate), withKey: "animateRun")
    }
    
    func move(moveType: ChessRoadType, moveDirection: CharactorDirection, complation: @escaping () -> Void) {
        //zRotation = CGFloat(-Double.pi / 2)
        
        let cgpath = CGMutablePath()
        let startingPoint = CGPoint(x: position.x, y: position.y)
        var controlPoint1 = CGPoint(x: position.x, y: position.y)
        var controlPoint2 = CGPoint(x: position.x, y: position.y)
        var endingPoint = CGPoint(x: position.x, y: position.y)
        var duringTime = 1.0
        
        switch moveType {
        case .horizen:
            duringTime = 0.8
            if moveDirection == .Left {
                endingPoint = CGPoint(x: position.x - length, y: position.y)
            } else if moveDirection == .Right {
                endingPoint = CGPoint(x: position.x + length, y: position.y)
            }
        case .vertical:
            duringTime = 0.8
            if moveDirection == .Up {
                endingPoint = CGPoint(x: position.x, y: position.y + length)
            } else if moveDirection == .Down {
                endingPoint = CGPoint(x: position.x, y: position.y - length)
            }
        case .turnRight:
            if moveDirection == .Up {
                controlPoint1 = CGPoint(x: position.x, y: position.y + 0.55 * length)
                controlPoint2 = CGPoint(x: position.x + 0.45 * length, y: position.y + length)
                endingPoint = CGPoint(x: position.x + length, y: position.y + length)
            } else if moveDirection == .Down {
                controlPoint1 = CGPoint(x: position.x, y: position.y - 0.55 * length)
                controlPoint2 = CGPoint(x: position.x + 0.45 * length, y: position.y - length)
                endingPoint = CGPoint(x: position.x + length, y: position.y - length)
            }
            direction = .Right
        case .turnDown:
            if moveDirection == .Right {
                controlPoint1 = CGPoint(x: position.x + 0.55 * length, y: position.y)
                controlPoint2 = CGPoint(x: position.x + length, y: position.y - 0.45 * length)
                endingPoint = CGPoint(x: position.x + length, y: position.y - length)
            } else if moveDirection == .Left {
                controlPoint1 = CGPoint(x: position.x - 0.55 * length, y: position.y)
                controlPoint2 = CGPoint(x: position.x - length, y: position.y - 0.45 * length)
                endingPoint = CGPoint(x: position.x - length, y: position.y - length)
            }
            direction = .Down
        case .turnLeft:
            if moveDirection == .Down {
                controlPoint1 = CGPoint(x: position.x, y: position.y - 0.55 * length)
                controlPoint2 = CGPoint(x: position.x - 0.45 * length, y: position.y - length)
                endingPoint = CGPoint(x: position.x - length, y: position.y - length)
            } else if moveDirection == .Up {
                controlPoint1 = CGPoint(x: position.x, y: position.y - 0.55 * length)
                controlPoint2 = CGPoint(x: position.x + 0.45 * length, y: position.y - length)
                endingPoint = CGPoint(x: position.x + length, y: position.y - length)
            }
            direction = .Left
        case .turnUp:
            if moveDirection == .Left {
                controlPoint1 = CGPoint(x: position.x - 0.55 * length, y: position.y)
                controlPoint2 = CGPoint(x: position.x - length, y: position.y + 0.45 * length)
                endingPoint = CGPoint(x: position.x - length, y: position.y + length)
            } else if moveDirection == .Right {
                controlPoint1 = CGPoint(x: position.x + 0.55 * length, y: position.y)
                controlPoint2 = CGPoint(x: position.x + length, y: position.y + 0.45 * length)
                endingPoint = CGPoint(x: position.x + length, y: position.y + length)
            }
            direction = .Up
        case .cloud:
            alpha = 0
            duringTime = 0.1
            controlPoint1 = CGPoint(x: position.x, y: position.y + 5 * length)
            controlPoint2 = CGPoint(x: position.x, y: position.y + 5 * length)
            endingPoint = CGPoint(x: position.x + length, y: position.y + 5 * length)
            
        }
        
        cgpath.move(to: CGPoint(x: startingPoint.x, y: startingPoint.y), transform: .identity)
        cgpath.addCurve(to: CGPoint(x: endingPoint.x, y: endingPoint.y), control1: CGPoint(x: controlPoint1.x, y: controlPoint1.y), control2: CGPoint(x: controlPoint2.x, y: controlPoint2.y), transform: .identity)
        let curve = SKAction.follow(cgpath, asOffset: false, orientToPath: true, duration: duringTime)
        run(curve) {
            self.alpha = 1
            complation()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum CharactorDirection {
    case Up
    case Down
    case Left
    case Right
}
