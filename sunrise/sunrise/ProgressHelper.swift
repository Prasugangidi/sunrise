//
//  ProgressHelper.swift
//  sunrise
//
//  Created by reddys on 11/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit
import MRProgress
class ProgressHelper: NSObject {
    
    static func showAlertWithTitle(_ title : String?, message : String? , viewController : UIViewController){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let acceptAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) -> Void in
            
        })
        
        alertController.addAction(acceptAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func showNoInternetConnectionAlert()
    {
        let Appdel = UIApplication.shared.delegate as! AppDelegate
        
        let alertController = UIAlertController(title: "No Internet", message: "Internet connection is needed", preferredStyle: UIAlertControllerStyle.alert)
        let acceptAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) -> Void in
            
        })
        
        alertController.addAction(acceptAction)
        
        Appdel.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    
    
    class func applyShadowToView(_ view : UIView) {
        view.layer.shadowOpacity = 1.0;
        view.layer.shadowRadius = 0.0;
        view.layer.shadowColor = UIColor.lightGray.cgColor;
        view.layer.shadowOffset = CGSize(width: 0.0, height: -1.0);
    }
    
    
    class func showActivityIndicatior()
    {
        self.hideActivityIndicator()
        
        let Appdel = UIApplication.shared.delegate as! AppDelegate
        MRProgressOverlayView.showOverlayAdded(to: Appdel.window!, title: "Loading...", mode: MRProgressOverlayViewMode.indeterminate, animated: true)
    }
    
    class func hideActivityIndicator()
    {
        let Appdel = UIApplication.shared.delegate as! AppDelegate
        MRProgressOverlayView.dismissAllOverlays(for: Appdel.window!, animated: true)
        
    }

}
