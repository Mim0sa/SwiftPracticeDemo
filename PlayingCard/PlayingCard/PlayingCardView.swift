//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by 吉乞悠 on 2018/12/10.
//  Copyright © 2018 吉乞悠. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {

    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    }

}
