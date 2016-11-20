//
//  ChattingViewController.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 13/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit
import Darwin

let fmax = FLT_MAX


class DynamicTextView:UITextView
{
    var heightConstraint:NSLayoutConstraint?
    
    override func layoutSubviews()
    {
         super.layoutSubviews()
         self.setNeedsUpdateConstraints()
    }
    
    
    override func updateConstraints()
    {
        let max = CGFloat(fmax)
        let size = self.sizeThatFits(CGSize(width:self.bounds.size.width, height:max))
        
        if ((self.heightConstraint == nil))
        {
           self.heightConstraint =   NSLayoutConstraint(item: self, attribute:.Height , relatedBy:NSLayoutRelation.Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: size.height)
            self.addConstraint(self.heightConstraint!)
            
            
        }
        super.updateConstraints()
    }
    
}


class ChattingViewController: UIViewController, UITextViewDelegate
{
    @IBOutlet weak var  toolBar:UIToolbar!
    @IBOutlet weak var  chatTextView:DynamicTextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var constraintTextFieldBottom:NSLayoutConstraint?
    @IBOutlet weak var tableViewBottomConstant:NSLayoutConstraint?
    
    var contactID:String = ""
    
    var chatArray = [AnyObject]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.showKeyBoard(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.hideKeyBoard(_:)), name: UIKeyboardWillHideNotification, object: nil)
        self.toolBar.hidden = true
        self.chatArray.append("")
        self.chatArray.append("")
        self.chatArray.append("")
        self.chatArray.append("")

         
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



extension ChattingViewController
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return chatArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChattingTableViewCell", forIndexPath: indexPath) as! ChattingTableViewCell
            
            
            return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        return 57
    }

    
    
}

extension ChattingViewController
{
    func showKeyBoard(notification: NSNotification)
    {
        let dictInfo: NSDictionary = notification.userInfo!
        let kbFrame = dictInfo.objectForKey(UIKeyboardFrameEndUserInfoKey)
        let  animationDuration = dictInfo.objectForKey(UIKeyboardAnimationDurationUserInfoKey)?.doubleValue
        let  keyboardFrame: CGRect  = (kbFrame?.CGRectValue())!
        var  height:CGFloat =  keyboardFrame.size.height ;
        
        
      height   -=  (self.tabBarController?.tabBar.frame.size.height)!
        // Because the "space" is actually the difference between the bottom lines of the 2 views,
        // we need to set a negative constant value here.
        
        constraintTextFieldBottom!.constant -= height;
        tableViewBottomConstant!.constant = 0;
        
        self.view.setNeedsUpdateConstraints()
        
        // Update the layout before rotating to address the following issue.
        // https://github.com/ghawkgu/keyboard-sensitive-layout/issues/1
        /*if (self.currentOrientation != orientation) {
         [self.view layoutIfNeeded];
         }*/
        
        
        UIView.animateWithDuration(animationDuration!)
        {
            self.view.layoutIfNeeded()
            self.tableView.layoutIfNeeded()
            if self.chatArray.count > 0
            {
                let indexPath = NSIndexPath(forRow: self.chatArray.count - 1, inSection: 0)
                self.tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .Top)
                
            }
            
        }
        
    }
    
    
    func hideKeyBoard(notification: NSNotification)
    {
        let dictInfo: NSDictionary = notification.userInfo!
        let  animationDuration = dictInfo.objectForKey(UIKeyboardAnimationDurationUserInfoKey)?.doubleValue
        constraintTextFieldBottom!.constant = 0
        tableViewBottomConstant!.constant = 0;
        
        
        UIView.animateWithDuration(animationDuration!)
        {
            self.view.layoutIfNeeded()
        
        }
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    {
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

extension ChattingViewController
{
    
    func getChat()
    {
        self.view.showSpinner()
        
       DataSessionManger.sharedInstance.getChatConversationForID(self.contactID, page: "1", onFinish: { (response, deserializedResponse) in
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
        })
        
        }) { (error) in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
            })
            
        }
    }
    
}
