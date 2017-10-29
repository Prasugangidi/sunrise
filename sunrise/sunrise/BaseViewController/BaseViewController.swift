//
//  BaseViewController.swift
//  sunrise
//
//  Created by Madhav Yanamala on 10/29/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit
import SJSwiftSideMenuController

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let ShoppingImage   = UIImage(named: "Shopping")!
        let searchImage = UIImage(named: "Search")!
        let ShoppingButton   = UIBarButtonItem(image: ShoppingImage, style: .plain, target: self, action: #selector(BaseViewController.shoppingButtonClicked))
        let SearchButton = UIBarButtonItem(image: searchImage,  style: .plain, target: self, action: #selector(BaseViewController.searchButtonClicked))
        navigationItem.rightBarButtonItems = [ShoppingButton,SearchButton]
        
        self.createTitleView()
    }
    
    func createTitleView()
    {
        let sunriseClick = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        sunriseClick.setTitle("SUNRISECLICK", for: .normal)
        sunriseClick.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
        sunriseClick.setTitleColor(UIColor.black, for: .normal)
        sunriseClick.addTarget(self, action: #selector(BaseViewController.showHomePageViewController), for: .touchUpInside)
        self.navigationItem.titleView = sunriseClick
    }
    
    @objc func shoppingButtonClicked()
    {
        
    }
    
    @objc func searchButtonClicked()
    {
        
    }
    
    @objc func showHomePageViewController()
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        SJSwiftSideMenuController.pushViewController(rootVC, animated: true)
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
