//
//  ProudctDetailViewController.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/16/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit

class ProductDetailViewController: ContainerViewController {

    @IBOutlet weak var _vTopContainer: UIView!
    @IBOutlet weak var _vMidContainer: UIView!
    @IBOutlet weak var _vBottomContainer: UIView!
    @IBOutlet var _vTitle: UIView!
    @IBOutlet weak var _lbProductName: UILabel!
    @IBOutlet weak var _lbProductPrice: UILabel!
    
    var _topVc: ProductDetailTopContainerViewController?
    var _midVc: ProductDetailMidContainerViewController?
    var _bottomVc: ProductDetailBottomContainerViewController?
    
    var _productInfo: ProductItemEntity?
    var _productDetail: ProductItemEntity?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        self.configureInlineViewControllers()
        // Do any additional setup after loading the view.
    }
    
    override func fetchData() {
        if let sku =  _productInfo!.sku{
            NetworkManager.sharedManager.getDetailProduct(sku, {result in
                do {
                    let value = try result.get()
                    if let result = value.result{
                        if let product =  result.product{
                            self._productDetail = product
                            self._topVc?._product = self._productDetail
                            self._midVc?._product = self._productDetail
                            self._bottomVc?._product = self._productDetail
                            self.refreshData()
                        }
                    }
                }
                catch{
                    
                }
            })
        }
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()

        _vTitle.frame = (self.navigationController?.navigationBar.bounds)!
        if let productInfo = _productInfo {
            if let productName = productInfo.name {
                self._lbProductName.text = productName
            }
            
            if let productPrice = _productInfo?.price {
                if let sellPrice = productPrice.sellPrice {
                    
                    _lbProductPrice!.text = String.init(format: "%d", arguments: [sellPrice]);
                } else {
                    _lbProductPrice!.text = ""
                }
            }
            
        }
        
        self.navigationItem.titleView = _vTitle
        
        if (self.navigationController?.viewControllers.count)! > 1
        {
            self.navigationItem.leftBarButtonItems = [self.backBarButtonItem(),
                                                      self.spaceBarButtonItem()]
        }
        else
        {
            self.navigationItem.leftBarButtonItems = nil
        }
        
        self.navigationItem.rightBarButtonItems = [self.cartBarButtonItem()]
        
    }
    
    override func navigationBarBackgroundColor() -> Color? {
        return Color.white
    }
    
    override func refreshData() {
        super.refreshData()

        _topVc?.refreshData();
        _midVc?.refreshData();
        _bottomVc?.refreshData();
    }

    // MARK: - ContainerViewController
    override func configureInlineViewControllers() {
        
        _topVc = StoryboardManager.mainManager.instantiateViewControllerWithIdentifier(identifier: "detail_product_top_vc") as? ProductDetailTopContainerViewController
        if let topVc = _topVc {
            topVc.delegate = self;
            topVc._product = self._productDetail
            self.addInlineViewController(topVc)
        }
        
        
        _midVc = StoryboardManager.mainManager.instantiateViewControllerWithIdentifier(identifier: "detail_product_mid_vc") as? ProductDetailMidContainerViewController
        if let midVc = _midVc {
            midVc.delegate = self;
            self.addInlineViewController(midVc)
        }
       
        _bottomVc = StoryboardManager.mainManager.instantiateViewControllerWithIdentifier(identifier: "detail_product_bottom_vc") as? ProductDetailBottomContainerViewController
        if let bottomVc = _bottomVc {
            bottomVc.delegate = self;
            bottomVc._product = self._productDetail
            self.addInlineViewController(bottomVc)
        }
    }
    
    override func topMarginOfInlineViewController(_ viewController: InlineViewController) -> CGFloat {
        return 10
    }
    
    override func containerViewOfInlineViewController(_ viewController: InlineViewController) -> UIView? {
        if viewController == _topVc {
            return _vTopContainer
        } else if(viewController == _midVc){
            return _vMidContainer
        } else if(viewController == _bottomVc){
            return _vBottomContainer
        }
        return nil;
    }
    
    override func autolayoutInlineViewController(_ viewController: InlineViewController) {
        super.autolayoutInlineViewController(viewController);
        if let topVc = _topVc
            ,let midVc = _midVc
            ,let bottomVc = _bottomVc{
            if topVc.ready
                && midVc.ready
                && bottomVc.ready {
                self.hideLoadingIndicatorView()
            }
        }
    }
}
