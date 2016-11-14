//
//  EditProfileTableViewCell.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 13/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit

protocol EditProfileTableViewCellProtocol
{
    func editButtonClickedForCell(cell:EditProfileTableViewCell)
}

class EditProfileTableViewCell: UITableViewCell
{
    @IBOutlet weak var  titleLabel:UILabel!
    @IBOutlet weak var  dataLabel :UILabel!
    @IBOutlet weak var editButton:UIButton!
    var delegate:EditProfileTableViewCellProtocol?
 
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func editButtonClicked(button:UIButton)
    {
        self.delegate?.editButtonClickedForCell(self)
    }

}
