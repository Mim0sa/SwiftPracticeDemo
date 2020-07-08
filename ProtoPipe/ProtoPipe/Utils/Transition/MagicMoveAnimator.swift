//
//  MagicMoveAnimator.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/21.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class MagicMoveAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let fromRect: CGRect
    let toRect: CGRect
    
    init(fromRect: CGRect, toRect: CGRect) {
        self.fromRect = fromRect
        self.toRect = toRect
        
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        let containerView = transitionContext.containerView
        
        var toView = toViewController?.view
        var fromView = fromViewController?.view
        if transitionContext.responds(to: #selector(UIViewControllerTransitionCoordinatorContext.view(forKey:))) {
            toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
            fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        }
        
        toView?.frame = transitionContext.finalFrame(for: toViewController!)
        toView?.alpha = 0.0
        
        fromView?.frame = transitionContext.initialFrame(for: fromViewController!)
        
        containerView.addSubview(toView!)

        let tempView = UIImageView()
        tempView.frame = fromRect
        tempView.backgroundColor = .orange
        containerView.addSubview(tempView)
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(withDuration: transitionDuration, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.6) {
                tempView.frame = self.toRect
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                tempView.alpha = 0
                toView!.alpha = 1.0
            }
        }) { (finished: Bool) -> Void in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
}
