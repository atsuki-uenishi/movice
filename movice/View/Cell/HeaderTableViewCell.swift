//
//  HeaderTableViewCell.swift
//  movice
//
//  Created by 上西篤季 on 2022/11/24.
//

import UIKit

protocol HeaderTableViewCellDelegate: AnyObject {
    func headerTableViewCellDidTapCell(_ cell: HeaderTableViewCell, movie: Movie)
}

class HeaderTableViewCell: UITableViewCell {
    
    static let identifier = "HeaderTableViewCell"
    
    weak var delegate: HeaderTableViewCellDelegate?
    
    @IBOutlet private weak var headerCollectionView: UICollectionView!
    
    private var popularMovies:[Movie] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let view = UINib(nibName: "HeaderTableViewCell", bundle: nil).instantiate(withOwner: self).first as! UITableViewCell
        contentView.addSubview(view)
        
        headerCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerCollectionView.frame = contentView.bounds
    }
    
    func configure(popularMovies: [Movie], width: CGFloat) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: 500)
        layout.scrollDirection = .horizontal
        headerCollectionView.collectionViewLayout = layout
        self.popularMovies = popularMovies
        DispatchQueue.main.async {
            self.headerCollectionView.reloadData()
        }
    }
}

extension HeaderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        popularMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movie = popularMovies[indexPath.row].poster_path
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = popularMovies[indexPath.row]
        self.delegate?.headerTableViewCellDidTapCell(self, movie: movie)
    }
    
}
