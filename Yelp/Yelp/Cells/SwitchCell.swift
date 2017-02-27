//
//  SwitchCell.swift
//  Yelp
//
//  Created by Nguyen Nam Long on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate {
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var switchValue: UISwitch!
    var delegate: SwitchCellDelegate!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switchValue.isOn = false
        switchValue.addTarget(self, action: #selector(switchUpdateValue), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with name: String, isOn: Bool) {
        nameLabel.text = name
        switchValue.isOn = isOn
    }
    
    func switchUpdateValue() {
        if delegate != nil {
            delegate?.switchCell(switchCell: self, didChangeValue: switchValue.isOn)
        }
    }

}
