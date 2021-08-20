//
//  WebViewController.swift
//  RestEaze
//
//  Created by William Jones on 7/2/21.
//

import UIKit
import WebKit

//extension WKWebView {
//    func load(_ urlString: String) {
//        if let url = URL(string: urlString) {
//            let request = URLRequest(url: url)
//            load(request)
//        }
//    }
//}

class WebViewController: UIViewController {
    

    @IBOutlet weak var webview: WKWebView!
    let webView = WKWebView()
    
    
//    override func loadView() {
//        self.view = webview
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Constants.cookie.cookies = HTTPCookieStorage.shared.cookies ??
        
        for cookie in Constants.cookie.cookies{
            webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
        }
        print("this ran")
        webView.load(URLRequest(url: URL(string: "https://dev.tanzenmed.com")!))
    }
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
