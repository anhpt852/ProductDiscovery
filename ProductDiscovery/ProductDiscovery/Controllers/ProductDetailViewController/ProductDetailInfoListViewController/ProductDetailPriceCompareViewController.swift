//
//  PriceDetailCompareViewController.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/18/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit
@objc protocol ProductDetailPriceCompareViewControllerDelegate {
    @objc optional func updateHeight(_ height:CGFloat)
    
}
class ProductDetailPriceCompareViewController: BaseViewController {
    @IBOutlet weak var _tableView: UITableView!
    @IBOutlet weak var _lcTableViewHeight :NSLayoutConstraint?
    @IBOutlet weak var _lcEmptyContentHeight: NSLayoutConstraint!
    var _productAttributes: [ProductAttributes]?
        var delegate: ProductDetailPriceCompareViewControllerDelegate?
        var _numbOfAttributes = 0
        
//        deinit {
//            if let tableView = _tableView {
//                tableView.removeObserver(self, forKeyPath: "contentSize")
//            }
//
//        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
//            if let productAttributes = _productAttributes {
//                if productAttributes.count > 0 {
//                    self._numbOfAttributes = productAttributes.count
//                }
//            }
            _lcEmptyContentHeight.priority = .defaultHigh
            _lcTableViewHeight?.priority = .defaultLow
            _tableView.isHidden = true
            if let updateHeight = delegate?.updateHeight {
                updateHeight(_lcEmptyContentHeight.constant)
            }
            
            _tableView.isScrollEnabled = false
            _tableView.register(UINib(nibName: "ProductInfoTableViewCell", bundle: nil), forCellReuseIdentifier: ProductInfoTableViewCell.cell_identifier())
//            _tableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
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


    extension ProductDetailPriceCompareViewController: UITableViewDelegate,UITableViewDataSource {

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
