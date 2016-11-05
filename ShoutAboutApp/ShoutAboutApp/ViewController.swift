//
//  ViewController.swift
//  ShoutAboutAppV
//
//  Created by VIRENDRA GUPTA on 05/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    var mobileNumberString:String = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
            mobileNumberTextField.addTarget(self, action:#selector(ViewController.edited), forControlEvents:UIControlEvents.EditingChanged)
        submitButton.userInteractionEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitButtonClicked(sender: UIButton)
    {
        ///print hit webservice
        print("Mobile Number to Submit \(mobileNumberString)")
        mobileNumberTextField.resignFirstResponder()
        
        if NetworkConnectivity.isConnectedToNetwork() != true
        {
            displayAlertMessage("No Internet Connection")
            
        }else
        {
            //hit webservice
            
            DataSessionManger.sharedInstance.getOTPForMobileNumber(mobileNumberString, onFinish: { (response, deserializedResponse) in
                
                print(" response :\(response) , deserializedResponse \(deserializedResponse) ")
                if deserializedResponse is NSDictionary
                {
                    if deserializedResponse.objectForKey(message) != nil
                    {
                        let messageString = deserializedResponse.objectForKey(message) as? String
                        if messageString == otpMessage
                        {
                            dispatch_async(dispatch_get_main_queue(), {
                                let otpViewController = self.storyboard?.instantiateViewControllerWithIdentifier("OTPViewController") as? OTPViewController
                                self.presentViewController(otpViewController!, animated: true, completion: nil)
                                
                            });
                            // print go ahead
                        }else
                        {
                            // stay here
                        }
                    }
                }
                
                }, onError: { (error) in
                    print(" error:\(error)")
                    
            })
        }
        
    }

}


extension ViewController:UITextFieldDelegate
{
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        var text:NSString =  textField.text ?? ""
        text =  text.stringByReplacingCharactersInRange(range, withString: string)
        
        
        if text.length == 10
        {
            submitButton.userInteractionEnabled = true
        }else
        {
            submitButton.userInteractionEnabled = false
        }
        
        if text.length > 10
        {
            return false
        }
        return true
    }
    func edited()
    {
        print("Edited \(mobileNumberTextField.text)")
        mobileNumberString = mobileNumberTextField.text!
    }
}



extension UIViewController
{
    /* Displays alert message
     */
    func displayAlertMessage(userMessage: String)
    {
        
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
}

