//
//  ProductDetailMidContainerViewController.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/16/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit
import CAPSPageMenu



class ProductDetailMidContainerViewController: InlineViewController,ProductDetailInfoListViewControllerDelegate, ProductDetailDescriptionViewControllerDelegate, ProductDetailPriceCompareViewControllerDelegate {

    var _curentPage = 0
    private var _isExpand = false
    private var _pageMenu : CAPSPageMenu?
    var _product: ProductItemEntity?
    @IBOutlet weak var _btnBlur: UIButton!
    private var _controller1: ProductDetailDescriptionViewController?
    private var _controller1Height:CGFloat = 0.0
    private var _controller2: ProductDetailInfoListViewController?
    private var _controller2Height:CGFloat = 0.0
    private var _controller3: ProductDetailPriceCompareViewController?
    private var _controller3Height:CGFloat = 0.0
    
    @IBOutlet weak var _lcViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateData()
        self.initViewController()
        
        _lcViewHeight.constant = 200
        
        // Do any additional setup after loading the view.
    }
    
    func initViewController(){
        if let product = _product {
            var controllerArray : [UIViewController] = []
            
            _controller1 = StoryboardManager.mainManager.instantiateViewControllerWithIdentifier(identifier: "detail_mid_description") as? ProductDetailDescriptionViewController
            _controller1!.delegate = self
            _controller1!.title = "Mô tả sản phẩm"
            controllerArray.append(_controller1!)
            
            _controller2 = StoryboardManager.mainManager.instantiateViewControllerWithIdentifier(identifier: "list_detail_info") as? ProductDetailInfoListViewController
            _controller2!.delegate = self
            _controller2!.title = "Thông số kĩ thuật"
            _controller2!._productAttributes = product.attributeGroups
            controllerArray.append(_controller2!)
            
            _controller3 = StoryboardManager.mainManager.instantiateViewControllerWithIdentifier(identifier: "detail_mid_price_compare") as? ProductDetailPriceCompareViewController
            _controller3!.delegate = self
            _controller3!.title = "So sánh giá"
            controllerArray.append(_controller3!)

            let parameters: [CAPSPageMenuOption] = [
                .menuItemSeparatorWidth(0),
                .scrollMenuBackgroundColor(UIColor.white),
                .viewBackgroundColor(UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)),
                .bottomMenuHairlineColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 0.1)),
                .selectionIndicatorColor(UIColor.init(hex: "df2020")),
                .menuMargin(20.0),
                .menuHeight(40.0),
                .selectedMenuItemLabelColor(UIColor.init(hex: "262829")),
                .unselectedMenuItemLabelColor(UIColor.init(hex: "8f9598")),
                .menuItemFont(UIFont(name: "HelveticaNeue-Medium", size: 14.0)!),
                .useMenuLikeSegmentedControl(true),
                .selectionIndicatorHeight(2.0),
            ]
            
            _pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
            
            // Optional delegate
            _pageMenu!.delegate = self
            
            self.view.addSubview(_pageMenu!.view, insets: UIEdgeInsets.zero)
            if(_isExpand == false) {
                self.view.bringSubviewToFront(_btnBlur)
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        let whiteColor = UIColor.white
        gradient.colors = [whiteColor.withAlphaComponent(0.0).cgColor, whiteColor.withAlphaComponent(0.8).cgColor, whiteColor.withAlphaComponent(1.0).cgColor]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = _btnBlur.bounds
        _btnBlur.layer.mask = gradient

    }
    override func refreshData() {
        super.refreshData();
        self.initViewController()
    }
    
    
    // MARK: ProductDetailInfoListViewControllerDelegate
    func updateHeight(_ height: CGFloat) {
        if _pageMenu?.currentPageIndex == 0 {
            _controller1Height = height + 40
        } else if (_pageMenu?.currentPageIndex == 1){
            _controller2Height = height + 40
        } else if (_pageMenu?.currentPageIndex == 2){
            _controller3Height = height + 40
        }
        
        if(_isExpand == true) {
            _lcViewHeight.constant = height + 40
        }
        
    }
    @IBAction func showAll(_ sender: Any) {
        _isExpand = true
        _btnBlur.isHidden = true
        self.refreshData()

    }
    
}

extension ProductDetailMidContainerViewController: CAPSPageMenuDelegate{
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        _curentPage = index
        if index == 0 {
            _lcViewHeight.constant = _controller1Height
        } else if (index == 1){
             _lcViewHeight.constant = _controller2Height
        } else if (index == 2){
             _lcViewHeight.constant = _controller3Height
        }
    }
}
