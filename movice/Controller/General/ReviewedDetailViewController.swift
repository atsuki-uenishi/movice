//
//  ReviewedDetailViewController.swift
//  movice
//
//  Created by 上西篤季 on 2022/12/01.
//

import UIKit
import RealmSwift
import SnackBar_swift


class ReviewedDetailViewController: UIViewController {

    let realm = try! Realm()
    var reviewedMovie: ReviewedMovieData!
    var deleteButton: UIBarButtonItem!
    @IBOutlet private weak var posterImageview: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var reviewLabel: UILabel!
    @IBOutlet private weak var reviewChangeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureNavbar()
    }
    
    private func configureNavbar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .clear
        deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = deleteButton
    }
    
    private func configure() {
        let poster = ImageUtil().getImageByUrl(url: reviewedMovie.poster, size: "500")
        posterImageview.image = poster
        titleLabel.text = reviewedMovie.title
        dateLabel.text = reviewedMovie.reviewDate
        reviewLabel.text = reviewedMovie.review
        ratingLabel.text = getStar(by: reviewedMovie.rating)
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
    
    private func popNavigation() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func deleteButtonTapped(_ sender: UIBarButtonItem) {
        do {
            try realm.write {
                realm.delete(reviewedMovie)
            }
            SnackBar.make(in: self.view, message: "レビューを削除しました。", duration: .infinite).setAction(with: "OK", action: self.popNavigation).show()
        } catch {
            print("error delete watchlist \(error)")
        }
    }
    
    @IBAction private func reviewChangeButtonTapped(_ sender: UIButton) {
        let modalVC = StoryboardScene.ReviewView.initialScene.instantiate()
        modalVC.modalPresentationStyle = .formSheet
        modalVC.reviewedMovie = reviewedMovie
        modalVC.presentationController?.delegate = self
        present(modalVC, animated: true, completion: nil)
    }
}

extension ReviewedDetailViewController: UIAdaptivePresentationControllerDelegate {
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
      reviewedMovie = realm.objects(ReviewedMovieData.self).filter("title CONTAINS[cd] %@", reviewedMovie.title).first
      configure()
  }
}
