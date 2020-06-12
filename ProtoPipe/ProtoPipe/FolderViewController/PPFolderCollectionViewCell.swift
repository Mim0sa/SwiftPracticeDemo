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
    var isChosen: Bool
}

class PPFolderCollectionViewCell: UICollectionViewCell {
    
    var model: PPFolderCollectionViewCellModel? {
        willSet { guard
            let newModel = newValue else { return }
            detailLabel.text = newModel.detail
            titleLabel.text = newModel.title
            coverView.image = newModel.coverImage
            isEditing = newModel.isChosen
        }
    }
    
    let coverView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let chosenView = UIButton() //
    
    var isEditing: Bool = false {
        willSet {
            updateChosen(with: newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        detailLabel.textColor = UIColor(withHex: 0xdddddd)
        detailLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.left.greaterThanOrEqualTo(60)
            make.right.equalTo(-30)
            make.bottom.equalTo(-20)
        }
        
        titleLabel.textColor = UIColor(withHex: 0xeeeeee)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.greaterThanOrEqualTo(60)
            make.right.equalTo(-30)
            make.bottom.equalTo(detailLabel.snp.top).offset(-8)
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
    
    func updateChosen(with isChosen: Bool) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
