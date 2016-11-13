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
    //@IBOutlet weak var searchView:UIView?
   // @IBOutlet weak var searchBar:UISearchBar?
    @IBOutlet weak var tableView: UITableView!
    var allValidContacts = [SearchPerson]()
    var errorMessage:String?

   let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Setup the Search Controller
        //searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Setup the Scope Bar
        //searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        //searchBar = searchController.searchBar
        
        //searchView = searchController.searchBar
        
        tableView.tableHeaderView = searchController.searchBar
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "message")
        searchController.hidesNavigationBarDuringPresentation = false
        //self.automaticallyAdjustsScrollViewInsets = false

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
        
    }
}

extension SearchViewController
{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if allValidContacts.count > 0
        {
            return  allValidContacts.count //objects.count
        }
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if allValidContacts.count > 0
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("contact", forIndexPath: indexPath) as! ContactTableViewCell
            cell.delegate = self
            
            let personContact = allValidContacts[indexPath.row]
            cell.nameLabel?.text = personContact.name
            cell.mobileLabel?.text = personContact.mobileNumber
            
            return cell
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

extension SearchViewController
{
    
    internal func searchBarTextDidBeginEditing(searchBar: UISearchBar)
    {
        
    }
    
    
    internal func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        getSearchForText(searchBar.text!)
        
    }
    
    
    internal func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        
        
    }
    
    
    internal func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        
        
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
        
         let dict = ["mobile_number":text,  kapp_user_id:String(appUserId), kapp_user_token :appUserToken, ]
        
        DataSessionManger.sharedInstance.searchContact(dict, onFinish: { (response, deserializedResponse, errorMessage) in
            
            dispatch_async(dispatch_get_main_queue(),
                {
                    self.allValidContacts = deserializedResponse
                    self.view.removeSpinner()
                    self.tableView.reloadData()
                    self.errorMessage = errorMessage
                
                
            });
            
        }) { (error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.view.removeSpinner()
               // self.displayAlert("Success", handler: self.handler)
                
            });//
        }
        
    }
}
