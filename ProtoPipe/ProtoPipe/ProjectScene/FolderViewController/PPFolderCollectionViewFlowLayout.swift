//
//  PPFolderCollectionViewFlowLayout.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/24.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PPFolderCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        
        scrollDirection = .vertical
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0

        itemSize = folderCollectionViewCellSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

var folderCollectionViewCellSize: CGSize {
     return CGSize(width:  screenWidth > screenHeight ? screenWidth / 4 : screenWidth / 3,
                   height: screenWidth > screenHeight ? screenWidth / 4 : screenWidth / 3)
}

