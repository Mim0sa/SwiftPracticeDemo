//
//  DNSwitch.swift
//  Day&Night-Switch
//
//  Created by 吉乞悠 on 2020/3/7.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class DNSwitch: UIView {
    
    var isOn: Bool = false {
        didSet {
            animate()
        }
    }
    
    private var hasAnimate: Bool = false
    
    private let imageView = UIImageView()
    private let thumbView = UIView()
    
    private let tapGestureRecognizer = UITapGestureRecognizer()

    init(withSystemSizeOn position: CGPoint, image: UIImage) {
        super.init(frame: CGRect(x: position.x - DNSwitch.width / 2,
                                 y: position.y - DNSwitch.height / 2,
                                 width: DNSwitch.width, height: DNSwitch.height))
        
        clipsToBounds = true
        layer.cornerRadius = frame.height / 2
        
        configureImageView(image: image)
        configureThumbView()
        prepareGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureThumbView() {
        thumbView.frame = CGRect(x: DNSwitch.offset, y: DNSwitch.offset,
                                 width: frame.height - DNSwitch.offset * 2,
                                 height: frame.height - DNSwitch.offset * 2)
        thumbView.backgroundColor = .white
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        
        thumbView.layer.shadowOffset = CGSize(width: 0, height: 1)
        thumbView.layer.shadowColor = UIColor.black.cgColor
        thumbView.layer.shadowRadius = DNSwitch.offset
        thumbView.layer.shadowOpacity = 0.5
        addSubview(thumbView)
    }

    private func prepareGestureRecognizer() {
        tapGestureRecognizer.addTarget(self, action: #selector(tap(gesture:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func tap(gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            setOn(!isOn, animated: true)
        }
    }
    
    private func configureImageView(image: UIImage) {
        let ratio = image.size.height / frame.height
        let imgWidth = image.size.width / ratio
        imageView.frame.size = CGSize(width: imgWidth > frame.width ? imgWidth : frame.width, height: frame.height)
        imageView.frame.origin = CGPoint(x: imgWidth > frame.width ? frame.width - imgWidth : 0, y: 0)
        imageView.image = image
        addSubview(imageView)
    }
    
    func setOn(_ isOn:Bool, animated: Bool) {
        hasAnimate = animated
        if self.isOn != isOn {
            self.isOn = isOn
        }
    }

    private func animate() {
        if hasAnimate {
            UIView.animate(withDuration: 0.15, animations: {
                self.updateFrame()
            }) { (finish) in
                self.hasAnimate = false
            }
        } else {
            updateFrame()
        }
    }

    private func updateFrame() {
        if isOn {
            imageView.frame.origin = CGPoint(x: 0, y: 0)
            thumbView.frame.origin = CGPoint(x: frame.width - thumbView.frame.width - DNSwitch.offset, y: DNSwitch.offset)
        } else {
            imageView.frame.origin = CGPoint(x: frame.width - imageView.frame.width, y: 0)
            thumbView.frame.origin = CGPoint(x: DNSwitch.offset, y: DNSwitch.offset)
        }
    }
    
}

extension DNSwitch {
    static let width: CGFloat = 153
    static let height: CGFloat = 93
    
    static let offset: CGFloat = 6
}
