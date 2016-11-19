//
//  MainSearchViewController.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 19/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit

class MainSearchViewController: UIViewController
{
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var searchButton:UIButton!
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
