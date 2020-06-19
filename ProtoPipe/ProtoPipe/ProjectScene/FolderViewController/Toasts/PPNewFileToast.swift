//
//  PPNewFileToast.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/6/18.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PPNewFileToast: PPToastViewController, UITextFieldDelegate {
    
    var fileNameLbl: UILabel!
    var fileNameTextField: UITextField!
    var deviceLbl: UILabel!
    var templateLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toastNavigationBar.title = "New File"
        
        fileNameLbl = makeTitleLabel(title: "File Name")
        toastView.addSubview(fileNameLbl)
        fileNameLbl.snp.makeConstraints { (make) in
            make.top.equalTo(18)
            make.left.equalTo(28)
        }
        
        fileNameTextField = UITextField()
        fileNameTextField.delegate = self
        fileNameTextField.font = UIFont.systemFont(ofSize: 18)
        fileNameTextField.backgroundColor = UIColor(withHex: 0x222324)
        fileNameTextField.textColor = UIColor(withHex: 0xeeeeee)
        fileNameTextField.borderStyle = .roundedRect
        fileNameTextField.returnKeyType = .done
        fileNameTextField.spellCheckingType = .no
        toastView.addSubview(fileNameTextField)
        fileNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(fileNameLbl.snp.bottom).offset(14)
            make.left.equalTo(28)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        deviceLbl = makeTitleLabel(title: "Device")
        toastView.addSubview(deviceLbl)
        deviceLbl.snp.makeConstraints { (make) in
            make.top.equalTo(fileNameTextField.snp.bottom).offset(18)
            make.left.equalTo(28)
        }

        templateLbl = makeTitleLabel(title: "Template")
        toastView.addSubview(templateLbl)
        templateLbl.snp.makeConstraints { (make) in
            make.top.equalTo(deviceLbl.snp.bottom).offset(18)
            make.left.equalTo(28)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(toastView.frame)
    }
    
}

extension PPNewFileToast {
    private func makeTitleLabel(title: String) -> UILabel {
        let lbl = UILabel()
        lbl.text = title
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        lbl.textColor = UIColor.subtitleGray
        lbl.textAlignment = .left
        return lbl
    }
}

extension PPNewFileToast {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
