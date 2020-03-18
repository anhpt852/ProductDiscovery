//
//  ProductDetailDescriptionViewController.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/18/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit
import WebKit
@objc protocol ProductDetailDescriptionViewControllerDelegate {
    @objc optional func updateHeight(_ height:CGFloat)
    
}

class ProductDetailDescriptionViewController: BaseViewController {

    @IBOutlet weak var _webView: WKWebView!
    @IBOutlet weak var _lcWebViewHeight :NSLayoutConstraint?
    var delegate: ProductDetailDescriptionViewControllerDelegate?
//    
//    deinit {
//        _webView.scrollView.removeObserver(self, forKeyPath: "contentSize")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = Bundle.main.url(forResource: "product_description", withExtension: "html")!
        _webView.scrollView.isScrollEnabled = false
        _webView.loadFileURL(url, allowingReadAccessTo: url)
        _webView.navigationDelegate = self
        let request = URLRequest(url: url)
        _webView.load(request)
//        _webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if object as? WKWebView == _webView {
//            if keyPath == "contentSize" {
//                let value = CGFloat(_lcWebViewHeight!.constant) - _webView.scrollView.contentSize.height
//                if (Float(abs(value)) < .ulpOfOne) {
//                    return
//                }
//                _lcWebViewHeight?.constant = _webView.scrollView.contentSize.height
//                if let updateHeight = delegate?.updateHeight {
//                    updateHeight(_webView.scrollView.contentSize.height)
//                }
//                _webView.layoutIfNeeded()
//            }
//        }
//    }
}

extension ProductDetailDescriptionViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self._lcWebViewHeight!.constant = webView.scrollView.contentSize.height
            if let updateHeight = self.delegate?.updateHeight {
                updateHeight(self._webView.scrollView.contentSize.height)
            }
            self._webView.layoutIfNeeded()
        }
    }
}
