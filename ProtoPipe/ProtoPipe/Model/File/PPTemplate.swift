//
//  PPTemplate.swift
//  ProtoPipe
//
//  Created by CM on 2020/6/30.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

enum PPTemplateType: String {
    case Map    = "Map"
    case Tab    = "Tab"
    case List   = "List"
    case Blank  = "Blank"
    case Camera = "Camera"
    case Secret = "Secret"
}

class PPTemplate {
    
    let type: PPTemplateType
    
    let name: String
    
    init(type: PPTemplateType) {
        self.type = type
        
        name = type.rawValue
    }
    
}

// MARK: - Helper
extension PPTemplate {
    func getIconNameStr() -> String {
        return "Template_Icon_\(type.rawValue)"
    }
}
