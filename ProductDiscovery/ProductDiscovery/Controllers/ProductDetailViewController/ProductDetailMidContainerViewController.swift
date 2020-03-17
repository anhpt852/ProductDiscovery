//
//  ProductDetailMidContainerViewController.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/16/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit
import CAPSPageMenu

class ProductDetailMidContainerViewController: InlineViewController, CAPSPageMenuDelegate {

    var _pageMenu : CAPSPageMenu?
    var _product: ProductItemEntity?
    var _controller1: ProductDetailInfoListViewController?
    var _controller2: ProductDetailInfoListViewController?
    var _controller3: ProductDetailInfoListViewController?
    
    @IBOutlet weak var _lcViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateData()
        self.initViewController()
        
        // Do any additional setup after loading the view.
    }
    
    func initViewController(){
        var controllerArray : [UIViewController] = []
        
        _controller1 = StoryboardManager.mainManager.instantiateViewControllerWithIdentifier(identifier: "list_detail_info") as? ProductDetailInfoListViewController
        _controller1!.title = "Mô tả sản phẩm"
        controllerArray.append(_controller1!)
        
        _controller2 = StoryboardManager.mainManager.instantiateViewControllerWithIdentifier(identifier: "list_detail_info") as? ProductDetailInfoListViewController
        _controller2!.title = "Thông số kĩ thuật"
        _controller2!._productAttributes = _product?.attributeGroups
        controllerArray.append(_controller2!)
        
        _controller3 = StoryboardManager.mainManager.instantiateViewControllerWithIdentifier(identifier: "list_detail_info") as? ProductDetailInfoListViewController
        _controller3!.title = "So sánh giá"
        controllerArray.append(_controller3!)

        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(0),
            .scrollMenuBackgroundColor(UIColor.white),
            .viewBackgroundColor(UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)),
            .bottomMenuHairlineColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 0.1)),
            .selectionIndicatorColor(UIColor(red: 18.0/255.0, green: 150.0/255.0, blue: 225.0/255.0, alpha: 1.0)),
            .menuMargin(20.0),
            .menuHeight(40.0),
            .selectedMenuItemLabelColor(UIColor(red: 18.0/255.0, green: 150.0/255.0, blue: 225.0/255.0, alpha: 1.0)),
            .unselectedMenuItemLabelColor(UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)),
            .menuItemFont(UIFont(name: "HelveticaNeue-Medium", size: 14.0)!),
            .useMenuLikeSegmentedControl(true),
            .selectionIndicatorHeight(2.0),
        ]
        
        _pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        // Optional delegate
        _pageMenu!.delegate = self
        
        self.view.addSubview(_pageMenu!.view, insets: UIEdgeInsets.zero)
    }
    
    override func refreshData() {
        super.refreshData();
        self.initViewController()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
