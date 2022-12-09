//
//  DetailViewController.swift
//  movice
//
//  Created by 上西篤季 on 2022/09/08.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    var selectedMoive: Movie!
    var watchlistMovie: Results<WatchlistData>?
    var reviewedMovie: Results<ReviewedMovieData>?
    let realm = try! Realm()
    var alreadyAdd = false
    var alreadyReview = false
    
    @IBOutlet private weak var poster: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var addToWatchlistButton: UIButton!
    @IBOutlet private weak var reviewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavbar()
        
        poster.image = ImageUtil().getImageByUrl(url: selectedMoive.poster_path, size: "300")
        titleLabel.text = selectedMoive.title
        
        overviewLabel.text = selectedMoive.overview

        watchlistCheck()
        reviewedCheck()
    }
    
    private func watchlistCheck(){
        
        watchlistMovie = realm.objects(WatchlistData.self).filter("title CONTAINS[cd] %@", selectedMoive.title)
    
        alreadyAdd = !(watchlistMovie?.isEmpty ?? false)
        addToWatchlistButton.titleLabel?.text = alreadyAdd ? "ウォッチリストから削除" : "ウォッチリストに追加"
    }
    
    func reviewedCheck() {
        
        reviewedMovie = realm.objects(ReviewedMovieData.self).filter("title CONTAINS[cd] %@", selectedMoive.title)
        
        alreadyReview = !(reviewedMovie?.isEmpty ?? false)
        
        if alreadyReview {
            reviewButton.setTitle("レビューを変更する", for: .normal)
        } else {
            reviewButton.setTitle("レビューを書く", for: .normal)
        }
    }
    
    private func configureNavbar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
   
    @IBAction private func toReview(_ sender: UIButton) {
        let modalVC = StoryboardScene.ReviewView.initialScene.instantiate()
        modalVC.modalPresentationStyle = .formSheet
        if alreadyReview {
            modalVC.reviewedMovie = reviewedMovie?.first
        } else {
            modalVC.reviewMovie = selectedMoive
        }
        present(modalVC, animated: true, completion: nil)
    }
    
    
    @IBAction private func addWatchlist(_ sender: UIButton) {
        if alreadyAdd {
            guard let watchlistMovie = self.watchlistMovie else {
                print("watchlist not found")
                return
            }
            do {
                try realm.write {
                    realm.delete(watchlistMovie)
                    alreadyAdd = false
                }
                addToWatchlistButton.setTitle("ウォッチリストに追加", for: .normal)
            } catch {
                print("error delete watchlist \(error)")
            }
        } else {
            let addMovie = WatchlistData()
            addMovie.title = selectedMoive.title
            addMovie.poster = selectedMoive.poster_path
            addMovie.releaseDate = selectedMoive.release_date
            addMovie.overview = selectedMoive.overview
            do {
                try realm.write {
                    realm.add(addMovie)
                    alreadyAdd = true
                }
                addToWatchlistButton.setTitle("ウォッチリストから削除", for: .normal)
            } catch {
                print("error add watchlist \(error)")
            }
        }
    }
}
