//
//  SwitchCell.swift
//  Yelp
//
//  Created by Nguyen Nam Long on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var switchValue: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switchValue.isOn = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with name: String, isOn: Bool) {
        nameLabel.text = name
        switchValue.isOn = isOn
    }

}
