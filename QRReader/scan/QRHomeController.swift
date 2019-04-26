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
//import RxDataSources

enum ItemEditingCommand {
    case setItems(items: [HomeModel])
    case addItem(item: HomeModel)
    case deleteItem(indexPath: IndexPath)
    case moveItem(from: IndexPath, to: IndexPath)
}

struct QRHomeViewModel {
    fileprivate var homeItems: [HomeModel]
    init(homeItems:[HomeModel] = []) {
//        self.homeItems = [
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//            HomeModel(fileType: .HomeFileCode, title: "Simon", items: 10, date: Date()),
//        ]
        self.homeItems = homeItems
    }
    func executeCommand(command: ItemEditingCommand) -> QRHomeViewModel{
        switch command {
        case .setItems(let items):
            return QRHomeViewModel(homeItems: items)
            
        case .addItem(let item):
            var items = self.homeItems
            items.append(item)
            return QRHomeViewModel(homeItems: items)
            
        case .deleteItem(let indexPath):
            var items = self.homeItems
            items.remove(at: indexPath.row)
            return QRHomeViewModel(homeItems: items)
            
        case .moveItem(let from, let to):
            var items = self.homeItems
            let item = items[from.row]
            items.remove(at: from.row)
            items.insert(item, at: to.row)
            return QRHomeViewModel(homeItems: items)
        }
    }
}

class QRHomeController: UIViewController, QRAddFolderDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectBarItem: UIBarButtonItem!
    @IBOutlet weak var addFolderBarItem: UIBarButtonItem!
    
    @IBOutlet weak var editBarItem: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var dataSource: [HomeModel] = [
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
    var viewModel: QRHomeViewModel = QRHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage.image(color: .white), for: .default)
        navigationController?.navigationBar.showLine(false)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        selectBarItem.rx.tap.subscribe(onNext: { [weak self] in
            self?.isSelectAll = !(self?.isSelectAll)!
            if self?.isSelectAll == true {
                self?.selectBarItem.image = UIImage(named: "right_select")
            } else {
                self?.selectBarItem.image = UIImage(named: "right")
            }
            var arr: [HomeModel] = [HomeModel]()
            
            for model in self?.dataSource ?? [] {
                var m = model
                m.isSelected = self?.isSelectAll ?? false
                arr.append(m)
            }
            self?.dataSource = arr
            self?.tableView .reloadData()
        }).disposed(by: disposeBag)
        
        editBarItem.rx.tap.subscribe(onNext: {[weak self] in
            self?.handleNaviToolBarButtom((self?.editBarItem)!)
        }).disposed(by: disposeBag)
        
    }
    
    // MARK: - handle UI Action With Rx
    func bindViewModel() {
        let items = Observable.just(viewModel.homeItems)
        
        items.bind(to:tableView.rx.items){(tb, row, model) -> UITableViewCell in
            let cell = tb.dequeueReusableCell(withIdentifier: "QRHomeCell") as! QRHomeCell
            cell.titleLabel.text = model.title
            cell.tipsLabel.text = "\(model.items) items";
            let format: DateFormatter = DateFormatter();
            format.dateFormat = "yyyy/MM/dd"
            cell.timeLabel.text = format.string(from: Date(timeIntervalSinceNow: TimeInterval(1000000 * row)))
            cell.isEdit = self.isEdit
            cell.checkBoxBtn.isSelected = model.isSelected
//            cell.editingAccessoryView = UIImageView(image: UIImage(named: "right"))
            cell.didSelectTap = {(selected) in
                // model.isSelected = selected
                if !selected {
                    self.selectBarItem.image = UIImage(named: "right")
                }
            }
            return cell
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(HomeModel.self).subscribe(onNext: { (model) in
            print("select model,\(model)")
        }).disposed(by: disposeBag)
        
        tableView.rx.itemDeselected.subscribe(onNext: {(indexPath) in
            print("deleted model \(indexPath.row)")
        }).disposed(by: disposeBag)
        
        tableView.rx.itemMoved.subscribe(onNext: {(sourceIndexPath, desIndexPath) in
            print("move from \(sourceIndexPath) to \(desIndexPath)")
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
        
        //获取删除项的索引
        tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
        }).disposed(by: disposeBag)
        
        //获取删除项的内容
        tableView.rx.modelDeleted(String.self).subscribe(onNext: { item in
        }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddFolder" {
            let navc = segue.destination as! UINavigationController
            let vc = navc.topViewController as! QRAddFolderController
            vc.delegate = self
        }
    }
    
    // MARK: -addFolderDelegate
    func addFolderDetail(_ folder: HomeModel) {
        viewModel.homeItems.append(folder)
        tableView.reloadData()
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
        for cell: QRHomeCell in tableView!.visibleCells as! [QRHomeCell]{
            cell.isEdit = isEdit
        }
        tableView.setEditing(isEdit, animated: true)
//        tableView.setEditing(!isEdit, animated: true)
//        tableView.isEditing = true
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
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "QRHomeCell") as! QRHomeCell
        cell.titleLabel.text = model.title
        cell.tipsLabel.text = "\(model.items) items";
        let format: DateFormatter = DateFormatter();
        format.dateFormat = "yyyy/MM/dd"
        cell.timeLabel.text = format.string(from: Date(timeIntervalSinceNow: TimeInterval(1000000 * indexPath.row)))
        cell.isEdit = isEdit
        cell.checkBoxBtn.isSelected = model.isSelected
        cell.didSelectTap = {(selected) in
            var m = model
            m.isSelected = selected
            self.dataSource[indexPath.row] = m
            if !selected {
                self.selectBarItem.image = UIImage(named: "right")
            }
        }
        return cell
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
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}
