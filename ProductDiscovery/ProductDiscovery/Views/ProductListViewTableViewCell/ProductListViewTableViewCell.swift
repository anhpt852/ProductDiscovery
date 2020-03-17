//
//  ProductListViewTableViewCell.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/16/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit

class ProductListViewTableViewCell: UITableViewCell, UISearchBarDelegate {
    
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
                    
                    _lbProductPrice!.text = String.init(format: "%d", arguments: [sellPrice]);
                    if sellPrice != supplierSalePrice {
                        _lbProductOldPrice!.text = String.init(format: "%d", arguments: [supplierSalePrice])
                    }
                } else {
                    _lbProductPrice!.text = "Chưa có thông tin"
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public static func cell_identifier() -> String{
        return "list_product_view_cell";
    }
    
    //MARK: UISearchBarDelegate
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            var newText: String = text.copy() as! String
            newText = newText.trimmingCharacters(in: CharacterSet.whitespaces)
            if newText.count == 0 {
                return
            }
            
            // do search
        }
        
        
    }
}
