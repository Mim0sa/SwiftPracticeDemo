//
//  PPNewFileToastTemplateCell.swift
//  ProtoPipe
//
//  Created by CM on 2020/6/30.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PPNewFileToastTemplateCell: UICollectionViewCell {
    
    var template: (template: PPTemplate, isSelected: Bool)? {
        didSet {
            updateStatus()
        }
    }
    
    var icon: UIImageView!
    var title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 12
        
        icon = UIImageView()
        icon.backgroundColor = .subtitleGray
        icon.layer.cornerRadius = 8
        addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 64, height: 64))
            make.centerX.equalToSuperview()
            make.top.equalTo(16)
        }
        
        title = UILabel()
        title.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        title.textColor = .titleWhite
        title.textAlignment = .center
        addSubview(title)
        title.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon.snp.bottom).offset(12)
        }
    }
    
    func updateStatus() {
        guard let template = template else { return }
        
        icon.image = UIImage(named: template.template.getIconNameStr())
        title.text = template.template.name
        backgroundColor = template.isSelected ? .activeGreen : .clear
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
