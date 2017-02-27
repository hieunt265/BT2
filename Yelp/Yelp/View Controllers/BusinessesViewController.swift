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
    var filterMode = Filter()
    var filterDelegate: FilterViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        noResultLabel.isHidden = true
        
        
        
        navigationController?.navigationBar.barTintColor = UIColor.blue
        navigationController?.navigationBar.addSubview(searchBar)

        Business.search(with: "") { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                self.tableView.reloadData()
            }
        }

    }
    
    override func viewWillLayoutSubviews() {
        let navBarHeight = self.navigationController?.navigationBar.frame.height
        let y = (navBarHeight! - 20) / 2
        let screenWidth = tableView.superview!.frame.width
        searchBar.frame = CGRect(x: 70, y: y, width: screenWidth - 100, height: 20)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        if navigationController.topViewController is FilterViewController {
            let filtersViewController = navigationController.topViewController as! FilterViewController
            filtersViewController.delegate = self
            filtersViewController.filterModelBefore = filterMode
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


extension BusinessesViewController: FilterViewControllerDelegate {
    func filterUpdate(didUpdate: Filter) {
        filterMode = didUpdate
        
        var distance: Float?
        var categories = [String]()
        var sortBy = YelpSortMode(rawValue: 0)
        
        for item in filterMode.categories {
            if item.isOn {
                categories.append(item.code)
            }
        }
        
        for item in filterMode.distance {
            if item.isOn {
                distance = item.value
                break
            }
        }
        for item in filterMode.sortBy {
            if item.isOn {
                sortBy = item.value
                break
            }
        }
        
        Business.search(with: searchBar.text!, sort: sortBy, categories: categories, distance: distance, deals: filterMode.isDeal) { (businesses, error) in
            if let businesses = businesses {
                self.businesses = businesses
                
                self.tableView.reloadData()
            }
        }
        
    }
}
