//
//  QRHomeModel.swift
//  QRReader
//
//  Created by xiwang wang on 2019/3/22.
//  Copyright © 2019 com.simon. All rights reserved.
//

import Foundation
import RxDataSources

enum HomeFileType {
    case HomeFileNone
    case HomeFileWeb    // 网页
    case HomeFileFolder // 文件夹
    case HomeFileCode   // 二维码/条码
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

struct HomeModel: Equatable, CustomDebugStringConvertible  {
    var isSelected: Bool
    var fileType: HomeFileType
    var title: String
    var items: Int
    var date: Date
    
    init(fileType: HomeFileType, title: String, items: Int, date: Date) {
        self.fileType = fileType
        self.title = title
        self.items = items
        self.date = date
        self.isSelected = false
    }
}

extension HomeModel {
    var debugDescription: String {
        return ""
    }
}
