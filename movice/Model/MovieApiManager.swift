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
    case getPopularMovie
    case getUpcomingMovie
    case getTopRatedMovie
}
 
extension MovieApiManager: TargetType {

    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .getMovieTitle:
            return "/search/movie"
        case .getPopularMovie:
            return "/trending/movie/day"
        case .getUpcomingMovie:
            return "/movie/upcoming"
        case .getTopRatedMovie:
            return "/movie/top_rated"
                }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovieTitle:
            return .get
        case .getPopularMovie:
            return .get
        case .getUpcomingMovie:
            return .get
        case .getTopRatedMovie:
            return .get
        }
    }
 
    var task: Task {
        
        let apiKey = "5e042589f0bdade46c96a1853d0af63e"
        let language = "ja-JP"
        
        switch self {
        case .getMovieTitle(let title):
            return .requestParameters(parameters: ["query": title, "api_key": apiKey, "language": language], encoding: URLEncoding.queryString)
        case .getPopularMovie:
            return .requestParameters(parameters: ["api_key": apiKey, "language": language, "page": "1"], encoding: URLEncoding.queryString)
        case .getUpcomingMovie:
            return .requestParameters(parameters: ["api_key": apiKey, "language": language, "page": "1"], encoding: URLEncoding.queryString)
        case .getTopRatedMovie:
            return .requestParameters(parameters: ["api_key": apiKey, "language": language, "page": "1"], encoding: URLEncoding.queryString)
        }
    }
 
    var headers: [String : String]? {
        ["Content-type": "application/json"]
    }
}
