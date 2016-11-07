//
//  JoinViewController.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 06/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, InputTableViewCellProtocol, ClickTableViewCellProtocol
{
    @IBOutlet weak var tableView: UITableView!
    var activeTextField:UITextField?
    var name:String = ""
    var email:String = ""
    var address:String = ""
    var website:String = ""

    var completionHandler: (Float)->Void = {
        (arg: Float) -> Void in
    }
    var handler :(UIAlertAction) -> Void =
        { (arg: UIAlertAction) -> Void in
            
            
            print("do something");
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.showKeyBoard(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.hideKeyBoard(_:)), name: UIKeyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    
}

extension JoinViewController
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 7
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3
        {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("input", forIndexPath: indexPath) as! InputTableViewCell
            cell.inputTextField.delegate = self
            cell.delegate = self
            if indexPath.row == 0
            {
                cell.inputTextField.placeholder = kEmail
                cell.inputTextField.tag = 0
                
            }
            
            if indexPath.row == 1
            {
                cell.inputTextField.placeholder = kName
                cell.inputTextField.tag = 1
            }
            
            if indexPath.row == 2
            {
                cell.inputTextField.placeholder = kAddress
                cell.inputTextField.tag = 2
            }
            if indexPath.row == 3
            {
                cell.inputTextField.placeholder = kWebsite
                cell.inputTextField.tag = 3
            }
            
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("button", forIndexPath: indexPath) as! ClickTableViewCell
        cell.delegate = self
        
        if indexPath.row == 4
        {
            cell.button.setTitle("Join", forState: .Normal)
        }
        if indexPath.row == 5
        {
            cell.button.setTitle("Or", forState: .Normal)
            cell.button.userInteractionEnabled = false
        }
        if indexPath.row == 6
        {
            cell.button.setTitle("Skip", forState: .Normal)
        }
        
        
        return cell
    }

}
extension JoinViewController
{
    func buttonClicked(cell: ClickTableViewCell)
    {
        if cell.button.titleLabel?.text == "Skip"
        {
           print("Skip")
            let tabBarVC = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarVC") as? UITabBarController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
            appDelegate.window?.rootViewController = tabBarVC
            appDelegate.window?.makeKeyAndVisible()

        }
        
        if cell.button.titleLabel?.text == "Join"
        {
            print("join")
            
            print(" email:\(self.email), name:\(self.name),  web:\(self.website ), address:f \(self.address) ")
            
            let appUserId = NSUserDefaults.standardUserDefaults().objectForKey(kapp_user_id) as! Int
            let appUserToken = NSUserDefaults.standardUserDefaults().objectForKey(kapp_user_token) as! String
            
            let dict = ["name":self.name, "email":self.email, "website":self.website, "address":self.address, kapp_user_id:String(appUserId), kapp_user_token :appUserToken, "notify_token":"text"]
            postData(dict)
            
        }
    }
    
    
    override func displayAlert(userMessage: String, handler: ((UIAlertAction) -> Void)?)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
        let tabBarVC = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarVC") as? UITabBarController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
            appDelegate.window?.rootViewController = tabBarVC
            appDelegate.window?.makeKeyAndVisible()
            
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func postData(dict:[String:String])
    {
         activeTextField?.resignFirstResponder()
        self.view.showSpinner()
        DataSessionManger.sharedInstance.updateProfile(dict, onFinish: { (response, deserializedResponse) in
            if deserializedResponse is NSDictionary
            {
                if deserializedResponse.objectForKey("success") != nil
                {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.view.removeSpinner()
                        self.displayAlert("Success", handler: self.handler)
                        
                    });
                }
            }
            
            
            }) { (error) in
                dispatch_async(dispatch_get_main_queue(), {
                    self.view.removeSpinner()
                    self.displayAlertMessage(error as! String)
                    
                });
                
                
        }
    
    
    }
    
    
    func getTextForCell(text: String, cell: InputTableViewCell)
    {
        if cell.inputTextField.tag == 0
        {
            self.email = text
        }
        if cell.inputTextField.tag == 1
        {
            self.name = text
        }
        if cell.inputTextField.tag == 3
        {
            self.website = text
            
        }
        if cell.inputTextField.tag == 2
        {
            self.address = text
        }
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool
    {
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        self.activeTextField = textField
    }
    func textFieldDidEndEditing(textField: UITextField)
    {
        
        
    }
    
     func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
            return true
    }
    
    func showKeyBoard(notification: NSNotification)
    {
        if ((activeTextField?.superview?.superview?.isKindOfClass(InputTableViewCell)) != nil)
        {
            if let cell = activeTextField?.superview?.superview as? InputTableViewCell
            {
                let dictInfo: NSDictionary = notification.userInfo!
                let kbSize :CGSize = (dictInfo.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue().size)!
                let contentInsets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
                self.tableView.contentInset = contentInsets
                self.tableView.scrollIndicatorInsets = contentInsets
                
                self.tableView.scrollToRowAtIndexPath(self.tableView.indexPathForCell(cell)!, atScrollPosition: .Top, animated: true)
                
            }
        }
    }
    func hideKeyBoard(notification: NSNotification)
    {
        
        if  activeTextField != nil
        {
            let contentInsets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.tableView.contentInset = contentInsets
            self.tableView.scrollIndicatorInsets = contentInsets
        }
    }

    
    
}
