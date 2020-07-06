//
//  PPFolderCollectionViewModel.swift
//  ProtoPipe
//
//  Created by CM on 2020/6/15.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import Foundation

struct PPFolderCollectionViewModel {
    
    var modelData: [PPFolderCollectionViewCellModel] = []
    
    var count: Int {
        get { return modelData.count }
    }
    
    // New File
    mutating func newFile(_ file: PPFile) {
        modelData.insert(PPFolderCollectionViewCellModel(title: file.name,
                                                         detail: "最后修改于 \(file.getDateStr(file.lastChangeTimeStamp))",
                                                         coverImage: #imageLiteral(resourceName: "pic"),
                                                         isEditing: false),
                         at: 0)
    }
    
    mutating func updateEditStatus(with isEditing: Bool) {
        for i in 0...modelData.count - 1 {
            if isEditing {
                modelData[i].isEditing = true
                modelData[i].isChosen = false
            } else {
                modelData[i].isEditing = false
            }
        }
    }
    
    mutating func updateChosenStatus(at index: Int) {
        modelData[index].isChosen = !modelData[index].isChosen
    }
    
}
