//
//  ConnectionManager.swift
//  sunrise
//
//  Created by reddys on 23/9/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit

class ConnectionManager: NSObject {
    
    class func getURLRequestWithUrl(_ url : String) -> URLRequest
    {
        let requestUrl = URL(string:url)
        var requestSession = URLRequest(url:requestUrl!)
        // requestSession.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // requestSession.addValue("application/json", forHTTPHeaderField: "Accept")
         requestSession.httpMethod = "GET"
        return requestSession
    }
    
    class func registerNewUser(userRes: UserResource ,complection :  @escaping (String?) -> Void , failure : @escaping (NSError?) -> Void?)
    {
        
        var requestSession = self.getURLRequestWithUrl(Constants.NEW_USER_REGISTER_URL)
        requestSession.httpMethod = "POST"
        var resDic = [:] as Dictionary<String, String>
        resDic["email"] = userRes.email
        resDic["firstname"] = userRes.forename
        resDic["lastname"] = userRes.lastname
        resDic["password"] = userRes.password
        resDic["username"] = userRes.username
        resDic["birthday"] = userRes.birthday
        
        requestSession.setBodyContent(resDic)
        
        NSLog( "Running on main thread  \(Thread.current.isMainThread)")
        let session = URLSession.shared
        let taskSession = session.dataTask(with: requestSession, completionHandler: { (data, response, error) -> Void in
            if response == nil
            {
                DispatchQueue.main.async(execute: {
                    failure(error as NSError?)
                })
            }
            else
            {
                let responseString = String(data: data!, encoding: String.Encoding.utf8) as String!
                complection(responseString)
            }
        })
        taskSession.resume()
        
    }
    
    class func checkUserEmailId(emailID: String ,complection :  @escaping (String?) -> Void , failure : @escaping (NSError?) -> Void?)
    {
        
        var requestSession = self.getURLRequestWithUrl(Constants.CHECK_EMAIL_URL+emailID)
        requestSession.httpMethod = "POST"
        
        NSLog( "Running on main thread  \(Thread.current.isMainThread)")
        let session = URLSession.shared
        let taskSession = session.dataTask(with: requestSession, completionHandler: { (data, response, error) -> Void in
            if response == nil
            {
                DispatchQueue.main.async(execute: {
                    failure(error as NSError?)
                })
            }
            else
            {
                let responseString = String(data: data!, encoding: String.Encoding.utf8) as String!
                complection(responseString)
            }
        })
        taskSession.resume()
        
    }
    
    class func getTopBanner(complection :  @escaping ([[String : AnyObject]]?) -> Void , failure : @escaping (NSError?) -> Void?)
    {
        
        let requestSession = self.getURLRequestWithUrl(Constants.GET_TOP_BANNER_URL)
        
