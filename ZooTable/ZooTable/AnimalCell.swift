//
//  AnimalCell.swift
//  ZooTable
//
//  Created by Shridevi Sawant on 05/04/23.
//

import UIKit

class AnimalCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
