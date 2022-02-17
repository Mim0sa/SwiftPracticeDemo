//
//  ViewController.swift
//  Day&Night-Switch
//
//  Created by 吉乞悠 on 2020/3/7.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()

        let position = CGPoint(x: view.center.x, y: view.center.y)
        let dnSwitch = DNSwitch(withSystemSizeOn: position, image: #imageLiteral(resourceName: "switchImg2"))
        view.addSubview(dnSwitch)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            dnSwitch.setOn(!dnSwitch.isOn, animated: true) 
        })
    }


}

