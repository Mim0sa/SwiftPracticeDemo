//
//  PPToastViewControllerDelegate.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/6/18.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

@objc protocol PPToastViewControllerDelegate: class {
    func toastViewControllerDidClickCancelBtn(_ toastViewController: PPToastViewController)
    
    @objc optional func newFileToastDidClickConfirmBtn(_ toastViewController: PPToastViewController, newFileModel: NewFileModel)
}
