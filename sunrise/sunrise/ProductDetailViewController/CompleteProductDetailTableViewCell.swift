//
//  CompleteProductDetailTableViewCell.swift
//  sunrise
//
//  Created by reddys on 17/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit
import SDWebImage


class CompleteProductDetailTableViewCell: UITableViewCell ,UITextFieldDelegate ,UIPickerViewDelegate , UIPickerViewDataSource {
    
    @IBOutlet weak var modelNameLbl: UILabel!
    @IBOutlet weak var goodNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var colorTF: UITextField!
    @IBOutlet weak var modelSizeTF: UITextField!
    @IBOutlet weak var modelQtyTF: UITextField!
    @IBOutlet weak var goodsIcons: UIView!
    
    var pickerView = UIPickerView()
    var pickerSelectionView = UIView()
    var cancelButton = UIButton()
    var doneButton = UIButton()
    var activeTF : UITextField!
    
    
    
    var modelData : [String : AnyObject]!
    var selectedRow = 0
    var modelSizeSelected = false
    var modelColorSelected = false
    var indexPath : IndexPath!
    var ProductInfo : [String : AnyObject]?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        modelSizeTF.delegate = self
        modelQtyTF.delegate = self
        colorTF.delegate = self
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
        self.colorTF.rightView = downArrowImgView1
        self.colorTF.rightViewMode = .always
        
        let downArrowImgView2 = UIImageView(image: UIImage(named: "DownArrow"))
        self.modelSizeTF.rightView = downArrowImgView2
        self.modelSizeTF.rightViewMode = .always
        
        let downArrowImgView3 = UIImageView(image: UIImage(named: "DownArrow"))
        self.modelQtyTF.rightView = downArrowImgView3
        self.modelQtyTF.rightViewMode = .always
        
        
        
    }
    
    
    @objc func pickerViewCancelButtonClicked()
    {
        self.colorTF.resignFirstResponder()
        self.modelSizeTF.resignFirstResponder()
        self.modelQtyTF.resignFirstResponder()
        
    }
    
    @objc func pickerViewDoneButtonClicked()
    {
        if activeTF == modelSizeTF {
            self.modelSizeSelected = true
            let productKeys: [[String : AnyObject]] = self.modelData["goods_product_no_key"] as!  [[String : AnyObject]]
            let productkey = productKeys[selectedRow]
            self.ProductInfo = productkey
            activeTF.text = productkey["attr_value"] as? String
        }
        if activeTF == colorTF {
            self.modelColorSelected = true
            let productKeys: [[String : AnyObject]] = self.modelData["similar_goods"] as!  [[String : AnyObject]]
            let productkey = productKeys[selectedRow]
            activeTF.text = productkey["display_goods_color"] as? String
        }
        if activeTF == modelQtyTF {
            activeTF.text = "\(selectedRow+1)"
        }
        self.colorTF.resignFirstResponder()
        self.modelSizeTF.resignFirstResponder()
        self.modelQtyTF.resignFirstResponder()
        
    }
    
    func setDataWith(model : [String : AnyObject]?)
    {
        self.modelData = model
        self.goodNameLbl.text =  model!["display_goods_name"] as? String
        goodNameLbl.text = goodNameLbl.text?.uppercased()
        self.modelNameLbl.text = model!["display_model_type_name"] as? String
        self.colorTF.text = model!["display_goods_color"] as? String
        self.modelSizeTF.text = model!["product_attr_name"] as? String
        self.modelSizeTF.inputView = self.pickerSelectionView
        self.modelQtyTF.inputView = self.pickerSelectionView
        setGoodGimmics()
        
        
        let display_market_price = modelData["display_market_price"] as! String
        let display_shop_price = modelData["display_shop_price"] as! String
        let display_currency = modelData["display_currency"] as! String
        let shopPrice = display_currency+display_shop_price
        let marketPrice = display_currency+display_market_price
        
        if Float(display_market_price)! > Float(display_shop_price)!
        {
            let savePrice = Float(display_market_price)! - Float(display_shop_price)!
            let saveAmountPrice = "SAVE "+display_currency+"\(savePrice)"
            
            let totalPriceString = marketPrice+" "+shopPrice+" "+saveAmountPrice
            
            
            let somePartStringRange = (totalPriceString as NSString).range(of: marketPrice)
            let shopPricerange = (totalPriceString as NSString).range(of: shopPrice)
            let marketPricerange = (totalPriceString as NSString).range(of: marketPrice)
            let saveAmountPricerange = (totalPriceString as NSString).range(of: saveAmountPrice)

            let attributeString = NSMutableAttributedString(string: totalPriceString.lowercased())
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: somePartStringRange)
            attributeString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black , range: shopPricerange)
            attributeString.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "ArialMT", size: 10), range: saveAmountPricerange)

            priceLbl.attributedText = attributeString
            
        }
        else
        {
            priceLbl.text = shopPrice.lowercased()
          //  priceLbl.text = display_currency.lowercased()
        }
        priceLbl.font = UIFont(name: "Arial", size: 20)
        priceLbl.textAlignment = .center
    
    }
    
    func setGoodGimmics()
    {
        self.goodsIcons.backgroundColor = UIColor.red
        for subView in self.goodsIcons.subviews {
            subView.removeFromSuperview()
        }
        let goodsGimmic = self.modelData["goods_gimmick"] as! [[String : AnyObject]]
        var xChod : CGFloat = self.goodsIcons.frame.size.width/CGFloat(goodsGimmic.count)-5
        for good in goodsGimmic {
            let btn = UIButton(frame: CGRect(x: xChod, y: 5, width: 50, height: 50))
            let imagePath = good["icon"] as! String
            btn.sd_setBackgroundImage(with: URL(string: imagePath), for: .normal, completed: { (image, error, type, url) in
                if error != nil
                {
                    print(error!)
                }
            })
            btn.sd_setImage(with: URL(string: imagePath), for: .normal, completed: nil)
            btn.backgroundColor = UIColor.green
            self.goodsIcons.addSubview(btn)
            xChod += 55
        }
        
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
        if activeTF == modelSizeTF {
            let sizes: [[String : AnyObject]] = self.modelData["goods_product_no_key"] as!  [[String : AnyObject]]
            return sizes.count
        }
        if activeTF == modelQtyTF
        {
            if self.modelSizeSelected
            {
                let quantity = ProductInfo!["stocks"] as! String
                return Int(quantity)!
            }
            
        }
        
        return 0

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if activeTF == modelSizeTF {
            let productKeys: [[String : AnyObject]] = self.modelData["goods_product_no_key"] as!  [[String : AnyObject]]
            let productkey = productKeys[row]
            return productkey["attr_value"] as? String
        }
        
        
        if activeTF == modelQtyTF  {
            return "\(row+1)"
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedRow = row
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
}
