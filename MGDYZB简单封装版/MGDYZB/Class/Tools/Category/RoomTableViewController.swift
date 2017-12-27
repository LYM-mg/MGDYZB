//
//  RoomTableViewController.swift
//  MGDYZB
//
//  Created by newunion on 2017/12/26.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit

class RoomTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewConfig()
    }
    
   fileprivate func tableViewConfig() {
//        tableView.backgroundColor = UIColor.yellow
//        tableView.showsVerticalScrollIndicator = false
//        tableView.showsHorizontalScrollIndicator = false
//
//        tableView.estimatedSectionHeaderHeight = 0;
//        tableView.estimatedSectionFooterHeight = 0;
//        tableView.estimatedRowHeight = 0;
//        tableView.separatorStyle = .none
    
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never;
//        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.star()
        self.scrollViewDidScroll(tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.reset()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        }

        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.text = "第\(indexPath.section)列  第\(indexPath.row)行"

        return cell!
    }
 
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navigationController?.navigationBar.change(UIColor.orange, with: scrollView, andValue: 128)
    }
}
