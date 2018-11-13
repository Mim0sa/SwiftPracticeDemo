//
//  ViewController.swift
//  YDS_demo
//
//  Created by 吉乞悠 on 2018/11/13.
//  Copyright © 2018 吉乞悠. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headImageView.layer.cornerRadius = 16
        headImageView.layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(note:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //---------------------
    
    @IBOutlet weak var contentViewOfScrollView: UIView!
    
    var pictureCounter = 0
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var contentCellArr:[ContentCellView] = []
    
    @IBAction func addPicture(_ sender: UIButton) {
        if pictureCounter == 0 {
            //0张图片时直接创建俩个框
            scrollView.contentSize = CGSize(width: 250, height: 125)
            contentCellArr.append(createAContentCellView(index: 0))
            contentViewOfScrollView.addSubview(contentCellArr[0])
            contentCellArr.append(createAContentCellView(index: 1))//加号cell
            contentViewOfScrollView.addSubview(contentCellArr[1])
            
            pictureCounter += 1
            
        } else if pictureCounter >= 1 && pictureCounter < 8 {
            //1到7张图片时后面跟着一个加号框
            scrollView.contentSize = CGSize(width: 250 + 125 * pictureCounter, height: 125)
            contentCellArr.removeLast()
            contentCellArr.append(createAContentCellView(index: pictureCounter))
            contentViewOfScrollView.addSubview(contentCellArr[pictureCounter])
            contentCellArr.append(createAContentCellView(index: pictureCounter + 1))//加号cell
            contentViewOfScrollView.addSubview(contentCellArr[pictureCounter + 1])
            
            pictureCounter += 1
            
        } else if pictureCounter == 8{
            //添加第九张图片，此时数组内有9个cell
            scrollView.contentSize = CGSize(width: 125 + 125 * pictureCounter, height: 125)
            contentCellArr.removeLast()
            contentCellArr.append(createAContentCellView(index: pictureCounter))
            contentViewOfScrollView.addSubview(contentCellArr[pictureCounter])
            
            pictureCounter += 1
            
        }
    }
    
    func createAContentCellView(index: Int) -> ContentCellView {
        let contentCellView = ContentCellView(frame: CGRect(x: index * 125, y: 0, width: 125, height: 125))
        contentCellView.backgroundColor = UIColor.randomColor
        return contentCellView
    }
    
    //--------------------------
    
    @objc func keyboardWillShow(note: NSNotification) {
        let userInfo = note.userInfo!
        let  keyBoardBounds = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            as! NSValue).cgRectValue
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]
            as! NSNumber).doubleValue
        let deltaY = keyBoardBounds.size.height
        
        let animations:(() -> Void) = {
            //键盘的偏移量
            self.bottomView.transform = CGAffineTransform(translationX: 0 , y: -deltaY)
            
        }
        
        if duration > 0 {
            let options = UIView.AnimationOptions(rawValue: UInt((userInfo[UIResponder.keyboardAnimationCurveUserInfoKey]
                as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
    }
    
    @objc func keyboardWillHidden(note: NSNotification) {
        let userInfo  = note.userInfo!
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]
            as! NSNumber).doubleValue
        
        let animations:(() -> Void) = {
            //键盘的偏移量
            self.bottomView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        if duration > 0 {
            let options = UIView.AnimationOptions(rawValue: UInt((userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }
    
}
