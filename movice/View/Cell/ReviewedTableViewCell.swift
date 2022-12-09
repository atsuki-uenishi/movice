//
//  ReviewedTableViewCell.swift
//  movice
//
//  Created by 上西篤季 on 2022/11/29.
//

import UIKit

class ReviewedTableViewCell: UITableViewCell {
    
    static let identifier = "ReviewedTableViewCell"
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var reviewlabel: UILabel!
    
    func configure(posterUrl: String, title: String, date: String, rating: Double, review: String) {
        let poster = ImageUtil().getImageByUrl(url: posterUrl, size: "500")
        posterImageView.image = poster
        titleLabel.text = title
        dateLabel.text = date
        reviewlabel.text = review
        
        ratingLabel.text = getStar(by: rating)
    }
    
    private func getStar(by score: Double) -> String {
        let star = "⭐️"
        let blackstar = "★"
        var stars = [blackstar, blackstar, blackstar, blackstar, blackstar]
        for i in 0 ..< Int(score) {
            stars[i] = star
        }
        return stars.joined()
    }
}
