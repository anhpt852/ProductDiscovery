//
//  ProductListViewTableViewCell.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/16/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit
import SkeletonView
class ProductListViewTableViewCell: UITableViewCell, UISearchBarDelegate {
    
    @IBOutlet weak var _ivProductThumb: UIImageView!
    @IBOutlet weak var _lbProductName: UILabel!
    @IBOutlet weak var _lbProductPrice: UILabel!
    @IBOutlet weak var _lbProductOldPrice: UILabel!
    @IBOutlet weak var _lbDiscountPercent: UILabel!
    @IBOutlet weak var _vOldPrice: UIView!
    
    
    let gradient = SkeletonGradient(baseColor: SkeletonAppearance.default.tintColor)
    var product: ProductItemEntity? {
        
        didSet {
            if let _product = product {
                if let images =  _product.images
                        ,let name =  _product.name
                        ,let price =  _product.price{
                        if images.count > 0 {
                            let image:ProductImage = images.first!
                            _ivProductThumb!.sd_setImage(with:URL.init(string: image.url! as String) , completed: nil)
                        } else {
                            _ivProductThumb.image = UIImage.init(named: "ic_empty_product_thumb");
                        }
                        _lbProductName!.text = name
                        
                        if let sellPrice = price.sellPrice, let supplierSalePrice = price.supplierSalePrice {
                            
                            _lbProductPrice.attributedText = sellPrice.formatMoneyNumber();
                            if sellPrice != supplierSalePrice{
                                let attributeString: NSMutableAttributedString =  supplierSalePrice.formatMoneyNumber()
                                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                                _lbProductOldPrice.attributedText = attributeString
                                
                                let discount = (supplierSalePrice/sellPrice) * 100
                                _lbDiscountPercent.text = String.init(format: "-%.f", discount)+"% "
                                _vOldPrice.isHidden =  false
                            } else {
                                _vOldPrice.isHidden = true
                            }
                        } else {
                            _vOldPrice.isHidden = true
                            _lbProductPrice!.text = "Chưa có thông tin"
                        }
                    }
                }
            }
            
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        [_ivProductThumb,_lbProductName,_lbProductPrice, _lbProductOldPrice].forEach{$0?.showAnimatedGradientSkeleton(usingGradient: gradient, transition: .crossDissolve(0.7))}
 
        // Initialization code
    }

    func hideAnimation(){
        [_ivProductThumb,_lbProductName,_lbProductPrice, _lbProductOldPrice].forEach{$0?.hideSkeleton()}
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public static func cell_identifier() -> String{
        return "list_product_view_cell";
    }
    
}
