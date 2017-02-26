//
//  FilterViewController.swift
//  Yelp
//
//  Created by Nguyen Nam Long on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var tableVIew: UITableView!
    var filterModel = Filter()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIew.dataSource = self
        tableVIew.dataSource = self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK: Table View

extension FilterViewController: UITabBarDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Deal"
        case 1: return "Distance"
        case 2: return "Sort By"
        case 3: return "Category"
        default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 : return 1
        case 1: return filterModel.distance.count
        case 2: return filterModel.sortBy.count
        case 3: return filterModel.yelpCategories().count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchCell
            cell.config(with: "Offering a Deal", isOn: filterModel.isDeal)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "checkCell") as! CheckCell
            cell.config(name: filterModel.distance[indexPath.row].name, isCheck: filterModel.distance[indexPath.row].isOn)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "checkCell") as! CheckCell
            cell.config(name: filterModel.sortBy[indexPath.row].name, isCheck: filterModel.sortBy[indexPath.row].isOn)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchCell
            cell.config(with: filterModel.categories[indexPath.row].name, isOn: filterModel.categories[indexPath.row].isOn)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}

