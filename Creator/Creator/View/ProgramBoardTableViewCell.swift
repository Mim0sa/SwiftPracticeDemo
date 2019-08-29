//
//  ProgramBoardTableViewCell.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/8/22.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit

class ProgramBoardTableViewCell: UITableViewCell {
    
    let blockBtn = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        isUserInteractionEnabled = true
        backgroundColor = .clear
//        separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        setupUI()
    }
    
    func setupUI(){
        blockBtn.frame = CGRect(x: 20, y: 20, width: 150 - 40, height: 150 - 40)
        blockBtn.layer.cornerRadius = 20
        blockBtn.clipsToBounds = true
        addSubview(blockBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
