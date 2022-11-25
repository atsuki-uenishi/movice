//
//  GetImageByUrlController.swift
//  movice
//
//  Created by 上西篤季 on 2022/09/08.
//

import UIKit

class ImageUtil {
    // PosterURLからURLを作成し、UIImageにする。sizeは154,300,500,780
    func getImageByUrl(url: String, size: String) -> UIImage{
        let posterSizeUrl = "https://image.tmdb.org/t/p/w\(size)"
        guard let url = URL(string: posterSizeUrl + url) else {
            return UIImage()
        }
        do {
            if let imageData = try UIImage(data: Data(contentsOf: url)) {
                return imageData
            }
        } catch let error as NSError {
            print("Error : \(error.localizedDescription)")
        }
        return UIImage()
    }
}
