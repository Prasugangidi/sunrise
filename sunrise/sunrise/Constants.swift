//
//  Constants.swift
//  sunrise
//
//  Created by reddys on 23/9/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit

class Constants: NSObject {
  
    //https://www.sunriseclick.com/api/getHomepageTopBanner
    static let BASE_URL_TEST = "https://www.sunriseclick.com/api/"
    static let BASE_URL_LIVE = "https://www.sunriseclick.com/api/"

    static let BASE_URL = BASE_URL_LIVE
    
    //https://www.sunriseclick.com/api/getHomepageBottomBannerName
    //https://www.sunriseclick.com/api/getHomepageBottomBanner
    static let GET_TOP_BANNER_URL = BASE_URL + "getHomepageTopBanner"
    static let GET_BOTTOM_BANNER_TITLE_URL = BASE_URL + "getHomepageBottomBannerName"
    static let GET_BOTTOM_BANNER1_URL = BASE_URL + "getHomepageBottomBanner"
    
    //https://www.sunriseclick.com/api/getHomepageRightBannerName
    //https://www.sunriseclick.com/api/getHomepageRightBanner
    static let GET_BOTTOM_BANNER2_TITLE_URL = BASE_URL + "getHomepageRightBannerName"
    static let GET_BOTTOM_BANNER2_URL = BASE_URL + "getHomepageRightBanner"
    
    //https://www.sunriseclick.com/api/getMenu
    static let GET_MENU_URL = BASE_URL + "getMenu"
    
    //https://www.sunriseclick.com/api/getHelpContent (Get Help)
    //https://www.sunriseclick.com/api/getAboutUsContent (About Us)
    //https://www.sunriseclick.com/api/getLegalContent (policies)
    //https://www.sunriseclick.com/api/getCustomerServiceDetails (customer service)
    //https://www.sunriseclick.com/api/getAffiliation (Official Online Store)
    //https://www.sunriseclick.com/api/getAcceptedPaymentTypes (Accepted Payment Types)
      static let GET_HELP_CONTENT_URL = BASE_URL + "getHelpContent"
      static let GET_ABOUT_US_CONTENT_URL = BASE_URL + "getAboutUsContent"
      static let GET_LEGAL_CONTENT_URL = BASE_URL + "getLegalContent"
      static let GET_CUSTOMER_SERVICE_DETAILS_URL = BASE_URL + "getCustomerServiceDetails"
      static let GET_AFFILIATION_URL = BASE_URL + "getAffiliation"
      static let GET_ACCEPTED_PAYMENT_TYPES_URL = BASE_URL + "getAcceptedPaymentTypes"
      static let NEW_USER_REGISTER_URL = BASE_URL + "newUser?"
      static let CHECK_EMAIL_URL = BASE_URL + "isNewEmail?email="
    
    //https://www.sunriseclick.com/api/getModelsForSrcPage?src_page_name=sale (MODEL LISTING)
    //https://www.sunriseclick.com/api/getModelsForSrcPage?src_page_name=scba (SCBA)
    //https://www.sunriseclick.com/api/getModelsForSrcPage?src_page_name=authenticity (AUTHENTICITY)
      static let GET_MODELSFORSOURCE_URL = BASE_URL + "getModelsForSrcPageLite?src_page_name="
    


     //https://www.sunriseclick.com/api/getModelForModelPageLite?goods_id=  (MODELS)
       static let GET_MODELFORMODEL_URL = BASE_URL + "getModelForModelPageLite?goods_id="
    
     //https://www.sunriseclick.com/api/getCartDetails (CART)
       static let GET_CART_DETAILS_URL = BASE_URL + "getCartDetails"
    
     //https://www.sunriseclick.com/api/getBestSellersModels
       static let GET_BEST_SELLER_MODELS_URL = BASE_URL + "getBestSellersModels/goods_id="

    
    
    //https://www.sunriseclick.com/api/getPeopleAlsoBoughtModels?goods_id=
      static let GET_PEOPLE_ALSO_BOUGHT_URL = BASE_URL + "getPeopleAlsoBoughtModels?goods_id="
    
    
    //https://www.sunriseclick.com/api/getRecentlyViewModels?goods_id=
      static let GET_RECENTLY_VIEW_MODEL_URL = BASE_URL + "getRecentlyViewModels?goods_id="

    //https://www.sunriseclick.com/api/login?email=<email>&password=<password>&checkout=<checkout> (LOGIN)
    
    //https://www.sunriseclick.com/api/doForgetPassword?email=<email> (FORGOT PASSWORD)
    
    //https://www.sunriseclick.com/api/newUser?email=<email>&password=<password>&firstname=<firstname>&lastname=<lastname>&username=<username>&birthday=<birthday>
   
    //https://www.sunriseclick.com/api/getUser (login to the website and check)
    
    //https://www.sunriseclick.com/api/isNewEmail?email=yaparlaprasanna@gmail.com
    
    //https://www.sunriseclick.com/api/subscribeToMailing?email=<email> (SUBSCRIBE TO MAIL)
    
    //https://www.sunriseclick.com/api/searchAutoComplete?search_term=<search_term>  (SEARCH)
    
    
}
