//
//  CheckCell.swift
//  Yelp
//
//  Created by Nguyen Nam Long on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit



class CheckCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!

    
    var isCheck: Bool = false {
        didSet {
            checkImage.isHidden = !(isCheck)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func config(name: String, isCheck: Bool) {
        nameLabel.text = name
        self.isCheck = isCheck
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
