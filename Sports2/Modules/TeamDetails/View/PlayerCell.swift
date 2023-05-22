//
//  PlayerCell.swift
//  Sports2
//
//  Created by Mac on 21/05/2023.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var playerNo: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
      //  img.makeRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
