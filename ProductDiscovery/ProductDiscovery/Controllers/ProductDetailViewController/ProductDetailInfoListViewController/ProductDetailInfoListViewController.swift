//
//  ProductDetailInfoListViewController.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/17/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit

class ProductDetailInfoListViewController: BaseViewController {

    @IBOutlet weak var _tableView: UITableView!
    var delegate: ProductDetailInfoListViewController?
    
    var _productAttributes: [ProductAttributes]?
    
    var _numbOfAttributes = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if let productAttributes = _productAttributes {
            if productAttributes.count > 0 {
                self._numbOfAttributes = productAttributes.count
            }
        }
        _tableView.register(UINib(nibName: "ProductInfoTableViewCell", bundle: nil), forCellReuseIdentifier: ProductInfoTableViewCell.cell_identifier())
    }
    
    override func refreshData() {
       
    }
}


extension ProductDetailInfoListViewController: UITableViewDelegate,UITableViewDataSource {

    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _numbOfAttributes;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = _productAttributes![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductInfoTableViewCell.cell_identifier()) as! ProductInfoTableViewCell
        cell.info = item
        cell.cellBackgroundColor = (indexPath.row % 2) == 1 ? UIColor.init(hex: "eef1f3") : UIColor.white
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    

}
