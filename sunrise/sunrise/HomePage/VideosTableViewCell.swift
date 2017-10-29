//
//  VideosTableViewCell.swift
//  sunrise
//
//  Created by reddys on 23/9/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit

class VideosTableViewCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        label1.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
