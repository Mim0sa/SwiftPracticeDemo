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
        
        setupUI()
    }
    
    func setupUI(){
        blockBtn.frame = CGRect(x: 20, y: 20, width: 150 - 40, height: 150 - 40)
        blockBtn.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.2)
        blockBtn.layer.cornerRadius = 20
        addSubview(blockBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
