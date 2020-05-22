//
//  MagicMoveAnimator.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/21.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class MagicMoveAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containerView = transitionContext.containerView
        
        var toView = toViewController?.view
        if transitionContext.responds(to: #selector(UIViewControllerTransitionCoordinatorContext.view(forKey:))) {
            toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        }
        
        toView?.frame = transitionContext.finalFrame(for: toViewController!)
        toView?.alpha = 0.0
        
        containerView.addSubview(toView!)

        let tempView = UIImageView()
        tempView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        tempView.backgroundColor = .orange
        containerView.addSubview(tempView)
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: transitionDuration, animations: {
            tempView.frame = transitionContext.finalFrame(for: toViewController!)
        }) { (finished: Bool) -> Void in
            tempView.alpha = 0
            toView!.alpha = 1.0
            
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
}
