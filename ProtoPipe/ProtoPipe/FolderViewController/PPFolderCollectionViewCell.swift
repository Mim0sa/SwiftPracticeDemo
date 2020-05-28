//
//  PPFolderCollectionViewCell.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/25.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PPFolderCollectionViewCell: UICollectionViewCell {
    
    let coverView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        detailLabel.text = "最后修改于 2018/01/04"
        detailLabel.textColor = UIColor(withHex: 0xdddddd)
        detailLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        detailLabel.sizeToFit()
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(-20)
        }
        
        titleLabel.text = "未命名文件未命名文件未命名文件未命名文件"
        titleLabel.textColor = UIColor(withHex: 0xeeeeee)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        titleLabel.sizeToFit()
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(detailLabel.snp.top).offset(-8)
        }
        
        coverView.image = #imageLiteral(resourceName: "pic")
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
