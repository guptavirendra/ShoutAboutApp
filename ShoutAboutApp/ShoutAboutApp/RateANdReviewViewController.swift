//
//  RateANdReviewViewController.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 06/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit

class RateANdReviewViewController: UIViewController,UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.backgroundColor = bgColor

         self.navigationController?.navigationBar.hidden = false
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
}

extension RateANdReviewViewController
{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3 //allValidContacts.count //objects.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
        let cell = tableView.dequeueReusableCellWithIdentifier("RatingTableViewCell", forIndexPath: indexPath) as! RatingTableViewCell
        
        
        return cell
        }
        if indexPath.row == 1
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("WriteReviewTableViewCell", forIndexPath: indexPath) as! WriteReviewTableViewCell
            return cell
        }
         let cell = tableView.dequeueReusableCellWithIdentifier("button", forIndexPath: indexPath) as! ClickTableViewCell
        cell.contentView.backgroundColor = bgColor
        cell.button.layer.borderWidth = 1.0
        cell.button.layer.borderColor = UIColor.blackColor().CGColor
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
       if indexPath.row == 1
            {
                return 100
        }
        if indexPath.row == 2
        {
            return 54
        }
        return 200
    }
    
    

    
    
    
}
