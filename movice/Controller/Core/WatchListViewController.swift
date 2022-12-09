//
//  WatchListViewController.swift
//  movice
//
//  Created by 上西篤季 on 2022/09/05.
//

import UIKit
import RealmSwift

class WatchListViewController: UIViewController {

    let realm = try! Realm()
    var watchlist: Results<WatchlistData>?
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView.register(UINib(nibName: "WatchlistTableViewCell", bundle: nil), forCellReuseIdentifier: WatchlistTableViewCell.identifier)
        configureNavbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadWatchlist()
        tableView.reloadData()
    }
    
    private func configureNavbar() {
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    func loadWatchlist() {
        watchlist = realm.objects(WatchlistData.self)
        tableView.reloadData()
    }

}

extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          self.watchlist?.count ?? 1
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard let cell = tableView.dequeueReusableCell(withIdentifier: WatchlistTableViewCell.identifier, for: indexPath) as? WatchlistTableViewCell else {
              return UITableViewCell()
          }
          
          if let watchlist = self.watchlist {
              let watchlistMovie = watchlist[indexPath.row]
              cell.configure(movie: watchlistMovie)
          }
          return cell
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let watchList = self.watchlist {
            
            let watchlistMoive = watchList[indexPath.row]
            let movieDataConversion = Movie(title: watchlistMoive.title, poster_path: watchlistMoive.poster, release_date: watchlistMoive.releaseDate, overview: watchlistMoive.overview)
            DispatchQueue.main.async {
                let detailVC = StoryboardScene.DetailView.initialScene.instantiate()
                detailVC.selectedMoive = movieDataConversion
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
            
        } else {
            return
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
}


