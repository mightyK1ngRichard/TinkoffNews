//
//  WebNewsViewController.swift
//  TinkoffLab
//
//  Created by Дмитрий Пермяков on 04.02.2023.
//

import UIKit
import WebKit

class WebNewsViewController: UIViewController {

    var linkToNews: URL?

    @IBOutlet weak var webVC: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let link = linkToNews {
            let request = URLRequest(url: link)
            webVC.load(request)
        } else {
            print("ERROR FROM WebNewsViewController")
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
