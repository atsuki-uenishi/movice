//
//  DarkenImage.swift
//  movice
//
//  Created by 上西篤季 on 2022/09/17.
//

import UIKit

extension UIImage  {
    // 画像を暗くする
    func darkenImage(_ level:CGFloat) -> UIImage{
        
        guard let context = UIGraphicsGetCurrentContext(),
              let cgImage = self.cgImage
        else {
            return self
        }
        
        let frame = CGRect(origin:CGPoint(x:0,y:0),size:self.size)
        let tempView = UIView(frame:frame)
        tempView.backgroundColor = UIColor.black
        tempView.alpha = level

        UIGraphicsBeginImageContext(frame.size)
        self.draw(in: frame)

        context.translateBy(x: 0, y: frame.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.clip(to: frame, mask: cgImage)
        tempView.layer.render(in: context)

        guard let imageRef = context.makeImage() else {
            return UIImage()
        }
        let toReturn = UIImage(cgImage:imageRef)
        UIGraphicsEndImageContext()
        return toReturn

        }
}
