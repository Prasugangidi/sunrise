//
//  ProductDetailViewController.swift
//  sunrise
//
//  Created by reddys on 15/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit

enum OpenViewType {
    case none
    case details
    case reviews
    case technology
}

class ProductDetailViewController: BaseViewController , UITableViewDelegate , UITableViewDataSource , ProductsScrollTableViewCellDelegate , DetailsAndReviewsTableViewCellDelegate{
    
    var productModel : [String : AnyObject] = [:]
    var productDetails : [String : AnyObject] = [:]
    var recentlyViewed : [[String : AnyObject]] = []
    var peopleAlsoBought : [[String : AnyObject]] = []
    var openedView : OpenViewType = .none
    
    var reviewsOpened = false
    var detailsOpened = false
    var technologyOpened = false
    
    @IBOutlet weak var productDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        productDetailTableView.delegate = self
        productDetailTableView.dataSource = self
        
        getProductDetails()
    }
    
    func getProductDetails()
    {
        ProgressHelper.showActivityIndicatior()
        let goodId = self.productModel["goods_id"] as! String
        ConnectionManager.getModelForProduct(goodsId: goodId, complection: { (responseData) in
            
            self.productDetails = responseData!
            self.getPeopleAlsoBought()
            
        }, failure: { (error) -> Void in
            
            DispatchQueue.main.async {
                ProgressHelper.hideActivityIndicator()
            }
        })
    }
    
    func getPeopleAlsoBought()
    {
        let goodId = self.productModel["goods_id"] as! String
        ConnectionManager.getPeopleBoughtModels(goodsId: goodId, complection: { (responseData) in
            
            self.peopleAlsoBought = responseData!
            self.getrecentlyViewed()
            
        }, failure: { (error) -> Void in
            
            self.getrecentlyViewed()
        })
    }
    
    func getrecentlyViewed()
    {
        let goodId = self.productModel["goods_id"] as! String
        ConnectionManager.getRecentlyViewModels(goodsId: goodId, complection: { (responseData) in
            
            self.recentlyViewed = responseData!
            DispatchQueue.main.async {
                self.productDetailTableView.reloadData()
                ProgressHelper.hideActivityIndicator()
            }
            
        }, failure: { (error) -> Void in
            
            DispatchQueue.main.async {
                ProgressHelper.hideActivityIndicator()
                self.productDetailTableView.reloadData()
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 || section == 1 || section == 2
        {
            if self.productDetails.count > 0
            {
                return 1
            }
            
            return 0
        }
        
        if section == 3
        {
            if self.peopleAlsoBought.count > 0
            {
                return 1
            }
            return 0
        }
        
        if section == 4
        {
            if self.recentlyViewed.count > 0
            {
                return 1
            }
            return 0
        }
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if indexPath.section == 0 {
            let cell : CourosalTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CourosalTableViewCell", for: indexPath) as! CourosalTableViewCell
            let imagesGallery = self.productDetails["goods_gallery"] as! [[String : AnyObject]]
            cell.pageControl.isHidden = true
            cell.setNeedsDisplay()
            cell.layoutIfNeeded()
            cell.setGoodsGalleryData(goodsGalleryData: imagesGallery)
            return cell
        }
        if indexPath.section == 1 {
            let cell : CompleteProductDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompleteProductDetailTableViewCell", for: indexPath) as! CompleteProductDetailTableViewCell
            cell.setDataWith(model: self.productDetails)
            return cell
        }
        if indexPath.section == 2 {
            let cell : DetailsAndReviewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailsAndReviewsTableViewCell", for: indexPath) as! DetailsAndReviewsTableViewCell
            
            cell.detailsViewAndHideButton.setImage(UIImage(named: "plus"), for: .normal)
            cell.reviewsViewAndHideButton.setImage(UIImage(named: "plus"), for: .normal)
            cell.technologyViewAndHideButton.setImage(UIImage(named: "plus"), for: .normal)
            
            cell.detailsViewHeight.constant = 0
            cell.allReviewsHeight.constant = 0
            cell.rightReviewViewHeight.constant = 0
            cell.technologyViewHeight.constant = 0
            
            cell.writeReviewView.isHidden = true
            
            cell.delegate = self
            cell.setDataWith(model: self.productDetails)
            
            if self.detailsOpened            {
                cell.detailsViewAndHideButton.setImage(UIImage(named: "minus"), for: .normal)
                 cell.detailsViewHeight.constant = 120
            }
            
            if self.reviewsOpened            {
                let goods_reviews_details = self.productDetails["goods_reviews_details"] as! [String : AnyObject]
                let isRevewable = goods_reviews_details["is_goods_reviewable"] as! Bool
                if isRevewable
                {
                    cell.writeReviewView.isHidden = false
                    cell.rightReviewViewHeight.constant = 130
                }
                let goods_reviews = goods_reviews_details["goods_reviews"] as! [[String : AnyObject]]
                if goods_reviews.count > 0
                {
                    if (goods_reviews.count * 100) > 200
                    {
                        cell.allReviewsHeight.constant = 200
                    }
                    else
                    {
                        cell.allReviewsHeight.constant = (CGFloat(goods_reviews.count * 100))
                    }
                }
                cell.reviewsViewAndHideButton.setImage(UIImage(named: "minus"), for: .normal)
            }
            
            if self.technologyOpened            {
                cell.technologyViewAndHideButton.setImage(UIImage(named: "minus"), for: .normal)
                cell.technologyViewHeight.constant = 120
            }
            
            return cell
        }
        
        if indexPath.section == 3 {
            let cell : ProductsScrollTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProductsScrollTableViewCell", for: indexPath) as! ProductsScrollTableViewCell
            cell.headingLbl.text = "PEOPLE ALSO BOUGHT"
            cell.delegate = self
            cell.setDataWith(model: self.peopleAlsoBought)
            return cell
        }
        
        if indexPath.section == 4 {
            let cell : ProductsScrollTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProductsScrollTableViewCell", for: indexPath) as! ProductsScrollTableViewCell
            cell.headingLbl.text = "RECENTLY VIEWED"
            cell.delegate = self
            cell.setDataWith(model: self.recentlyViewed)
            
           
            
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 {
            return 250
        }
        if indexPath.section == 1 {
            return 325
        }
        if indexPath.section == 2 {
            
            var height : CGFloat = 90.0
            if self.detailsOpened            {
                height = 200
            }
            if self.reviewsOpened            {
                let goods_reviews_details = self.productDetails["goods_reviews_details"] as! [String : AnyObject]
                let isRevewable = goods_reviews_details["is_goods_reviewable"] as! Bool
                if isRevewable
                {
                    height += 130
                }
                let goods_reviews = goods_reviews_details["goods_reviews"] as! [[String : AnyObject]]
                if goods_reviews.count > 0
                {
                    if (goods_reviews.count * 100) > 200
                    {
                        height += 200
                    }
                    else
                    {
                        height += (CGFloat(goods_reviews.count * 100))
                    }
                }
            }
            if self.technologyOpened            {
                 height = 210
            }
            return height
        }
        return (self.view.frame.size.width * 1.0)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.001
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    func buttonExpandedOrCollapsed(type : OpenViewType)
    {
        self.openedView = type
        let indexPath = IndexPath(row: 0, section: 2)
        
        switch self.openedView
        {
        case .none:
            break
        case .details:
           self.detailsOpened = !self.detailsOpened
            self.reviewsOpened = false
           self.technologyOpened = false
            break
        case .reviews:
            self.reviewsOpened = !self.reviewsOpened
            self.detailsOpened = false
            self.technologyOpened = false
            break
        case .technology:
            self.technologyOpened = !self.technologyOpened
            self.reviewsOpened = false
            self.detailsOpened = false
            break
        }
        
        self.productDetailTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func productSelectedWithProductInfo(productInfo : [String : AnyObject])
    {
        let productDetailVC : ProductDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        productDetailVC.productModel = productInfo
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
