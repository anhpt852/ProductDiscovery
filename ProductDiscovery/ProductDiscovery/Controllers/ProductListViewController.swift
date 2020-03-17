//
//  ViewController.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/16/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit

class ProductListViewController: BaseViewController{
    

    @IBOutlet weak var _tableView: UITableView!
    @IBOutlet var _searchBar: UISearchBar!
    var listProducts = [ProductItemEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        _tableView.register(UINib(nibName: "ProductListViewTableViewCell", bundle: nil), forCellReuseIdentifier: ProductListViewTableViewCell.cell_identifier())
        self.fetchData()
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()

        
        _searchBar.frame = (self.navigationController?.navigationBar.bounds)!
        _searchBar.tintColor = Color.white
        self.navigationItem.titleView = _searchBar
        
        UISearchBar.appearance().tintColor = UIColor.white
        if let textfield = _searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.init(hex: "#8f9598")
            textfield.backgroundColor = UIColor.white

        }
        
        
        if (self.navigationController?.viewControllers.count)! > 1
        {
            self.navigationItem.leftBarButtonItems = [self.backBarButtonItem(),
                                                      self.spaceBarButtonItem()]
        }
        else
        {
            self.navigationItem.leftBarButtonItems = nil
        }
        
        self.navigationItem.rightBarButtonItems = []
        
    }
    
    override func navigationBarBackgroundColor() -> Color? {
        return Color.init(hex: "#ea341f")
    }
    
    override func fetchData() {
        NetworkManager.sharedManager.getListProduct({result in
            do {
                let value = try result.get()
                if let result = value.result{
                    if let products =  result.products{
                        self.listProducts = products;
                        self._tableView.reloadData();
                    }
                }
            }
            catch{
                
            }
        })
    }

}

extension ProductListViewController: UITableViewDelegate,UITableViewDataSource {

    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProducts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = listProducts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListViewTableViewCell.cell_identifier()) as! ProductListViewTableViewCell
        cell.product = item
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = listProducts[indexPath.row]
        let detailVC = StoryboardManager.mainManager.instantiateViewControllerWithIdentifier(identifier: "detail_product_vc") as! ProductDetailViewController
        detailVC._productInfo = item
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

}

