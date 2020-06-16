//
//  PPToastViewController.swift
//  ProtoPipe
//
//  Created by CM on 2020/6/16.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PPToastViewController: PPBaseViewController, PPToastNavigationBarDelegate {
    
    let toastNavigationBar = PPToastNavigationBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        modalPresentationStyle = .pageSheet
        
        view.backgroundColor = .sceneBlack
        
        toastNavigationBar.delegate = self
        view.addSubview(toastNavigationBar)
        toastNavigationBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(78)
        }
        // Do any additional setup after loading the view.
    }

}

extension PPToastViewController {
    func toastNavigationBarDidClickDismissButton(_ toastNavigationBar: PPToastNavigationBar) {
        dismiss(animated: true, completion: nil)
    }
}
