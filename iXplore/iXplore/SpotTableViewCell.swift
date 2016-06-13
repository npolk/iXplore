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
    
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func hideStars() {
        star1.hidden = true
        star2.hidden = true
        star3.hidden = true
        star4.hidden = true
    }
    
}
