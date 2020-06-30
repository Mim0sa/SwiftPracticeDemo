//
//  PPNewFileToast.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/6/18.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PPNewFileToast: PPToastViewController {
    
    var fileNameLbl: UILabel!
    var fileNameTextField: UITextField!
    var deviceLbl: UILabel!
    var deviceCollectionView: UICollectionView!
    var templateLbl: UILabel!
    var templateCollectionView: UICollectionView!
    var cancelBtn: UIButton!
    var confirmBtn: UIButton!
    
    typealias NewFileToastModel = (title: String, device: PPDevice, template: PPTemplate)
    
    let model: NewFileToastModel = ("", .Custom, .Blank)
    
    weak var delegate: PPToastViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toastNavigationBar.title = "New File"
        contentView.contentSize = preferredContentSize
        
        fileNameLbl = makeTitleLabel(title: "File Name")
        contentView .addSubview(fileNameLbl)
        fileNameLbl.snp.makeConstraints { (make) in
            make.top.equalTo(18)
            make.left.equalTo(28)
        }
        
        fileNameTextField = UITextField()
        fileNameTextField.delegate = self
        fileNameTextField.font = UIFont.systemFont(ofSize: 18)
        fileNameTextField.backgroundColor = .textFieldGray
        fileNameTextField.textColor = .titleWhite
        fileNameTextField.borderStyle = .roundedRect
        fileNameTextField.returnKeyType = .done
        fileNameTextField.spellCheckingType = .no
        contentView.addSubview(fileNameTextField)
        fileNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(fileNameLbl.snp.bottom).offset(14)
            make.left.equalTo(28)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        deviceLbl = makeTitleLabel(title: "Device")
        contentView.addSubview(deviceLbl)
        deviceLbl.snp.makeConstraints { (make) in
            make.top.equalTo(fileNameTextField.snp.bottom).offset(18)
            make.left.equalTo(28)
        }
        
        deviceCollectionView = makeCollectionView()
        deviceCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: PPNewFileToast.DeviceCellID)
        contentView.addSubview(deviceCollectionView)
        deviceCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(deviceLbl.snp.bottom).offset(14)
            make.left.right.equalTo(view)
            make.height.equalTo(120)
        }

        templateLbl = makeTitleLabel(title: "Template")
        contentView.addSubview(templateLbl)
        templateLbl.snp.makeConstraints { (make) in
            make.top.equalTo(deviceCollectionView.snp.bottom).offset(18)
            make.left.equalTo(28)
        }
        
        templateCollectionView = makeCollectionView()
        templateCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: PPNewFileToast.TemplateCellID)
        contentView.addSubview(templateCollectionView)
        templateCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(templateLbl.snp.bottom).offset(14)
            make.left.right.equalTo(view)
            make.height.equalTo(120)
        }
        
        cancelBtn = PPRoundedButton(type: .Cancel)
        contentView.addSubview(cancelBtn)
        cancelBtn.addTarget(self, action: #selector(cancel(sender:)), for: .touchUpInside)
        cancelBtn.snp.makeConstraints { (make) in
            make.top.equalTo(templateCollectionView.snp.bottom).offset(35)
            make.centerX.equalToSuperview().offset(-100)
            make.width.equalTo(120)
            make.height.equalTo(49)
            make.bottom.equalTo(-35)
        }

        confirmBtn = PPRoundedButton(type: .Confirm)
        contentView.addSubview(confirmBtn)
        confirmBtn.addTarget(self, action: #selector(confirm(sender:)), for: .touchUpInside)
        confirmBtn.snp.makeConstraints { (make) in
            make.top.equalTo(templateCollectionView.snp.bottom).offset(35)
            make.centerX.equalToSuperview().offset(100)
            make.width.equalTo(120)
            make.height.equalTo(49)
            make.bottom.equalTo(-35)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(view.frame)
    }
    
    @objc func cancel(sender: UIButton) {
        delegate?.toastViewControllerDidClickCancelBtn(self)
    }
    
    @objc func confirm(sender: UIButton) {
        delegate?.newFileToastDidClickConfirmBtn?(self)
    }
    
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension PPNewFileToast: UICollectionViewDelegate, UICollectionViewDataSource {
    static let DeviceCellID = "DeviceCollectionViewCell"
    static let TemplateCellID = "TemplateCollectionViewCell"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == deviceCollectionView {
            return 6
        } else if collectionView == templateCollectionView {
            return 7
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == deviceCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PPNewFileToast.DeviceCellID, for: indexPath)
            cell.backgroundColor = .darkGray
            return cell
        } else if collectionView == templateCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PPNewFileToast.TemplateCellID, for: indexPath)
            cell.backgroundColor = .darkGray
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - Helper
extension PPNewFileToast {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        contentView.endEditing(true)
    }
    
    private func makeTitleLabel(title: String) -> UILabel {
        let lbl = UILabel()
        lbl.text = title
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        lbl.textColor = .subtitleGray
        lbl.textAlignment = .left
        return lbl
    }
    
    private func makeCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 90, height: 120)
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }
}

// MARK: - UITextFieldDelegate
extension PPNewFileToast: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
