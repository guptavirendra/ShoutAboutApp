//
//  ReviewTableViewCell.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 13/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell
{

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var ratingView: RatingControl!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var countLabel5: UILabel!
    @IBOutlet weak var countLabel4: UILabel!
    @IBOutlet weak var countLabel3: UILabel!
    
    @IBOutlet weak var countLabel2: UILabel!
    
    @IBOutlet weak var countLabel1: UILabel!
    
    
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
         view1.makeImageRounded()
         view2.makeImageRounded()
         view3.makeImageRounded()
         view4.makeImageRounded()
         view5.makeImageRounded()
         profileImageView.makeImageRounded()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
