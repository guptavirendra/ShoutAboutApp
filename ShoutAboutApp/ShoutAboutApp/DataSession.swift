//
//  DataSession.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 06/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit

class DataSession: BaseNSURLSession
{
   //MARK: GET OTP
    func getOTPForMobileNumber(mobileNumber:String, onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        let dict = ["mobile_number":mobileNumber]
        super.getWithOnFinish(mCHWebServiceMethod.add_app_user, parameters: dict, onFinish: { (response, deserializedResponse) in
            
               onFinish(response: response, deserializedResponse: deserializedResponse)
            
            }) { (error) in
                onError(error: error)
        }
        
    }
    
    
    //MARK: GET OTP VALIDATION
    func getOTPValidateForMobileNumber(mobileNumber:String, otp:String,  onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        let dict = ["mobile_number":mobileNumber, "otp":otp]
        super.getWithOnFinish(mCHWebServiceMethod.match_otp, parameters: dict, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
            }) { (error) in
                onError(error: error)
        }
        
    }
    
    //MARK: UPDATE PROFILE
    func updateProfile(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        
        super.postDataWithOnFinish(mCHWebServiceMethod.update_profile, parameters: dict, postBody: nil, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
            }) { (error) in
                onError(error: error)
        }
    }
    
    //MARK: SYNC CONTACT
    func syncContactToTheServer(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        super.postDataWithOnFinish(mCHWebServiceMethod.add_contact_list, parameters: dict, postBody: nil, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
        }) { (error) in
            onError(error: error)
        }
    }
    
    
    func searchContact(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        super.getWithOnFinish(mCHWebServiceMethod.search_mobile_number, parameters: dict, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
        }) { (error) in
            onError(error: error)
        }
        
    }
    
    
    func getChatList(onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        super.getWithOnFinish(mCHWebServiceMethod.chat_contact_list, parameters: nil, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
        }) { (error) in
            onError(error: error)
        }
        
    }
    
    
    //MARK: CONTACT LIST
    func addRateReview(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        super.postDataWithOnFinish(mCHWebServiceMethod.add_rate_review, parameters: dict, postBody: nil, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
        }) { (error) in
            onError(error: error)
        }
        
    }
    
    //MARK: CONTACT LIST REVIEW
    func getContactReviewList(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        
        super.getWithOnFinish(mCHWebServiceMethod.contact_review_list, parameters: nil, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
        }) { (error) in
            onError(error: error)
        }
        
    }
    
    
    func getChatConversionForContactID(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        super.getWithOnFinish(mCHWebServiceMethod.chat_conversation, parameters: nil, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
        }) { (error) in
            onError(error: error)
        }


    }
    
    
    func sendTextMessage(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        
        super.getWithOnFinish(mCHWebServiceMethod.send_message, parameters: nil, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
        }) { (error) in
            onError(error: error)
        }
    }
    
    
    
}

class DataSessionManger: NSObject
{
    static let sharedInstance = DataSessionManger()
    
    
    
