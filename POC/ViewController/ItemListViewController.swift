//
//  ItemListViewController.swift
//  POC
//
//  Created by Shashank on 21/07/20.
//  Copyright © 2020 Shashank. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage

class ItemListViewController: UIViewController {
    var tblViewItem = UITableView()
    let refreshControl = UIRefreshControl()
    var array_detail : [Rows]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.view.addSubview(tblViewItem)
        self.setupTableView()
        self.callApi()
    }
    func setupTableView(){
        // Setting Autolayout Anchor programatically
        self.tblViewItem.translatesAutoresizingMaskIntoConstraints = false
        self.tblViewItem.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tblViewItem.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.tblViewItem.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.tblViewItem.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        //confirming Delegate and data source of tableview
        tblViewItem.dataSource = self
        tblViewItem.delegate = self
       // register table view cell
        self.tblViewItem.register(UITableViewCell.self, forCellReuseIdentifier: Constant.KConstant.cell_identifier)
        self.tblViewItem.rowHeight = UITableView.automaticDimension
        self.tblViewItem.estimatedRowHeight = 44
        // implement pull to refresh functionality in tableview
        self.tblViewItem.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshItemData(_:)), for: .valueChanged)
    }
    //method called when user use pull to refresh functionality
    @objc private func refreshItemData(_ sender: Any) {
        // Fetch item Data by using pull to refresh
        self.callApi()
        self.refreshControl.endRefreshing()
    }
    
    func callApi(){
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            self.showAlert(_title_str: "You are not connected to internet")
            return
            
        case .online(.wwan):
            print("Connected via WWAN")
        case .online(.wiFi):
            print("Connected via WiFi")
        }
        
        let vm = SMItemListViewModel()
        vm.ItemListAPI(view: self.view) { (success, message, response) in
            DispatchQueue.main.async {
                Loader.hideIndicator(View: self.view)
            }
            if success && message.isEmpty {
                print(self.array_detail?.count ?? 0)
                self.array_detail = response?.rows
                // update UI using the response here
                DispatchQueue.main.async {
                    self.navigationItem.title = response?.title
                    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
                    self.navigationController?.navigationBar.titleTextAttributes = textAttributes
                    self.tblViewItem.reloadData()
                }
            }
        }
    }
    func showAlert(_title_str : String) {
        let alert = UIAlertController(title: "No Internet", message: _title_str,         preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
