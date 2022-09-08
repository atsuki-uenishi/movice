//
//  MovieApiManager.swift
//  movice
//
//  Created by 上西篤季 on 2022/09/06.
//

import Foundation
import Moya



enum MovieApiManager {
    case getMovieTitle(title: String)
//    case getMovie()
}
 
extension MovieApiManager: TargetType {

    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3/search")!
    }
    
    var path: String {
        switch self {
                case .getMovieTitle:
                    return "/movie"
                }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovieTitle:
            return .get
        }
    }
 
    var task: Task {
        switch self {
        case .getMovieTitle(let title):
            let apiKey = "5e042589f0bdade46c96a1853d0af63e"
            let language = "ja-JP"
            return .requestParameters(parameters: ["query": title, "api_key": apiKey, "language": language], encoding: URLEncoding.queryString)
        }
    }
 
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
