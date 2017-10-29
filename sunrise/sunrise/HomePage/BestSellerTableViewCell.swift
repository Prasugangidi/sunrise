//
//  BestSellerTableViewCell.swift
//  sunrise
//
//  Created by reddys on 23/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit

class BestSellerTableViewCell: UITableViewCell {

    @IBOutlet weak var bestSellerLbl: UILabel!
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
