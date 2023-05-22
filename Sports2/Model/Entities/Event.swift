//
//  Event.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import Foundation

class Event : Codable {
    
    var event_key : Int?
    var event_date : String?
    var event_time : String?
    var event_home_team : String?
    var home_team_key : Int?
    var event_away_team : String?
    var away_team_key : Int?
    var league_name : String?
    var league_key : Int?
    var home_team_logo : String?
    var away_team_logo : String?
    var league_logo : String?
    var event_final_result : String?

    
}

class EventResult : Codable {
    
    var success : Int
    var result : [Event]
    
}
