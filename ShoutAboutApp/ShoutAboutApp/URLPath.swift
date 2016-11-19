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
let bgColor = UIColor(patternImage: UIImage(named: "bg")!)



let name  = "name"
let email: String = "email"
let mobile_number: String = "mobile_number"
let created_at: String = "created_at"
let updated_at: String = "updated_at"
let dob : String = "dob"
let address: String = "address"
let website: String = "website"
let photo: String = "photo"
let gcm_token: String = "gcm_token"
let last_online_time: String = "last_online_time"
let user_profile = "user_profile"


struct WebServicePath
{
    let add_app_user         = "add_app_user"
    let match_otp            = "match_otp"
    let update_profile       = "update_profile"
    let add_contact_list     = "add_contact_list"
    let search_mobile_number = "search_mobile_number"
    let chat_contact_list    = "chat_contact_list"
    let user_contact_list    = "user_contact_list"
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
    var name:String?
    var photo:String?
    var last_message:String?
    var last_message_time:String?
    var unread_message:Int = 0
}


class SearchPerson:PersonContact
{
    var idString:Int = 0
    //var name: String
    var email: String?
    //var "mobile_number": "1234567890",
    var app_user_token: String?
    var created_at : String?
    var updated_at: String?
    var dob: String?
    var address: String?
    var website: String?
    var photo: String?
    var gcm_token: String?
    var last_online_time: String?
    var ratingAverage:[AnyObject] = [AnyObject]()
    var reviewCount:[AnyObject]   = [AnyObject]()
}

class ContactPerson:NSObject
{
    var total : Int = 0
    var per_page: Int = 0
    var current_page: Int = 0
    var last_page: Int = 0
    var next_page_url: String?
    var prev_page_url: String?
    var from: Int = 0
    var to: Int = 0
    var data:[SearchPerson] = [SearchPerson]()
}


 