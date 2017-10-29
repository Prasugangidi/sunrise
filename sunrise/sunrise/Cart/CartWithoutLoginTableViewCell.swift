//
//  CartWithoutLoginTableViewCell.swift
//  sunrise
//
//  Created by reddys on 28/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit

protocol CartWithoutLoginTableViewCellDelegate {
    
    func productSelectedWithProductInfo(productInfo : [String : AnyObject])
}


class CartWithoutLoginTableViewCell: UITableViewCell {

    @IBOutlet weak var sellerTitleLbl: UILabel!
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    var modelsArray : [[String : AnyObject]] = []
    var timer : Timer?
    var currentPage = 0
    var imagesCount = 0
    
    var delegate : CartWithoutLoginTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setDataWith(model : [[String : AnyObject]])    {
        
        modelsArray = model
        
        for subView in self.imageScrollView.subviews {
            subView.removeFromSuperview()
        }
        
        imagesCount = model.count/2
        
        imageScrollView.contentSize = CGSize(width: self.imageScrollView.frame.size.width * CGFloat(imagesCount), height: self.imageScrollView.frame.size.height)
        var xChod : CGFloat = 5
        
        for i in 0..<model.count {
            let productInfo = model[i]
            
            let imageView = UIImageView(frame: CGRect(x: xChod, y: 0, width: self.imageScrollView.frame.size.width/2-10, height: self.imageScrollView.frame.size.height-150))
            imageView.sd_setImage(with: URL(string: productInfo["goods_thumb"] as! String), placeholderImage: UIImage(named: "placeholder.png"));
            self.imageScrollView.addSubview(imageView)
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
            imageView.tag = i
            
            
            let nameLbl = UILabel(frame: CGRect(x: xChod, y: self.imageScrollView.frame.size.height-150, width: self.imageScrollView.frame.size.width/2-10, height: 50))
            nameLbl.text =  productInfo["display_goods_name"] as? String
            nameLbl.text = nameLbl.text?.uppercased()
            nameLbl.font = UIFont(name: "Arial-BoldMT", size: 17)
            nameLbl.textAlignment = .left
            self.imageScrollView.addSubview(nameLbl)
            
            let categoryLbl = UILabel(frame: CGRect(x: xChod, y: self.imageScrollView.frame.size.height-120, width: self.imageScrollView.frame.size.width/2-10, height: 50))
            categoryLbl.text =  productInfo["display_model_type_name"] as? String
            categoryLbl.font = UIFont(name: "ArialMT", size: 16)
            categoryLbl.numberOfLines = 3
            categoryLbl.textAlignment = .left
            self.imageScrollView.addSubview(categoryLbl)
            
            
            
            let priceLbl = UILabel(frame: CGRect(x: xChod, y: self.imageScrollView.frame.size.height-90, width: self.imageScrollView.frame.size.width/2-10, height: 50))
            
            let display_market_price = productInfo["display_market_price"] as! String
            let display_shop_price = productInfo["display_shop_price"] as! String
            let display_currency = productInfo["display_currency"] as! String
            let shopPrice = display_currency+display_shop_price
            let marketPrice = display_currency+display_market_price
            
            
            if Float(display_market_price)! > Float(display_shop_price)!
            {
                let savePrice = Float(display_market_price)! - Float(display_shop_price)!
                
                let totalPriceString = marketPrice+" "+shopPrice
                let somePartStringRange = (totalPriceString as NSString).range(of: marketPrice)
                let range = (totalPriceString as NSString).range(of: shopPrice)
                let attributeString = NSMutableAttributedString(string: totalPriceString.lowercased())
                attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: somePartStringRange)
                attributeString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
                priceLbl.attributedText = attributeString
                
            }
            else
            {
                priceLbl.text = shopPrice.lowercased()
            }
            priceLbl.font = UIFont(name: "ArialHebrew-Light", size: 18)
            priceLbl.textAlignment = .left
            self.imageScrollView.addSubview(priceLbl)
            
            
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CartWithoutLoginTableViewCell.imageViewtapped(tapGesture:)))
            imageView.addGestureRecognizer(tapGesture)
            
            xChod += self.imageScrollView.frame.size.width/2
        }
        
        self.currentPage  = imagesCount
        if timer != nil
        {
            timer!.invalidate()
            timer = nil
            
            
        }
        timer = Timer.scheduledTimer(timeInterval: 3 , target: self, selector: #selector(CartWithoutLoginTableViewCell.loop), userInfo: nil, repeats: true)
        timer!.fire()
    }
    
    @objc func imageViewtapped(tapGesture : UITapGestureRecognizer)
    {
        let index = tapGesture.view!.tag
        self.delegate?.productSelectedWithProductInfo(productInfo: self.modelsArray[index])
    }
    
    
    @objc func loop()    {
        if self.currentPage == imagesCount        {
            self.currentPage = 0
        }
        self.scrollToPage(self.currentPage)
        self.currentPage += 1
    }
    
    func scrollToPage(_ page: Int) {
        UIView.animate(withDuration: 0.3)
        {
            self.imageScrollView.contentOffset.x = self.imageScrollView.frame.width * CGFloat(page)
        }
        func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
}
