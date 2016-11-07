//
//  ContactViewController.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 06/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//


class PersonContact: NSObject
{
    var name:String  = ""
    var mobileNumber:String = ""
}

import UIKit

import Contacts

class ContactViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ContactTableViewCellProtocol
{
    @IBOutlet weak var tableView: UITableView!
    var objects = [CNContact]()
    var allValidContacts = [PersonContact]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = bgColor
        self.getContacts()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ContactViewController
{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return  allValidContacts.count //objects.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("contact", forIndexPath: indexPath) as! ContactTableViewCell
        cell.delegate = self
        
        let personContact = allValidContacts[indexPath.row]
        cell.nameLabel?.text = personContact.name
        cell.mobileLabel?.text = personContact.mobileNumber
        
        return cell
    }
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
     func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 100.0
        
    }
    
    //MARK: CALL
    func buttonClicked(cell: ContactTableViewCell, button: UIButton)
    {
        
        if self.tableView.indexPathForCell(cell) != nil
        {
            let indexPath = self.tableView.indexPathForCell(cell)
            if button.titleLabel?.text == "Call"
            {
                let personContact = allValidContacts[indexPath!.row]
                let   phone = "tel://"+personContact.mobileNumber
                UIApplication.sharedApplication().openURL(NSURL(string: phone)!)
            }
            if button.titleLabel?.text == "Chat"
            {
                
            }
            if button.titleLabel?.text == "reviews"
            {
              
                let rateANdReviewViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RateANdReviewViewController") as? RateANdReviewViewController
                 self.navigationController!.pushViewController(rateANdReviewViewController!, animated: true)
                
                
            }
        }
    }
}

extension ContactViewController
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
                    let personContact = PersonContact()
                    personContact.name = name!
                    personContact.mobileNumber =  mobile!
                    allValidContacts.append(personContact)
                    
                }
            }
            
            postData()
            
        }
    
    
    
    
    func postData()
    {
        let stringtext = getJsonFromArray(allValidContacts)
        print("json:\(stringtext)")
        
        let appUserId = NSUserDefaults.standardUserDefaults().objectForKey(kapp_user_id) as! Int
        let appUserToken = NSUserDefaults.standardUserDefaults().objectForKey(kapp_user_token) as! String
        
        let dict = ["contacts":stringtext, kapp_user_id:String(appUserId), kapp_user_token :appUserToken, ]
        postContactToServer(dict)
    }
    
    
    override func displayAlert(userMessage: String, handler: ((UIAlertAction) -> Void)?)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.tableView.reloadData()
            self.view.removeSpinner()
            
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func postContactToServer(dict:[String:String])
    {
        self.view.showSpinner()
        DataSessionManger.sharedInstance.syncContactToTheServer(dict, onFinish: { (response, deserializedResponse) in
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.view.removeSpinner()
            })
            if deserializedResponse.objectForKey("success") != nil
            {
                dispatch_async(dispatch_get_main_queue(), {
                    self.view.removeSpinner()
                    self.displayAlert("Sync to server successfully ", handler: nil)
                    
                });
            }
            
            
            }) { (error) in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                    self.view.removeSpinner()
                })
                
        }
        
        
    }
    
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