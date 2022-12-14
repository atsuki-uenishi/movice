//
//  UIImageView+URL.swift
//  movice
//
//  Created by 上西篤季 on 2022/09/24.
//

import UIKit
import Nuke

extension UIImageView {
    func loadImage(urlString: String) {
        let posterSizeUrl = "https://image.tmdb.org/t/p/w500"
        guard let url = URL(string: posterSizeUrl + urlString) else {
            return 
        }
        loadImage(with: url)
    }
    
    func loadImage(with url: URL) {
        Nuke.loadImage(with: url, into: self) { (result: Result<ImageResponse, ImagePipeline.Error>) in
            switch result {
            case .success(let success):
                self.image = success.image
            case .failure(let failure):
                print(failure)
            }
        }
    }
}


