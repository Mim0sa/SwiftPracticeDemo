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
        contentView.contentSize = CGSize(width: 540, height: 679)
        
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
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 140, height: 180)
        flowLayout.scrollDirection = .horizontal
        
        deviceCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        deviceCollectionView.contentInset = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
        deviceCollectionView.backgroundColor = .clear
        deviceCollectionView.delegate = self
        deviceCollectionView.dataSource = self
        deviceCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCellID)
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
        
        templateCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        templateCollectionView.contentInset = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
        templateCollectionView.backgroundColor = .clear
        templateCollectionView.delegate = self
        templateCollectionView.dataSource = self
        templateCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCellID)
        contentView.addSubview(templateCollectionView)
        templateCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(templateLbl.snp.bottom).offset(14)
            make.left.right.equalTo(view)
            make.height.equalTo(180)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(templateCollectionView.frame)
    }
    
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
fileprivate let CollectionViewCellID = "CollectionViewCell"

extension PPNewFileToast {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID, for: indexPath)
        cell.backgroundColor = .randomColor
        return cell
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
}

// MARK: - UITextFieldDelegate
extension PPNewFileToast {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
