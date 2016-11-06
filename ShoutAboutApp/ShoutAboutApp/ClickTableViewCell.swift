//
//  ClickTableViewCell.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 06/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit

protocol ClickTableViewCellProtocol
{
    func buttonClicked(cell:ClickTableViewCell)
}

class ClickTableViewCell: UITableViewCell
{
    @IBOutlet weak var button: UIButton!
    var delegate:ClickTableViewCellProtocol?
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        
    }
    
    @IBAction func buttonClicked(button:UIButton)
    {
        self.delegate?.buttonClicked(self)
    }

}
