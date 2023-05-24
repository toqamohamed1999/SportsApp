//
//  Helper.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import Foundation

let API_KEY = "57b39cb2a9e26b94227ea074cbcd0f4400f01cc3ccac93956639610ee12dfa69"

//format = 2024-01-18
func getCurrentDate() -> String{
    
    let date = Date()
    let dateFormatter = DateFormatter()
     
    dateFormatter.dateFormat = "yyyy-MM-dd"
     
    let result = dateFormatter.string(from: date)
    
    return result
}


func getFutureDate() -> String{
    
    let date = Date()
    
    var dateComponent = DateComponents()
    dateComponent.year = 1
    let futureDate = Calendar.current.date(byAdding: dateComponent, to: date)!
    
    let dateFormatter = DateFormatter()
     
    dateFormatter.dateFormat = "yyyy-MM-dd"
     
    let result = dateFormatter.string(from: futureDate)
    
    return result
}

func getPastDate() -> String{
    
    let date = Date()
    
    var dateComponent = DateComponents()
    dateComponent.year = -1
    
    let pastDate = Calendar.current.date(byAdding: dateComponent, to: date)!
    
    let dateFormatter = DateFormatter()
     
    dateFormatter.dateFormat = "yyyy-MM-dd"
     
    let result = dateFormatter.string(from: pastDate)
    
    return result
}

func getTeamPlaceolder(sportName : String) -> String{
    
    switch(sportName){
        
    case "Football" : return "soccer"
    case "Basketball" : return "basketballTeam"
    case "Cricket" : return "cricketTeam"
    case "Tennis" : return "tennisTeam"
   
    default:
        return "soccer"
    }
}

func getLeaguePlaceolder(sportName : String) -> String{
    
    print(sportName)
    
    switch(sportName){
        
    case "Football" : return "soccerLeague "
    case "Basketball" : return "basketLeague"
    case "Cricket" : return "cricketLeague"
    case "Tennis" : return "tennisLeague"
        
    default:
        return "soccerLeague"
    }
}

func getURL(fetchType : String,sportName : String = "", leagueId : Int = 0,
            eventType : String = "",teamKey : Int = 0) -> String{
    
    switch(fetchType){
      
    case "leagues" :  return "https://apiv2.allsportsapi.com/"+sportName+"/?met=Leagues&APIkey="+API_KEY
        
    case "upcoming" : return"https://apiv2.allsportsapi.com/"+sportName+"?met=Fixtures&leagueId="+String(leagueId)+"&from="+getCurrentDate()+"&to="+getFutureDate()+"&APIkey="+API_KEY
        
    case "latest" : return
        "https://apiv2.allsportsapi.com/"+sportName+"?met=Fixtures&leagueId="+String(leagueId)+"&from="+getPastDate()+"&to="+getCurrentDate()+"&APIkey="+API_KEY
        
    case "team" : return "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId="+String(teamKey)+"&APIkey="+API_KEY
        
    default:
        return ""
    
    }
}