        NSLog( "Running on main thread  \(Thread.current.isMainThread)")
        let session = URLSession.shared
        let taskSession = session.dataTask(with: requestSession, completionHandler: { (data, response, error) -> Void in
            if response == nil
            {
                DispatchQueue.main.async(execute: {
                    failure(error as NSError?)
                })
            }
            else
            {
                do {
                    let responseData : [[String : AnyObject]] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String : AnyObject]]
                    DispatchQueue.main.async(execute: {
                        complection(responseData)
                    })
                } catch {
                    NSLog("ERROR when parse JSON")
                }
            }
        })
        taskSession.resume()
        
    }
    
    class func getBottomBannerTitle(complection :  @escaping (String?) -> Void , failure : @escaping (NSError?) -> Void?)
    {
        
        let requestSession = self.getURLRequestWithUrl(Constants.GET_BOTTOM_BANNER_TITLE_URL)
        
        NSLog( "Running on main thread  \(Thread.current.isMainThread)")
        let session = URLSession.shared
        let taskSession = session.dataTask(with: requestSession, completionHandler: { (data, response, error) -> Void in
            if response == nil
            {
                DispatchQueue.main.async(execute: {
                    failure(error as NSError?)
                })
            }
            else
            {
                let responseString = String(data: data!, encoding: .utf8)
                 complection(responseString)
            }
        })
        taskSession.resume()
        
    }
    
    class func getBottomBanner1(complection :  @escaping ([[String : AnyObject]]?) -> Void , failure : @escaping (NSError?) -> Void?)
    {
        
        let requestSession = self.getURLRequestWithUrl(Constants.GET_BOTTOM_BANNER1_URL)
        
        NSLog( "Running on main thread  \(Thread.current.isMainThread)")
        let session = URLSession.shared
        let taskSession = session.dataTask(with: requestSession, completionHandler: { (data, response, error) -> Void in
            if response == nil
            {
                DispatchQueue.main.async(execute: {
                    failure(error as NSError?)
                })
            }
            else
            {
                do {
                    let responseData : [[String : AnyObject]] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String : AnyObject]]
                    DispatchQueue.main.async(execute: {
                        complection(responseData)
                    })
                } catch {
                    NSLog("ERROR when parse JSON")
                }
            }
        })
        taskSession.resume()
        
    }
    
    class func getBottomBanner2Title(complection :  @escaping (String?) -> Void , failure : @escaping (NSError?) -> Void?)
    {
        
        let requestSession = self.getURLRequestWithUrl(Constants.GET_BOTTOM_BANNER2_TITLE_URL)
        
        NSLog( "Running on main thread  \(Thread.current.isMainThread)")
        let session = URLSession.shared
        let taskSession = session.dataTask(with: requestSession, completionHandler: { (data, response, error) -> Void in
            if response == nil
            {
                DispatchQueue.main.async(execute: {
                    failure(error as NSError?)
                })
            }
            else
            {
                let responseString = String(data: data!, encoding: .utf8)
                complection(responseString)
            }
        })
        taskSession.resume()
        
    }
    class func getBottomBanner2(complection :  @escaping ([[String : AnyObject]]?) -> Void , failure : @escaping (NSError?) -> Void?)
    {
        
        let requestSession = self.getURLRequestWithUrl(Constants.GET_BOTTOM_BANNER2_URL)
        
        NSLog( "Running on main thread  \(Thread.current.isMainThread)")
        let session = URLSession.shared
        let taskSession = session.dataTask(with: requestSession, completionHandler: { (data, response, error) -> Void in
            if response == nil
            {
                DispatchQueue.main.async(execute: {
                    failure(error as NSError?)
                })
            }
            else
            {
                do {
                    let responseData : [[String : AnyObject]] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String : AnyObject]]
                    DispatchQueue.main.async(execute: {
                        complection(responseData)
                    })
                } catch {
                    NSLog("ERROR when parse JSON")
                }
            }
        })
        taskSession.resume()
        
    }
    class func getMenu(complection :  @escaping ([[String : AnyObject]]?) -> Void , failure : @escaping (NSError?) -> Void?)
    {
        
        let requestSession = self.getURLRequestWithUrl(Constants.GET_MENU_URL)
        
        NSLog( "Running on main thread  \(Thread.current.isMainThread)")
        let session = URLSession.shared
        let taskSession = session.dataTask(with: requestSession, completionHandler: { (data, response, error) -> Void in
            if response == nil
            {
                DispatchQueue.main.async(execute: {
                    failure(error as NSError?)
                })
            }
            else
            {
                do {
                    let responseData : [[String : AnyObject]] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String : AnyObject]]
                    DispatchQueue.main.async(execute: {
                        complection(responseData)
                    })
                } catch {
                    NSLog("ERROR when parse JSON")
                }
            }
        })
        taskSession.resume()
        
    }
    
    
    class func getModelsForSource(sourceType : String ,complection :  @escaping ([String : AnyObject]?) -> Void , failure : @escaping (NSError?) -> Void?)
    {
        
        let requestSession = self.getURLRequestWithUrl(Constants.GET_MODELSFORSOURCE_URL+sourceType)
        
        NSLog( "Running on main thread  \(Thread.current.isMainThread)")
        let session = URLSession.shared
        let taskSession = session.dataTask(with: requestSession, completionHandler: { (data, response, error) -> Void in
            if response == nil
            {
                DispatchQueue.main.async(execute: {
                    failure(error as NSError?)
                })
            }
            else
            {
                do {
                    let responseData : [String : AnyObject] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : AnyObject]
                    DispatchQueue.main.async(execute: {
                        complection(responseData)
                    })
                } catch {
                    NSLog("ERROR when parse JSON")
                }
            }
        })
        taskSession.resume()
        
    }
    class func getModelForProduct(goodsId : String ,complection :  @escaping ([String : AnyObject]?) -> Void , failure : @escaping (NSError?) -> Void?)
    {
        
        let requestSession = self.getURLRequestWithUrl(Constants.GET_MODELFORMODEL_URL+goodsId)
        
        NSLog( "Running on main thread  \(Thread.current.isMainThread)")
        let session = URLSession.shared
        let taskSession = session.dataTask(with: requestSession, completionHandler: { (data, response, error) -> Void in
            if response == nil
            {
                DispatchQueue.main.async(execute: {
                    failure(error as NSError?)
                })
            }
            else
            {
                do {
                    let responseData : [String : AnyObject] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : AnyObject]
                    DispatchQueue.main.async(execute: {
                        complection(responseData)
                    })
                } catch {
                    NSLog("ERROR when parse JSON")
                }
            }
        })
        taskSession.resume()
        
    }
    class func getCartDetails(complection :  @escaping ([[String : AnyObject]]?) -> Void , failure : @escaping (NSError?) -> Void?)
    {
        
        let requestSession = self.getURLRequestWithUrl(Constants.GET_CART_DETAILS_URL)
        
        NSLog( "Running on main thread  \(Thread.current.isMainThread)")
        let session = URLSession.shared
        let taskSession = session.dataTask(with: requestSession, completionHandler: { (data, response, error) -> Void in
            if response == nil
            {
                DispatchQueue.main.async(execute: {
                    failure(error as NSError?)
                })
            }
            else
            {
                do {
                    let responseData : [[String : AnyObject]] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String : AnyObject]]
                    DispatchQueue.main.async(execute: {
                        complection(responseData)
                    })
                } catch {
                    NSLog("ERROR when parse JSON")
                }
            }
        })
        taskSession.resume()
        
    }
    class func getPeopleBoughtModels(goodsId : String ,complection :  @escaping ([[String : AnyObject]]?) -> Void , failure : @escaping (NSError?) -> Void?)
    {
        
        let requestSession = self.getURLRequestWithUrl(Constants.GET_PEOPLE_ALSO_BOUGHT_URL+goodsId)
        
        NSLog( "Running on main thread  \(Thread.current.isMainThread)")
        let session = URLSession.shared
        let taskSession = session.dataTask(with: requestSession, completionHandler: { (data, response, error) -> Void in
            if response == nil
            {
                DispatchQueue.main.async(execute: {
                    failure(error as NSError?)
                })
            }
            else
            {
                do {
                    let responseData : [[String : AnyObject]] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String : AnyObject]]
                    DispatchQueue.main.async(execute: {
                        complection(responseData)
                    })
                } catch {
                    NSLog("ERROR when parse JSON")
                }
            }
        })
        taskSession.resume()
        
    }
    class func getRecentlyViewModels(goodsId : String ,complection :  @escaping ([[String : AnyObject]]?) -> Void , failure : @escaping (NSError?) -> Void?)
    {
        
        let requestSession = self.getURLRequestWithUrl(Constants.GET_RECENTLY_VIEW_MODEL_URL+goodsId)
        
        NSLog( "Running on main thread  \(Thread.current.isMainThread)")
        let session = URLSession.shared
        let taskSession = session.dataTask(with: requestSession, completionHandler: { (data, response, error) -> Void in
            if response == nil
            {
                DispatchQueue.main.async(execute: {
                    failure(error as NSError?)
                })
            }
            else
            {
                do {
                    let responseData : [[String : AnyObject]] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String : AnyObject]]
                    DispatchQueue.main.async(execute: {
                        complection(responseData)
                    })
                } catch {
                    NSLog("ERROR when parse JSON")
                }
            }
        })
        taskSession.resume()
        
    }
    class func getBestSellersModels(goodsId : String ,complection :  @escaping ([[String : AnyObject]]?) -> Void , failure : @escaping (NSError?) -> Void?)
    {
        
        let requestSession = self.getURLRequestWithUrl(Constants.GET_BEST_SELLER_MODELS_URL+goodsId)
        
        NSLog( "Running on main thread  \(Thread.current.isMainThread)")
        let session = URLSession.shared
        let taskSession = session.dataTask(with: requestSession, completionHandler: { (data, response, error) -> Void in
            if response == nil
            {
                DispatchQueue.main.async(execute: {
                    failure(error as NSError?)
                })
            }
            else
            {
                do {
                    let responseData : [[String : AnyObject]] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String : AnyObject]]
                    DispatchQueue.main.async(execute: {
                        complection(responseData)
                    })
                } catch {
                    NSLog("ERROR when parse JSON")
                }
            }
        })
        taskSession.resume()
        
    }
    class func encodedString(originalString : String) -> String?
    {
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted)
        
        if let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            //do something with escaped string
            
            return escapedString
        }
        return nil
    }
    }

extension URLRequest {
    mutating func setBodyContent(_ contentMap: Dictionary<String, String>) {
        var firstOneAdded = false
        var contentBodyAsString = String()
        let contentKeys:Array<String> = Array(contentMap.keys)
        for contentKey in contentKeys {
            if(!firstOneAdded) {
                
                contentBodyAsString = contentBodyAsString + contentKey + "=" + contentMap[contentKey]!
                firstOneAdded = true
            }
            else {
                contentBodyAsString = contentBodyAsString + "&" + contentKey + "=" + contentMap[contentKey]!
            }
        }
        
        contentBodyAsString = contentBodyAsString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        //  contentBodyAsString = contentBodyAsString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        self.httpBody = contentBodyAsString.data(using: String.Encoding.utf8)
    }
}



