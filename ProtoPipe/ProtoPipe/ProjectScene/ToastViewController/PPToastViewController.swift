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
    func toastViewControllerDidClickOKButton(_ vc: PPToastViewController)
}

struct PPToastModel {
    let title: String
    let toastView: PPToastView
}

class PPToastViewController: PPBaseViewController, PPToastViewDelegate {
    
    let toastNavigationBar = PPToastNavigationBar()
    let toastView: PPToastView
    
    var toastModel: PPToastModel
    
    var delegate: PPToastViewControllerDelegate?
    
    init(toastModel: PPToastModel) {
        self.toastModel = toastModel
        self.toastView = toastModel.toastView
        super.init(nibName: nil, bundle: nil)
        
        toastNavigationBar.title = toastModel.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

extension PPToastViewController {
    func toastViewDidClickOKButton(_ toastView: PPToastView) {
        delegate?.toastViewControllerDidClickOKButton(self)
    }
    
    func toastViewDidClickDismissButton(_ toastView: PPToastView) {
        delegate?.toastViewControllerDidClickDismissButton(self)
    }
}
