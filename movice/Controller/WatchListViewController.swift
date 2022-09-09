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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadWatchlist()
    }
    
    func loadWatchlist() {
        watchlist = realm.objects(WatchlistData.self)
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! DetailViewController
        
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let watchlistMoive = watchlist![indexPath.row]
            let movieDataConversion = Movie(title: watchlistMoive.title, poster_path: watchlistMoive.poster, release_date: watchlistMoive.releaseDate, overview: watchlistMoive.overview)
            destinationVC.selectedMoive = movieDataConversion
        }
    }


}

extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchlist?.count ?? 1
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "watchlistCell", for: indexPath)
          

          if let safeWatchlist = watchlist {
              let image = cell.contentView.viewWithTag(1) as! UIImageView
              let label = cell.contentView.viewWithTag(2) as! UILabel
              image.image = getImageByUrl().getImageByUrl(url: safeWatchlist[indexPath.row].poster, dark: true, size: "154")
              label.text = safeWatchlist[indexPath.row].title
          }
        
        return cell
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    
    
}
