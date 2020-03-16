//
//  BaseViewController.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/12/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit
import Alamofire
import PMAlertController

class BaseViewController: UIViewController {
    
    @IBOutlet var _btCart: UIButton?
    @IBOutlet var _scrollView: UIScrollView?
    
    var _progressHUD: MBProgressHUD?;
    var _error:NSError?
    private var _networkErrorAlertView:PMAlertController?
    var _cartBarButtonItem:BBBadgeBarButtonItem?

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let parent = self.parent {
            if( parent.isKind(of: UINavigationController.self)){
                var image:UIImage?
                image = UIImage.init(named: "bg_navigation_noel")?.resizable_()
                self.navigationController?.navigationBar.setBackgroundImage(image, for: .any, barMetrics:.default)
                if self.isNavigationBarShadowDisable() {
                    self.navigationController?.navigationBar.shadowImage = UIImage.init()
                    self.navigationController?.navigationBar.titleTextAttributes = [
                        NSAttributedString.Key.foregroundColor: UIColor.white,
                        NSAttributedString.Key.font:UIFont.init(name: "HelveticaNeue", size: 17.0)!
                    ]
                }
                
            }
        }
    }
    // MARK: - public instance methods
    func isNavigationBarShadowDisable() -> Bool {
        return true
    }
    
    func resetData(){
        
    }
    
    func loadData(){
        
    }
    
    func refreshData(){
        
    }
    
    func fetchData(){
    
    }
    
    func updateData(){
        
    }
    
    func hideLoadingIndicatorView(){
        if _progressHUD == nil {
            return;
        }
        _progressHUD?.hide(animated: false);
    }
    
    func handleResponse (response:AnyObject, error:NSError)
    {
    
    }
    
    func handleNetworkError(error:NSError){
        _error = error
        
        if(!self.isViewLoaded
            || !(self.view.window != nil)){
            return;
        }
        if error.domain == NSCocoaErrorDomain {
            let userInfo:NSDictionary? = error.userInfo as NSDictionary?
            let errorKey = userInfo?.value(forKey: "NSDebugDescription") as! String
            let reason = error.localizedFailureReason
            
            let alert:PMAlertController = PMAlertController(title: "", description: NSLocalizedString(" Error on \(errorKey)\rFailure Reason:\(String(describing: reason))", comment: ""), image: nil, style: .alert)
            
            alert.addAction(PMAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .default, action: {() in
            }))
            
            self.present(alert, animated: true, completion: nil)
           
        }
        if (error.domain == NSURLErrorDomain) {
            if _networkErrorAlertView != nil || error.code != NSURLErrorTimedOut {
                return
            }
            _networkErrorAlertView = PMAlertController(title: "", description: NSLocalizedString("request_timeout", comment: ""), image: nil, style: .alert)
            _networkErrorAlertView?.addAction(PMAlertAction(title: NSLocalizedString("request_load", comment: ""), style: .cancel, action: { () -> Void in
                self.refreshData()
            }))
            _networkErrorAlertView?.addAction(PMAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .default, action: {[weak self] () in
                let strongSelf = self
                strongSelf?._networkErrorAlertView = nil
            }))
            
            self.present(_networkErrorAlertView!, animated: true, completion: nil)
        }
    }
    
    func backBarButtonItem() -> UIBarButtonItem {
        let item:UIBarButtonItem = self.barButtonItemWithImageNamed(imageNamed: "ic_back", action:Selector.init(("backClicked:")))
        let button:UIButton = (item.customView as? UIButton)!
        
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16.0, bottom: 0, right: 0)
        return item
    }
    
    func cartBarButtonItem() -> UIBarButtonItem {
        if _cartBarButtonItem == nil {
            if let btCart = _btCart {
                _cartBarButtonItem = self.badgeBarButtonItemWithButton(button: btCart)
            }
            else
            {
                _cartBarButtonItem = self.badgeBarButtonItemWithImageNamed(imagedName: "ic_cart",
                                                                           action: Selector.init(("cartClicked:")))
//                _cartBarButtonItem?.badgeValue = 
//                _cartBarButtonItem?.tag =
            }
        }
         return _cartBarButtonItem!
    }
    
    func spaceBarButtonItem() -> UIBarButtonItem {
        let item = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        item.width = 5.0
        return item
    }

    
    func configureNavigationBar() -> Bool{
        if(self.parent == nil || (self.parent?.isKind(of: UINavigationController.self)) == false)
        {
            return false
        }
        
        self.navigationItem.backBarButtonItem
            = UIBarButtonItem.init(title: "",
                                   style: .plain,
                                   target: nil,
                                   action: nil)
        return true
    }
    // MARK: - private instance methods
    func barButtonItemWithImageNamed(imageNamed:NSString, action:Selector) -> UIBarButtonItem {
        let button:UIButton = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: imageNamed as String), for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return self.barButtonItemWithButton(button: button)
    }
    
    func barButtonItemWithButton(button:UIButton) -> UIBarButtonItem {
        return UIBarButtonItem.init(customView: button)
    }
    
    func badgeBarButtonItemWithImageNamed(imagedName:NSString, action:Selector) -> BBBadgeBarButtonItem {
        let button:UIButton = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: imagedName as String), for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        var bounds:CGRect = CGRect.init(x: 0, y: 0, width: 44.0, height: 44.0)
        button.bounds = bounds
        button.sizeToFit()
        bounds = button.bounds
        button.bounds = bounds
        
        return self.badgeBarButtonItemWithButton(button: button)
    }
    
    func badgeBarButtonItemWithButton(button:UIButton) -> BBBadgeBarButtonItem {
        let item:BBBadgeBarButtonItem = BBBadgeBarButtonItem.init(customUIButton: button)
        item.style = .plain
        item.badgeBGColor = UIColor.init(named: "db5a27")
        item.badgePadding = 4
        item.badgeOriginX = 12
        item.badgeOriginY = 4.0
        item.shouldAnimateBadge = true
        item.shouldHideBadgeAtZero = true
        item.badgeFont = UIFont.init(name: "HelveticaNeue", size: 11.0)
        item.badgeTextColor = UIColor.white
        return item
    }
    
    
    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    // MARK: - private action methods
    
    // MARK: - delegate methods

}
