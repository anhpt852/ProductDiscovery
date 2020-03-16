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
    
    var _topVc: ProductDetailTopContainerViewController?
    var _midVc: ProductDetailMidContainerViewController?
    var _bottomVc: ProductDetailBottomContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureInlineViewControllers()
        // Do any additional setup after loading the view.
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
