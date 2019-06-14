//
//  QRDBManager.swift
//  QRReader
//
//  Created by xiwang wang on 2019/4/29.
//  Copyright © 2019 com.simon. All rights reserved.
//

import RealmSwift
import UIKit
class QRDBManager: Object {
    private static var _manager: Realm!
    private class func getDB() -> Realm {
        if _manager == nil {
            let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, .userDomainMask, true)[0] as String
            let dbPath = docPath.appending("/defaultDB.realm")
            _manager = try! Realm(fileURL: URL(string: dbPath)!)
            
        }
        return _manager
    }
}

extension QRDBManager {
    
    public class func insertHomeItem(by item: HomeItem) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(item)
        }
        print(defaultRealm.configuration.fileURL ?? "")
    }
    
    public class func getItems() -> Results<HomeItem> {
        let defaultRealm = self.getDB()
        return defaultRealm.objects(HomeItem.self)
    }
    
    public class func deleteItem(item: HomeItem) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.delete(item)
        }
    }
    
    public class func deleteItems(items: Results<HomeItem>) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.delete(items)
        }
    }
    
}

