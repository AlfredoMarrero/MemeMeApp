//
//  MemeTableViewCell.swift
//  MemeMe_app
//
//  Created by Alfredo M. on 1/24/17.
//  Copyright © 2017 Alfredo. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

   
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet var memedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
