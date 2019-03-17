//
//  LoginViewController.swift
//  YiShe
//
//  Created by 吉乞悠 on 2019/3/6.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let videoBackGroundView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoBackGroundView.backgroundColor = UICOLOR_EEEEEE
        self.view.addSubview(videoBackGroundView)
    }
    
}
