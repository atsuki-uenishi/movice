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
        
        let star = "⭐️"
        let blackstar = "★"
        
        switch rating {
        case 1:
            var text = ""
            text.append(star)
            text.append(blackstar)
            text.append(blackstar)
            text.append(blackstar)
            text.append(blackstar)
            ratingLabel.text = text
        case 2:
            var text = ""
            text.append(star)
            text.append(star)
            text.append(blackstar)
            text.append(blackstar)
            text.append(blackstar)
            ratingLabel.text = text
        case 3:
            var text = ""
            text.append(star)
            text.append(star)
            text.append(star)
            text.append(blackstar)
            text.append(blackstar)
            ratingLabel.text = text
        case 4:
            var text = ""
            text.append(star)
            text.append(star)
            text.append(star)
            text.append(star)
            text.append(blackstar)
            ratingLabel.text = text
        case 5:
            var text = ""
            text.append(star)
            text.append(star)
            text.append(star)
            text.append(star)
            text.append(star)
            ratingLabel.text = text
        default:
            var text = ""
            text.append(blackstar)
            text.append(blackstar)
            text.append(blackstar)
            text.append(blackstar)
            text.append(blackstar)
            ratingLabel.text = text
        }
    }
}
