//
//  ShoppingListViewController.swift
//  sunrise
//
//  Created by reddys on 3/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit

class ShoppingListViewController: BaseViewController ,UITableViewDelegate ,UITableViewDataSource , ProductTableViewCellDelegate{
    
    @IBOutlet weak var shoppingListTableView: UITableView!
    var sourceType : String!
    var leftSideArray  : [[String : AnyObject]] = []
    var rightSideArray  : [[String : AnyObject]] = []
    var subCategory : String?
    var totalResponse : [String : AnyObject] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        shoppingListTableView.delegate = self
        shoppingListTableView.dataSource = self
        self.getModelsForCurrentSourceType()
        // Do any additional setup after loading the view.
    }
    
    func getModelsForCurrentSourceType()
    {
     if sourceType == "what\'s new"
        {
           sourceType = "whats-new"
        }
    
        ProgressHelper.showActivityIndicatior()
        ConnectionManager.getModelsForSource(sourceType: self.sourceType, complection: { (responseData) in
            let models = responseData!["models"] as! [[String : AnyObject]]
            self.totalResponse = responseData!
//            var models : [[String : AnyObject]] = []
//            if self.subCategory != nil
//            {
//                for model in modelsArray
//                {
//                    if self.subCategory!.contains((model["category_name"] as! String))
//                    {
//                        models.append(model)
//                    }
//                }
//            }
//            else
//            {
//                models = modelsArray
//            }
            self.leftSideArray.removeAll()
            self.rightSideArray.removeAll()
            for i in 0..<models.count
            {
                if i%2 == 0
                {
                    self.leftSideArray.append(models[i])
                }
                else
                {
                    self.rightSideArray.append(models[i])
                }
            }
            
            DispatchQueue.main.async {
                self.shoppingListTableView.reloadData()
                ProgressHelper.hideActivityIndicator()
            }
            
        }, failure: { (error) -> Void in
            
            DispatchQueue.main.async {
                ProgressHelper.hideActivityIndicator()
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        }
        return leftSideArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0 {
            let cell : FilterOptionsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FilterOptionsTableViewCell", for: indexPath) as! FilterOptionsTableViewCell
            cell.title1Lbl.text = self.totalResponse["name"] as? String
            cell.title2Lbl.text = "\(self.leftSideArray.count+self.rightSideArray.count) Products found"
            return cell
        }
        if indexPath.section == 1 {
              let cell : ProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
            let model1 = leftSideArray[indexPath.row]
            var model2 : [String : AnyObject] = [:]
            if rightSideArray.count > indexPath.row
            {
               model2 = rightSideArray[indexPath.row]
            }
            cell.delegate = self
            cell.indexPath = indexPath
            cell.setDataWith(model1: model1, model2: model2)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 {
            return 80
        }
        
        return 380
    }
    
    func leftImageSelectedWithIndexPath(indexPath : IndexPath)
    {
        let model = leftSideArray[indexPath.row]
        
        let productDetailVC : ProductDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        productDetailVC.productModel = model
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }
    func rightImageSelectedWithIndexPath(indexPath : IndexPath)
    {
        let model = rightSideArray[indexPath.row]
        
        let productDetailVC : ProductDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        productDetailVC.productModel = model
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
