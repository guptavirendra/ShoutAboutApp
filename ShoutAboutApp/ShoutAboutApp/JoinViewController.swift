//
//  JoinViewController.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 06/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit
import Firebase
import Contacts

 class ContactManager: NSObject
{
    static let sharedInstance = ContactManager()
     
}


extension UITableView
{
    func addBackGroundImageView()
    {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView = imageView
        
        
        let top = NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let leading = NSLayoutConstraint(item: imageView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: imageView, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        
        self.addConstraints([top, leading, trailing, bottom])
        
    }
    
    
}



class JoinViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, InputTableViewCellProtocol, ClickTableViewCellProtocol
{
    var objects = [CNContact]()
    var allValidContacts = [SearchPerson]()
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
        
        //tableView.addBackGroundImageView()
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
                cell.inputTextField.placeholder =  kName
                cell.inputImage.image = UIImage(named: kName)
                cell.inputTextField.tag = 0
                
            }
            
            if indexPath.row == 1
            {
                cell.inputTextField.placeholder = kEmail
                cell.inputImage.image = UIImage(named: kEmail)
                cell.inputTextField.tag = 1
            }
            
            if indexPath.row == 2
            {
                cell.inputTextField.placeholder = kAddress
                cell.inputImage.image = UIImage(named: kAddress)
                cell.inputTextField.tag = 2
            }
            if indexPath.row == 3
            {
                cell.inputTextField.placeholder = kWebsite
                cell.inputImage.image = UIImage(named: kWebsite)
                cell.inputTextField.tag = 3
                
            }
            
