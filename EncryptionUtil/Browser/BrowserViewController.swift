//
//  BrowserViewController.swift
//  EncryptionUtil
//
//  Created by Jansen on 6/20/17.
//  Copyright © 2017 Jansen. All rights reserved.
//

import UIKit
import WebKit
import SnapKit
//import SimpleAlert
import FontAwesome

class BrowserViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var btnAddrUI: UIBarButtonItem!
    @IBOutlet weak var btnBackUI: UIBarButtonItem!
    @IBOutlet weak var btnForwardUI: UIBarButtonItem!
    @IBOutlet weak var btnRefreshUI: UIBarButtonItem!
    @IBOutlet weak var btnClearUI: UIBarButtonItem!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    var webView : WKWebView!
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @IBAction func btnForward(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    @IBAction func btnRefresh(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func btnClear(_ sender: UIBarButtonItem) {
        self.clearBrowserCache()
    }
    @IBAction func btnAddress(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Website", message: "Enter a website address", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = "http://"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.goToWeb(web: (textField?.text)!)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.setupWebView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    func initUI(){
        btnAddrUI.image = UIImage.fontAwesomeIcon(name: .safari, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        btnBackUI.image = UIImage.fontAwesomeIcon(name: .chevronLeft, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        btnForwardUI.image = UIImage.fontAwesomeIcon(name: .chevronRight, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        btnClearUI.image = UIImage.fontAwesomeIcon(name: .trash, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        btnRefreshUI.image = UIImage.fontAwesomeIcon(name: .refresh, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        
    }
    
    func setupWebView(){
        webView = WKWebView()
        webView.navigationDelegate = self
        goToWeb(web: "https://www.google.com/")
        
        self.view.addSubview(webView)
        self.view.bringSubview(toFront: progressView)
        webView.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
    }
    func clearBrowserCache() {
        if #available(iOS 9.0, *)
        {
            let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
            let date = NSDate(timeIntervalSince1970: 0)
            
            WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date as Date, completionHandler:{ })
        }
        else
        {
            var libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, false).first!
            libraryPath += "/Cookies"
            
            do {
                try FileManager.default.removeItem(atPath: libraryPath)
            } catch {
                print("error")
            }
            URLCache.shared.removeAllCachedResponses()
        }
        
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
        
        let fileManager = FileManager.default
        let libraryURL: URL? = try! fileManager.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let cookiesURL: URL? = libraryURL?.appendingPathComponent("Cookies", isDirectory: true)
        try? fileManager.removeItem(at: cookiesURL!)
        let webKitDataURL: URL? = libraryURL?.appendingPathComponent("WebKit", isDirectory: true)
        try? fileManager.removeItem(at: webKitDataURL!)
        let cacheDataURL: URL? = libraryURL?.appendingPathComponent("Caches", isDirectory: true)
        try? fileManager.removeItem(at: cacheDataURL!)
        
        let configuration = WKWebViewConfiguration()
        configuration.processPool = WKProcessPool()
        
        self.goToWeb(web: "www.google.com")
    }
    
    func goToWeb(web:String) {
        var address = web
        if (web.characters.count) == 0 || web.range(of: "http") == nil{
            address = "http://" + web
        }
        
        let url = URL(string: address)
        let request = URLRequest(url: url!)//, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        webView.load(request)
        
    }
}
