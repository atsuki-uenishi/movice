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
    let realm = try! Realm()
    var alreadyAdd = false
    
    @IBOutlet private weak var poster: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var addToWatchlistButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavbar()
        
        poster.image = ImageUtil().getImageByUrl(url: selectedMoive.poster_path, size: "300")
        titleLabel.text = selectedMoive.title
        releaseLabel.text = "公開日　\(selectedMoive.release_date)"
        overviewLabel.text = selectedMoive.overview
        
        watchlistMovie = realm.objects(WatchlistData.self)
        
        watchlistMovie = watchlistMovie?.filter("title CONTAINS[cd] %@", selectedMoive.title)
    
        alreadyAdd = !(watchlistMovie?.isEmpty ?? false)
        
        addToWatchlistButton.titleLabel?.text = alreadyAdd ? "ウォッチリストから削除" : "ウォッチリストに追加"
        
    }
    
    private func configureNavbar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .black
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
                    addToWatchlistButton.setTitle("ウォッチリストに追加", for: .normal)
                }
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
                    addToWatchlistButton.setTitle("ウォッチリストから削除", for: .normal)
                }
            } catch {
                print("error add watchlist \(error)")
            }
        }
    }
}
