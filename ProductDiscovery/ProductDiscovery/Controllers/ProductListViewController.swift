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
    var _loading = false
    var _currentPage = 1
    var _totalItems = 0
    var _totalPages = 0
    var _keyword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        _tableView.keyboardDismissMode = .onDrag
        _tableView.register(UINib(nibName: "ProductListViewTableViewCell", bundle: nil), forCellReuseIdentifier: ProductListViewTableViewCell.cell_identifier())
        self.refreshData()
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
    
    func handleResponse(_ value: ProductListEntity){
        if let result = value.result, let extra = value.extra{
            if let products =  result.products {
                self.listProducts += products;
                self._tableView.reloadData();
            }
            
            if let totalItems = extra.totalItems {
                self._totalItems = totalItems
                self._totalPages = totalItems / 10
            }
        }
    }
    
    override func fetchData() {
        
        NetworkManager.sharedManager.getListProduct( _currentPage  , _keyword, {result in
            self._loading = false
            do {
                let value = try result.get()
                self.handleResponse(value)
            }
            catch{
                
            }
        },cacheCompletion: { error, cache in
            if(cache != nil){
                let value = cache as! ProductListEntity
                self.handleResponse(value)
            }
            
        })
    }
    
    override func resetData() {
        _loading = false
        _currentPage = 1
        _totalItems = 0
        _totalPages = 0
        
        listProducts = []
    }
    
    override func refreshData() {
        self.resetData()
        self.loadData()
    }
    
    override func loadData() {
        if (_loading == true) {
            return
        }
        _loading =  true
        DispatchQueue.main.async {
              //your code block
            self._tableView.reloadData()
        }
        self.fetchData()
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
        
        if _loading == false && _currentPage < _totalPages && (listProducts.count - indexPath.row) < 5{
            _currentPage += 1
            self.loadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = listProducts[indexPath.row]
        let detailVC = StoryboardManager.mainManager.instantiateViewControllerWithIdentifier(identifier: "detail_product_vc") as! ProductDetailViewController
        detailVC._productInfo = item
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

}
extension ProductListViewController: UISearchBarDelegate {

    //MARK: UISearchBarDelegate
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                searchBar.resignFirstResponder()
            }
        }
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload), object: nil)
        self.perform(#selector(self.reload), with: nil, afterDelay: 0.5)
    }
    
    @objc func reload() {
        guard let searchText = _searchBar.text else { return }
        _keyword = searchText
        refreshData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchBar.searchTextField.resignFirstResponder()
    }

}

    
    
