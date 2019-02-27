//
//  TableViewCell.swift
//  meme1
//
//  Created by sh da on 25/12/2018.
//  Copyright © 2018 sh da. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var imageViewT: UIImageView!
    @IBOutlet weak var tLabelT: UILabel!
    @IBOutlet weak var bLabelT: UILabel!
}
