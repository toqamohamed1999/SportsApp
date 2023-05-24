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
    
    func changeData(event : Event ,sportName  :String, eventType : String){
        
        var placeHolder = getTeamPlaceolder(sportName: sportName)
        
        let imgUrl = URL(string: event.home_team_logo ?? placeHolder)
        img1?.kf.setImage(
            with: imgUrl,
            placeholder: UIImage(named: placeHolder))
        
        let imgUrl2 = URL(string: event.away_team_logo ?? placeHolder)
        img2?.kf.setImage(
            with: imgUrl2,
            placeholder: UIImage(named: placeHolder))
        
        teamName1.text = event.event_home_team ?? "Unknown name"
        teamName2.text = event.event_away_team ?? "Unknown name"
        dateLabel.text = event.event_date
        if(eventType == "upcoming"){
            timeLabel.text = event.event_time
        }else{
            timeLabel.text = event.event_final_result
        }
    }

}


