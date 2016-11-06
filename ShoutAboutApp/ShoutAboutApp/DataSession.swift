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
    
    func getOTPValidateForMobileNumber(mobileNumber:String, otp:String,  onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        let dataSession = DataSession()
        dataSession.getOTPValidateForMobileNumber(mobileNumber, otp: otp, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
            }) { (error) in
                onError(error: error)
        }
        
    }
    
    
    func updateProfile(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        let dataSession = DataSession()
        dataSession.updateProfile(dict, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
            }) { (error) in
                onError(error: error)
        }
        
    }
    
    func syncContactToTheServer(dict:[String:String], onFinish:(response:AnyObject,deserializedResponse:AnyObject)->(), onError:(error:AnyObject)->())
    {
        let dataSession = DataSession()
        dataSession.syncContactToTheServer(dict, onFinish: { (response, deserializedResponse) in
            onFinish(response: response, deserializedResponse: deserializedResponse)
            }) { (error) in
                onError(error: error)
        }

    }
}
