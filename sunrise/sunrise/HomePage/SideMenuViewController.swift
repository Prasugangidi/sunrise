//
//  SideMenuViewController.swift
//  sunrise
//
//  Created by reddys on 23/9/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit
import SJSwiftSideMenuController

class SideMenuViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var sideMenuTableView: UITableView!
    
    var isSubMenu = false
    var category : String?
    var menuArray : [[String : AnyObject]] = []
    var responseArray : [[String : AnyObject]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        if !isSubMenu {
            getSideMenuData()
        }
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SideMenuViewController.refreshData), name: NSNotification.Name(rawValue: "UserActivity"), object: nil)
        
        self.refreshData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func getSideMenuData()
    {
        ConnectionManager.getMenu(complection: { (responseArray) in
            print(responseArray)
            self.responseArray = responseArray!
            self.menuArray = responseArray!
            self.refreshData()

            DispatchQueue.main.async {
                self.sideMenuTableView.reloadData()
            }
            
        }, failure: { (error) -> Void in
            
        })
    }
    
    @objc func refreshData()
    {
        if !isSubMenu {
            self.menuArray.removeAll()
            self.menuArray.append(contentsOf: self.responseArray)
            let userRes = RealmHelper.getUserResource()
            if userRes != nil
            {
                self.menuArray.append(["name" : userRes!.forename+userRes!.lastname as AnyObject])
                self.menuArray.append(["name" : "SIGN IN" as AnyObject])
            }
            else
            {
                self.menuArray.append(["name" : "REGISTER" as AnyObject])
                self.menuArray.append(["name" : "SIGN IN" as AnyObject])
            }
        }
        self.sideMenuTableView.reloadData()
    }
    
    // MARK UItableview datasource methods
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if self.isSubMenu
        {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.isSubMenu
        {
            if section == 0
            {
                return 1
            }
        }
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            cell?.backgroundColor = UIColor.black
            cell?.selectionStyle = .none
            cell?.textLabel?.textColor = UIColor.white
            cell?.textLabel?.font = UIFont(name:"Bold", size:13)
        }
        if self.isSubMenu
        {
            if indexPath.section == 0
            {
                 cell?.textLabel?.text = "BACK"
                return cell!
            }
        }
       var sideItem = menuArray[indexPath.row]
        let name  = sideItem["name"] as? String
        cell?.textLabel?.text = name
    
        if indexPath.row == 10{
            cell?.backgroundColor = UIColor.gray
            cell?.textLabel?.font = UIFont(name:"Bold", size:13)
        }
    
        if indexPath.row == 11{
            cell?.backgroundColor = UIColor.gray
            cell?.textLabel?.font = UIFont(name:"Bold", size:13)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if self.isSubMenu
        {
            if indexPath.section == 0
            {
                self.navigationController?.popViewController(animated: true)
                return
            }
        }
        let sideItem = menuArray[indexPath.row]
        if let subMenu : [[String : AnyObject]] =  sideItem["sub_menu"] as? [[String : AnyObject]]{
            if subMenu.count > 0
            {
                let sideVC_L : SideMenuViewController = (self.storyboard!.instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuViewController)!
                sideVC_L.menuArray = subMenu
                sideVC_L.isSubMenu = true
                sideVC_L.category = sideItem["name"] as? String
                
                //nameLbl.text = nameLbl.text?.uppercased()
                self.navigationController?.pushViewController(sideVC_L, animated: true)
            }
            else
            {
               self.navigateToAppropriateViewController(sideItem: sideItem)
            }
        }
        else
        {
            self.navigateToAppropriateViewController(sideItem: sideItem)
        }
    }
    
    func navigateToAppropriateViewController(sideItem : [String : AnyObject])
    {
        var name  = sideItem["name"] as! String
        
        if name == "REGISTER"
        {
            let shoppingListVC : RegisterViewController = self.storyboard!.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
            SJSwiftSideMenuController.hideLeftMenu()
            SJSwiftSideMenuController.pushViewController(shoppingListVC, animated: true)
            return
        }
        if name == "SIGN IN"
        {
            let shoppingListVC : LoginViewController = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            SJSwiftSideMenuController.hideLeftMenu()
            SJSwiftSideMenuController.pushViewController(shoppingListVC, animated: true)
            return
        }
        
        let shoppingListVC : ShoppingListViewController = (self.storyboard!.instantiateViewController(withIdentifier: "ShoppingListViewController") as? ShoppingListViewController)!
        shoppingListVC.sourceType = name.uppercased()
        if self.isSubMenu
        {
            name = self.category!
            let link = sideItem["link"] as! String
            let array = link.components(separatedBy: "/")
            shoppingListVC.sourceType = array[array.count-2]
        }
        SJSwiftSideMenuController.hideLeftMenu()
        SJSwiftSideMenuController.pushViewController(shoppingListVC, animated: true)
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
