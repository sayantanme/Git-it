//
//  RepoDetailsCell.swift
//  Git-it
//
//  Created by Sayantan Chakraborty on 25/11/17.
//  Copyright © 2017 Sayantan Chakraborty. All rights reserved.
//

import UIKit

class RepoDetailsCell: UITableViewCell {

    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var detailsText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
