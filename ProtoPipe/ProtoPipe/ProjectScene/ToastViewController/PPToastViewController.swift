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
    var toastView = UIView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        modalPresentationStyle = .formSheet
        modalTransitionStyle = .coverVertical
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalPresentationStyle = .formSheet
        
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
