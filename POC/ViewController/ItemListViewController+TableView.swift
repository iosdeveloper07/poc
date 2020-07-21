//
//  ItemListViewController+TableView.swift
//  POC
//
//  Created by Shashank on 21/07/20.
//  Copyright © 2020 Shashank. All rights reserved.
//

import UIKit

extension ItemListViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array_detail?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let margin_contentView = cell.contentView.layoutMarginsGuide
        let margin_ImageView = cell.imageView?.layoutMarginsGuide
        let margin_textLabel = cell.textLabel?.layoutMarginsGuide
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        cell.imageView?.translatesAutoresizingMaskIntoConstraints = false
        cell.imageView?.topAnchor.constraint(equalTo: margin_contentView.topAnchor,constant: 0).isActive = true
        cell.imageView?.leadingAnchor.constraint(equalTo: margin_contentView.leadingAnchor,constant: 0).isActive = true
        cell.imageView?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cell.imageView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.layer.cornerRadius = 20
        cell.textLabel?.translatesAutoresizingMaskIntoConstraints = false
        cell.textLabel?.topAnchor.constraint(equalTo: margin_contentView.topAnchor,constant: 0).isActive = true
        cell.textLabel?.leadingAnchor.constraint(equalTo: margin_ImageView!.leadingAnchor, constant: 50).isActive = true
        
        cell.detailTextLabel?.translatesAutoresizingMaskIntoConstraints = false
        cell.detailTextLabel?.topAnchor.constraint(equalTo: margin_textLabel!.topAnchor,constant: 20).isActive = true
        
        cell.detailTextLabel?.leadingAnchor.constraint(equalTo: margin_ImageView!.leadingAnchor, constant: 50).isActive = true
        cell.detailTextLabel?.trailingAnchor.constraint(equalTo: margin_contentView.trailingAnchor, constant: 0).isActive = true
        cell.detailTextLabel?.bottomAnchor.constraint(equalTo: margin_contentView.bottomAnchor, constant: 0).isActive = true
        if let array_item = self.array_detail{
            let dict_item = array_item[indexPath.row]
            cell.textLabel?.text = dict_item.title ?? "N/A"
            cell.detailTextLabel?.text = dict_item.description  ?? "N/A"
            cell.imageView?.sd_setImage(with: URL(string: dict_item.imageHref ?? ""), placeholderImage: UIImage(named: "Placeholder"))
        }
        return cell
    }
}


