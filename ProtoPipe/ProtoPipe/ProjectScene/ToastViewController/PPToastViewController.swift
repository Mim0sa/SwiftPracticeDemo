//
//  PPToastViewController.swift
//  ProtoPipe
//
//  Created by CM on 2020/6/16.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PPToastViewController: PPBaseViewController {
    
    let toastNavigationBar = PPToastNavigationBar()
    let toastView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalPresentationStyle = .pageSheet
        
        view.backgroundColor = .sceneBlack
        
        view.addSubview(toastNavigationBar)
        toastNavigationBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(78)
        }
        
        view.addSubview(toastView)
        toastView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(toastNavigationBar.snp.bottom)
        }
    }
    
}
