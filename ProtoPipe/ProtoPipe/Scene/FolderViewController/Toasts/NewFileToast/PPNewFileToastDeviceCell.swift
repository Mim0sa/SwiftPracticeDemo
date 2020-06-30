//
//  PPNewFileToastDeviceCell.swift
//  ProtoPipe
//
//  Created by CM on 2020/6/30.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PPNewFileToastDeviceCell: UICollectionViewCell {
    
    var device: (device: PPDevice, isSelected: Bool)? {
        didSet {
            updateStatus()
        }
    }
    
    var icon: UIImageView!
    var title: UILabel!
    var detail: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 12
        
        icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 38, height: 64))
            make.centerX.equalToSuperview()
            make.top.equalTo(12)
        }
        
        title = UILabel()
        title.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        title.textColor = .titleWhite
        title.textAlignment = .center
        addSubview(title)
        title.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon.snp.bottom).offset(6)
        }
        
        detail = UILabel()
        detail.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        detail.textColor = .subtitleGray
        detail.textAlignment = .center
        addSubview(detail)
        detail.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(title.snp.bottom)
        }
    }
    
    func updateStatus() {
        guard let device = device else { return }
        
        icon.image = UIImage(named: device.device.iconNameStr)
        title.text = device.device.name
        detail.text = "\(Int(device.device.screenSize.width)) x \(Int(device.device.screenSize.height))"
        backgroundColor = device.isSelected ? .activeGreen : .clear
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
