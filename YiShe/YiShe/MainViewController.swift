//
//  MainViewController.swift
//  YiShe
//
//  Created by 吉乞悠 on 2019/3/16.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.backgroundColor = UICOLOR_EEEEEE
        imageView.frame = CGRect(x: view.center.x - 150, y: view.center.y - 100, width: 300, height: 200)
        view.addSubview(imageView)

    }
    
}
