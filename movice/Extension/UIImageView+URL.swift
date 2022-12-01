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
        let posterSizeUrl = "https://image.tmdb.org/t/p/w154"
        guard let url = URL(string: posterSizeUrl + urlString) else {
            return 
        }
        loadImage(with: url)
    }
    
    func loadImage(with url: URL) {
        Nuke.loadImage(with: url, into: self)
    }
}
