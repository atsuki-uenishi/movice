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
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var addToWatchlistButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        poster.image = getImageByUrl().getImageByUrl(url: selectedMoive.poster_path, dark: false, size: "300")
        titleLabel.text = selectedMoive.title
        releaseLabel.text = "公開日　\(selectedMoive.release_date)"
        overviewLabel.text = selectedMoive.overview
        
        watchlistMovie = realm.objects(WatchlistData.self)
        
        watchlistMovie = watchlistMovie?.filter("title CONTAINS[cd] %@", selectedMoive.title)
        
        if watchlistMovie?.isEmpty == false {
            alreadyAdd = true
        }
        
        addToWatchlistButton.titleLabel?.text = alreadyAdd ?  "ウォッチリストから削除" : "ウォッチリストに追加"
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
   
    
    
    @IBAction func addWatchlist(_ sender: UIButton) {
        if alreadyAdd {
            do {
                try realm.write {
                    realm.delete(watchlistMovie!)
                    alreadyAdd = false
                    self.loadView()
                    self.viewDidLoad()
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
                    self.loadView()
                    self.viewDidLoad()
                }
            } catch {
                print("error add watchlist \(error)")
            }
        }
    }
    
    

}
