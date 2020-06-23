//
//  PPFolderCollectionViewCell.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/25.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

struct PPFolderCollectionViewCellModel {
    var title: String
    var detail: String
    var coverImage: UIImage
    var isEditing: Bool
    var isChosen: Bool = false
}

protocol PPFolderCollectionViewCellDelegate: class {
    func folderCollectionViewCellDidUpdateChosenStatus(_ cell: PPFolderCollectionViewCell)
}

class PPFolderCollectionViewCell: UICollectionViewCell {
    
    var model: PPFolderCollectionViewCellModel? {
        willSet { guard
            let newModel = newValue else { return }
            detailLabel.text = newModel.detail
            titleLabel.text = newModel.title
            coverView.image = newModel.coverImage
            isEditing = newModel.isEditing
            dotButton.isChosen = newModel.isChosen
        }
    }
    
    let coverView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let dotButton = PPDotButton()
    
    weak var delegate: PPFolderCollectionViewCellDelegate?
    
    var isEditing: Bool = false {
        willSet {
            if newValue != isEditing {
                updateEditStatus(with: newValue)
            }
        }
    }
    
//    var isChosen: Bool = false {
//        willSet {
//            updateChosenStatus(with: newValue)
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        detailLabel.textColor = .subtitleGray
        detailLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        detailLabel.sizeToFit()
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(-20)
        }
        
        titleLabel.textColor = .titleWhite
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        titleLabel.sizeToFit()
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-60)
            make.bottom.equalTo(detailLabel.snp.top).offset(-8)
        }
        
        dotButton.delegate = self
        dotButton.isHidden = true
        addSubview(dotButton)
        dotButton.snp.makeConstraints { (make) in
            make.right.equalTo(-30)
            make.height.width.equalTo(20)
            make.centerY.equalTo(titleLabel)
        }
        
        coverView.backgroundColor = .lightGray
        coverView.contentMode = .scaleAspectFit
        addSubview(coverView)
        coverView.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(24)
            make.bottom.equalTo(titleLabel.snp.top).offset(-12)
        }
    }
    
    func updateEditStatus(with isEditing: Bool) {
        if isEditing {
            dotButton.alpha = 0
            dotButton.isEnabled = false
            dotButton.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {
                self.dotButton.alpha = 1
            }) { (isFinish) in
                self.dotButton.isEnabled = true
            }
        } else {
            dotButton.isEnabled = false
            UIView.animate(withDuration: 0.2, animations: {
                self.dotButton.alpha = 0
            }) { (isFinish) in
                self.dotButton.alpha = 0
                self.dotButton.isHidden = true
            }
        }
    }
    
    override func prepareForReuse() {
        dotButton.isChosen = false
    }
    
//    func updateChosenStatus(with isChosen: Bool) {
//        dotButton.isChosen = isChosen
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PPFolderCollectionViewCell: PPDotButtonDelegate {
    func dotButtonDidUpdateChosenStatus(_ dotButton: PPDotButton) {
        delegate?.folderCollectionViewCellDidUpdateChosenStatus(self)
    }
}
