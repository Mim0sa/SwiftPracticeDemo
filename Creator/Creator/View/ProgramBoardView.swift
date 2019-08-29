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
    var programTableViewData: [OptionKey] = [] //didset?
    
    let tableView = UITableView()
    
    let cellID = "ProgramBoardTableViewCell"
    
    var frameOfVisibleCells: [CGRect] {
        get {
            let visibleCells = tableView.visibleCells
            var reactOfVisibleCells: [CGRect] = []
            for cell in visibleCells {
                var frame = convert(cell.frame, from: superview)
                frame.origin.x = -frame.origin.x
                reactOfVisibleCells.append(frame)
            }
            return reactOfVisibleCells
        }
    }

    init(point: CGPoint, width: CGFloat, blockNum: Int) {
        // initialize
        self.blockNum = blockNum
        
        super.init(frame: CGRect(x: point.x, y: point.y, width: width, height: 5 * (width - gap) + gap))
        
        // preference
        for _ in 0...blockNum - 1 { programTableViewData.append(.Null) }
        
        backgroundColor = .brown
        layer.cornerRadius = cornerRadius
        
        //setupUI
        setupUI()
    }
    
    func setupUI(){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 100))
        headerView.backgroundColor = .clear
        let headerViewImageView = UIImageView(frame: CGRect(x: 20, y: 20, width: frame.width - 40, height: 100 - 20))
        headerViewImageView.backgroundColor = .orange
        headerViewImageView.layer.cornerRadius = cornerRadius
        headerView.addSubview(headerViewImageView)
        
        tableView.frame = CGRect(x: 0, y: gap, width: frame.width, height: frame.height - 2 * gap)
        tableView.backgroundColor = .cyan
//        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.tableHeaderView = headerView
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProgramBoardTableViewCell.self, forCellReuseIdentifier: cellID)
        addSubview(tableView)
    }
    
    // MARK: - 更新列表
    func updateProgramTableView(){
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProgramBoardView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ProgramBoardTableViewCell
        cell.blockBtn.setImage(UIImage(named: programTableViewData[indexPath.row].rawValue), for: .normal)
        cell.tag = 100 + indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for frame in frameOfVisibleCells {
            print(frame)
        }
    }
}
