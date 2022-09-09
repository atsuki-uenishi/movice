//
//  GetImageByUrlController.swift
//  movice
//
//  Created by 上西篤季 on 2022/09/08.
//

import UIKit

class getImageByUrl {
    
    //PosterURLからURLを作成し、UIImageにする。画像を暗くするかの、on/offあり。 sizeは154か300
    func getImageByUrl(url: String, dark: Bool, size: String) -> UIImage{
        let posterSizeUrl = "https://image.tmdb.org/t/p/w\(size)"
        let url = URL(string: posterSizeUrl+url)
        do {
            let data = try Data(contentsOf: url!)
            if !dark {
                return UIImage(data: data)!
            }
            return darken(image: UIImage(data: data)!, level: 0.5)
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
    }
    
    //画像を暗くする
    func darken(image:UIImage, level:CGFloat) -> UIImage{

            let frame = CGRect(origin:CGPoint(x:0,y:0),size:image.size)
            let tempView = UIView(frame:frame)
            tempView.backgroundColor = UIColor.black
            tempView.alpha = level

            UIGraphicsBeginImageContext(frame.size)
            let context = UIGraphicsGetCurrentContext()
            image.draw(in: frame)

            context!.translateBy(x: 0, y: frame.size.height)
            context!.scaleBy(x: 1.0, y: -1.0)
            context!.clip(to: frame, mask: image.cgImage!)
            tempView.layer.render(in: context!)

            let imageRef = context!.makeImage()
            let toReturn = UIImage(cgImage:imageRef!)
            UIGraphicsEndImageContext()
            return toReturn

        }
}
