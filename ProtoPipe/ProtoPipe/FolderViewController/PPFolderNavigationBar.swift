//
//  PPFolderNavigationBar.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/22.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

protocol PPFolderNavigationBarDelegate {
    func folderNavigationBarDidClickSelectButton(_ folderNavigationBar: PPFolderNavigationBar)
    func folderNavigationBarDidClickCancelButton(_ folderNavigationBar: PPFolderNavigationBar)
}

class PPFolderNavigationBar: UIView {

    let barIcon: UIButton = UIButton(type: .system)
    var barItems: [UIButton] = [] // [New, Select, Cancel, Share, Delete]
    let alertBar = UIView()
    
    var currentBarItems: [UIButton] = []
    
    var isSelected: Bool = false {
        willSet {
            updateCurrentBarItems(withStyle: newValue)
            updateAlertBar(withStyle: newValue)
        }
    }
    
    var delegate: PPFolderNavigationBarDelegate?
    
    init() {
        super.init(frame: CGRect())
        
        backgroundColor = UIColor(withHex: 0x131415)
        
        barIcon.setTitle("ProtoPipe", for: .normal)
        barIcon.titleLabel?.font = UIFont.systemFont(ofSize: 44, weight: .heavy)
        barIcon.tintColor = UIColor(withHex: 0xeeeeee)
        barIcon.sizeToFit()
        
        alertBar.backgroundColor = UIColor(withHex: 0x50BAA1)
        
        let barItem_new = makeBarItem(with: .New)
        barItems.append(barItem_new)
        currentBarItems.append(barItem_new)
        
        let barItem_select = makeBarItem(with: .Select)
        barItems.append(barItem_select)
        currentBarItems.append(barItem_select)
        
        let barItem_cancel = makeBarItem(with: .Cancel)
        barItem_cancel.isHidden = true
        barItems.append(barItem_cancel)
        
        let barItem_share = makeBarItem(with: .Share)
        barItem_share.isHidden = true
        barItems.append(barItem_share)
        
        let barItem_delete = makeBarItem(with: .Delete)
        barItem_delete.isHidden = true
        barItems.append(barItem_delete)
        
        addSubview(barIcon)
        addSubview(alertBar)
        addSubview(barItem_new)
        addSubview(barItem_select)
        addSubview(barItem_cancel)
        addSubview(barItem_share)
        addSubview(barItem_delete)
        
        barIcon.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.bottom.equalTo(0)
        }
        
        alertBar.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(0)
            make.top.equalTo(snp.bottom)
        }
        
        updateCurrentBarItemsConstraints()
    }
    
    func updateCurrentBarItemsConstraints() {
        for i in 0...currentBarItems.count - 1 {
            currentBarItems[i].snp.updateConstraints { (make) in
                if i == 0 {
                    make.right.equalTo(-40)
                } else {
                    make.right.equalTo(currentBarItems[i - 1].snp.left).offset(-20)
                }
                make.bottom.equalTo(-5)
            }
        }
    }
    
    func updateCurrentBarItems(withStyle isSelected: Bool) {
        let newBarItems = isSelected ? [barItems[2], barItems[3], barItems[4]] : [barItems[0], barItems[1]]
        
        for item in currentBarItems { item.isHidden = true }
        currentBarItems = newBarItems
        for item in currentBarItems { item.isHidden = false }
        updateCurrentBarItemsConstraints()
    }
    
    func updateAlertBar(withStyle isSelected: Bool) {
        layoutIfNeeded()
        let alertBarHeight = isSelected ? 6 : 0
        alertBar.snp.updateConstraints { (make) in
            make.height.equalTo(alertBarHeight)
        }
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Target Actions
fileprivate enum BarItemType: String {
    case New = "New"
    case Select = "Select"
    case Cancel = "Cancel"
    case Share = "Share"
    case Delete = "Delete"
}

extension PPFolderNavigationBar {
    @objc func barItemClicked(sender: UIButton) {
        switch BarItemType(rawValue: sender.currentTitle!) {
        case .New:
            break
        case .Select:
            delegate?.folderNavigationBarDidClickSelectButton(self)
        case .Cancel:
            delegate?.folderNavigationBarDidClickCancelButton(self)
        case .Share:
            break
        case .Delete:
            break
        case .none:
            break
        }
        
    }
}

// MARK: - Helper
extension PPFolderNavigationBar {
    fileprivate func makeBarItem(with barItemType: BarItemType) -> UIButton {
        let barItem = UIButton(type: .system)
        barItem.setTitle(barItemType.rawValue, for: .normal)
        barItem.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        barItem.tintColor = UIColor(withHex: 0xeeeeee)
        barItem.sizeToFit()
        barItem.addTarget(self, action: #selector(barItemClicked(sender:)), for: .touchUpInside)
        return barItem
    }
}


