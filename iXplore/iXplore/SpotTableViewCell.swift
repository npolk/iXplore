//
//  SpotTableViewCell.swift
//  iXplore
//
//  Created by Serene Mirza on 6/13/16.
//  Copyright © 2016 Natalie Polk. All rights reserved.
//

import UIKit

class SpotTableViewCell: UITableViewCell {
    
    
    var logo = UIImageView()
    var label = UILabel()
    var date = UILabel()
    var describe = UILabel()
    var star = UIImageView()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //LOGO
        let logoFrame = CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height)
        logo = UIImageView(frame: logoFrame)
        self.addSubview(logo)
        
        //LABEL
        let labelFrame = CGRectMake(self.frame.height + 5, 0, self.frame.width - self.frame.height - 100, self.frame.height/2)
        label = UILabel(frame: labelFrame)
        self.addSubview(label)
        
        //DATE
        let dateFrame = CGRectMake(self.frame.width - 70, 0, 100, self.frame.height/2)
        date = UILabel(frame: dateFrame)
        date.font = date.font.fontWithSize(11)
        date.textAlignment = .Right
        self.addSubview(date)
        
        //DESCRIPTION
        let describeFrame = CGRectMake(self.frame.height + 5, self.frame.height/2, self.frame.width - self.frame.height, self.frame.height/2)
        describe = UILabel(frame: describeFrame)
        self.addSubview(describe)
        describe.font = describe.font.fontWithSize(11)
        
        //STAR (to indicate favorites)
        let starFrame = CGRect(x: self.frame.width+30, y: 0, width: self.frame.height/2.5, height: self.frame.height/2.5)
        star = UIImageView(frame: starFrame)
        star.image = UIImage(named: "star_pink.png")
        self.addSubview(star)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
