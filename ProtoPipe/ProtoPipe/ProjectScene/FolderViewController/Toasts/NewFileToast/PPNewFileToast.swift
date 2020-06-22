//
//  PPNewFileToast.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/6/18.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PPNewFileToast: PPToastViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var fileNameLbl: UILabel!
    var fileNameTextField: UITextField!
    var deviceLbl: UILabel!
    var deviceCollectionView: UICollectionView!
    var templateLbl: UILabel!
    var templateCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toastNavigationBar.title = "New File"
        contentView.contentSize = CGSize(width: 540, height: 0)
        
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
        deviceCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: DeviceCollectionViewCellID)
        contentView.addSubview(deviceCollectionView)
        deviceCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(deviceLbl.snp.bottom).offset(14)
            make.left.right.equalTo(view)
            make.height.equalTo(180)
        }

        templateLbl = makeTitleLabel(title: "Template")
        contentView.addSubview(templateLbl)
        templateLbl.snp.makeConstraints { (make) in
            make.top.equalTo(deviceCollectionView.snp.bottom).offset(18)
            make.left.equalTo(28)
        }
        
        templateCollectionView = makeCollectionView()
        templateCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: TemplateCollectionViewCellID)
        contentView.addSubview(templateCollectionView)
        templateCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(templateLbl.snp.bottom).offset(14)
            make.left.right.equalTo(view)
            make.height.equalTo(180)
            make.bottom.equalTo(-18)
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(templateCollectionView.frame)
    }
    
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
fileprivate let DeviceCollectionViewCellID   = "DeviceCollectionViewCell"
fileprivate let TemplateCollectionViewCellID = "TemplateCollectionViewCell"

extension PPNewFileToast {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == deviceCollectionView {
            return 10
        } else if collectionView == templateCollectionView {
            return 5
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == deviceCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeviceCollectionViewCellID, for: indexPath)
            cell.backgroundColor = .randomColor
            return cell
        } else if collectionView == templateCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TemplateCollectionViewCellID, for: indexPath)
            cell.backgroundColor = .randomColor
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - Helper
extension PPNewFileToast {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    private func makeTitleLabel(title: String) -> UILabel {
        let lbl = UILabel()
        lbl.text = title
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        lbl.textColor = UIColor.subtitleGray
        lbl.textAlignment = .left
        return lbl
    }
    
    private func makeCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 140, height: 180)
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
extension PPNewFileToast {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}