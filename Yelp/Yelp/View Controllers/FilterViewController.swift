//
//  FilterViewController.swift
//  Yelp
//
//  Created by Nguyen Nam Long on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate {
    func filterUpdate(didUpdate: Filter)
}

class FilterViewController: UIViewController {
    
    @IBOutlet weak var tableVIew: UITableView!
    var filterModelBefore = Filter()
    var filterModeAfter = Filter()
    var delegate: FilterViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIew.dataSource = self
        tableVIew.delegate = self
        
        filterModeAfter = filterModelBefore
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSave(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
            self.delegate?.filterUpdate(didUpdate: self.filterModeAfter)
        }
    }

    
    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) { 
            self.delegate?.filterUpdate(didUpdate: self.filterModelBefore)
        }
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

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
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
        case 1: return filterModeAfter.distance.count
        case 2: return filterModeAfter.sortBy.count
        case 3: return filterModeAfter.categories.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchCell
            cell.config(with: "Offering a Deal", isOn: filterModeAfter.isDeal)
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "checkCell") as! CheckCell
            cell.config(name: filterModeAfter.distance[indexPath.row].name, isCheck: filterModeAfter.distance[indexPath.row].isOn)
            print("\(cell.nameLabel.text) - \(cell.isCheck)")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "checkCell") as! CheckCell
            cell.config(name: filterModeAfter.sortBy[indexPath.row].name, isCheck: filterModeAfter.sortBy[indexPath.row].isOn)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchCell
            cell.config(with: filterModeAfter.categories[indexPath.row].name, isOn: filterModeAfter.categories[indexPath.row].isOn)
            cell.delegate = self
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: break
        case 1:
            for index in 0...filterModeAfter.distance.count-1 {
                filterModeAfter.distance[index].isOn = false
                if index == indexPath.row {
                    filterModeAfter.distance[index].isOn = true
                }
            }
            tableVIew.reloadData()
        case 2:
            for index in 0...filterModeAfter.sortBy.count-1 {
                filterModeAfter.sortBy[index].isOn = false
                if index == indexPath.row {
                    filterModeAfter.sortBy[index].isOn = true
                }
            }
            tableVIew.reloadData()
        default: break
        }
    }
    
    
}



// MARK: delegate

extension FilterViewController: SwitchCellDelegate {
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let index = tableVIew.indexPath(for: switchCell)
        if index?.section == 0 {
            filterModeAfter.isDeal = value
        }else if index?.section == 3 {
            filterModeAfter.categories[(index?.row)!].isOn = value
        }
        print("\(filterModeAfter.categories[(index?.row)!].name) : \(filterModeAfter.categories[(index?.row)!].isOn) ")
    }
    
}

