//
//  ClothingTableViewCell.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 10/10/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class ClothingTableViewCell: UITableViewCell {

    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var descriptionCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
