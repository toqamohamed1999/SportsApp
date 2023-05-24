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
    
    func changeData(team : Team, sportName :String){
        
        let imgUrl = URL(string: team.team_logo ?? getTeamPlaceolder(sportName: sportName))
        img?.kf.setImage(
        with: imgUrl,
        placeholder: UIImage(named: getTeamPlaceolder(sportName: sportName)))

        nameLabel.text = team.team_name
        
    }
}
