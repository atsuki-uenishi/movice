//
//  WatchListViewController.swift
//  movice
//
//  Created by 上西篤季 on 2022/09/05.
//

import UIKit

class WatchListViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    let listData:[String] = ["cell_1","cell_2","cell_3","cell_4","cell_5"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }



}

extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
          
         cell.imageView?.image = UIImage(named: "header")
          
//         let image = cell.contentView.viewWithTag(1) as! UIImageView
//
//         image.image = UIImage(named: <#T##String#>)
          
//         let label = cell.contentView.viewWithTag(2) as! UILabel
//
//         label.text = listData[indexPath.row]
          
          cell.textLabel?.text = listData[indexPath.row]
        
        return cell
      }
    
}
