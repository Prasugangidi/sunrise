//
//  DetailsAndReviewsTableViewCell.swift
//  sunrise
//
//  Created by reddys on 25/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit
import AXRatingView

protocol DetailsAndReviewsTableViewCellDelegate {
    
    func buttonExpandedOrCollapsed(type : OpenViewType)
}

class DetailsAndReviewsTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var reviewsViewAndHideButton: UIButton!
    @IBOutlet weak var detailsViewAndHideButton: UIButton!
    @IBOutlet weak var technologyViewAndHideButton: UIButton!
    
    @IBOutlet weak var technologyLbl: UILabel!
    
    @IBOutlet weak var technologyName: UITextField!
    @IBOutlet weak var technologyView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var reviewsLbl: UILabel!
    @IBOutlet weak var ratingsView: AXRatingView!
    @IBOutlet weak var reviewCountLbl: UILabel!
    @IBOutlet weak var writeReviewView: UIView!
    @IBOutlet weak var reviewScrollView: UIScrollView!
    @IBOutlet weak var detailsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var rightReviewViewHeight: NSLayoutConstraint!
    @IBOutlet weak var allReviewsHeight: NSLayoutConstraint!
    @IBOutlet weak var technologyViewHeight: NSLayoutConstraint!
   
  
   
    var delegate : DetailsAndReviewsTableViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    func setDataWith(model : [String : AnyObject]?)
    {
        let goods_reviews_details = model!["goods_reviews_details"] as! [String : AnyObject]
        let goods_reviews = goods_reviews_details["goods_reviews"] as! [[String : AnyObject]]
        
        reviewsLbl.text = "\(goods_reviews.count) REVIEWS"
        
        for subView in self.reviewScrollView.subviews {
            subView.removeFromSuperview()
        }
        
        reviewScrollView.contentSize = CGSize(width: self.reviewScrollView.frame.size.width , height: CGFloat(goods_reviews.count * 100))
        var xChod : CGFloat = 5
        var yChod : CGFloat = 0
        for i in 0..<goods_reviews.count {
            let reviewInfo = goods_reviews[i]
            
            let reviewView = UIView(frame: CGRect(x: 0, y: yChod, width: self.reviewScrollView.frame.size.width, height: 100))
            reviewView.backgroundColor = UIColor.lightGray
            
            
            
            
            let nameLbl = UILabel(frame: CGRect(x: 130, y: 2, width: self.reviewScrollView.frame.size.width-10, height: 20))
            nameLbl.text =  reviewInfo["title"] as? String
            nameLbl.text = nameLbl.text?.lowercased()
            nameLbl.font = UIFont(name: "Arial-BoldMT", size: 16)
            nameLbl.textAlignment = .left
            reviewView.addSubview(nameLbl)
            
            let userLbl = UILabel(frame: CGRect(x: 5, y: 25, width: self.reviewScrollView.frame.size.width-10, height: 20))
            userLbl.text =  reviewInfo["user_name"] as? String
            userLbl.text = userLbl.text?.lowercased()
            userLbl.font = UIFont(name: "Arial-BoldMT", size: 16)
            userLbl.textAlignment = .left
            reviewView.addSubview(userLbl)
            
            let timeLbl = UILabel(frame: CGRect(x: 130, y: 25, width: self.reviewScrollView.frame.size.width-10, height: 20))
            timeLbl.text =  reviewInfo["add_time"] as? String
            timeLbl.text = timeLbl.text?.lowercased()
            timeLbl.font = UIFont(name: "Arial-BoldMT", size: 16)
            timeLbl.textAlignment = .left
            reviewView.addSubview(timeLbl)
            
            let onLbl = UILabel(frame: CGRect(x: 110, y: 25, width: self.reviewScrollView.frame.size.width-10, height: 20))
            onLbl.text = "on"
            onLbl.font = UIFont(name: "Arial-BoldMT", size: 16)
            onLbl.textAlignment = .left
            reviewView.addSubview(onLbl)
            
            
            let categoryLbl = UILabel(frame: CGRect(x: 5, y: 45, width: self.reviewScrollView.frame.size.width-10, height: 30))
            categoryLbl.text =  reviewInfo["content"] as? String
            categoryLbl.font = UIFont(name: "ArialMT", size: 16)
            categoryLbl.numberOfLines = 6
            categoryLbl.textAlignment = .left
            reviewView.addSubview(categoryLbl)
           // self.scrollView.addSubview(categoryLbl)
            
            self.reviewScrollView.addSubview(reviewView)
            yChod += 100
        }
        
    }
    
    @IBAction func detailsButtonClicked(_ sender: Any) {
        self.delegate?.buttonExpandedOrCollapsed(type: .details)
    }
    
    
    @IBAction func reviewsButtonClicked(_ sender: Any) {
       self.delegate?.buttonExpandedOrCollapsed(type: .reviews)
    }
    
    @IBAction func technologyButtonClicked(_ sender: Any) {
        self.delegate?.buttonExpandedOrCollapsed(type: .technology)
    }
    
    func collapseAllButtons()
    {
        detailsViewAndHideButton.setImage(UIImage(named: "plus"), for: .normal)
        detailsViewAndHideButton.setImage(UIImage(named: "plus"), for: .normal)
        technologyViewAndHideButton.setImage(UIImage(named: "plus"), for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
