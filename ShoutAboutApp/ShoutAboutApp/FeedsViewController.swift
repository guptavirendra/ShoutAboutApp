//
//  FeedsViewController.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 06/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit

class FeedsViewController: UIViewController
{

   @IBOutlet weak var tableView:UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedsTableViewCell", forIndexPath: indexPath) as? FeedsTableViewCell
            cell?.contentView.setGraphicEffects()
         
        return cell!
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("MyFeedsTableViewCell", forIndexPath: indexPath) as? FeedsTableViewCell
        cell?.contentView.setGraphicEffects()
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.row == 0
        {
            return 160
        }
        return 210
    }

     

}
