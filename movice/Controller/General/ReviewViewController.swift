//
//  ReviewViewController.swift
//  movice
//
//  Created by 上西篤季 on 2022/11/30.
//

import UIKit
import Cosmos
import RealmSwift
import SnackBar_swift

class ReviewViewController: UIViewController {
    
    var reviewMovie: Movie?
    var reviewedMovie: ReviewedMovieData?
    let realm = try! Realm()
    var rating: Double = 3
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var ratingCosmosView: CosmosView!
    @IBOutlet private weak var reviewTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingCosmosView.didFinishTouchingCosmos = didFinishTouchCosmos
        configure()
    }
    
    
    private func configure() {
        if let reviewMovie = reviewMovie {
            let poster = ImageUtil().getImageByUrl(url: reviewMovie.poster_path, size: "500")
            posterImageView.image = poster
            
            titleLabel.text = reviewMovie.title
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
            dateLabel.text = dateFormatter.string(from: date)
            
        } else if let reviewedMovie = reviewedMovie {
            let poster = ImageUtil().getImageByUrl(url: reviewedMovie.poster, size: "500")
            posterImageView.image = poster
            
            titleLabel.text = reviewedMovie.title
            
            dateLabel.text = reviewedMovie.reviewDate
            
            ratingCosmosView.rating = reviewedMovie.rating
            rating = reviewedMovie.rating
            
            reviewTextField.text = reviewedMovie.review
            
        } else {
            return
        }
    }
    
    private func didFinishTouchCosmos(_ rating: Double) {
        self.rating = rating
    }
    
    private func dismis() {
        if let presentationController = presentationController{
                    presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
                }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func close(_ sender: UIButton) {
        dismis()
    }
    
    @IBAction private func saveReview(_ sender: UIButton) {
        if let reviewText = reviewTextField.text, !reviewText.isEmpty, let reviewDate = dateLabel.text{
            let reviewingMovie = ReviewedMovieData()
            
            if let reviewMovie = reviewMovie {
                reviewingMovie.poster = reviewMovie.poster_path
                reviewingMovie.title = reviewMovie.title
                reviewingMovie.review = reviewText
                reviewingMovie.reviewDate = reviewDate
                reviewingMovie.rating = rating
                do {
                    try realm.write {
                        realm.add(reviewingMovie)
                    }
                    SnackBar.make(in: self.view, message: "レビューを保存しました。", duration: .infinite).setAction(with: "OK", action: self.dismis).show()
                } catch {
                    print("error add watchlist \(error)")
                }
                
            } else if let reviewedMovie = reviewedMovie {
                let targetMovie = realm.objects(ReviewedMovieData.self).filter("title CONTAINS[cd] %@", reviewedMovie.title)[0]
                do {
                    try realm.write {
                        targetMovie.review = reviewText
                        targetMovie.rating = rating
                    }
                    SnackBar.make(in: self.view, message: "レビューを保存しました。", duration: .infinite).setAction(with: "OK", action: self.dismis).show()
                } catch {
                    print("error add watchlist \(error)")
                }
            }
        } else {
            SnackBar.make(in: self.view, message: "レビューを入力してください。", duration: .infinite).setAction(with: "OK", action: nil).show()
        }
    }
    
}
