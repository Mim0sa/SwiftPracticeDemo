//
//  ProgramBoardView.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/8/22.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit

class ProgramBoardView: UIView {
    
    let gap: CGFloat = 20
    let cornerRadius: CGFloat = 20
    
    let blockNum: Int
    
    let tableView = UITableView()
    
    let cellID = "ProgramBoardTableViewCell"

    init(point: CGPoint, width: CGFloat, blockNum: Int) {
        // initialize
        self.blockNum = blockNum
        
        super.init(frame: CGRect(x: point.x, y: point.y, width: width, height: 5 * (width - gap) + gap))
        
        // preference
        backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.3)
        layer.cornerRadius = cornerRadius
        
        //setupUI
        setupUI()
    }
    
    func setupUI(){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 100))
        headerView.backgroundColor = .clear
        
        tableView.frame = CGRect(x: 0, y: gap, width: frame.width, height: frame.height - 2 * gap)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProgramBoardTableViewCell.self, forCellReuseIdentifier: cellID)
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProgramBoardView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        cell?.backgroundColor = .clear
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
