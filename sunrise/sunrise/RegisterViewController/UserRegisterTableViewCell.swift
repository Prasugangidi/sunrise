//
//  UserRegisterTableViewCell.swift
//  sunrise
//
//  Created by reddys on 22/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit

protocol UserRegisterTableViewCellDelegate {
    func registerButtonClickedWithIndexPath(indexPath : IndexPath)
}

class UserRegisterTableViewCell: UITableViewCell {

    var indexPath : IndexPath!
    var delegate : UserRegisterTableViewCellDelegate?
    
    @IBOutlet weak var fornameTF: UITextField!
    @IBOutlet weak var lastnameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var confirmEmailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var birthdayTF: UITextField!
    
    var pickerView = UIDatePicker()
    var pickerSelectionView = UIView()
    var cancelButton = UIButton()
    var doneButton = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
      pickerSelectionView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 240)
        
        cancelButton.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.darkGray, for: .normal)
        cancelButton.addTarget(self, action: #selector(UserRegisterTableViewCell.pickerViewCancelButtonClicked), for: .touchUpInside)
        
        doneButton.frame = CGRect(x: self.frame.size.width-120, y:0 , width: 120, height: 40)
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.darkGray, for: .normal)
        doneButton.addTarget(self, action: #selector(UserRegisterTableViewCell.pickerViewDoneButtonClicked), for: .touchUpInside)
        
        pickerView.frame = CGRect(x: 0, y: 50, width: self.frame.size.width, height: 200)
        
        pickerSelectionView.addSubview(cancelButton)
        pickerSelectionView.addSubview(doneButton)
        pickerSelectionView.addSubview(pickerView)
        
        pickerSelectionView.backgroundColor = UIColor.white
        pickerView.backgroundColor = UIColor.white
        
        self.birthdayTF.inputView = pickerSelectionView
    }
    
    @objc func pickerViewCancelButtonClicked()
    {
        self.birthdayTF.resignFirstResponder()
    }
    
    @objc func pickerViewDoneButtonClicked()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from:pickerView.date)
        self.birthdayTF.text = dateString
        self.birthdayTF.resignFirstResponder()

    }

    @IBAction func registerButtonClicked(_ sender: Any) {
        self.delegate?.registerButtonClickedWithIndexPath(indexPath: self.indexPath)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
