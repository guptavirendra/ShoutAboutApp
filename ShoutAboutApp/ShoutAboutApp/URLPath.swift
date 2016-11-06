//
//  URLPathvar swift
//  iCancerHealth
//
//  Created by VIRENDRA GUPTA on 05/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import Foundation
import UIKit

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
    let add_app_user     = "add_app_user"
    let match_otp        = "match_otp"
    let update_profile   = "update_profile"
    let add_contact_list = "add_contact_list"
}


