//
//  ProgramBoardTableViewCell.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/8/22.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit

class ProgramBoardTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
