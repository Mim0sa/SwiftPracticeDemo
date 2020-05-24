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
        scrollDirection = .vertical
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
        let itemWidth = firstLaunchScreenWidth > firstLaunchScreenHeight ? firstLaunchScreenWidth / 4 : firstLaunchScreenHeight / 4
        itemSize = CGSize(width: itemWidth - 5, height: (itemWidth - 5) / 5 * 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
