//
//  ViewController.swift
//  QRReader
//
//  Created by xiwang wang on 2019/3/20.
//  Copyright © 2019 com.simon. All rights reserved.
//

import UIKit
import Flutter
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pushFlutterViewController()
    }
    
    func pushFlutterViewController() {
        print("push event")
        if let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine {
            let flutterViewController: FlutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
            flutterViewController.title = "Flutter view"
            flutterViewController.setInitialRoute("route1")
//            self.present(flutterViewController, animated: false, completion: nil)
            self.navigationController?.pushViewController(flutterViewController, animated: true)
        }
    }


}

