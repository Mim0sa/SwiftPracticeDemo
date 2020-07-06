//
//  PPNewFileToast.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/6/18.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

typealias NewFileToastModel = ( // For Internal Transfer
    title: String,
    devices: [(device: PPDevice, isSelected: Bool)],
    templates: [(template: PPTemplate, isSelected: Bool)])

class NewFileModel: NSObject { // For Export
    let title: String
    let device: PPDevice
    let template: PPTemplate
    
    init(title: String, device: PPDevice, template: PPTemplate) {
        self.title = title
        self.device = device
        self.template = template
    }
}

class PPNewFileToast: PPToastViewController {
    
    var fileNameLbl: UILabel!
    var fileNameTextField: UITextField!
    var deviceLbl: UILabel!
    var deviceCollectionView: UICollectionView!
    var templateLbl: UILabel!
    var templateCollectionView: UICollectionView!
    var cancelBtn: UIButton!
    var confirmBtn: UIButton!
    
    var model: NewFileToastModel = ("", [], [])
    
    weak var delegate: PPToastViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare Model
        for type in PPNewFileToast.DeviceTypeList {
            let device = PPDevice(type: type)
            model.devices.append((device, false))
        }
        model.devices[0].isSelected = true
        
        for type in PPNewFileToast.TemplateTypeList {
            let template = PPTemplate(type: type)
            model.templates.append((template, false))
        }
        model.templates[0].isSelected = true
        
        // Prepare UI
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
        deviceCollectionView.register(PPNewFileToastDeviceCell.self, forCellWithReuseIdentifier: PPNewFileToast.DeviceCellID)
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
        templateCollectionView.register(PPNewFileToastTemplateCell.self, forCellWithReuseIdentifier: PPNewFileToast.TemplateCellID)
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

}

// MARK: - Target Actions
extension PPNewFileToast {
    @objc func cancel(sender: UIButton) {
        delegate?.toastViewControllerDidClickCancelBtn(self)
    }
    
    @objc func confirm(sender: UIButton) {
        if fileNameTextField.text?.isEmpty == true {
            print("empty")
        } else {
            delegate?.newFileToastDidClickConfirmBtn?(self, newFileModel: getFilteredModel())
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension PPNewFileToast: UICollectionViewDelegate, UICollectionViewDataSource {
    static let DeviceCellID = "DeviceCollectionViewCell"
    static let TemplateCellID = "TemplateCollectionViewCell"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == deviceCollectionView {
            return model.devices.count
        } else if collectionView == templateCollectionView {
            return model.templates.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == deviceCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PPNewFileToast.DeviceCellID, for: indexPath) as! PPNewFileToastDeviceCell
            cell.device = model.devices[indexPath.row]
            return cell
        } else if collectionView == templateCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PPNewFileToast.TemplateCellID, for: indexPath) as! PPNewFileToastTemplateCell
            cell.template = model.templates[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == deviceCollectionView {
            for i in 0...model.devices.count - 1 { model.devices[i].isSelected = false }
            model.devices[indexPath.row].isSelected.toggle()
            collectionView.reloadData()
        } else if collectionView == templateCollectionView {
            for i in 0...model.templates.count - 1 { model.templates[i].isSelected = false }
            model.templates[indexPath.row].isSelected.toggle()
            collectionView.reloadData()
        }
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
        flowLayout.itemSize = CGSize(width: 100, height: 120)
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
    
    private func getFilteredModel() -> NewFileModel {
        var newFileModel = (fileNameTextField.text, PPDevice(type: .Custom), PPTemplate(type: .Blank))
        for i in 0...model.devices.count - 1 {
            if model.devices[i].isSelected {
                newFileModel.1 = model.devices[i].device; break
            }
        }
        
        for i in 0...model.templates.count - 1 {
            if model.templates[i].isSelected {
                newFileModel.2 = model.templates[i].template; break
            }
        }
        
        return NewFileModel(title: newFileModel.0 ?? "File", device: newFileModel.1, template: newFileModel.2)
    }
}

// MARK: - UITextFieldDelegate
extension PPNewFileToast: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

// MARK: - Static Model
extension PPNewFileToast {
    static let DeviceTypeList: [PPDeviceType] = [.iPhoneX, .iPhone8, .iPhoneSE, .iPhone8p, .iPhone11p, .Custom]
    static let TemplateTypeList: [PPTemplateType] = [.Blank, .Tab, .List, .Camera, .Map, .Secret]
}
