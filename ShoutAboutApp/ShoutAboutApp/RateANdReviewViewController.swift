//
//  RateANdReviewViewController.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 06/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit

class RateANdReviewViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, ClickTableViewCellProtocol
{
    @IBOutlet weak var tableView: UITableView!
     
    var activeTextView:UITextView?
    
    var person:SearchPerson = SearchPerson()
    
    var rating:String = "0"
    var review:String = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        //self.tableView.addBackGroundImageView()
        //self.tableView.backgroundColor = bgColor
        self.automaticallyAdjustsScrollViewInsets = false

         self.navigationController?.navigationBar.hidden = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.showKeyBoard(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.hideKeyBoard(_:)), name: UIKeyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer()
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(self.hideKeyBoard(_:)))
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
            //cell.contentView.backgroundColor = bgColor
            cell.button.layer.borderWidth = 1.0
            //cell.button.layer.borderColor = UIColor.blackColor().CGColor
            cell.delegate = self
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
        if indexPath.row == 0
        {
            return 150
        }
        
        if indexPath.row == 1
        {
                return 140
        }
        if indexPath.row == 2
        {
            return 54
        }
        
        if indexPath.row == 3
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
    func textViewDidBeginEditing(textView: UITextView)
    {
        activeTextView = textView
        textView.becomeFirstResponder()
    }
    
    
    /*
    - (void)textViewDidBeginEditing:(UITextView *)textView
    {
    // save the text view that is being edited
    
    if ([textView.text isEqualToString:NSLocalizedString(@"Add question", nil)] ||[textView.text isEqualToString:NSLocalizedString(@"Add answer", nil)] )
    {
    textView.text = @"";
    textView.textColor = [UIColor colorWithRed:39./255. green:39./255. blue:39./255. alpha:1.]; //optional
    }
    mActiveView = textView;
    [textView becomeFirstResponder];
    
    
    }*/
    
    
    func textViewDidEndEditing(textView: UITextView)
    {
        textView.resignFirstResponder()
    }
    /*
    - (void)textViewDidEndEditing:(UITextView *)textView
    {
    
    if ([textView.text isEqualToString:@"Add question"] ||[textView.text isEqualToString:@"Add answer"] )
    {
    textView.text = @"";
    textView.textColor = [UIColor lightGrayColor]; //optional
    
    [textView resignFirstResponder];
    }
    else
    {
    if (textView.tag == 1)
    {
    mQuestion = textView.text;
    }
    else if (textView.tag == 2)
    {
    mAnswer = textView.text;
    }
    
    }
    // release the selected text view as we don't need it anymore
    mActiveView = nil;
    }
    
    */
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    {
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
   


    func showKeyBoard(notification: NSNotification)
    {
        if ((activeTextView?.superview?.superview?.superview?.isKindOfClass(WriteReviewTableViewCell)) != nil)
        {
            if let cell = activeTextView?.superview?.superview?.superview as? WriteReviewTableViewCell
            {
               // let dictInfo: NSDictionary = notification.userInfo!
                //let kbSize :CGSize = (dictInfo.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue().size)!
                //let contentInsets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
               // self.tableView.contentInset = contentInsets
               // self.tableView.scrollIndicatorInsets = contentInsets
                self.tableView.scrollToRowAtIndexPath(self.tableView.indexPathForCell(cell)!, atScrollPosition: .Top, animated: true)
            }
        }
    }
    
    
    func hideKeyBoard(notification: NSNotification)
    {
        
        if  activeTextView != nil
        {
            let contentInsets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.tableView.contentInset = contentInsets
            self.tableView.scrollIndicatorInsets = contentInsets
            self.tableView.scrollToNearestSelectedRowAtScrollPosition(.Bottom, animated: true)
        }
    }

}

extension RateANdReviewViewController
{
    func buttonClicked(cell:ClickTableViewCell)
    {
        if self.tableView.indexPathForCell(cell) != nil
        {
            let indexPath = self.tableView.indexPathForCell(cell)
            
        }
    }
    
    func addLike()
    {
        
    }
    }
