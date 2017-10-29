//
//  LoginViewController.swift
//  sunrise
//
//  Created by reddys on 20/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class LoginViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource  {
    
  
    @IBOutlet weak var loginTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loginTableView.delegate = self
        loginTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
         if indexPath.section == 0{
        let cell : SignInTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SignInTableViewCell", for: indexPath) as! SignInTableViewCell
        cell.indexPath = indexPath
       // cell.delegate = self as SignInTableViewCellDelegate
        return cell
    }
        if indexPath.section == 1 {
            let cell : RegisterNowTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RegisterNowTableViewCell", for: indexPath) as! RegisterNowTableViewCell
            return cell
        }
        if indexPath.section == 2{
            let cell : ChangePasswordTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChangePasswordTableViewCell", for: indexPath) as! ChangePasswordTableViewCell
            cell.indexPath = indexPath
          //  cell.delegate = self as ChangePasswordTableViewCellDelegate
            return cell
        }
 return UITableViewCell()
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

