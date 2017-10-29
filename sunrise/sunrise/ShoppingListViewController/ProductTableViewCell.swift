//
//  ProductTableViewCell.swift
//  sunrise
//
//  Created by reddys on 6/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit
import SDWebImage

protocol ProductTableViewCellDelegate {
    
    func rightImageSelectedWithIndexPath(indexPath : IndexPath)
    func leftImageSelectedWithIndexPath(indexPath : IndexPath)
        
}

class ProductTableViewCell: UITableViewCell , UIPickerViewDelegate , UIPickerViewDataSource , UITextFieldDelegate{
   
    

    @IBOutlet weak var productImage1: UIImageView!
    @IBOutlet weak var size1TF: UITextField!
    @IBOutlet weak var quantity1TF: UITextField!
    @IBOutlet weak var name1Lbl: UILabel!
    @IBOutlet weak var category1Lbl: UILabel!
    @IBOutlet weak var price1Lbl: UILabel!
    @IBOutlet weak var button1: UIButton!
    
    
    @IBOutlet weak var productImage2: UIImageView!
    @IBOutlet weak var size2TF: UITextField!
    @IBOutlet weak var quantity2TF: UITextField!
    @IBOutlet weak var name2Lbl: UILabel!
    @IBOutlet weak var category2Lbl: UILabel!
    @IBOutlet weak var price2Lbl: UILabel!
    @IBOutlet weak var button2: UIButton!
    
    var pickerView = UIPickerView()
    var pickerSelectionView = UIView()
    var cancelButton = UIButton()
    var doneButton = UIButton()
    var activeTF : UITextField!
    
