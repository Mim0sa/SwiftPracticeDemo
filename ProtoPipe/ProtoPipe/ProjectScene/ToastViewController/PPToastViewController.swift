//
//  PPToastViewController.swift
//  ProtoPipe
//
//  Created by CM on 2020/6/16.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

protocol PPToastViewControllerDelegate {
    func toastViewControllerDidClickDismissButton(_ vc: PPToastViewController)
}

class PPToastViewController: PPBaseViewController, PPToastNavigationBarDelegate {
    
    let toastNavigationBar = PPToastNavigationBar()
    
    var delegate: PPToastViewControllerDelegate?

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
    }

}

extension PPToastViewController {
    func toastNavigationBarDidClickDismissButton(_ toastNavigationBar: PPToastNavigationBar) {
        delegate?.toastViewControllerDidClickDismissButton(self)
    }
}
