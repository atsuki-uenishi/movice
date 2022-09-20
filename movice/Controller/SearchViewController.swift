//
//  ViewController.swift
//  movice
//
//  Created by 上西篤季 on 2022/09/03.
//

import UIKit
import Moya

class SearchViewController: UIViewController {
    
    @IBOutlet private weak var titleSearchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    let movieDataRepository = MovieDataRepository()
    var searchResult: [Movie] = []
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleSearchBar.delegate = self
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        indicator.center = view.center
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.color = .blue
        view.addSubview(indicator)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let horizontalSpace:CGFloat = 5

        let cellSize:CGFloat = self.view.bounds.width / 2 - horizontalSpace

        return CGSize(width: cellSize, height: cellSize)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            1
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as UICollectionViewCell? else {
            return UICollectionViewCell()
        }
        
        let movieInformation = searchResult[indexPath.row]
        
        let image = cell.contentView.viewWithTag(1) as! UIImageView
        
        image.image = ImageUtil().getImageByUrl(url: movieInformation.poster_path, dark: true, size: "154")
        
        let label = cell.contentView.viewWithTag(2) as! UILabel
    
        label.text = movieInformation.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        
        if let indexPath = collectionView.indexPathsForSelectedItems {
            destinationVC.selectedMoive = searchResult[indexPath[0][1]]
         
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let title = searchBar.text {
            if title.isEmpty {
                searchResult = []
                collectionView.reloadData()
            } else {
                indicator.startAnimating()
                DispatchQueue.global().async {
                    self.getMovieData(title: title)
                    DispatchQueue.main.async {
                        searchBar.resignFirstResponder()
                        self.indicator.stopAnimating()
                    }
                }
            }
        }
    }
    
    // 映画情報の取得
    func getMovieData(title: String) {
        movieDataRepository.getMoiveData(title: title) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let movieData):
                self.searchResult = movieData.results
                self.collectionView.reloadData()
            case .failure(let moyaError):
                print(moyaError.localizedDescription)
            }
        }
    }
}