    var delegate : ProductTableViewCellDelegate?
    var model1Data : [String : AnyObject]?
    var model2Data : [String : AnyObject]?
    var selectedRow = 0
    var size1Selected = false
    var size2Selected = false
    var indexPath : IndexPath!
    var leftSideProductInfo : [String : AnyObject]?
    var rightSideProductInfo : [String : AnyObject]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        size1TF.delegate = self
        size2TF.delegate = self
        quantity1TF.delegate = self
        quantity2TF.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerSelectionView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 240)
        cancelButton.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.darkGray, for: .normal)
        cancelButton.addTarget(self, action: #selector(ProductTableViewCell.pickerViewCancelButtonClicked), for: .touchUpInside)
        
        doneButton.frame = CGRect(x: self.frame.size.width-120, y:0 , width: 120, height: 40)
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.darkGray, for: .normal)
        doneButton.addTarget(self, action: #selector(ProductTableViewCell.pickerViewDoneButtonClicked), for: .touchUpInside)

        pickerView.frame = CGRect(x: 0, y: 50, width: self.frame.size.width, height: 200)
        
        pickerSelectionView.addSubview(cancelButton)
        pickerSelectionView.addSubview(doneButton)
        pickerSelectionView.addSubview(pickerView)
        pickerSelectionView.backgroundColor = UIColor.white
        pickerView.backgroundColor = UIColor.white

        let downArrowImgView1 = UIImageView(image: UIImage(named: "DownArrow"))
        self.size1TF.rightView = downArrowImgView1
        self.size1TF.rightViewMode = .always

        let downArrowImgView2 = UIImageView(image: UIImage(named: "DownArrow"))
        self.quantity1TF.rightView = downArrowImgView2
        self.quantity1TF.rightViewMode = .always
        
        let downArrowImgView3 = UIImageView(image: UIImage(named: "DownArrow"))
        self.size2TF.rightView = downArrowImgView3
        self.size2TF.rightViewMode = .always
        
        let downArrowImgView4 = UIImageView(image: UIImage(named: "DownArrow"))
        self.quantity2TF.rightView = downArrowImgView4
        self.quantity2TF.rightViewMode = .always
        
        button1.layer.cornerRadius = 3.0
        button1.layer.borderColor = UIColor.red.cgColor
        
        let lefttapGesture = UITapGestureRecognizer(target: self, action: #selector(ProductTableViewCell.leftImagetapped))
        productImage1.isUserInteractionEnabled = true
        productImage1.addGestureRecognizer(lefttapGesture)
        
        let righttapGesture = UITapGestureRecognizer(target: self, action: #selector(ProductTableViewCell.rightImagetapped))
        productImage2.isUserInteractionEnabled = true
        productImage2.addGestureRecognizer(righttapGesture)
        
        
        
    }
    
    @objc func leftImagetapped()
    {
        self.delegate?.leftImageSelectedWithIndexPath(indexPath: self.indexPath)
        
    }
    @objc func rightImagetapped()
    {
        self.delegate?.rightImageSelectedWithIndexPath(indexPath: self.indexPath)
        
    }
    
    @objc func pickerViewCancelButtonClicked()
    {
        self.size1TF.resignFirstResponder()
        self.size2TF.resignFirstResponder()
        self.quantity1TF.resignFirstResponder()
        self.quantity2TF.resignFirstResponder()

    }
    
    @objc func pickerViewDoneButtonClicked()
    {
        if activeTF == size1TF {
            self.size1Selected = true
            let productKeys: [[String : AnyObject]] = self.model1Data!["goods_product_no_key"] as!  [[String : AnyObject]]
            let productkey = productKeys[selectedRow]
            activeTF.text = productkey["attr_value"] as? String
        }
        do {
            if self.activeTF == size2TF {
                self.size2Selected = true
                let productKeys: [[String : AnyObject]] = self.model2Data!["goods_product_no_key"] as!  [[String : AnyObject]]
                let productkey = productKeys[selectedRow]
                activeTF.text = productkey["attr_value"] as? String
            }
        }
        if activeTF == quantity1TF || activeTF == quantity2TF {
            activeTF.text = "\(selectedRow+1)"
        }
        self.size1TF.resignFirstResponder()
        self.size2TF.resignFirstResponder()
        self.quantity1TF.resignFirstResponder()
        self.quantity2TF.resignFirstResponder()
    }
    
    func setDataWith(model1 : [String : AnyObject] , model2 : [String : AnyObject]?)
    {
        self.model1Data = model1
        self.name1Lbl.text =  model1["display_goods_name"] as? String
         name1Lbl.text = name1Lbl.text?.uppercased()
        self.category1Lbl.text =  model1["display_model_type_name"] as? String
        self.productImage1.sd_setImage(with: URL(string: model1["goods_thumb"] as! String), placeholderImage: UIImage(named: "placeholder.png"))
        self.size1TF.text = model1["product_attr_name"] as? String
        self.size1TF.inputView = self.pickerSelectionView
        self.quantity1TF.inputView = self.pickerSelectionView
        self.price1Lbl.text = model1["display_market_price"] as? String
        
        
        
        self.model2Data = model2
        self.name2Lbl.text =  model2!["display_goods_name"] as? String
        self.price2Lbl.text = model2!["display_market_price"] as? String
        self.category2Lbl.text =  model2!["display_model_type_name"] as? String
        name2Lbl.text = name2Lbl.text?.uppercased()
        if let imagePath = model2!["goods_thumb"]
        {
            self.productImage2.sd_setImage(with: URL(string: imagePath as! String), placeholderImage: UIImage(named: "placeholder.png"))
        }
       
        self.size2TF.text = model2!["product_attr_name"] as? String
        self.size2TF.inputView = self.pickerSelectionView
        self.quantity2TF.inputView = self.pickerSelectionView

    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        activeTF = textField
        self.pickerView.reloadAllComponents()
        return true
    }
    
    // MARK PIckerView Delegate and datasource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
   {
    if activeTF == size1TF {
        let sizes: [[String : AnyObject]] = self.model1Data!["goods_product_no_key"] as!  [[String : AnyObject]]
        return sizes.count
    }
    if activeTF == size2TF {
        let sizes: [[String : AnyObject]] = self.model2Data!["goods_product_no_key"] as!  [[String : AnyObject]]
        return sizes.count
    }
    if activeTF == quantity1TF 
    {
        if self.size1Selected
        {
            let quantity = leftSideProductInfo!["stocks"] as! String
            return Int(quantity)!
        }
        }
    if activeTF == quantity2TF
    {
        if self.size2Selected
        {
            let quantity = rightSideProductInfo!["stocks"] as! String
            return Int(quantity)!
        }
    }
    return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if activeTF == size1TF {
            let productKeys: [[String : AnyObject]] = self.model1Data!["goods_product_no_key"] as!  [[String : AnyObject]]
            let productkey = productKeys[row]
            self.leftSideProductInfo = productkey
            return productkey["attr_value"] as? String
        }
        
        if activeTF == size2TF {
            let productKeys: [[String : AnyObject]] = self.model2Data!["goods_product_no_key"] as!  [[String : AnyObject]]
            let productkey = productKeys[row]
            self.rightSideProductInfo = productkey
            return productkey["attr_value"] as? String
        }
        
        if activeTF == quantity1TF || activeTF == quantity2TF {
           return "\(row+1)"
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedRow = row
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Con  let cell : BottomBar1TableViewCell = tableView.dequeueReusableCell(withIdentifier: "BottomBar1TableViewCell", for: indexPath) as! BottomBar1TableViewCellfigure the view for the selected state
    }

}

