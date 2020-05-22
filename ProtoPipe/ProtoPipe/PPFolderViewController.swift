//
//  PPFolderViewController.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/21.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit
import SnapKit

class PPFolderViewController: PPBaseViewController, PPCanvasViewControllerDelegate, UIViewControllerTransitioningDelegate {

    lazy var box = UIButton()
    
    let folderNavigationBar = PPFolderNavigationBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(withHex: 0x191B1D)
        
        view.addSubview(box)
        box.backgroundColor = .orange
        box.snp.makeConstraints { (make) -> Void in
           make.width.height.equalTo(200)
           make.center.equalTo(self.view)
        }
        box.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        
        view.addSubview(folderNavigationBar)
    }

    @objc func buttonClicked(sender: UIButton) {
        let vc = PPCanvasViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.transitioningDelegate = self
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    func canvasViewControllerDidClickedFolderButton(vc: PPCanvasViewController) {
        dismiss(animated: true, completion: nil)
    }

}

extension PPFolderViewController {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MagicMoveAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MagicMoveAnimator()
    }
}
