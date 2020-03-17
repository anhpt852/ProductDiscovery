//
//  ContentViewController.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/12/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit

class ContentViewController: BaseViewController {
    
    
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

    // MARK: - BaseViewController
    
    override func refreshData() {
        
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        
        if (self.navigationController?.viewControllers.count)! > 1
        {
            self.navigationItem.leftBarButtonItems = [self.backBarButtonItem(),
                                                      self.spaceBarButtonItem()]
        }
        else
        {
            self.navigationItem.leftBarButtonItems = nil
        }
        
        self.navigationItem.rightBarButtonItems = []

    }
    
    func addViewControllerInViewWithInsets(_ viewController:BaseViewController?, _ parentView: UIView?, _ insets:UIEdgeInsets){
        guard let viewController = viewController, let parentView = parentView else {
            return
        }
        
        viewController.willMove(toParent: self)
        self.addChild(viewController)
        
        let childView =  viewController.view
        parentView.addSubview(childView, insets: insets)
        viewController.didMove(toParent: self)
    }
    // MARK: - public instance methods
    
    // MARK: - private instance methods
    
    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    // MARK: - private action methods
    
    // MARK: - delegate methods
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
