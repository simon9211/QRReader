//
//  QRHomeModel.swift
//  QRReader
//
//  Created by xiwang wang on 2019/3/22.
//  Copyright © 2019 com.simon. All rights reserved.
//

import Foundation
import RxDataSources
import RealmSwift

enum HomeFileType: Int{
    case none = 0
    case web    // 网页
    case folder // 文件夹
    case code   // 二维码/条码
}

struct HomeSectionModel<String, ItemType>: SectionModelType {
    var items: [ItemType]
    var header: String
    public typealias Item = ItemType
    
    init(original: HomeSectionModel<String, ItemType>, items: [ItemType]) {
        self = original
        self.items = items
    }
    
    public var identity: String {
        return header
    }
}

//struct HomeModel: Equatable, CustomDebugStringConvertible  {
//    var isSelected: Bool
//    var fileType: HomeFileType
//    var title: String
//    var items: Int
//    var date: Date
//    
//    init(fileType: HomeFileType = .none, title: String, items: Int = 0, date: Date) {
//        self.fileType = fileType
//        self.title = title
//        self.items = items
//        self.date = date
//        self.isSelected = false
//    }
//}
//
//extension HomeModel {
//    var debugDescription: String {
//        return ""
//    }
//}

class HomeItem: Object {
    @objc dynamic var isSelected: Bool = false
    @objc dynamic var title: String = "defalut Name"
    @objc dynamic var content: String = ""
    @objc dynamic var items: Int = 0
    @objc dynamic var date: Date? = nil
    @objc dynamic var fileType: Int = 0
    //let owners = LinkingObjects(fromType: HomeItem.self, property: "HomeItem")
    
    override static func ignoredProperties() -> [String] {
        return ["isSelected"]
    }
    
}
