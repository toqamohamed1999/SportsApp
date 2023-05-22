//
//  Teams.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import Foundation


class Team : Codable{
    
    var team_key : Int?
    var team_name : String?
    var team_logo : String?
    var players : [Player]?
    
    init(team_key: Int? = nil, team_name: String? = nil, team_logo: String? = nil) {
        self.team_key = team_key
        self.team_name = team_name
        self.team_logo = team_logo
    }
    
}


class TeamResult : Codable {
    
    var success : Int
    var result : [Team]
}
