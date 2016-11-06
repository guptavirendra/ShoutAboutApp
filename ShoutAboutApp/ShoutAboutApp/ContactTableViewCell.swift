//
//  ContactTableViewCell.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 06/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit

protocol ContactTableViewCellProtocol {
    func buttonClicked(cell:ContactTableViewCell)
}

class ContactTableViewCell: UITableViewCell
{
     @IBOutlet weak var profileImageView: UIImageView!
     @IBOutlet weak var nameLabel: UILabel!
     @IBOutlet weak var mobileLabel: UILabel!
     @IBOutlet weak var ratingLabel: UILabel!
     @IBOutlet weak var callButton: UIButton!
     @IBOutlet weak var chaBbutton: UIButton!
     @IBOutlet weak var revieBbutton: UIButton!
    var delegate:ContactTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonClicked(button:UIButton)
    {
        self.delegate?.buttonClicked(self)
    }

}
