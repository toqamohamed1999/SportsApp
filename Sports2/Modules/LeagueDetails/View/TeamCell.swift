//
//  TeamCell.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import UIKit

class TeamCell: UICollectionViewCell {
    
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img.makeRoundedWithoutBorder()

    }
}
