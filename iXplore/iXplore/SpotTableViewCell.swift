//
//  SpotTableViewCell.swift
//  iXplore
//
//  Created by Serene Mirza on 6/13/16.
//  Copyright © 2016 Natalie Polk. All rights reserved.
//

import UIKit

class SpotTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var date: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
