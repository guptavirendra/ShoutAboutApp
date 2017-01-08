//
//  LeftViewController.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 13/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var profileImageView:UIImageView!
    @IBOutlet weak var nameLabel:UILabel!
    var choiceArray = [String]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        choiceArray = ["Block","Spam","Settings","Favorites","Premium","Logout"]
        profileImageView.makeImageRounded()
        

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
       // self.revealViewController().rearViewRevealWidth = 120
        self.nameLabel.text = ProfileManager.sharedInstance.personalProfile.name
        // else need to update
        if ProfileManager.sharedInstance.localStoredImage != nil
        {
            self.profileImageView.image = ProfileManager.sharedInstance.localStoredImage
            
        }else
        {
            if let photo  = ProfileManager.sharedInstance.personalProfile.photo
            {
                setProfileImgeForURL(photo)
            }
             
        }
    }
    
    func setProfileImgeForURL(urlString:String)
    {
        self.profileImageView.setImageWithURL(NSURL(string:urlString ), placeholderImage: UIImage(named: "profile_pic"))
    }
}


extension LeftViewController
{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return choiceArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let text = choiceArray[indexPath.row]
        cell.textLabel?.text = text
        cell.textLabel?.font = UIFont(name: "TitilliumWeb-Regular", size: 18)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.imageView?.image = UIImage(named: text)
        return cell
        
    }
    
    //MARK: SELECTION
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.row == 5
        {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(kapp_user_id)
            NSUserDefaults.standardUserDefaults().removeObjectForKey(kapp_user_token)
            NSUserDefaults.standardUserDefaults().removeObjectForKey(contactStored)
            
            let vc = self.storyboard?.instantiateInitialViewController()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
            appDelegate.window?.rootViewController = vc
            appDelegate.window?.makeKeyAndVisible()
        }else
        {
        
            if  let vc = self.storyboard?.instantiateViewControllerWithIdentifier("SpamFavBlockViewController") as? SpamFavBlockViewController
            {
                
                //0,1,3 bsf
                
                if indexPath.row == 0
                {
                    vc.favSpamBlock = .block
                }
                if indexPath.row == 1
                {
                    vc.favSpamBlock = .spam
                }
                if indexPath.row == 3
                {
                    vc.favSpamBlock = .fav
                }
                
                self.navigationController?.navigationBar.barTintColor = appColor
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 60
        
    }
    
}
