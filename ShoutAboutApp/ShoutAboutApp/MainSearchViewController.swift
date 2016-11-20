//
//  MainSearchViewController.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 19/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit

class MainSearchViewController: UIViewController, ContactTableViewCellProtocol
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var searchButton:UIButton!
    var allValidContacts = [SearchPerson]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if self.revealViewController() != nil
        {
            self.revealViewController().getProfileData()
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }

         
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if let historydata = self.retrievePearson()
        {
            allValidContacts = historydata
            self.tableView.reloadData()
        }
       
        
    }
    func retrievePearson() -> [SearchPerson]?
    {
        if let unarchivedObject = NSUserDefaults.standardUserDefaults().objectForKey(searchHistory) as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? [SearchPerson]
        }
        return nil
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

extension MainSearchViewController
{
    @IBAction func searchButtonClicked(button:UIButton)
    {
        let searchViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchViewController") as? SearchViewController
        self.navigationController!.pushViewController(searchViewController!, animated: true)
        
    }
}

extension MainSearchViewController
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
        if let urlString = personContact.photo
        {
            
            cell.profileImageView.setImageWithURL(NSURL(string:urlString ), placeholderImage: UIImage(named: "profile"))
            
        }else
        {
            cell.profileImageView.image = UIImage(named: "profile")
        }
        
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
