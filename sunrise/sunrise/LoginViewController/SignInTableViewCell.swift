//
//  SignInTableViewCell.swift
//  sunrise
//
//  Created by reddys on 23/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit

protocol SignInTableViewCellDelegate {
    func signInButtonClickedWithIndexPath(indexPath : IndexPath)
}

class SignInTableViewCell: UITableViewCell {

    var indexPath : IndexPath!
    var delegate : SignInTableViewCellDelegate?
    
    @IBOutlet weak var enterEmailTF: UITextField!
    @IBOutlet weak var enterPasswordTF: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    @IBAction func signInButtonClicked(_ sender: Any)
    
    {
       self.delegate?.signInButtonClickedWithIndexPath(indexPath: self.indexPath)
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
