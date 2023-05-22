//
//  League.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import Foundation

class League : Codable{
    
    var league_key : Int?
    var league_name: String?
    var country_key : Int?
    var country_name : String?
    var league_logo : String?
    var country_logo: String?
    var sportName : String?
    
}

class LeaguesResult : Codable{
    
    var success : Int
    var result : [League]
    
}
