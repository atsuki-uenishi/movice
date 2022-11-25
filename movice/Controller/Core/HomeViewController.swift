//
//  HomeViewController.swift
//  movice
//
//  Created by 上西篤季 on 2022/11/13.
//

import UIKit

enum Sections: Int {
    case Popular = 0
    case Upcoming = 1
    case TopRated = 2
}

class HomeViewController: UIViewController {
    
    let movieDataRepository = MovieDataRepository()
    
    @IBOutlet private weak var homeTable: UITableView! {
        didSet {
            homeTable.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.identifier)
            homeTable.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        }
    }
    
    let sectionTitles: [String] = ["", "新着", "高評価"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTable.delegate = self
        homeTable.dataSource = self
        
        configureNavbar()
        
        
    }
    
    private func configureNavbar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .black
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == Sections.Popular.rawValue {
            guard let headerCell = homeTable.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier, for: indexPath) as? HeaderTableViewCell else {
                return UITableViewCell()
            }
            
            headerCell.delegate = self
            
            movieDataRepository.getPopularMovie { result in
                switch result {
                case .success(let movieData):
                    headerCell.configure(popularMovies: movieData.results, width: UIScreen.main.bounds.width)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return headerCell
        } else {
            guard let cell = homeTable.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
                return UITableViewCell()
            }
            
            cell.delegate = self
            
            switch indexPath.section {
                
            case Sections.Upcoming.rawValue:
                
                movieDataRepository.getUpcomingMovie { result in
                    switch result {
                    case .success(let movieData):
                        cell.configure(movies: movieData.results)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            
            case Sections.TopRated.rawValue:
                movieDataRepository.getTopRatedMovie{ result in
                    switch result {
                    case .success(let movieData):
                        cell.configure(movies: movieData.results)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            default:
                return UITableViewCell()
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == Sections.Popular.rawValue {
            return 500
        } else {
            return 200
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        header.textLabel?.textColor = .white
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset

        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController: HeaderTableViewCellDelegate {
    
    func headerTableViewCellDidTapCell(_ cell: HeaderTableViewCell, movie: Movie) {
        DispatchQueue.main.async { [weak self] in
            let detailVC = UIStoryboard(name: "DetailView", bundle: nil).instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
            detailVC.selectedMoive = movie
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, movie: Movie) {
        DispatchQueue.main.async { [weak self] in
            let detailVC = UIStoryboard(name: "DetailView", bundle: nil).instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
            detailVC.selectedMoive = movie
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
