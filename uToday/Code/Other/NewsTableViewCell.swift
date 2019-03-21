//
//  NewsTableViewCell.swift
//  uToday
//  This is going to be the cell for the table view which we use for news... 
//  Created by Matthew Jagiela on 3/20/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet var articleImage: UIImageView!
    @IBOutlet var articleSource: UILabel!
    @IBOutlet var aritcleTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
