//
//  CalendarTableViewCell.swift
//  uToday
// This is going to be used exclusively for the calendar view so we can show what is coming up next for the day...
//  Created by Matthew Jagiela on 3/18/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {
    @IBOutlet var calendarColor: UIView!
    @IBOutlet var calendarName: UILabel!
    @IBOutlet var eventName: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
