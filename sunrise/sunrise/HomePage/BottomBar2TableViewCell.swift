//
//  BottomBar2TableViewCell.swift
//  sunrise
//
//  Created by reddys on 26/9/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit

class BottomBar2TableViewCell: UITableViewCell {

    @IBOutlet weak var bnrImageView1: UIImageView!
    
    @IBOutlet weak var bnrImageView2: UIImageView!
    
    @IBOutlet weak var imgOneLabelA: UILabel!
    
    @IBOutlet weak var imgOneLabelB: UILabel!
    
    @IBOutlet weak var imgOneLabelC: UILabel!
    
    @IBOutlet weak var imgTwoLabelA: UILabel!
    
    @IBOutlet weak var imgTwoLabelB: UILabel!
    
    @IBOutlet weak var imgTwoLabelC: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBannerData( bannerData : [[String : AnyObject]] , forRow row : Int)
    {
        var set1  : [[String : AnyObject]] = []
         var set2  : [[String : AnyObject]] = []
        
        for i in 0..<bannerData.count
        {
            if i%2 == 0
            {
                set1.append(bannerData[i])
            }
            else
            {
                set2.append(bannerData[i])
            }
        }
        
        let data1 = set1[row]
        
        let data2 = set2[row]
        
        let imageUrl1 = data1["image_path"] as! String
        bnrImageView1.sd_setImage(with: URL(string: imageUrl1), placeholderImage: UIImage(named: "placeholder.png"))
        imgOneLabelA.text = data1["text_1"] as? String
        imgOneLabelB.text = data1["text_2"] as? String
        imgOneLabelC.text = data1["text_3"] as? String
        
        let imageUrl2 = data2["image_path"] as! String
        bnrImageView2.sd_setImage(with: URL(string: imageUrl2), placeholderImage: UIImage(named: "placeholder.png"))
        imgTwoLabelA.text = data2["text_1"] as? String
        imgTwoLabelB.text = data2["text_2"] as? String
        imgTwoLabelC.text = data2["text_3"] as? String
    }

}
