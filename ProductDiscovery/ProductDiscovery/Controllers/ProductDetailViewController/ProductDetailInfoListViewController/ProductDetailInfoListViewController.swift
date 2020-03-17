//
//  ProductDetailInfoListViewController.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/17/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit

@objc protocol ProductDetailInfoListViewControllerDelegate {
    @objc optional func updateHeight(_ height:CGFloat)
    
}

class ProductDetailInfoListViewController: BaseViewController {

    @IBOutlet weak var _tableView: UITableView!
    @IBOutlet weak var _lcTableViewHeight :NSLayoutConstraint?
    var _productAttributes: [ProductAttributes]?
    var delegate: ProductDetailInfoListViewControllerDelegate?
    var _numbOfAttributes = 0
    
    deinit {
        _tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let productAttributes = _productAttributes {
            if productAttributes.count > 0 {
                self._numbOfAttributes = productAttributes.count
            }
        }
        _tableView.isScrollEnabled = false
        _tableView.register(UINib(nibName: "ProductInfoTableViewCell", bundle: nil), forCellReuseIdentifier: ProductInfoTableViewCell.cell_identifier())
        _tableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func refreshData() {
       
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object as? UITableView == _tableView {
            if keyPath == "contentSize" {
                let value = CGFloat(_lcTableViewHeight!.constant) - _tableView.contentSize.height
                if (Float(abs(value)) < .ulpOfOne) {
                    return
                }
                _lcTableViewHeight?.constant = _tableView.contentSize.height
                if let updateHeight = delegate?.updateHeight {
                    updateHeight(_tableView.contentSize.height)
                }
                _tableView.layoutIfNeeded()
            }
        }
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
