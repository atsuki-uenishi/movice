//
//  MovieData.swift
//  movice
//
//  Created by 上西篤季 on 2022/09/06.
//

import Foundation

struct MovieData: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let poster_path: String
    let release_date: String
    let overview: String
}
