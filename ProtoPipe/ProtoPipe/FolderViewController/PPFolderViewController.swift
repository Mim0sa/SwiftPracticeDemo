//
//  PPFolderViewController.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/21.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit
import SnapKit

class PPFolderViewController: PPBaseViewController, PPCanvasViewControllerDelegate, UIViewControllerTransitioningDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let folderNavigationBar = PPFolderNavigationBar()
    var collectionView: UICollectionView!
    
    let folderCollectionViewCellID = "FolderCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(withHex: 0x191B1D)
        
        view.addSubview(folderNavigationBar)
        folderNavigationBar.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(90)
        }
        
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: PPFolderCollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PPFolderCollectionViewCell.self, forCellWithReuseIdentifier: folderCollectionViewCellID)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(0)
            make.right.equalTo(10)
            make.top.equalTo(90)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        flowLayout.itemSize = folderCollectionViewCellSize
        flowLayout.invalidateLayout()
    }

    @objc func buttonClicked(sender: UIButton) {
        let vc = PPCanvasViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.transitioningDelegate = self
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }

}

extension PPFolderViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: folderCollectionViewCellID, for: indexPath)
        //cell.backgroundColor = .randomColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(collectionView.cellForItem(at: indexPath)?.frame.size)
    }
}

extension PPFolderViewController {
    func canvasViewControllerDidClickedFolderButton(vc: PPCanvasViewController) {
        dismiss(animated: true, completion: nil)
    }
}

extension PPFolderViewController {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MagicMoveAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MagicMoveAnimator()
    }
}
