//
//  URLPathvar swift
//  iCancerHealth
//
//  Created by VIRENDRA GUPTA on 05/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import Foundation
import UIKit

let search_mobile  = "search_mobile"
let message        = "message"
let otpMessage     = "Successfully sent the One Time Password to your Mobile Number"
let otpExpireMessage = "your otp has been expired, please regenerate new otp."
let kapp_user_id    = "app_user_id"
let kapp_user_token = "app_user_token"
let inavalidOTP     = "Invalid OTP Number"

let kEmail   = "email"
let kName    = "Name"
let kAddress = "Address"
let kWebsite = "Website"
let bgColor = UIColor(patternImage: UIImage(named: "background")!)

struct WebServicePath
{
    let add_app_user         = "add_app_user"
    let match_otp            = "match_otp"
    let update_profile       = "update_profile"
    let add_contact_list     = "add_contact_list"
    let search_mobile_number = "search_mobile_number"
    let chat_contact_list    = "chat_contact_list"
    let  app_user_profile    = "app_user_profile"
    let image_upload         = "image_upload"
    let send_message         = "send_message"
    let chat_conversation    = "chat_conversation"
    let contact_review_list  = "contact_review_list"
    let add_rate_review      = "add_rate_review"
    let like_review          = "like_review"
    let dislike_review       = "dislike_review"
    let unlike_review        = "unlike_review"
    let undislike_review     = "undislike_review"
}

class ChatPerson:NSObject
{
    var idString:Int = 0
    var name:String  = ""
    var photo:String = ""
    
}

class SearchPerson:PersonContact
{
    var idString:Int = 0
    var ratingAverage:[AnyObject] = [AnyObject]()
    var reviewCount:[AnyObject]   = [AnyObject]()
    /*
    {
    "id": 3798,
    "name": "Chandani Delhi",
    "mobile_number": "8447673545",
    "rating_average": [],
    "review_count": []
    }
 */

}


