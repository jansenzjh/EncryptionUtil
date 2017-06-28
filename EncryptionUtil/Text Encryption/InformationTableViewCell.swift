//
//  InformationTableViewCell.swift
//  EncryptionUtil
//
//  Created by Jansen on 6/18/17.
//  Copyright © 2017 Jansen. All rights reserved.
//

import UIKit

class InformationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDesc: UILabel!
    
    var informationGID : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
