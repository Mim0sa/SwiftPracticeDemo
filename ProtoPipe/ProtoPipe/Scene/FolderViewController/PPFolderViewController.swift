//
//  PPFolderViewController.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/21.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit
import SnapKit

class PPFolderViewController: PPBaseViewController, PPCanvasViewControllerDelegate {

    let folderNavigationBar = PPFolderNavigationBar()
    var collectionView: UICollectionView!
    
    var model = PPFolderCollectionViewModel() {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .sceneBlack
        
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: PPFolderCollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PPFolderCollectionViewCell.self, forCellWithReuseIdentifier: FolderCollectionViewCellID)
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
extension PPFolderViewController: PPFolderNavigationBarDelegate {
    func folderNavigationBarDidClickSelectButton(_ folderNavigationBar: PPFolderNavigationBar) {
        model.updateEditStatus(with: folderNavigationBar.isSelected)
    }
    
    func folderNavigationBarDidClickCancelButton(_ folderNavigationBar: PPFolderNavigationBar) {
        model.updateEditStatus(with: folderNavigationBar.isSelected)
    }
    
    func folderNavigationBarDidClickNewButton(_ folderNavigationBar: PPFolderNavigationBar) {
        let newFileToast = PPNewFileToast()
        newFileToast.delegate = self
        present(newFileToast, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
fileprivate let FolderCollectionViewCellID = "FolderCollectionViewCell"

extension PPFolderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCollectionViewCellID, for: indexPath) as! PPFolderCollectionViewCell
        cell.delegate = self
        cell.model = model.modelData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - PPFolderCollectionViewCellDelegate
extension PPFolderViewController: PPFolderCollectionViewCellDelegate {
    func folderCollectionViewCellDidUpdateChosenStatus(_ cell: PPFolderCollectionViewCell) {
        model.updateChosenStatus(at: collectionView.indexPath(for: cell)!.row)
    }
}
 
// MARK: - PPToastViewControllerDelegate
extension PPFolderViewController: PPToastViewControllerDelegate {
    func toastViewControllerDidClickCancelBtn(_ toastViewController: PPToastViewController) {
        dismiss(animated: true, completion: nil)
    }

    func newFileToastDidClickConfirmBtn(_ toastViewController: PPToastViewController, newFileModel: NewFileModel) {
        dismiss(animated: true, completion: nil)
        let file = PPFile(name: newFileModel.title, device: newFileModel.device, template: newFileModel.template)

        collectionView.performBatchUpdates({
            model.newFile(file)
            collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
        }, completion: nil)
    }
}

// MARK: - PPCanvasViewControllerDelegate
extension PPFolderViewController {
    func canvasViewControllerDidClickedFolderButton(_ vc: PPCanvasViewController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension PPFolderViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MagicMoveAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MagicMoveAnimator()
    }
}
