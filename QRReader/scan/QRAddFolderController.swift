//
//  QRAddFolderController.swift
//  QRReader
//
//  Created by xiwang wang on 2019/3/25.
//  Copyright © 2019 com.simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


protocol QRAddFolderDelegate: NSObjectProtocol {
    func addFolderDetail(_ folder: HomeItem)
}

class QRAddFolderController: UIViewController {

    var disposeBag = DisposeBag()
    
    @IBOutlet weak var textField: UITextField!
    weak var delegate: QRAddFolderDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem?.rx.tap.subscribe(onNext: {[weak self] in
            guard let name = self?.textField.text else {
                SVProgressHUD.showError(withStatus: "Please input a name for folder")
                return
            }
            let item = HomeItem()
            item.title = name
            item.items = Int(arc4random() % 100)
            item.fileType = HomeFileType.folder.rawValue
            self?.delegate?.addFolderDetail(item)
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        navigationItem.leftBarButtonItem?.rx.tap.subscribe(onNext: {[weak self] in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    

}