            return cell
        }
        
        if indexPath.row == 4 || indexPath.row == 6
        {
        let  cell = tableView.dequeueReusableCellWithIdentifier("button", forIndexPath: indexPath) as! ClickTableViewCell
        cell.delegate = self
        
        if indexPath.row == 4
        {
            cell.button.setTitle("Join", forState: .Normal)
            cell.widthConstraints?.constant = cell.contentView.bounds.size.width - 60
        }
            /*
        if indexPath.row == 6
        {
            cell.textLabel?.text = "Or"
            cell.textLabel?.textAlignment = .Center
            cell.textLabel?.makeImageRoundedWithGray()
            //cell.button.setTitle("Or", forState: .Normal)
            //cell.button.makeImageRoundedWithGray()
            //cell.button.backgroundColor = UIColor.blackColor()
            cell.button.userInteractionEnabled = false
            //let width = NSLayoutConstraint(item: cell.button, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: 30)
            
            //cell.button.addConstraint(width)
        }*/
        
        if indexPath.row == 6
        {
            cell.widthConstraints?.constant = 80
            cell.button.setTitle("Skip", forState: .Normal)
            cell.button.backgroundColor = UIColor.blackColor()
            let centerx = NSLayoutConstraint(item: cell.button, attribute: .CenterX, relatedBy: .Equal, toItem: cell.contentView, attribute: .CenterX, multiplier: 1.0, constant: 0)
            cell.contentView.addConstraint(centerx)
        }
        
        
        return cell
        }
        
        
               let cell = tableView.dequeueReusableCellWithIdentifier("FaceBookGoogleTableViewCell", forIndexPath: indexPath) as! FaceBookGoogleTableViewCell
                //cell.button.setTitle("Skip", forState: .Normal)
        return cell
        
      }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.row == 5
        {
            return 66
        }
        
        return 44
    }

    

}
extension JoinViewController
{
    func buttonClicked(cell: ClickTableViewCell)
    {
        getFireBaseAuth()
        
        dispatch_async(dispatch_get_global_queue(0, 0),
                       {
                        self.getContacts()
                        
        })
        
        if cell.button.titleLabel?.text == "Skip"
        {
            
            
            
            print("Skip")
            self.dismissViewControllerAnimated(false, completion: nil)
            let tabBarVC = self.storyboard?.instantiateViewControllerWithIdentifier("SWRevealViewController") as? SWRevealViewController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
            appDelegate.window?.rootViewController = tabBarVC
            appDelegate.window?.makeKeyAndVisible()

        }
        
        if cell.button.titleLabel?.text == "Join"
        {
            print("join")
            
            print(" email:\(self.email), name:\(self.name),  web:\(self.website ), address:f \(self.address) ")
            
            if self.name.characters.count == 0
            {
                self.displayAlertMessage("Please enter name")
                
            }else if self.email.characters.count == 0
            {
                self.displayAlertMessage("Please enter email")
                             }
            else if self.address.characters.count == 0
            {
                self.displayAlertMessage("Please enter address")
                
            }else if self.website.characters.count == 0
            {
                self.displayAlertMessage("Please enter website")
                
            }else
            {
                let appUserId = NSUserDefaults.standardUserDefaults().objectForKey(kapp_user_id) as! Int
                let appUserToken = NSUserDefaults.standardUserDefaults().objectForKey(kapp_user_token) as! String
                
                let dict = ["name":self.name, "email":self.email, "website":self.website, "address":self.address, kapp_user_id:String(appUserId), kapp_user_token :appUserToken, "notify_token":"text"]
                postData(dict)
            }
        }
    }
    
    
    override func displayAlert(userMessage: String, handler: ((UIAlertAction) -> Void)?)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default)
        { (action) in
            self.dismissViewControllerAnimated(false, completion: nil)
            let tabBarVC = self.storyboard?.instantiateViewControllerWithIdentifier("SWRevealViewController") as? SWRevealViewController
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
                        self.displayAlert("Success", handler: nil)
                        
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
            self.name = text
            
        }
        if cell.inputTextField.tag == 1
        {
            self.email = text
        }
        if cell.inputTextField.tag == 2
        {
            self.address = text
        }
        if cell.inputTextField.tag == 3
        {
            self.website = text
            
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
        if ((activeTextField?.superview?.superview?.superview!.isKindOfClass(InputTableViewCell)) != nil)
        {
            if let cell = activeTextField?.superview?.superview?.superview as? InputTableViewCell
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

extension JoinViewController
{
    
    func getFireBaseAuth()
    {
        FIRAuth.auth()?.signInAnonymouslyWithCompletion({ (user, error) in
            
            // 2
            if let err = error { // 3
                print(err.localizedDescription)
                return
            }
            
            //self.performSegueWithIdentifier("LoginToChat", sender: nil) // 4
        })

    }
}

extension JoinViewController
{
    func getContacts()
    {
        let store = CNContactStore()
        
        if CNContactStore.authorizationStatusForEntityType(.Contacts) == .NotDetermined
        {
            store.requestAccessForEntityType(.Contacts, completionHandler: { (authorized: Bool, error: NSError?) -> Void in
                if authorized
                {
                    self.retrieveContactsWithStore(store)
                }else
                {
                    self.displayCantAddContactAlert()
                }
            })
        }else if CNContactStore.authorizationStatusForEntityType(.Contacts) == .Denied
        {
            self.displayCantAddContactAlert()
            
        }
            
        else if CNContactStore.authorizationStatusForEntityType(.Contacts) == .Authorized
        {
            self.retrieveContactsWithStore(store)
        }
    }
    
    func displayCantAddContactAlert()
    {
        /*let okAction = UIAlertAction(title: "Change Settings",
         style: .Default,
         handler: { action in
         self.openSettings()
         })*/
        //let cancelAction =  UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        // showAlertWithMessage("You must give the app permission to add the contact first.", okAction: okAction, cancelAction: cancelAction)
        //displayAlert("You must give the app permission to add the contact first.", handler: nil)
        
        let alert = UIAlertController(title: "Alert", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Change Settings", style: .Default) { (action) in
            self.openSettings()
            
        }
        let cancelAction =  UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    
    /*
     override func displayAlert(userMessage: String, handler: ((UIAlertAction) -> Void)?)
     {
     let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
     let okAction = UIAlertAction(title: "Change Settings", style: .Default) { (action) in
     self.openSettings()
     
     }
     let cancelAction =  UIAlertAction(title: "OK", style: .Cancel, handler: nil)
     alert.addAction(okAction)
     alert.addAction(cancelAction)
     self.presentViewController(alert, animated: true, completion: nil)
     
     }*/
    
    func showAlertWithMessage(message : String, okAction:UIAlertAction, cancelAction:UIAlertAction )
    {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    func openSettings()
    {
        let url = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(url!)
    }
    func retrieveContactsWithStore(contactStore: CNContactStore)
    {
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),
            
            CNContactPhoneNumbersKey,
            ]
        
        // Get all the containers
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containersMatchingPredicate(nil)
        } catch {
            print("Error fetching containers")
        }
        
        var results: [CNContact] = []
        
        // Iterate all containers and append their contacts to our results array
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainerWithIdentifier(container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContactsMatchingPredicate(fetchPredicate, keysToFetch: keysToFetch)
                results.appendContentsOf(containerResults)
            } catch {
                print("Error fetching results for container")
            }
        }
        
        self.objects = results
        allValidContacts.removeAll()
        for contact in self.objects
        {
            let formatter = CNContactFormatter()
            
            let name = formatter.stringFromContact(contact)
            let mobile = (contact.phoneNumbers.first?.value as! CNPhoneNumber).valueForKey("digits") as? String
            
            if name?.characters.count > 0 && mobile != nil
            {
                let personContact = SearchPerson()
                personContact.name = name!
                personContact.mobileNumber =  mobile!
                allValidContacts.append(personContact)
                
                
            }
        }
        
        //1ProfileManager.sharedInstance.syncedContactArray.appendContentsOf(allValidContacts)
        
        /*allValidContacts.sortInPlace { (person1, person2) -> Bool in
         return person1.name < person2.name
         }*/
        if NetworkConnectivity.isConnectedToNetwork() != true
        {
            displayAlertMessage("No Internet Connection")
            
        }else
        {
            postData()
        }
    }
    
    func postData()
    {
        let stringtext = getJsonFromArray(allValidContacts)
        print("json:\(stringtext)")
        let trimmedString = stringtext.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        let appUserId = NSUserDefaults.standardUserDefaults().objectForKey(kapp_user_id) as! Int
        let appUserToken = NSUserDefaults.standardUserDefaults().objectForKey(kapp_user_token) as! String
        
        let dict = [ kapp_user_id:String(appUserId), kapp_user_token :appUserToken]
        let postDict = ["contacts":trimmedString]
        
        postContactToServer(dict, postDict: postDict)
    }
    
    /*
    override func displayAlert(userMessage: String, handler: ((UIAlertAction) -> Void)?)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.getContact()
            //self.tableView.reloadData() hit web service
            self.view.removeSpinner()
            
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }*/
    
    func getContact()
    {
        if NetworkConnectivity.isConnectedToNetwork() != true
        {
            self.displayAlertMessage("No Internet Connection")
            
        }else
        {
            self.getContactForPage()
        }
        
    }
    
    func postContactToServer(dict:[String:String], postDict:[String:String])
    {
        //self.view.showSpinner()
        DataSessionManger.sharedInstance.syncContactToTheServer(dict, postDict:postDict,  onFinish: { (response, deserializedResponse) in
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.getContact()
                //self.view.removeSpinner()
            })
            if deserializedResponse.objectForKey("success") != nil
            {
                dispatch_async(dispatch_get_main_queue(), {
                    //self.view.removeSpinner()
                    self.displayAlert("Sync to server successfully ", handler: nil)
                    
                });
            }
            
            
        }) { (error) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.view.removeSpinner()
            })
            
        }
        
        
    }
    
    
    func getContactForPage()
    {
        //self.view.showSpinner()
        
        //ProfileManager.sharedInstance.syncedContactArray.removeAll
        DataSessionManger.sharedInstance.getContactListForPage( { (response, contactPerson) in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
            ProfileManager.sharedInstance.syncedContactArray.appendContentsOf(contactPerson.data)
               // self.tableView.reloadData()
                self.saveContacts(ProfileManager.sharedInstance.syncedContactArray)
                NSNotificationCenter.defaultCenter().postNotificationName("ContactUpdated", object: nil)
                self.view.removeSpinner()
            })
            
        }) { (error) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
               // self.tableView.reloadData()
               // self.view.removeSpinner()
            })
            
        }
    }
    
    func saveContacts(person:[SearchPerson])
    {
        let archivedObject = SearchPerson.archivePeople(person)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey(contactStored)
        defaults.setObject(archivedObject, forKey: contactStored)
        defaults.synchronize()
    }
    
    
    
    //MARK: CONVERT TO JSON
    func getJsonFromArray(array: [PersonContact]) -> String
    {
        
        let jsonCompatibleArray = array.map { model in
            return [
                "name":model.name,
                "mobile_number":model.mobileNumber,
                
            ]
        }
        var errorinString = ""
        
        do
        {
            let data = try NSJSONSerialization.dataWithJSONObject(jsonCompatibleArray, options: NSJSONWritingOptions.PrettyPrinted)
            
            let json = NSString(data: data, encoding: NSUTF8StringEncoding)
            if let json = json
            {
                errorinString = json as String
                print(json)
            }
            
        }
        catch
        {
            print(" in catch block")
            
        }
        return errorinString
    }
}
