//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by 吉乞悠 on 2018/12/10.
//  Copyright © 2018 吉乞悠. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {

    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    }

}
