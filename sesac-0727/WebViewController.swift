//
//  WebViewController.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var destinationURL: String = "https://www.apple.com"
    
    @IBOutlet weak var webSearchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openWebPage(to: destinationURL)
        webSearchBar.delegate = self
    }
    
    @IBAction func goBackButtonClicked(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func reloadButtonClicked(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func goForwardButtonClicked(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    func openWebPage(to urlStr: String) {
        guard let url = URL(string: urlStr) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let target = searchBar.text else {
            print("Invalid Input in searchBar")
            return
        }
        openWebPage(to: target)
    }
}
