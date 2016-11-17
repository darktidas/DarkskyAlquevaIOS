//
//  InfoTableViewCell.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 09/10/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class PhenomenaTableViewCell: UITableViewCell {

    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var descriptionCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
