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
    
    /*******************  LOGIN SCREEN ********************/
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
    
    /*******************  OTP SCREEN ********************/
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
    
    /*******************  SIGN UP ********************/
    //MARK: UPDATE PROFILE
    func updateProfile(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        
        super.postDataWithOnFinish(mCHWebServiceMethod.update_profile, parameters: dict, postBody: nil, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
            }) { (error) in
                onError(error: error)
        }
    }
    /*******************  SEARCH CONTACT ********************/
    
    //MARK:SEARCH CONTACT
    func searchContact(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        super.getWithOnFinish(mCHWebServiceMethod.search_mobile_number, parameters: dict, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
        }) { (error) in
            onError(error: error)
        }
        
    }
    
    /******************* PROFILE SCREEN ********************/
    
    //MARK: GET USER PROFILE DATA
    func getProfileData(onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        let dict = NSObject.getAppUserIdAndToken()
        super.getWithOnFinish(mCHWebServiceMethod.app_user_profile, parameters: dict, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
        }) { (error) in
            onError(error: error)
        }
        
        
    }
    
    //MARK: POST PROFILE IMAGE
    
    func postProfileImage(mediaPath:[String]?, name:[String]?,onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        let dict = NSObject.getAppUserIdAndToken()
        /*
         super.postSBMediaWithOnFinish(mCHWebServiceMethod.image_upload, headerParam: dict, mediaPaths: mediaPath, bodyDict: nil, name: name, onFinish: { (response, deserializedResponse) in
         onFinish(response: response, deserializedResponse: deserializedResponse)
         }) { (error) in
         onError(error: error)
         }*/
        
        super.postMediaWithOnFinish(mCHWebServiceMethod.image_upload, headerParam: dict, mediaPaths: mediaPath, bodyDict: nil, name: "photo", onFinish: { (response, deserializedResponse) in
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
    
    
    func getContactListForPage(page:String, onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        
         var dict = NSObject.getAppUserIdAndToken()
         dict["page"] = page
         super.getWithOnFinish(mCHWebServiceMethod.user_contact_list, parameters: dict, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
        }) { (error) in
            onError(error: error)
        }
        
    }
    
    
    
    
    //MARK: CHAT LIST
    func getChatList(onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        let dict = NSObject.getAppUserIdAndToken()
        super.getWithOnFinish(mCHWebServiceMethod.chat_contact_list, parameters: dict, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
        }) { (error) in
            onError(error: error)
        }
        
    }
    
    
    //MARK: ADD REVIEW LIST
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
    
    
    
    //MARK: CHAT CONVERSATION
    
    func getChatConversionForContactID(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        super.getWithOnFinish(mCHWebServiceMethod.chat_conversation, parameters: nil, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
        }) { (error) in
            onError(error: error)
        }


    }
    
    // MARK: TEXT MESSAGE
    func sendTextMessage(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        
        super.getWithOnFinish(mCHWebServiceMethod.send_message, parameters: nil, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
        }) { (error) in
            onError(error: error)
        }
    }
    
    
    func sendVideoORImageMessage(recipentID:String, message_type: String, mediaPath:[String]?, name:[String]?,onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        
        var dict = NSObject.getAppUserIdAndToken()
        dict["recipient_id"] = recipentID
        dict["message_type"] = message_type
    
        super.postMediaWithOnFinish(mCHWebServiceMethod.send_message, headerParam: dict, mediaPaths: mediaPath, bodyDict: nil, name: message_type, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
        }) { (error) in
            onError(error: error)
        }
        
    }
    
}

