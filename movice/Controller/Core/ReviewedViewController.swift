//
//  ReviewedViewController.swift
//  movice
//
//  Created by 上西篤季 on 2022/11/14.
//

import UIKit
import RealmSwift

class ReviewedViewController: UIViewController {
    
    let realm = try! Realm()
    var reviewedMovies: Results<ReviewedMovieData>?
    
    @IBOutlet private weak var reviewedTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewedTable.dataSource = self
        reviewedTable.delegate = self
        reviewedTable.register(UINib(nibName: "ReviewedTableViewCell", bundle: nil), forCellReuseIdentifier: ReviewedTableViewCell.identifier)
        configureNavbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadReviewedMovies()
    }
    
    private func configureNavbar() {
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    private func loadReviewedMovies() {
        reviewedMovies = realm.objects(ReviewedMovieData.self)
        reviewedTable.reloadData()
    }
}

extension ReviewedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.reviewedMovies?.count ?? 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = reviewedTable.dequeueReusableCell(withIdentifier: ReviewedTableViewCell.identifier, for: indexPath) as? ReviewedTableViewCell else {
            return UITableViewCell()
        }
        
        if let reviewedMovies = self.reviewedMovies {
            let reviewedMovie = reviewedMovies[indexPath.row]
            cell.configure(posterUrl: reviewedMovie.poster, title: reviewedMovie.title, date: reviewedMovie.reviewDate, rating: reviewedMovie.rating, review: reviewedMovie.review)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let reviewedMovies = self.reviewedMovies else  {
            return
        }
        let reviewedDetailVC = StoryboardScene.ReviewedDetailView.initialScene.instantiate()
        reviewedDetailVC.reviewedMovie = reviewedMovies[indexPath.row]
        self.navigationController?.pushViewController(reviewedDetailVC, animated: true)
    }
    
    
}
