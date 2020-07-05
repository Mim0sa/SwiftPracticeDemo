//
//  PPFile.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/7/5.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import Foundation

class PPFile {
    
    var name: String
    
    var device: PPDevice
    let template: PPTemplate
    
    let createTimeStamp: TimeInterval
    var lastChangeTimeStamp: TimeInterval
    
    init(name: String = "", device: PPDevice, template: PPTemplate) {
        self.name = name
        self.device = device
        self.template = template
        
        createTimeStamp = Date().timeIntervalSince1970
        lastChangeTimeStamp = createTimeStamp
    }
}

// MARK: - Helper
extension PPFile {
    func getDateStr(_ timeStamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}
