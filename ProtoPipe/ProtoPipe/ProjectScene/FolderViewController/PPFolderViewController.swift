//
//  PPFolderViewController.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/21.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit
import SnapKit

class PPFolderViewController: PPBaseViewController, PPCanvasViewControllerDelegate, UIViewControllerTransitioningDelegate, UICollectionViewDelegate, UICollectionViewDataSource, PPFolderNavigationBarDelegate {

    let folderNavigationBar = PPFolderNavigationBar()
    var collectionView: UICollectionView!
    
    var collectionViewData: [PPFolderCollectionViewCellModel] = [PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false),PPFolderCollectionViewCellModel(title: "ProtoPipe原型 第一稿", detail: "最后修改于 2019/10/10", coverImage: #imageLiteral(resourceName: "pic"), isEditing: false)]
    
    let folderCollectionViewCellID = "FolderCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(withHex: 0x191B1D)
        
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
        
        folderNavigationBar.delegate = self
        view.addSubview(folderNavigationBar)
        folderNavigationBar.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(90)
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

// MARK: - PPFolderNavigationBarDelegate
extension PPFolderViewController {
    func folderNavigationBarDidClickSelectButton(_ folderNavigationBar: PPFolderNavigationBar) {
        for i in 0...collectionViewData.count - 1 {
            collectionViewData[i].isEditing = true
        }
        collectionView.reloadData()
    }
    
    func folderNavigationBarDidClickCancelButton(_ folderNavigationBar: PPFolderNavigationBar) {
        for i in 0...collectionViewData.count - 1 {
            collectionViewData[i].isEditing = false
        }
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension PPFolderViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: folderCollectionViewCellID, for: indexPath) as!PPFolderCollectionViewCell
        cell.model = collectionViewData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(collectionView.cellForItem(at: indexPath)?.frame.size ?? "error")
    }
}

// MARK: - PPCanvasViewControllerDelegate
extension PPFolderViewController {
    func canvasViewControllerDidClickedFolderButton(_ vc: PPCanvasViewController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension PPFolderViewController {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MagicMoveAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MagicMoveAnimator()
    }
}
