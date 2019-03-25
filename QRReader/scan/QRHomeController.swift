//
//  QRHomeController.swift
//  QRReader
//
//  Created by xiwang wang on 2019/3/21.
//  Copyright © 2019 com.simon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxAtomic

extension UIImage {
    class func image(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension UINavigationBar {
    
    func showLine(_ show: Bool) {
        if show {
            shadowImage = UIImage.image(color: .gray)
        } else {
            shadowImage = UIImage()
        }
    }
}

class QRHomeController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectBarItem: UIBarButtonItem!
    @IBOutlet weak var addFolderBarItem: UIBarButtonItem!
    
    @IBOutlet weak var editBarItem: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var dataArr = [
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
        ]
    
    var disposeBag = DisposeBag()
    
    
    var isEdit: Bool = false
    var isSelectAll: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage.image(color: .white), for: .default)
        navigationController?.navigationBar.showLine(false)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        handleUIAction()
    }
    
    // MARK: - handle UI Action With Rx
    func handleUIAction() {
        let dataSource = Observable<[HomeModel]>.of(dataArr)
        // RX大法好
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "QRHomeCell", cellType: QRHomeCell.self)) { indexPath, model, cell in
            cell.titleLabel.text = model.title
            cell.tipsLabel.text = "\(model.items) items";
            let format: DateFormatter = DateFormatter();
            format.dateFormat = "yyyy/MM/dd"
            cell.timeLabel.text = format.string(from: Date(timeIntervalSinceNow: TimeInterval(1000000 * indexPath)))
            cell.isEdit = self.isEdit
            cell.checkBoxBtn.isSelected = model.isSelected
            cell.didSelectTap = {(selected) in
                model.isSelected = selected
                if !selected {
                    self.selectBarItem.image = UIImage(named: "right")
                }
            }
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(HomeModel.self).subscribe(onNext: { music in
            print("你选中的歌曲信息【\(music)】")
        }).disposed(by: disposeBag)
        
        
        tableView.rx.didScroll.subscribe(onNext:{[weak self] in
            let offset: CGFloat = self?.tableView.contentOffset.y ?? 0
            let hidenBigTitle: Bool = offset > 44
            self?.titleLabel.isHidden = hidenBigTitle
            UIView.animate(withDuration: 0.25) {
                self?.navigationItem.title = !hidenBigTitle ? "" : "Scans"
            }
            self?.navigationController?.navigationBar.showLine(hidenBigTitle)
            
            if offset > -44 && offset < 0 {
                //                titleLabel.font = UIFont.boldSystemFont(ofSize: 30 * (100 - offset) / 100.0)
            }
        }).disposed(by: disposeBag)
        
        selectBarItem.rx.tap.subscribe(onNext: { [weak self] in
            self?.isSelectAll = !(self?.isSelectAll)!
            if self?.isSelectAll == true {
                self?.selectBarItem.image = UIImage(named: "right_select")
            } else {
                self?.selectBarItem.image = UIImage(named: "right")
            }
            for model in (self?.dataArr)! {
                model.isSelected = self?.isSelectAll ?? false
            }
            self?.tableView .reloadData()
        }).disposed(by: disposeBag)
        
        addFolderBarItem.rx.tap.subscribe(onNext: {[weak self] in
            self?.present(QRAddFolderController(), animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        
        editBarItem.rx.tap.subscribe(onNext: {[weak self] in
            self?.handleNaviToolBarButtom((self?.editBarItem)!)
        }).disposed(by: disposeBag)
        
    }
    
    // MARK: - naviItemAction
    @IBAction func naviItemAction(_ sender: UIBarButtonItem) {
        // tag = 0,1,2    
        if sender.tag == 0 {
            // select
//            isSelectAll = !isSelectAll
//            if isSelectAll == true {
//                selectBarItem.image = UIImage(named: "right_select")
//            } else {
//                selectBarItem.image = UIImage(named: "right")
//            }
//            for model in dataArr {
//                model.isSelected = isSelectAll
//            }
//            tableView .reloadData()
        } else if sender.tag == 1 {
            // add folder
        } else if sender.tag == 2 {
            // Edit or Done
            handleNaviToolBarButtom(sender)
        }
    }
    
    @IBAction func toolBarItemAction(_ sender: UIBarButtonItem) {
        
        if sender.title == "Export" {
            
        } else if sender.title == "Move" {
            
        } else if sender.title == "Delete" {
            
        }
    }
    
    func handleNaviToolBarButtom(_ sender: UIBarButtonItem) {
        isEdit = (sender.title == "Edit")
        // 编辑 显示⬅️
//        tableView.reloadData()
        for cell: QRHomeCell in tableView!.visibleCells as! [QRHomeCell]{
            cell.isEdit = isEdit
        }
        sender.title = isEdit ? "Done":"Edit"
        selectBarItem.isEnabled = isEdit
        selectBarItem.image = isEdit ? (UIImage(named: "right")) : nil
        addFolderBarItem.isEnabled = isEdit
        addFolderBarItem.image = isEdit ? (UIImage(named: "addfolder")) : nil
        tabBarController?.tabBar.isHidden = isEdit
        UIView.animate(withDuration: 0.25) {
            var cennter: CGPoint = self.toolBar.center
            self.isEdit ? (cennter.y -= 49):(cennter.y += 49)
            self.toolBar.center = cennter
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension QRHomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: QRHomeCell = tableView.dequeueReusableCell(withIdentifier: "QRHomeCell") as! QRHomeCell
        let model: HomeModel = self.dataArr[indexPath.row]
        cell.titleLabel.text = model.title
        cell.tipsLabel.text = "\(model.items) items";
        let format: DateFormatter = DateFormatter();
        format.dateFormat = "yyyy/MM/dd"
        cell.checkBoxBtn.isSelected = model.isSelected
        cell.timeLabel.text = format.string(from: Date(timeIntervalSinceNow: TimeInterval(1000000 * indexPath.row)))
        cell.isEdit = isEdit
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            let offset: CGFloat = scrollView.contentOffset.y
            let hidenBigTitle: Bool = offset > 44
            titleLabel.isHidden = hidenBigTitle
            UIView.animate(withDuration: 0.25) {
                self.navigationItem.title = !hidenBigTitle ? "" : "Scans"
            }
            navigationController?.navigationBar.showLine(hidenBigTitle)
            
            if offset > -44 && offset < 0 {
//                titleLabel.font = UIFont.boldSystemFont(ofSize: 30 * (100 - offset) / 100.0)
            }
        }
    }
}
