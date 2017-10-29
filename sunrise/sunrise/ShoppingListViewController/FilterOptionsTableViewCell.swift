//
//  FilterOptionsTableViewCell.swift
//  sunrise
//
//  Created by reddys on 6/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit

class FilterOptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var title1Lbl: UILabel!
    @IBOutlet weak var title2Lbl: UILabel!
    
     
    
    var title : String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  //self.title1Lbl.title = ["name"]
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


