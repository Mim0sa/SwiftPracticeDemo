//
//  HomeViewContoller.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/10/23.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit
import WebKit

class HomeViewContoller: UIViewController {
    
    var webViews: [WKWebView] = []
    var btns: [UIButton] = []
    var backBtn: UIButton?
    var detailView: ChapterDetailView?
    
    let btnStatus: [Bool] = [true, false, false]
    
    var lastTag: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebViews()
        
        setupBtns()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBigTitle()
    }

    func setupWebViews() {
        for i in 0...2 {
            let webView = WKWebView()
            self.view.addSubview(webView)
            webView.frame = self.view.bounds
            
            let url = Bundle.main.url(forResource: "Chapter"+"\(i+1)", withExtension: "html", subdirectory: "Chapter"+"\(i+1)")!
            webView.loadFileURL(url, allowingReadAccessTo: url)
            let request = URLRequest(url: url)
            webView.load(request)
            
            let mask = UIView()
            mask.frame = CGRect(x: CGFloat(i) * SCREENWIDTH / 3, y: 0, width: SCREENWIDTH / 3, height: SCREENHEIGHT)
            mask.backgroundColor = UIColor.black
            webView.mask = mask
            
            webView.isUserInteractionEnabled = false
            webViews.append(webView)
        }
    }
    
    func setupBtns() {
        for i in 0...2 {
            let btn = UIButton(frame: webViews[i].mask!.frame)
            btn.setImage(UIImage(named: btnStatus[i] ? "" : "lock"), for: .normal)
            btn.alpha = 0
            btn.layer.cornerRadius = 25
            btn.tag = 100 + i
            view.addSubview(btn)
            btn.addTarget(self, action: #selector(btnClicked(sender:)), for: .touchUpInside)
            btns.append(btn)
        }
        // backbtn
        backBtn = UIButton(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        backBtn?.setImage(UIImage(named: "back"), for: .normal)
        backBtn?.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        view.addSubview(backBtn!)
        backBtn?.isHidden = true
    }
    
    func setupBigTitle() {
        let img = UIImageView(image: UIImage(named: "bigtitle"))
        img.frame.size = CGSize(width: 1000, height: 800)
        img.center = CGPoint(x: view.center.x, y: view.center.y)
        view.addSubview(img)
        
        UIView.animate(withDuration: 0.25, delay: 1.5, options: [], animations: {
            img.center.y -= SCREENHEIGHT
            for btn in self.btns {
                btn.alpha = 1
            }
        })
        
        let iconView = UIView(frame: view.frame)
        iconView.backgroundColor = .white
        view.addSubview(iconView)
        
        let icon = UIImageView()
        icon.image = UIImage(named: "icon")
        icon.frame = CGRect(x: SCREENWIDTH / 2 - 100, y: SCREENHEIGHT / 2 - 100, width: 200, height: 200)
        icon.frame.size = CGSize(width: 200, height: 200)
        iconView.addSubview(icon)
        icon.layer.cornerRadius = 25
        icon.clipsToBounds = true
        
        UIView.animate(withDuration: 0.25, delay: 0.75, options: [], animations: {
            iconView.alpha = 0
        }) { (_) in
            iconView.removeFromSuperview()
        }
    }
    
    @objc func btnClicked(sender: UIButton) {
        for btn in btns {
            btn.isHidden = true
        }
        
        let tag = sender.tag - 100
        lastTag = tag
        
        if tag == 1 {
            view.sendSubviewToBack(webViews[2])
        } else if tag == 0 {
            view.sendSubviewToBack(webViews[2])
            view.sendSubviewToBack(webViews[1])
        }
        
        detailView = ChapterDetailView(chapter: lastTag! + 1)
        detailView?.delegate = self
        view.insertSubview(detailView!, belowSubview: backBtn!)

        UIView.animate(withDuration: 0.3, animations: {
            self.webViews[tag].mask?.frame = self.view.frame
        }) { (isFinished) in
            self.backBtn?.isHidden = false
        }
    }
    
    @objc func backClicked() {
        detailView!.removeFromSuperview()
        detailView = nil
        UIView.animate(withDuration: 0.3, animations: {
            self.webViews[self.lastTag!].mask?.frame = CGRect(x: CGFloat(self.lastTag!) * SCREENWIDTH / 3, y: 0, width: SCREENWIDTH / 3, height: SCREENHEIGHT)
        }) { (isFinished) in
            if self.lastTag == 1 {
                self.view.sendSubviewToBack(self.webViews[1])
                self.view.sendSubviewToBack(self.webViews[0])
            } else if self.lastTag == 0 {
                self.view.sendSubviewToBack(self.webViews[0])
            }
            
            self.backBtn?.isHidden = true
            for btn in self.btns { btn.isHidden = false }
        }
    }
    
}

extension HomeViewContoller: ChapterDetailViewDidClickedDelegate {
    func chapterDetailViewDidClicked(chessInfo: ChessInfo) {
        self.present(ViewController(chessInfo: chessInfo), animated: true) {
            
        }
    }
}
