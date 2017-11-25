//
//  HeaderViewCell.swift
//  Git-it
//
//  Created by Sayantan Chakraborty on 25/11/17.
//  Copyright © 2017 Sayantan Chakraborty. All rights reserved.
//

import UIKit

class HeaderViewCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView! = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 16
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var publicGists: UILabel!
    @IBOutlet weak var publicRepos: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
