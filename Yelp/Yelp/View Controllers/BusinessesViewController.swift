//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {

    var businesses: [Business]!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noResultLabel: UILabel!
    
    var searchBar = UISearchBar()
    var activityIndicatorView = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        noResultLabel.isHidden = true
        
        
        
        searchBar.sizeToFit()
//        navigationItem.titleView = searchBar
        navigationController?.navigationBar.addSubview(searchBar)

        Business.search(with: "") { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses

                for business in businesses {
                    self.businesses.append(business)
                    self.tableView.reloadData()
                }
            }
        }
        

        // Example of Yelp search with more search options specified
        /*
        Business.search(with: "Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses

                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
        }
        */
    }
    
    func onSearch() {
        Business.search(with: searchBar.text!) { (result, error) in
            if (result != nil) {
                if (result!.count) > 0 {
                    self.noResultLabel.isHidden = true
                    self.businesses = result!
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                } else {
                    self.noResultLabel.isHidden = false
                    self.tableView.isHidden = true
                }
            }else {
                self.noResultLabel.isHidden = false
                self.tableView.isHidden = true
            }
            
        }
    }
    

}






// MARK: - Table View
extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell") as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        cell.restaurantNameLabel.text = String(indexPath.row + 1) + ". " + businesses[indexPath.row].name!
        return cell
    }
}


// MARK: - Search Bar
extension BusinessesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        onSearch()
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        businesses.removeAll()
        onSearch()
        searchBar.resignFirstResponder()
    }
    
}
