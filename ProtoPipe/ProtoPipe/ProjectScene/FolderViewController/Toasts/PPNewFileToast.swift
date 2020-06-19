//
//  PPNewFileToast.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/6/18.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PPNewFileToast: PPToastViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension PPNewFileToast {
    private func makeTitleLabel(title: String) -> UILabel {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        lbl.textColor = UIColor.subtitleGray
        lbl.textAlignment = .left
        return lbl
    }
}
