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

class ViewController: UIViewController , UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var mainTableView: UITableView!

    var topBannerArray : [[String : AnyObject]]?
    var bottomBanner1Array : [[String : AnyObject]]?
    var bottomBarTitle : String?
    var bottomBanner2Array : [[String : AnyObject]]?
    var bottomBar2Title : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let ShoppingImage   = UIImage(named: "Shopping")!
       let searchImage = UIImage(named: "Search")!
        
        let ShoppingButton   = UIBarButtonItem(image: ShoppingImage, style: .plain, target: self, action: Selector(("didTapShoppingButton:")))
        let SearchButton = UIBarButtonItem(image: searchImage,  style: .plain, target: self, action: Selector(("didTapSearchButton:")))
        navigationItem.rightBarButtonItems = [ShoppingButton,SearchButton]
    
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        
        
        self.title = "SUNRISECLICK"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Arial", size: 21.0)!];
        
        
        if let image : UIImage = UIImage(named: "menu") as UIImage! {
            SJSwiftSideMenuController .showLeftMenuNavigationBarButton(image: image)
            
        
        }
        
        getTopBanner()
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        //To enable Swipe gesture for toggle menu
        // SJSwiftSideMenuController.enableDimBackground = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var numberOfRows = 1
        
        if topBannerArray != nil
        {
            numberOfRows += 1
        }
        if bottomBarTitle != nil
        {
            numberOfRows += 1
        }
        if bottomBanner1Array != nil
        {
            numberOfRows += bottomBanner1Array!.count
        }
        if bottomBar2Title != nil
        {
            numberOfRows += 1
        }
        if bottomBanner2Array != nil
        {
            numberOfRows += bottomBanner2Array!.count/2
        }
        return numberOfRows
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0 {
            let cell : VideosTableViewCell = tableView.dequeueReusableCell(withIdentifier: "VideosTableViewCell", for: indexPath) as! VideosTableViewCell
            
            return cell
        }
        else if indexPath.row == 1
        {
            let cell : CourosalTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CourosalTableViewCell", for: indexPath) as! CourosalTableViewCell
            cell.setData(bannerData: self.topBannerArray!)
            return cell
        }
        else if indexPath.row == 2
        {
            let cell : BottomBarTitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BottomBarTitleTableViewCell", for: indexPath) as! BottomBarTitleTableViewCell
            cell.headingLbl.text = self.bottomBarTitle
            return cell
        }
        else if indexPath.row > 2 && indexPath.row <= bottomBanner1Array!.count+2
        {
            
            let cell : BottomBar1TableViewCell = tableView.dequeueReusableCell(withIdentifier: "BottomBar1TableViewCell", for: indexPath) as! BottomBar1TableViewCell
            let bottomBannerData = bottomBanner1Array![indexPath.row-3]
            let imageUrl = bottomBannerData["image_path"] as! String
            cell.bannerImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
        }
        else if indexPath.row == bottomBanner1Array!.count+3
        {
            let cell : BottomBarTitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BottomBarTitleTableViewCell", for: indexPath) as! BottomBarTitleTableViewCell
            cell.headingLbl.text = self.bottomBar2Title
            return cell
        }
        else if indexPath.row > bottomBanner1Array!.count+3 && indexPath.row <= (bottomBanner2Array!.count/2)+bottomBanner1Array!.count+4
        {
            let cell : BottomBar2TableViewCell = tableView.dequeueReusableCell(withIdentifier: "BottomBar2TableViewCell", for: indexPath) as! BottomBar2TableViewCell
            cell.setBannerData(bannerData: bottomBanner2Array!, forRow: indexPath.row-(bottomBanner1Array!.count+4))
           
            return cell
        }
        else
        {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 0 {
            return 60
        }
        if indexPath.row == 1 {
            return (self.view.frame.size.width + 20)*1.12
        }
        if indexPath.row == 2{
            return 50
        }
        if bottomBanner1Array != nil {
            if indexPath.row == bottomBanner1Array!.count+3{
                return 100
                
            }
        }
        if indexPath.row > 2 && indexPath.row <= bottomBanner1Array!.count+2
        {
            return (self.view.frame.size.width)*0.35
        }
        if indexPath.row == 3{
            return 50
        }
        return 220
        
    }
    
    
    func getTopBanner()
    {
        ConnectionManager.getTopBanner(complection: { (responseData) in
            
            print(responseData)
            self.topBannerArray = responseData
            self.getBottomBannerTitle()
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
            
        }, failure: { (error) -> Void in
            
        })
    }
    
    func getBottomBannerTitle()
    {
        ConnectionManager.getBottomBannerTitle(complection: { (responseString) in
            print(responseString)
            self.bottomBarTitle = responseString?.replacingOccurrences(of: "\"", with: "")
            self.getBottomBanner1()
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
            
        }, failure: { (error) -> Void in
            
        })
    }
    
    func getBottomBanner1()
    {
        ConnectionManager.getBottomBanner1(complection: { (responseData) in
            
            print(responseData)
            self.bottomBanner1Array = responseData
            self.getBottomBanner2Title()
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
            
        }, failure: { (error) -> Void in
            
        })
    }
    
    func getBottomBanner2Title()
    {
        ConnectionManager.getBottomBanner2Title(complection: { (responseString) in
            print(responseString)
            self.bottomBar2Title = responseString?.replacingOccurrences(of: "\"", with: "")
            self.getBottomBanner2()
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
            
        }, failure: { (error) -> Void in
            
        })
    }
    
    func getBottomBanner2()
    {
        ConnectionManager.getBottomBanner2(complection: { (responseData) in
            
            print(responseData)
            self.bottomBanner2Array = responseData
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
            
        }, failure: { (error) -> Void in
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

