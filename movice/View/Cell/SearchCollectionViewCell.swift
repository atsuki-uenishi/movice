//
//  SearchCollectionViewCell.swift
//  movice
//
//  Created by 上西篤季 on 2022/11/26.
//

import UIKit
import RealmSwift

class SearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SearchCollectionViewCell"
    
    let realm = try! Realm()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let reviewStarLabel: UILabel = {
       let reviewStarLabel = UILabel()
        reviewStarLabel.textColor = .label
        reviewStarLabel.textAlignment = .center
        reviewStarLabel.textColor = .white
        reviewStarLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return reviewStarLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    func configure(movie: Movie) {
        posterImageView.loadImage(urlString: movie.poster_path)
        reviewedCheck(movie: movie)
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
                    reviewStarLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
                    reviewStarLabel.heightAnchor.constraint(equalToConstant: 50),
                    reviewStarLabel.widthAnchor.constraint(equalToConstant: 100),
                    reviewStarLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10)
                ])
            }
        }
    }
    
}
