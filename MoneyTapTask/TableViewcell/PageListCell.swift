//
//  PageListCell.swift
//  MoneyTapTask
//
//  Created by Anoop on 13/10/18.
//  Copyright © 2018 Anoop. All rights reserved.
//

import UIKit

class PageListCell: UITableViewCell {

    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
