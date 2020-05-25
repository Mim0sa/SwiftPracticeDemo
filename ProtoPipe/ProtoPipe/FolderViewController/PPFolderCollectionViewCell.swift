//
//  PPFolderCollectionViewCell.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/25.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PPFolderCollectionViewCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
