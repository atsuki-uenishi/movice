//
//  ReviewedMovieData.swift
//  movice
//
//  Created by 上西篤季 on 2022/11/29.
//

import Foundation
import RealmSwift

class ReviewedMovieData: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var poster : String = ""
    @objc dynamic var reviewDate: String = ""
    @objc dynamic var review: String = ""
    @objc dynamic var rating: Double = 0
}
