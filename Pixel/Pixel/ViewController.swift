//
//  ViewController.swift
//  Pixel
//
//  Created by 吉乞悠 on 2020/4/7.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var targetView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = imageView.image?.pixellated(scale: 30)
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        // 获取用户点击位置在图像上的相对位置
        let point = touch.location(in: imageView)
        targetView.backgroundColor = imageView.pickColor(at: point)
    }

}

