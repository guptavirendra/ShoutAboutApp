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
           let vc = self.storyboard?.instantiateInitialViewController()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
            appDelegate.window?.rootViewController = vc
            appDelegate.window?.makeKeyAndVisible()
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 60
        
    }
    
}
