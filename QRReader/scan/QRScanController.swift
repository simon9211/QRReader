//
//  QRScanController.swift
//  QRReader
//
//  Created by xiwang wang on 2019/3/20.
//  Copyright © 2019 com.simon. All rights reserved.
//

import UIKit
import WeScan

class QRScanController: UIViewController, ImageScannerControllerDelegate  {
    @IBOutlet weak var originImageView: UIImageView!
    @IBOutlet weak var scanedImageView: UIImageView!
    @IBOutlet weak var rectLabel: UILabel!
    var hasDone: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if hasDone == false {
            let scannerViewController = ImageScannerController()
            scannerViewController.imageScannerDelegate = self
            present(scannerViewController, animated: true, completion: nil)
        }
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        self.hasDone = true
        scanner.dismiss(animated: true) {
            
        }
        originImageView.image = results.originalImage
        scanedImageView.image = results.scannedImage
        rectLabel.text = "\(results.detectedRectangle)"
    }
    
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        self.hasDone = true
        scanner.dismiss(animated: true) {
        }
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        print(error)
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
