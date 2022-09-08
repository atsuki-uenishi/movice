//
//  ViewController.swift
//  movice
//
//  Created by 上西篤季 on 2022/09/03.
//

import UIKit
import Moya

class SearchViewController: UIViewController {
    
    @IBOutlet weak var titleSearchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let movieDataRepository = MovieDataRepository()
    var searchResult: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleSearchBar.delegate = self
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let horizontalSpace:CGFloat = 5

        let cellSize:CGFloat = self.view.bounds.width/2 - horizontalSpace

        return CGSize(width: cellSize, height: cellSize)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        
        let image = cell.contentView.viewWithTag(1) as! UIImageView
        

        image.image = getImageByUrl(url: searchResult[indexPath.row].poster_path, dark: true)
        
        
        
        let label = cell.contentView.viewWithTag(2) as! UILabel
    
        label.text = searchResult[indexPath.row].title
        
        return cell
    }
    
    func getMovieData(title: String) {
        movieDataRepository.getMoiveData(title: title) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let movieData):
                self.searchResult = movieData.results
                self.collectionView.reloadData()
            case .failure(let moyaError):
                print(moyaError.localizedDescription)
            }
        }
    }
    
    func getImageByUrl(url: String, dark: Bool) -> UIImage{
        let posterSizeUrl = "https://image.tmdb.org/t/p/w154"
        let url = URL(string: posterSizeUrl+url)
        do {
            let data = try Data(contentsOf: url!)
            if !dark {
                return UIImage(data: data)!
            }
            return darken(image: UIImage(data: data)!, level: 0.5)
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
    }
    
    //画像を暗くする
    func darken(image:UIImage, level:CGFloat) -> UIImage{

            let frame = CGRect(origin:CGPoint(x:0,y:0),size:image.size)
            let tempView = UIView(frame:frame)
            tempView.backgroundColor = UIColor.black
            tempView.alpha = level

            UIGraphicsBeginImageContext(frame.size)
            let context = UIGraphicsGetCurrentContext()
            image.draw(in: frame)

            context!.translateBy(x: 0, y: frame.size.height)
            context!.scaleBy(x: 1.0, y: -1.0)
            context!.clip(to: frame, mask: image.cgImage!)
            tempView.layer.render(in: context!)

            let imageRef = context!.makeImage()
            let toReturn = UIImage(cgImage:imageRef!)
            UIGraphicsEndImageContext()
            return toReturn

        }
    
    
    
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let title = searchBar.text {
            getMovieData(title: title)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
//            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

