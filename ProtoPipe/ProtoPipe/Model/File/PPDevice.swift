//
//  PPDevice.swift
//  ProtoPipe
//
//  Created by CM on 2020/6/30.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

enum PPDeviceType: String {
    case Custom    = "Custom"
    case iPhone8   = "iPhone 8"
    case iPhone8p  = "iPhone 8p"
    case iPhoneX   = "iPhone X"
    case iPhone11p = "iPhone 11p"
    case iPhoneSE  = "iPhone SE"
}

class PPDevice {
    
    let type: PPDeviceType
    
    let name: String
    let screenSize: CGSize
    let snapshotID: String
    
    init(type: PPDeviceType) {
        self.type = type
        
        name = type.rawValue
        screenSize = DeviceSizeDic[type] ?? CGSize()
        snapshotID = type.rawValue
    }
    
}

// MARK: - Helper
extension PPDevice {
    func getIconNameStr() -> String {
        switch type {
        case .Custom:
            return "Device_Icon_Custom"
        case .iPhone8, .iPhone8p, .iPhoneSE:
            return "Device_Icon_iPhone 8"
        case .iPhoneX, .iPhone11p:
            return "Device_Icon_iPhone X"
        }
    }
}

// MARK: - Static Model
fileprivate let DeviceSizeDic: [PPDeviceType:CGSize] = [.Custom    : CGSize(width: 360, height: 640),
                                                        .iPhone8   : CGSize(width: 375, height: 667),
                                                        .iPhone8p  : CGSize(width: 414, height: 736),
                                                        .iPhoneX   : CGSize(width: 414, height: 896),
                                                        .iPhone11p : CGSize(width: 375, height: 812),
                                                        .iPhoneSE  : CGSize(width: 320, height: 568),]

