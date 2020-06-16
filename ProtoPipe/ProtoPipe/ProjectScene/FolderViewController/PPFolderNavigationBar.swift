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
    func folderNavigationBarDidClickNewButton(_ folderNavigationBar: PPFolderNavigationBar)
}

class PPFolderNavigationBar: UIView {

    let barIcon: UIButton = UIButton(type: .system)
    private(set) var barItems: [UIButton] = [] // [New, Select, Cancel, Share, Delete]
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
        
        backgroundColor = .navigatorBlack
        
        // barIcon
        barIcon.setTitle("ProtoPipe", for: .normal)
        barIcon.titleLabel?.font = UIFont.systemFont(ofSize: 44, weight: .heavy)
        barIcon.tintColor = .titleWhite
        barIcon.sizeToFit()
        addSubview(barIcon)
        
        // alertBar
        alertBar.backgroundColor = .activeGreen
        addSubview(alertBar)
        
        // barItems
        for style in PPFolderNavigationBar.barItemStyles {
            let barItem = makeBarItem(with: style)
            barItems.append(barItem)
            addSubview(barItem)
        }
        
        // initial config
        currentBarItems.append(barItems[0])
        currentBarItems.append(barItems[1])
        barItems[2].isHidden = true
        barItems[3].isHidden = true
        barItems[4].isHidden = true
        
        // constraits
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UpdateStatus
extension PPFolderNavigationBar {
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
            delegate?.folderNavigationBarDidClickNewButton(self)
        case .Select:
            isSelected = true
            delegate?.folderNavigationBarDidClickSelectButton(self)
        case .Cancel:
            isSelected = false
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
        barItem.tintColor = .titleWhite
        barItem.sizeToFit()
        barItem.addTarget(self, action: #selector(barItemClicked(sender:)), for: .touchUpInside)
        return barItem
    }
}

// MARK: - Constant
fileprivate extension PPFolderNavigationBar {
    static let barItemStyles: [BarItemType] = [.New, .Select, .Cancel, .Share, .Delete]
    
}


