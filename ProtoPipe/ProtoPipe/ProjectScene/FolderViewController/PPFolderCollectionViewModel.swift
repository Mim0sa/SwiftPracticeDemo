//
//  PPFolderCollectionViewModel.swift
//  ProtoPipe
//
//  Created by CM on 2020/6/15.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import Foundation

struct PPFolderCollectionViewModel {
    
    var modelData: [PPFolderCollectionViewCellModel] = [PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false), PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false), PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false)]
    
    var count: Int {
        get {
            return modelData.count
        }
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
        modelData[index].isChosen?.toggle()
    }
    
}
