//
//  ContainerViewController.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/19/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit

class ContainerViewController: ContentViewController,InlineViewControllerDelegate {

    @IBOutlet var _vContent: UIView?
    
    // MARK: - constructor
    
    // MARK: - destructor
    
    // MARK: - public class methods
    
    // MARK: - private class methods
    
    // MARK: - override/overload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - public instance methods
    
    // MARK: - private instance methods
    
    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    func configureInlineViewControllers() {
        
    }
    
    func containerViewOfInlineViewController(_ viewController:InlineViewController) -> UIView? {
        return nil
    }
    
    func addInlineViewController(_ viewController:InlineViewController) {
        let containerView = self.containerViewOfInlineViewController(viewController)
        if let vContainer = containerView {
            self.addViewControllerInViewWithInsets(viewController, vContainer, UIEdgeInsets.zero)
        }
    }
    
    func topMarginOfInlineViewController(_ viewController:InlineViewController) -> CGFloat {
        return 10.0
    }
    
    func autolayoutInlineViewController(_ viewController:InlineViewController) {
        let containerView = self.containerViewOfInlineViewController(viewController)
        if containerView == nil { return }
        
        let width:CGFloat = (_vContent?.frame.size.width)!
        let height:CGFloat = viewController.heightOfViewWithWidth(width)
        
        var topConstraint:NSLayoutConstraint?
        for constraint:NSLayoutConstraint in (_vContent?.constraints)! {
            if constraint.firstAttribute == .top && constraint.firstItem as! NSObject == containerView!{
                topConstraint = constraint
                break
            }
        }
        
        if topConstraint != nil {
            let topConstant = height < 0 ? 0 : self.topMarginOfInlineViewController(viewController)
            topConstraint?.constant = topConstant
        }
        
        if height > 0{
            var heightConstraint:NSLayoutConstraint?
            for constraint:NSLayoutConstraint in (containerView?.constraints)! {
                if constraint.firstAttribute == .height && constraint.firstItem as? NSObject == containerView
                {
                    heightConstraint = constraint
                    break
                }
            }
            
            if heightConstraint != nil {
                heightConstraint?.constant = height
            }
        }
        containerView?.isHidden =  false
    }

    // MARK: - private action methods
    
    // MARK: - delegate methods
    func inlineViewControllerRequireAutolayout(_ viewController: InlineViewController) {
        self.autolayoutInlineViewController(viewController)
    }
}
