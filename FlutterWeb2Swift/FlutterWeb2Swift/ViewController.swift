//
//  ViewController.swift
//  FlutterWeb2Swift
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var webView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string:"https://demo.mymyser.com/index.html")
        let myRequest = URLRequest(url: myURL!)
        
        let config = WKWebViewConfiguration()
        let userContentController: WKUserContentController = WKUserContentController()
        userContentController.add(self, name: "js2Swift")
        config.userContentController = userContentController

        webView = WKWebView(
            frame: CGRect(x: 0, y: 64,
                          width: view.frame.size.width,
                          height: view.frame.size.height-64),
            configuration: config
        )
        view.addSubview(webView ?? WKWebView())
        
        webView?.load(myRequest)
    }
    
    @IBAction func onClickButton (_ sender: UIButton) {
        webView?.evaluateJavaScript("js2Dart('Send Native Message');", completionHandler: { (object, error) -> Void in
            print("⭐️:Send Native Message")
        })
    }
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "js2Swift") {
             print("⭐️: \(message.body)")
        }
    }
}
