//
//  ProductDetailTopContainerViewController.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/16/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit

class ProductDetailTopContainerViewController: InlineViewController {

    @IBOutlet weak var _vCarousel: iCarousel!
    @IBOutlet weak var _lbProductName: UILabel!
    @IBOutlet weak var _lbProductSKU: UILabel!
    @IBOutlet weak var _vProductStatus: UIView!
    @IBOutlet weak var _lbProductStatus: UILabel!
    @IBOutlet weak var _lbProductPrice: UILabel!
    @IBOutlet weak var _lbProductOldPrice: UILabel!
    @IBOutlet weak var _pageController: UIPageControl!
    
    var _numOfImages = 0
    var _product: ProductItemEntity?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _vCarousel.isPagingEnabled = true
//        _vCarousel.itemWidth =
        
        if let productInfo = _product {
            if let images = productInfo.images {
                if images.count > 0 {
                    self._numOfImages = images.count
                    self._pageController.numberOfPages = self._numOfImages
                    _vCarousel.reloadData()
                }
            }
        }
        _pageController.currentPage = 0;
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector((self.scrollPageController)), userInfo: nil, repeats: true)
        
        _vProductStatus.layer.cornerRadius = 8.0
        _vProductStatus.layer.masksToBounds = true
        
        if let product =  _product {
            if let status =  product.status
                ,let name =  product.name
                ,let price =  product.price
                ,let sku =  product.sku{
                _lbProductName.text = name
                _lbProductSKU.text = sku
                if let statusSale = status.sale {
                     _lbProductStatus.text = self.convertProductStatus(statusSale)
                } else {
                    _lbProductStatus.text = "Không có thông tin"
                }
               
                if let sellPrice = price.sellPrice, let supplierSalePrice = price.supplierSalePrice {
                    
                    _lbProductPrice.text = String.init(format: "%d", arguments: [sellPrice]);
                    if sellPrice != supplierSalePrice {
                        _lbProductOldPrice.text = String.init(format: "%d", arguments: [supplierSalePrice])
                    }
                } else {
                    _lbProductPrice.text = "Không có thông tin"
                }
            }
        }
        
        self.updateData()
        // Do any additional setup after loading the view.
    }
    
    override func refreshData() {
        super.refreshData();
    }
    
    func convertProductStatus(_ statusCode: String) -> String {
        if statusCode == "ngung_kinh_doanh" {
            return "Ngừng Kinh Doanh"
        } else if (statusCode == "hang_ban"){
            return "Hàng đang bán"
        } else if (statusCode == "hang_sap_het"){
            return "Sắp hết hàng"
        } else {
            return "Không có thông tin"
        }
    }
    
    @objc func scrollPageController(timerSender : Timer) {
       //Do Somethings
        if _pageController.currentPage == _numOfImages - 1 {
            _pageController.currentPage = 0;
        } else {
            _pageController.currentPage = _pageController.currentPage+1;
        }
        
        _vCarousel.scrollToItem(at: _pageController.currentPage, animated: true)
    }

}

extension ProductDetailTopContainerViewController: iCarouselDataSource,iCarouselDelegate{
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self._numOfImages
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView = Bundle.main.loadNibNamed("ImageItemCell", owner: self, options: nil)![0] as? ImageItemCell
        let item = _product?.images![index]
        //reuse view if available, otherwise create a new view
        if let view = view as? ImageItemCell {
            itemView = view
        } else {
            itemView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
            itemView?._imageURL = URL.init(string: (item?.url)!)
        }
        return itemView!
    }
    
   
    
    
}