class DataSessionManger: NSObject
{
    static let sharedInstance = DataSessionManger()
    
    
    func postProfileImage(mediaPath:[String]?, name:[String]?,onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        let dataSession = DataSession()
        dataSession.postProfileImage(mediaPath, name: name, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
            }) { (error) in
                onError(error: error)
        }
        
    }
    func getProfileData(onFinish:(response:AnyObject,personalProfile:PersonalProfile)->(), onError:(error:AnyObject)->())
    {
        let dataSession = DataSession()
        dataSession.getProfileData({ (response, deserializedResponse) in
            let personalProfileData = PersonalProfile()
            if deserializedResponse is NSDictionary
            {
                if let arrayDict = deserializedResponse.objectForKey(user_profile) as? [NSDictionary]
                {
                    
                    
                    let dataDict = arrayDict.first
                    personalProfileData.idInt = (dataDict?.objectForKey("id") as? Int)!
                    personalProfileData.name = dataDict?.objectForKey(name) as! String
                    personalProfileData.email = (dataDict?.objectForKey(email))! as! String
                    personalProfileData.mobile_number = dataDict?.objectForKey(mobile_number) as! String
                   
                    personalProfileData.created_at = (dataDict?.objectForKey(created_at))! as! String
                    personalProfileData.updated_at = dataDict?.objectForKey(updated_at) as! String
                    personalProfileData.address = dataDict?.objectForKey(address) as! String
                    personalProfileData.website = dataDict?.objectForKey(website) as! String
                    if let _ = dataDict?.objectForKey(photo) as? String
                    {
                        personalProfileData.photo = dataDict?.objectForKey(photo) as! String
                    }
                    
                    personalProfileData.gcm_token = (dataDict?.objectForKey(gcm_token) as? String)!
                    personalProfileData.last_online_time = dataDict?.objectForKey(last_online_time) as! String
                    if let _ = (dataDict?.objectForKey("rating_average") as? [AnyObject])
                    {
                        personalProfileData.rating_average = (dataDict?.objectForKey("rating_average") as? [AnyObject])!
                    }
                    
                    if let _ = dataDict?.objectForKey("review_count") as? [AnyObject]
                    {
                        personalProfileData.review_count = dataDict?.objectForKey("review_count") as! [AnyObject]
                    }
                    
                }
                
            }
            
            onFinish(response: response, personalProfile: personalProfileData)
            
            
            }) { (error) in
                onError(error: error)
        }
        
    }
    
    
    
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
                    if let photo = dict.objectForKey("photo") as? String
                    {
                        chatPerson.photo = photo
                    }
                    
                    if let lastMessage = dict.objectForKey("last_message") as? String
                    {
                    
                        chatPerson.last_message = lastMessage
                    }
                    
                    if let lastMessageTime = dict.objectForKey("last_message_time") as? String
                    {
                        chatPerson.last_message_time = lastMessageTime
                    }
                    
                    if let unreadMessage = dict.objectForKey("last_message_time") as? Int
                    {
                        chatPerson.unread_message = unreadMessage
                    }
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
    
    
    
    func getContactListForPage(page:String, onFinish:(response:AnyObject,contactPerson:ContactPerson)->(), onError:(error:AnyObject)->())
    {
        let dataSession = DataSession()
        dataSession.getContactListForPage(page, onFinish: { (response, deserializedResponse) in
            
            let conatactPerson = ContactPerson()
            if deserializedResponse is NSDictionary
            {
                
                if let  next_page_url = deserializedResponse.objectForKey("next_page_url") as? String
                {
                    conatactPerson.next_page_url = next_page_url
                    
                }
                conatactPerson.current_page = (deserializedResponse.objectForKey("current_page") as? Int)!
                conatactPerson.total = (deserializedResponse.objectForKey("total") as? Int)!
                conatactPerson.last_page = (deserializedResponse.objectForKey("last_page") as? Int)!
                
                if let   data = deserializedResponse.objectForKey("data") as? NSArray
                {
                    
                    for dict in data
                    {
                        
                        let searchPerson = SearchPerson()
                        
                        searchPerson.idString = (dict.objectForKey("id") as? Int)!
                        if let name = dict.objectForKey("name") as? String
                        {
                            searchPerson.name   = name
                        }
                        
                        searchPerson.email = dict.objectForKey("email") as? String
                        if let mobileNumber = dict.objectForKey("mobile_number") as? String
                        {
                            searchPerson.mobileNumber = mobileNumber
                        }
                        
                        searchPerson.app_user_token = dict.objectForKey("app_user_token") as? String
                         searchPerson.created_at = dict.objectForKey("created_at") as? String
                         searchPerson.updated_at = dict.objectForKey("updated_at") as? String
                         searchPerson.dob = dict.objectForKey("dob") as? String
                         searchPerson.address = dict.objectForKey("address") as? String
                         searchPerson.website = dict.objectForKey("website") as? String
                         searchPerson.photo = dict.objectForKey("photo") as? String
                         searchPerson.gcm_token = dict.objectForKey("gcm_token") as? String
                         searchPerson.last_online_time = dict.objectForKey("last_online_time") as? String
                        if let ratingAverage =  dict.objectForKey("rating_average") as? [AnyObject]
                        {
                            searchPerson.ratingAverage = ratingAverage
                        }
                        
                        if let reviewcount = dict.objectForKey("review_count") as? [AnyObject]
                        {
                            searchPerson.reviewCount = reviewcount
                        }
                        conatactPerson.data.append(searchPerson)
                         
                    }
                    
                }
                
            }
            onFinish(response: response, contactPerson: conatactPerson)
            
            }) { (error) in
                onError(error: error)
        }
        
        
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


