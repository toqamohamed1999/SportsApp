//
//  EventCell.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import UIKit

class EventCell: UICollectionViewCell {
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var teamName1: UILabel!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var teamName2: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.makeBorder()
       // img1.makeRoundedWithoutBorder()
        //img2.makeRoundedWithoutBorder()

    }

    
    override func layoutSubviews() {
        super.layoutSubviews()

    //    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

}


