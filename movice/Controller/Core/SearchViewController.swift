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
        
        titleSearchBar?.delegate = self
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        
        indicator.center = view.center
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.color = .blue
        view.addSubview(indicator)
        configureNavbar()
    }
    
    private func configureNavbar() {
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let horizontalSpace: CGFloat = 5
        
        let cellSize:CGFloat = UIScreen.main.bounds.width / 3 - horizontalSpace
        
        return CGSize(width: cellSize, height: cellSize + 50)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            1
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movieInformation = searchResult[indexPath.row]
        
        cell.configure(movie: movieInformation)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = StoryboardScene.DetailView.initialScene.instantiate()
        detailVC.selectedMoive = self.searchResult[indexPath[1]]
        self.navigationController?.pushViewController(detailVC, animated: true)

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
                searchBar.resignFirstResponder()
                DispatchQueue.global(qos: .background).async {
                    self.getMovieData(title: title)
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
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                }
                self.collectionView.reloadData()
            case .failure(let moyaError):
                print(moyaError.localizedDescription)
            }
        }
    }
}

