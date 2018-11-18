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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var contentCellArr:[UIView] = []
    
    var pictureCounter = 0
    
    @IBAction func addPicture() {
        
        if pictureCounter == 0 {
            //0张图片时直接创建俩个框
            UIView.animate(withDuration: 0.5, animations: {
                self.textView.frame.size.height -= 125
                self.scrollView.frame.origin.y -= 133//125 + 8
                self.scrollView.frame.size.height += 133//125 + 8
            }) { (true) in
                self.scrollView.contentSize = CGSize(width: 250, height: 125)
                self.createAContentCellView(index: 0)
                self.createAButtonCellView(index: 1)
            }
            
        } else if pictureCounter >= 1 && pictureCounter < 8 {
            //1到7张图片后面跟着一个加号框时
            scrollView.contentSize = CGSize(width: 250 + 125 * pictureCounter, height: 125)
            
            contentCellArr[contentCellArr.count - 1].removeFromSuperview()
            contentCellArr.removeLast()
            
            createAContentCellView(index: pictureCounter)
            createAButtonCellView(index: pictureCounter + 1)
            
            UIView.animate(withDuration: 0.5) {
                self.scrollView.contentOffset = CGPoint(x: (self.pictureCounter - 1) * 125, y: 0)
            }

        } else if pictureCounter == 8{
            //有8张图片，准备添加第九张图片，此时数组内有9个cell
            scrollView.contentSize = CGSize(width: 125 * 9, height: 125)
            
            contentCellArr[contentCellArr.count - 1].removeFromSuperview()
            contentCellArr.removeLast()
            
            createAContentCellView(index: pictureCounter)
            createAButtonCellView(index: pictureCounter + 1)
            
        }
        pictureCounter += 1
    }
    
    @objc func deleteImage(sender: UIButton){
        var targetTag = sender.superview!.superview!.tag - 500
        contentCellArr[targetTag].removeFromSuperview()
        if contentCellArr.count == 2 && targetTag == 0 {
            print(1)
            //只剩一张照片时删除最后一张
            UIView.animate(withDuration: 0.5) {
                self.textView.frame.size.height += 125
                self.scrollView.frame.origin.y += 133//125 + 8
                self.scrollView.frame.size.height -= 133//125 + 8
            }
            
            //reset
            pictureCounter = 0
            contentCellArr[0].removeFromSuperview()
            contentCellArr[1].removeFromSuperview()
            contentCellArr = []
        } else if contentCellArr.count >= 3 && contentCellArr.count < 10 {
            //2...9张照片时
            print(2)
            targetTag += 1
            UIView.animate(withDuration: 0.5) {
                while targetTag <= self.contentCellArr.count - 1 {
                    self.contentCellArr[targetTag].frame.origin.x -= 125
                    self.contentCellArr[targetTag].tag -= 1
                    targetTag += 1
                }
                self.scrollView.contentSize.width -= 125
            }
            contentCellArr.remove(at: sender.superview!.superview!.tag - 500)
            pictureCounter -= 1
        } else if contentCellArr.count == 10 {
            print(3)
            targetTag += 1
            UIView.animate(withDuration: 0.5) {
                while targetTag <= self.contentCellArr.count - 1 {
                    self.contentCellArr[targetTag].frame.origin.x -= 125
                    self.contentCellArr[targetTag].tag -= 1
                    targetTag += 1
                }
            }
            contentCellArr.remove(at: sender.superview!.superview!.tag - 500)
            pictureCounter -= 1
        }
    }
    
    func createAContentCellView(index: Int){
        let contentCellView = ContentCellView(frame: CGRect(x: index * 125, y: 0, width: 125, height: 133))
        contentCellView.imageView.image = UIImage(named: "zebra")
        
        contentCellView.deleteBtn.addTarget(self, action: #selector(deleteImage(sender:)), for: .touchUpInside)
        
        contentCellArr.append(contentCellView)
        contentCellView.tag = 500 + contentCellArr.count - 1
        print("pictureCounter = \(pictureCounter)")
        scrollView.addSubview(contentCellArr[index])
    }
    
    func createAButtonCellView(index: Int){
        let btnCellView = ButtonCellView(frame: CGRect(x: index * 125, y: 0, width: 125, height: 133))
        btnCellView.btnView.setImage(UIImage(named: "add"), for: .normal)
        btnCellView.btnView.addTarget(self, action: #selector(addPicture), for: .touchUpInside)
        contentCellArr.append(btnCellView)
        scrollView.addSubview(contentCellArr[index])
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
            //键盘弹起动画
            self.bottomView.transform = CGAffineTransform(translationX: 0 , y: -deltaY)
            self.scrollView.transform = CGAffineTransform(translationX: 0 , y: -deltaY)
            self.textView.frame.size.height -= deltaY
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
        let userInfo = note.userInfo!
        let  keyBoardBounds = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            as! NSValue).cgRectValue
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]
            as! NSNumber).doubleValue
        let deltaY = keyBoardBounds.size.height
        
        let animations:(() -> Void) = {
            //键盘落下动画
            self.bottomView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.scrollView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.textView.frame.size.height += deltaY
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