    func getOTPForMobileNumber(mobileNumber:String, onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        let dataSession = DataSession()
        dataSession.getOTPForMobileNumber(mobileNumber, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
            }) { (error) in
                onError(error: error)
        }
        
    }
    
    //MARK:// GRET OTP
    func getOTPValidateForMobileNumber(mobileNumber:String, otp:String,  onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        let dataSession = DataSession()
        dataSession.getOTPValidateForMobileNumber(mobileNumber, otp: otp, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
            }) { (error) in
                onError(error: error)
        }
        
    }
    
    //UPDATE PROFILE
    func updateProfile(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        let dataSession = DataSession()
        dataSession.updateProfile(dict, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
            }) { (error) in
                onError(error: error)
        }
        
    }
    
    // SYNC CONTACT TO SERVER
    func syncContactToTheServer(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        let dataSession = DataSession()
        dataSession.syncContactToTheServer(dict, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
            }) { (error) in
                onError(error: error)
        }

    }
    
    //CONTACT
    func searchContact(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:[SearchPerson], errorMessage:String?)->(), onError:(error:AnyObject)->())
    {
        let dataSession = DataSession()
        dataSession.searchContact(dict, onFinish: { (response, deserializedResponse) in
            
            var personArray:[SearchPerson] = [SearchPerson]()
            var errorMessage:String?
            if deserializedResponse is NSDictionary
            {
                if deserializedResponse.objectForKey("error") != nil
                {
                    errorMessage = deserializedResponse.objectForKey("error") as?String
                }
                
                
                if deserializedResponse.objectForKey(search_mobile) != nil
                {
                    let dataArray = deserializedResponse.objectForKey(search_mobile) as? [NSDictionary]
                    for dict in dataArray!
                    {
                        
                        let person:SearchPerson = SearchPerson()
                        person.name = (dict.objectForKey("name") as? String)!
                        person.idString = (dict["id"] as? Int)!
                        person.mobileNumber = (dict.objectForKey("mobile_number") as? String)!
                         person.ratingAverage = (dict.objectForKey("rating_average") as? [AnyObject])!
                         person.reviewCount = (dict.objectForKey("review_count") as? [AnyObject])!
                        personArray.append(person)
                        
                    }
                    
                }
            }
            
            onFinish(response: response, deserializedResponse: personArray, errorMessage:errorMessage )
            
            
            }) { (error) in
                onError(error: error)
        }
        
    }
    
    //MARK: CHAT LIST
    
    func getChatList(onFinish:(response:AnyObject,deserializedResponse:[ChatPerson])->(), onError:(error:AnyObject)->())
    {
        let dataSession = DataSession()
        dataSession.getChatList({ (response, deserializedResponse) in
            
            var dataArray = [ChatPerson]()
            if  deserializedResponse is [NSDictionary]
            {
                let arraydata = deserializedResponse as! [NSDictionary]
                for dict in arraydata
                {
                    let chatPerson = ChatPerson()
                    
                    chatPerson.idString = dict.objectForKey("id") as! Int
                    chatPerson.name = (dict.objectForKey("name") as? String)!
                    chatPerson.photo = (dict.objectForKey("photo") as? String)!
                    dataArray.append(chatPerson)
                }
                
            }
            onFinish(response: response, deserializedResponse: dataArray)
            
          }) { (error) in
            
            onError(error: error)
                
        }
    }
    
    func addRateReview(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        //by_user_id
        //for_user_id
        //review
        //rate
        
        let dataSession = DataSession()
        dataSession.addRateReview(dict, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
            }) { (error) in
                 onError(error: error)
        }
        
    }
    
    func getContactReviewList(dict:[String:String], onFinish:(response:AnyObject,reviewUser:ReviewUser)->(), onError:(error:AnyObject)->())
    {
         // GET
        /// for_user_id
        
        let appTokenDict = NSObject.getAppUserIdAndToken()
        
        
        let dataSession = DataSession()
        dataSession.getContactReviewList(dict, onFinish: { (response, deserializedResponse) in
            let reviewUser:ReviewUser = ReviewUser()
            if deserializedResponse is NSDictionary
            {
                if let  review_user = deserializedResponse.objectForKey("review_user") as? [NSDictionary]
                {
                    reviewUser.reviewPerson.name = (review_user.first!.objectForKey("name") as? String)!
                    
                }
                
                
                if let  rateReviewList = deserializedResponse.objectForKey("rateReviewList") as? [NSDictionary]
                {
                    
                    
                    for dict in rateReviewList
                    {
                        
                        let rateReviewr = RateReviewer()
                        rateReviewr.rate =   (dict.objectForKey("rate") as? String)!
                        rateReviewr.review =  (dict.objectForKey("review") as? String)!
                        rateReviewr.created_at =  (dict.objectForKey("created_at") as? String)!
                        
                        if let appuserDict =  dict.objectForKey("app_user") as? NSDictionary
                        {
                            
                            rateReviewr.appUser.idInt =   (appuserDict.objectForKey("id") as? Int)!
                            rateReviewr.appUser.name =      (appuserDict.objectForKey("name") as? String)!
                            rateReviewr.appUser.email =  (appuserDict.objectForKey("email") as? String)!
                            rateReviewr.appUser.mobileNumber =   (appuserDict.objectForKey("mobile_number") as? String)!
                            rateReviewr.appUser.createdAt =   (appuserDict.objectForKey("created_at") as? String)!
                            rateReviewr.appUser.updatedAt =   (appuserDict.objectForKey("updated_at") as? String)!
                            rateReviewr.appUser.dob =   (appuserDict.objectForKey("dob") as? String)!
                            rateReviewr.appUser.address =  (appuserDict.objectForKey("address") as? String)!
                            rateReviewr.appUser.website =    (appuserDict.objectForKey("website") as? String)!
                            rateReviewr.appUser.photo =  (appuserDict.objectForKey("photo") as? String)!
                            rateReviewr.appUser.gcmToken =  (appuserDict.objectForKey("gcm_token") as? String)!
                            rateReviewr.appUser.lastOnlineTime =   (appuserDict.objectForKey("last_online_time") as? String)!
                            
                            
                            }
                        
                        reviewUser.rateReviewList.append(rateReviewr)
                        
                        
                    }
                    
                }
                
                if let  ratingAverage = deserializedResponse.objectForKey("ratingAverage") as? [NSDictionary]
                {
                    for dict in ratingAverage
                    {
                        let average = RatingAverage()
                        average.average =   (dict.objectForKey("average") as? String)!
                        reviewUser.ratingAverageArray.append(average)
                        
                    }
                    
                }
                
                if let  reviewCount = deserializedResponse.objectForKey("reviewCount") as? [NSDictionary]
                {
                    for dict in reviewCount
                    {
                        let count = ReviewCount()
                        count.count =   (dict.objectForKey("count") as? String)!
                        reviewUser.reviewCountArray.append(count)
                        
                    }
                    
                }
                
                if let  rateGraph = deserializedResponse.objectForKey("rateGraph") as? [NSDictionary]
                {
                    for dict in rateGraph
                    {
                        let ratGraph   = RateGraph()
                        ratGraph.rate  =   (dict.objectForKey("rate") as? String)!
                        ratGraph.count =   (dict.objectForKey("count") as? String)!
                        reviewUser.rateGraphArray.append(ratGraph)
                    }
                }
            }
            
            
            
            }) { (error) in
                
                onError(error: error)
        }
       
    }
    
    func getChatConversionForContactID(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        
        
        
    }
    
    
    func sendTextMessage(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        
         
        
        
    }

    
    
}

