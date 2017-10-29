//
//  ChangePasswordTableViewCell.swift
//  sunrise
//
//  Created by reddys on 23/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit

protocol ChangePasswordTableViewCellDelegate {
    func changePasswordButtonClickedWithIndexPath(indexPath : IndexPath)
}



class ChangePasswordTableViewCell: UITableViewCell {

    var indexPath : IndexPath!
    var delegate : ChangePasswordTableViewCellDelegate?
    
    @IBOutlet weak var emailForPasswordTF: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func changePasswordButtonClicked(_ sender: Any)
    {
        self.delegate?.changePasswordButtonClickedWithIndexPath(indexPath: self.indexPath)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
