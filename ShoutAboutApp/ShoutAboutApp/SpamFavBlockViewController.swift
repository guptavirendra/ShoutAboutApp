//
//  SpamFavBlockViewController.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 08/01/17.
//  Copyright © 2017 VIRENDRA GUPTA. All rights reserved.
//

import UIKit

class SpamFavBlockViewController: UIViewController
{
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
