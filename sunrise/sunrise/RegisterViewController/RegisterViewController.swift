//
//  RegisterViewController.swift
//  sunrise
//
//  Created by reddys on 20/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SJSwiftSideMenuController
import Realm
import RealmSwift

class RegisterViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource , UserRegisterTableViewCellDelegate{
    
    
    @IBOutlet weak var registerTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        registerTableView.delegate = self
        registerTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell    {
        let cell : UserRegisterTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UserRegisterTableViewCell", for: indexPath) as! UserRegisterTableViewCell
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
    func registerButtonClickedWithIndexPath(indexPath : IndexPath)
    {
        
        let cell : UserRegisterTableViewCell = registerTableView.cellForRow(at: indexPath) as! UserRegisterTableViewCell
        
        if cell.fornameTF.text!.characters.count < 1 {
            ProgressHelper.showAlertWithTitle("Forename should not be empty", message: "please enter forename", viewController: self)
            return
        }
        if cell.lastnameTF.text!.characters.count < 1 {
            ProgressHelper.showAlertWithTitle("lastname should not be empty", message: "please enter Surname", viewController: self)
            return
        }
        if cell.emailTF.text!.characters.count < 1 {
            ProgressHelper.showAlertWithTitle("Email should not be empty", message: "please enter Emai ID", viewController: self)
            return
        }
        if cell.confirmEmailTF.text!.characters.count < 1 {
            ProgressHelper.showAlertWithTitle("Confirm Email should not be empty", message: "please re-enter the Emai ID", viewController: self)
            return
        }
        
        if cell.passwordTF.text!.characters.count < 1 {
            ProgressHelper.showAlertWithTitle("password should not be empty", message: "please enter password", viewController: self)
            return
        }
        if cell.confirmPasswordTF.text!.characters.count < 1 {
            ProgressHelper.showAlertWithTitle("Confirm password should not be empty", message: "please re-enter the password", viewController: self)
            return
        }
        
        if !self.validateEmail(enteredEmail: cell.emailTF.text!) {
            
            cell.emailTF.text = cell.confirmEmailTF.text
            return
        
        }
        
        ConnectionManager.checkUserEmailId(emailID: cell.emailTF.text!, complection:{ (responseString) in
            
            let result = responseString?.replacingOccurrences(of: "\"", with: "")
            if result?.lowercased() == "true"
            {
                DispatchQueue.main.async(execute: {
                    
                    let userRes = UserResource()
                    userRes.forename = cell.fornameTF.text!
                    userRes.lastname = cell.lastnameTF.text!
                    userRes.email = cell.emailTF.text!
                    userRes.password = cell.passwordTF.text!
                    userRes.birthday = cell.birthdayTF.text!
                    self.registerNewUser(userRes: userRes)
                })
                
            }
            else
            {
                DispatchQueue.main.async(execute: {
                    ProgressHelper.showAlertWithTitle("User already exists", message: "please signIn", viewController: self)
                })
            }
            
        }, failure: { (error) -> Void in
            print(error)
            
        })
        
    }
    
    func registerNewUser(userRes: UserResource)
    {
        ConnectionManager.registerNewUser(userRes: userRes, complection: { (response) in
            
            let registerResult = response?.replacingOccurrences(of: "\"", with: "")
            if registerResult?.lowercased() == "true"
            {
                DispatchQueue.main.async(execute: {
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(userRes)
                    }
                    self.showSalePage()
                })
            }
            else
            {
                DispatchQueue.main.async(execute: {
                    ProgressHelper.showAlertWithTitle("User already exists", message: "please signIn", viewController: self)
                })
            }
            
        }, failure: { (error) -> Void in
            print(error)
            
        })
    }
    
    func showSalePage()
    {
        let shoppingListVC : ShoppingListViewController = (self.storyboard!.instantiateViewController(withIdentifier: "ShoppingListViewController") as? ShoppingListViewController)!
        shoppingListVC.sourceType = "SALE"
         SJSwiftSideMenuController.pushViewController(shoppingListVC, animated: true)
         SJSwiftSideMenuController.hideLeftMenu()
        
    }
    
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    func isPasswordSame(passwordTF: String , confirmPasswordTF : String) -> Bool {
        if passwordTF == confirmPasswordTF{
            return true
        }else{
            return false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 20
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        
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



