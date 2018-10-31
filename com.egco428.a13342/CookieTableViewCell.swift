//
//  CookieTableViewCell.swift
//  com.egco428.a13342
//
//  Created by Kanta'MacPro on 31/10/2561 BE.
//  Copyright © 2561 Kanta'MacPro. All rights reserved.
//

import UIKit

class CookieTableViewCell: UITableViewCell {
    //MARK Properties
    @IBOutlet weak var fortuneResult: UILabel!
    @IBOutlet weak var fortuneDate: UILabel!
    @IBOutlet weak var cookieImage: UIImageView!
    @IBOutlet weak var fortuneTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
