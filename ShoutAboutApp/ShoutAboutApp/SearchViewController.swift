//
//  SearchViewController.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 06/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate,UISearchControllerDelegate, ContactTableViewCellProtocol, UITableViewDataSource, UITableViewDelegate
{

    @IBOutlet weak var tableView: UITableView!
    var allValidContacts  = [SearchPerson]()
    var localContactArray = [SearchPerson]()
    var errorMessage:String?

    let searchController = UISearchController(searchResultsController: nil)
    
    var isSeaechingLocal:Bool = true
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        tableView.tableHeaderView = searchController.searchBar
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "message")
        searchController.hidesNavigationBarDuringPresentation = false
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        //allValidContacts.removeAll()
        //self.tableView.reloadData()
        self.searchController.searchBar.text = nil
        self.navigationController?.navigationBar.hidden = true
        
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        self.searchController.active = true
        dispatch_async(dispatch_get_main_queue(), {
            self.searchController.searchBar.becomeFirstResponder()
        })
        //searchController.searchBar.delegate?.searchBarTextDidBeginEditing!(searchController.searchBar)
        //searchController.searchBar.delegate?.searchBarShouldBeginEditing!(searchController.searchBar)
    }
    
    
}

extension SearchViewController
{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isSeaechingLocal == true
        {
           return localContactArray.count
        }else
        {
        if allValidContacts.count > 0
        {
            return  allValidContacts.count //objects.count
        }
        }
        return 0
    }
    
    
    func returnCellForTableView(tableView: UITableView, indexPath: NSIndexPath, dataArray:[SearchPerson])->UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("contact", forIndexPath: indexPath) as! ContactTableViewCell
        cell.delegate = self
        
        let personContact = dataArray[indexPath.row]
        cell.nameLabel?.text = personContact.name
        cell.mobileLabel?.text = personContact.mobileNumber
        if let urlString = personContact.photo
        {
            cell.profileImageView.setImageWithURL(NSURL(string:urlString ), placeholderImage: UIImage(named: "profile"))
            
        }else
        {
            cell.profileImageView.image = UIImage(named: "profile")
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if isSeaechingLocal == true
        {
            return returnCellForTableView(tableView, indexPath: indexPath, dataArray: localContactArray)
        }else
        {
            if allValidContacts.count > 0
            {
                
                return returnCellForTableView(tableView, indexPath: indexPath, dataArray: allValidContacts)
            }
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("message", forIndexPath: indexPath)
        cell.textLabel?.text = errorMessage
        
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
            let personContact = allValidContacts[indexPath!.row]
            if button.titleLabel?.text == " Call"
            {
                let personContact = allValidContacts[indexPath!.row]
                let   phone = "tel://"+personContact.mobileNumber
                UIApplication.sharedApplication().openURL(NSURL(string: phone)!)
            }
            else if button.titleLabel?.text == " Chat"
            {
                let chattingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ChattingViewController") as? ChattingViewController
                self.navigationController!.pushViewController(chattingViewController!, animated: true)
                
            }
            else if button.titleLabel?.text == "reviews"
            {
                
                let rateANdReviewViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RateANdReviewViewController") as? RateANdReviewViewController
                self.navigationController!.pushViewController(rateANdReviewViewController!, animated: true)
                
                
            }else
            {
                let profileViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as? ProfileViewController
                profileViewController?.personalProfile = personContact
                
                self.navigationController!.pushViewController(profileViewController!, animated: true)
            }
        }
    }
}

extension SearchViewController
{
   
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool
    {
        return true
    }
    
    
    
     func searchBarTextDidBeginEditing(searchBar: UISearchBar)
    {
        
    }
    
    
    internal func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        isSeaechingLocal = false
        getSearchForText(searchBar.text!)
        
    }
    
    
    internal func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        allValidContacts.removeAll()
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    internal func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.characters.count > 0
        {
            searchString(searchText)
        }
        
        
    }

    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int)
    {
       
        
    }
}

extension SearchViewController
{
    func getSearchForText(text:String)
    {
        allValidContacts.removeAll()
        self.view.showSpinner()
        let appUserId = NSUserDefaults.standardUserDefaults().objectForKey(kapp_user_id) as! Int
        let appUserToken = NSUserDefaults.standardUserDefaults().objectForKey(kapp_user_token) as! String
        
         let dict = ["search":text,  kapp_user_id:String(appUserId), kapp_user_token :appUserToken, ]
        
        DataSessionManger.sharedInstance.searchContact(dict, onFinish: { (response, deserializedResponse, errorMessage) in
            
            self.isSeaechingLocal = false
            dispatch_async(dispatch_get_main_queue(),
                {
                    self.allValidContacts = deserializedResponse
                    
                    
                   var searchArray = self.retrievePearson()
                    
                    if searchArray == nil
                    {
                        searchArray = [SearchPerson]()
                        
                    }
                    if searchArray?.count > 30
                    {
                        
                        if deserializedResponse.count > 0
                        {
                            searchArray?.removeFirst()
                            searchArray?.append(deserializedResponse.first!)
                        }
                    }else
                    {
                        if deserializedResponse.count > 0
                        {
                            //searchArray?.removeFirst()
                            searchArray?.append(deserializedResponse.last!)
                        }
                    }
                    self.savePerson(searchArray!)
                    // NSUserDefaults.standardUserDefaults().setObject(searchArray, forKey: searchHistory)
                    self.view.removeSpinner()
                    self.tableView.reloadData()
                    self.errorMessage = errorMessage
                
                
            });
            
        }) { (error) in
            self.isSeaechingLocal = false
            dispatch_async(dispatch_get_main_queue(), {
                self.view.removeSpinner()
               // self.displayAlert("Success", handler: self.handler)
                
            });//
        }
        
    }
    
    func savePerson(person:[SearchPerson])
    {
        let archivedObject = SearchPerson.archivePeople(person)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(archivedObject, forKey: searchHistory)
        defaults.synchronize()
    }
    
    func retrievePearson() -> [SearchPerson]?
    {
        if let unarchivedObject = NSUserDefaults.standardUserDefaults().objectForKey(searchHistory) as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? [SearchPerson]
        }
        return nil
    }
}


extension SearchViewController
{
    func  searchString(searchString:String)
    {
        //let namePredicate  = NSPredicate(format: "(name BEGINSWITH[c] %@)", searchString)
        let phonePredicate = NSPredicate(format: "(mobileNumber BEGINSWITH[c] %@) OR (name BEGINSWITH[c] %@)", searchString, searchString)
        
       // let predicateArray = [namePredicate, phonePredicate]
       // let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicateArray)
        
    localContactArray  =  ProfileManager.sharedInstance.syncedContactArray.filter
            { phonePredicate.evaluateWithObject($0)
        };
        
    tableView.reloadData()
        
    }
}