extension NSObject
{
    //MARK: get up user Token
    class func getAppUserIdAndToken()->[String:String]
    {
         let appUserId = NSUserDefaults.standardUserDefaults().objectForKey(kapp_user_id) as! Int
         let appUserToken = NSUserDefaults.standardUserDefaults().objectForKey(kapp_user_token) as! String
        
        return [kapp_user_id:String(appUserId), kapp_user_token :appUserToken]
    }
    
    class func resetAppUserIdAndToken()
    {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: kapp_user_id)
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: kapp_user_token)
        
    }
}

class ReviewPerson:NSObject
{
    var name = String()
}


class RateReviewer:NSObject
{
    var rate       = String()
    var review     = String()
    var created_at = String()
    var appUser:AppUser = AppUser()
    var likes_count =  [AnyObject]()
    var user_like = [AnyObject]()
    var dislikes_count = [AnyObject]()
    var user_dislike = [AnyObject]()
}


class AppUser:NSObject
{
    var idInt:Int = 12
    var name : String = String()
    var email : String = String()
    var mobileNumber: String = String()
    var createdAt: String = String()
    var updatedAt : String = String()
    var dob : String = String()
    var address: String = String()
    var website : String = String()
    var photo :String = String()
    var gcmToken : String = String()
    var lastOnlineTime : String = String()
}

class ReviewCount:NSObject
{
    var count = String()
}

class RatingAverage:NSObject
{
    var average:String = String()
}

class RateGraph:NSObject
{
    var rate  = String()
    var count = String()
}

class ReviewUser:NSObject
{
    var reviewPerson       =  ReviewPerson()/// dict 1
    var rateReviewList     = [RateReviewer]()
    var ratingAverageArray = [RatingAverage]()
    var reviewCountArray   = [ReviewCount]()
    var rateGraphArray     = [RateGraph]()
}
