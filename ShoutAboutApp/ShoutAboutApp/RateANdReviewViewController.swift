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
     
    var activeTextField:UITextField?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.backgroundColor = bgColor

         self.navigationController?.navigationBar.hidden = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.showKeyBoard(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.hideKeyBoard(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
}

extension RateANdReviewViewController
{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5 //allValidContacts.count //objects.count
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
        
        if indexPath.row == 2
        {
             let cell = tableView.dequeueReusableCellWithIdentifier("button", forIndexPath: indexPath) as! ClickTableViewCell
            cell.contentView.backgroundColor = bgColor
            cell.button.layer.borderWidth = 1.0
            cell.button.layer.borderColor = UIColor.blackColor().CGColor
            return cell
        }
        
        if indexPath.row == 3
        {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReviewTableViewCell", forIndexPath: indexPath) as! ReviewTableViewCell
        return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UesrReviewTableViewCell", forIndexPath: indexPath) as! UesrReviewTableViewCell
        
        cell.commentLabel.text = "sdsddfffffggggfgfgfgfgfggfgfgfgfgfgfsdsjhkkdsfkdfskkdfkfdsjkkdfkkfdskfdskkdfkkkfdkkfdkdfkfdk"
        
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
        if indexPath.row == 0
        {
            return 250
        }
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.row == 1
        {
            return 100
        }
        if indexPath.row == 2
        {
            return 54
        }
        if indexPath.row == 0
        {
            return 250
        }
        
        return 100
    }
}

extension RateANdReviewViewController
{
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
