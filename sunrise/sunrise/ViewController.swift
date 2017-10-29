//
//  ViewController.swift
//  sunrise
//
//  Created by reddys on 23/9/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit
import SJSwiftSideMenuController
import SDWebImage

class ViewController: BaseViewController , UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var mainTableView: UITableView!

    var topBannerArray : [[String : AnyObject]]?
    var bottomBanner1Array : [[String : AnyObject]]?
    var bottomBarTitle : String?
    var bottomBanner2Array : [[String : AnyObject]]?
    var bottomBar2Title : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        
        if let image : UIImage = UIImage(named: "menu") as UIImage! {
            SJSwiftSideMenuController .showLeftMenuNavigationBarButton(image: image)
        }
        getTopBanner()
        mainTableView.dataSource = self
        mainTableView.delegate = self
        //To enable Swipe gesture for toggle menu
        // SJSwiftSideMenuController.enableDimBackground = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        }
        if section == 1 {
            if topBannerArray != nil
            {
                return 1
            }
        }
        if section == 2 {
            if bottomBarTitle != nil
            {
                return 1
            }
        }
        if section == 3 {
            if bottomBanner1Array != nil
            {
                return bottomBanner1Array!.count
            }
        }
        if section == 4 {
            if bottomBar2Title != nil
            {
                return 1
            }
        }
        if section == 5 {
            if bottomBanner2Array != nil
            {
                return bottomBanner2Array!.count/2
            }
        }
        return 0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0 {
            let cell : VideosTableViewCell = tableView.dequeueReusableCell(withIdentifier: "VideosTableViewCell", for: indexPath) as! VideosTableViewCell
            return cell
        }
        else if indexPath.section == 1
        {
            let cell : CourosalTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CourosalTableViewCell", for: indexPath) as! CourosalTableViewCell
            cell.setData(bannerData: self.topBannerArray!)
            return cell
        }
        else if indexPath.section == 2
        {
            let cell : BottomBarTitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BottomBarTitleTableViewCell", for: indexPath) as! BottomBarTitleTableViewCell
            cell.headingLbl.text = self.bottomBarTitle
            return cell
        }
        else if indexPath.section == 3
        {
            let cell : BottomBar1TableViewCell = tableView.dequeueReusableCell(withIdentifier: "BottomBar1TableViewCell", for: indexPath) as! BottomBar1TableViewCell
            let bottomBannerData = bottomBanner1Array![indexPath.row]
            let imageUrl = bottomBannerData["image_path"] as! String
            cell.bannerImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
        }
        else if indexPath.section == 4
        {
            let cell : BottomBarTitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BottomBarTitleTableViewCell", for: indexPath) as! BottomBarTitleTableViewCell
            cell.headingLbl.text = self.bottomBar2Title
            return cell
        }
        else if indexPath.section == 5
            //indexPath.row > bottomBanner1Array!.count+3 && indexPath.row <= (bottomBanner2Array!.count/2)+bottomBanner1Array!.count+4
        {
            let cell : BottomBar2TableViewCell = tableView.dequeueReusableCell(withIdentifier: "BottomBar2TableViewCell", for: indexPath) as! BottomBar2TableViewCell
            cell.setBannerData(bannerData: bottomBanner2Array!, forRow: indexPath.row)
            return cell
        }
        else
        {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 {
            return 60
        }
        if indexPath.section == 1 {
            return (self.view.frame.size.width + 20)*1.12
        }
        if indexPath.section == 2 || indexPath.section == 4{
            return 50
        }
        if indexPath.section == 3{
             return (self.view.frame.size.width)*0.35
        }
        if indexPath.section == 5{
           // return 220
            return (self.view.frame.size.width)*0.32 + 130
        }
        return 0
        
    }
    
    
    func getTopBanner()
    {
        ProgressHelper.showActivityIndicatior()
        ConnectionManager.getTopBanner(complection: { (responseData) in
            
            self.topBannerArray = responseData
            self.getBottomBannerTitle()
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
            
        }, failure: { (error) -> Void in
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
                ProgressHelper.hideActivityIndicator()
            }
        })
    }
    
    func getBottomBannerTitle()
    {
        ConnectionManager.getBottomBannerTitle(complection: { (responseString) in
            
            self.bottomBarTitle = responseString?.replacingOccurrences(of: "\"", with: "")
            self.getBottomBanner1()
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
            
        }, failure: { (error) -> Void in
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
                ProgressHelper.hideActivityIndicator()
            }
        })
    }
    
    func getBottomBanner1()
    {
        ConnectionManager.getBottomBanner1(complection: { (responseData) in
            
            self.bottomBanner1Array = responseData
            self.getBottomBanner2Title()
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
            
        }, failure: { (error) -> Void in
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
                ProgressHelper.hideActivityIndicator()
            }
        })
    }
    
    func getBottomBanner2Title()
    {
        ConnectionManager.getBottomBanner2Title(complection: { (responseString) in
            
            self.bottomBar2Title = responseString?.replacingOccurrences(of: "\"", with: "")
            self.getBottomBanner2()
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
            
        }, failure: { (error) -> Void in
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
                ProgressHelper.hideActivityIndicator()
            }
        })
    }
    
    func getBottomBanner2()
    {
        ConnectionManager.getBottomBanner2(complection: { (responseData) in
            
            self.bottomBanner2Array = responseData
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
                ProgressHelper.hideActivityIndicator()
            }
            
        }, failure: { (error) -> Void in
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
                ProgressHelper.hideActivityIndicator()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

