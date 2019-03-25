//
//  QRHomeModel.swift
//  QRReader
//
//  Created by xiwang wang on 2019/3/22.
//  Copyright © 2019 com.simon. All rights reserved.
//

import Foundation

enum HomeFileType {
    case HomeFileNone
    case HomeFileWeb    // 网页
    case HomeFileFolder // 文件夹
    case HomeFileCode   // 二维码/条码
}

class HomeModel {
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
