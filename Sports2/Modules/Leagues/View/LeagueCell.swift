//
//  LeagueCell.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import UIKit

class LeagueCell: UITableViewCell {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var player_no: UILabel!
    @IBOutlet weak var myView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    //self.makeBorder()
       myView.makeBorder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
                
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

       // contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    


}


extension UIView{
    
    func makeBorder(){
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 30
        clipsToBounds = true
    }
}
