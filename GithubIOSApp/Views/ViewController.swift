//
//  ViewController.swift
//  GithubIOSApp
//
//  Created by Mohamad Abdallah on 4/5/21.
//  Copyright © 2021 Abdallah. All rights reserved.
//

import UIKit


import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl() // -> For pull to refresh
    var page = 1
    var reposData = [ReposItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCellID")
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {//targets versions prior to iOS 10
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshReposData), for: .valueChanged)
        
        fetchReposData()
    }
    
    func fetchReposData(){
                
        let date = Helper.GetSubstractedTodayDate(days: 30)
        let getReposEndPoint = EndpointCases.getReposData(page: self.page, date: date)
        
        KRProgressHUD.show()

        APIClient.fetchReposData(endpoint: getReposEndPoint, completion: { (repos, error) in
            
            if let repos = repos{
                
                self.reposData.append(contentsOf: repos)
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                KRProgressHUD.dismiss()
                
            }else{
                self.refreshControl.endRefreshing()
                KRProgressHUD.showError(withMessage: error?.errorDescription)
            }
        })
        
    }
    
    @objc func refreshReposData(){ // -> remove all data , reload table , reGet data
        page = 1
        reposData.removeAll()
        tableView.reloadData()
        self.fetchReposData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reposData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCellID", for: indexPath) as? RepoTableViewCell)!
        
        cell.data = self.reposData[indexPath.row]
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= (self.reposData.count - 1) { //last cell
            page += 1
            self.fetchReposData()
       }
        
    }
    
}
