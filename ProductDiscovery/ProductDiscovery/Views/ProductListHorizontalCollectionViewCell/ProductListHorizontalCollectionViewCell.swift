//
//  ProductListHorizontalCollectionViewCell.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/17/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit

class ProductListHorizontalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var _ivProductThumb: UIImageView!
    @IBOutlet weak var _lbProductName: UILabel!
    @IBOutlet weak var _lbProductPrice: UILabel!
    @IBOutlet weak var _lbProductOldPrice: UILabel!
    
    var product: ProductItemEntity? {
        
        didSet {
            if let images =  product!.images
                ,let name =  product!.name
                ,let price =  product!.price{
                if images.count > 0 {
                    let image:ProductImage = images.first!
                    _ivProductThumb!.sd_setImage(with:URL.init(string: image.url! as String) , completed: nil)
                } else {
                    _ivProductThumb.image = UIImage.init(named: "ic_empty_product_thumb");
                }
                _lbProductName!.text = name
                
                if let sellPrice = price.sellPrice, let supplierSalePrice = price.supplierSalePrice {
                    
                    _lbProductPrice.attributedText = sellPrice.formatMoneyNumber();
                    if sellPrice != supplierSalePrice {
                        _lbProductOldPrice.attributedText = supplierSalePrice.formatMoneyNumber()
                    }
                } else {
                    _lbProductPrice!.text = "Chưa có thông tin"
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public static func cell_identifier() -> String{
        return "list_product_horizontal_cell";
    }
}
