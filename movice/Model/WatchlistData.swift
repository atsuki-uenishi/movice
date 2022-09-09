//
//  WatchlistData.swift
//  movice
//
//  Created by 上西篤季 on 2022/09/08.
//

import Foundation
import RealmSwift

class WatchlistData: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var poster : String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var overview: String = ""
}
