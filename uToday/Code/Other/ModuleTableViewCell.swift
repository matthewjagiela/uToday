//
//  ModuleTableViewCell.swift
//  uToday
//
//  Created by Matthew Jagiela on 2/12/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit

class ModuleTableViewCell: UITableViewCell {
    @IBOutlet var nameOfService: UILabel!
    @IBOutlet var pictureOfService: UIImageView!
    @IBOutlet var optionalLabelOne: UILabel!
    @IBOutlet var optionalLabelTwo: UILabel!
    @IBOutlet var summary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
