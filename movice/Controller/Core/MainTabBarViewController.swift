//
//  MainTabBarViewController.swift
//  movice
//
//  Created by 上西篤季 on 2022/11/14.
//

import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBar.appearance()
        appearance.tintColor = .systemGreen
        appearance.backgroundColor = .systemGray3
        
        let homeView = UIStoryboard(name: "HomeView", bundle: nil)
        let searchView = UIStoryboard(name: "SearchView", bundle: nil)
        let watchListView = UIStoryboard(name: "WatchListView", bundle: nil)
        
        let vc1 = UINavigationController(rootViewController: homeView.instantiateViewController(withIdentifier: "HomeView"))
        let vc2 = UINavigationController(rootViewController: searchView.instantiateViewController(withIdentifier: "SearchView"))
        let vc3 = UINavigationController(rootViewController: watchListView.instantiateViewController(withIdentifier: "WatchListView"))
        let vc4 = UINavigationController(rootViewController: ReviewedViewController())
        
        
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "eyeglasses")
        vc4.tabBarItem.image = UIImage(systemName: "text.bubble")
        
        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "Watch List"
        vc4.title = "Review"
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)

    }


}
