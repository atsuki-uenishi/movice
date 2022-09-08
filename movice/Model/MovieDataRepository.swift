//
//  MovieDataRepository.swift
//  movice
//
//  Created by 上西篤季 on 2022/09/07.
//

import Foundation
import Moya

typealias ComletionHandler<T> = (Result<T, MoyaError>) -> Void

final class MovieDataRepository {
    private let provider = MoyaProvider<MovieApiManager>(plugins: [NetworkLoggerPlugin()])
    
    func getMoiveData(title: String, completion: @escaping ComletionHandler<MovieData>) {
        provider.request(.getMovieTitle(title: title)) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case let .success(response):
                completion(self.decodeResponseToMovieData(response:response))
            case let .failure(moyaError):
                completion(.failure(moyaError))
            }
            
        }
    }
    
    private func decodeResponseToMovieData(response: Response) -> Result<MovieData, MoyaError> {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try response.filterSuccessfulStatusAndRedirectCodes()
            let movieData = try response.map(MovieData.self)
            return .success(movieData)
        } catch let error {
            let moyaError = error as! MoyaError
            return .failure(moyaError)
        }
    }
}
