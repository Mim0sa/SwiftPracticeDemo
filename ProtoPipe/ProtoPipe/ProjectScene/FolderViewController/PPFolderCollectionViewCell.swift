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
}

class PPFolderCollectionViewCell: UICollectionViewCell {
    
    var model: PPFolderCollectionViewCellModel? {
        willSet { guard
            let newModel = newValue else { return }
            detailLabel.text = newModel.detail
            titleLabel.text = newModel.title
            coverView.image = newModel.coverImage
            isEditing = newModel.isEditing
        }
    }
    
    let coverView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let dotButton = YZDotButton()
    
    var isEditing: Bool = false {
        willSet {
            updateEditStatus(with: newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        detailLabel.textColor = UIColor(withHex: 0xcccccc)
        detailLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        detailLabel.sizeToFit()
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(-20)
        }
        
        titleLabel.textColor = UIColor(withHex: 0xeeeeee)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        titleLabel.sizeToFit()
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-60)
            make.bottom.equalTo(detailLabel.snp.top).offset(-8)
        }
        
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
    
    func updateEditStatus(with isChosen: Bool) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
