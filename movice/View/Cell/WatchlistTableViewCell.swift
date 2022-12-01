//
//  WatchlistTableViewCell.swift
//  movice
//
//  Created by 上西篤季 on 2022/12/02.
//

import UIKit
import RealmSwift

class WatchlistTableViewCell: UITableViewCell {
    
    static let identifier = "WatchlistTableViewCell"
    
    let realm = try! Realm()
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private let reviewStarLabel: UILabel = {
       let reviewStarLabel = UILabel()
        reviewStarLabel.textColor = .label
        reviewStarLabel.textAlignment = .center
        reviewStarLabel.textColor = .white
        reviewStarLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return reviewStarLabel
    }()
    
    func configure(movie: WatchlistData) {
        let poster = ImageUtil().getImageByUrl(url: movie.poster, size: "500")
        posterImageView.image = poster
        titleLabel.text = movie.title
        let movieDataConversion = Movie(title: movie.title, poster_path: movie.poster, release_date: movie.releaseDate, overview: movie.overview)
        reviewedCheck(movie: movieDataConversion)
    }
    
    private func reviewedCheck(movie: Movie) {
        let reviewedMovies = realm.objects(ReviewedMovieData.self).filter("title CONTAINS[cd] %@", movie.title)
        let alreadyReview = !(reviewedMovies.isEmpty)
        if alreadyReview {
            if let reviewedMovie = reviewedMovies.first {
                reviewStarLabel.text = "⭐️\(Int(reviewedMovie.rating))"
                addSubview(reviewStarLabel)
                
                reviewStarLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    reviewStarLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -10),
                    reviewStarLabel.heightAnchor.constraint(equalToConstant: 50),
                    reviewStarLabel.widthAnchor.constraint(equalToConstant: 100),
                    reviewStarLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 0)
                ])
            }
        }
    }
    
}
