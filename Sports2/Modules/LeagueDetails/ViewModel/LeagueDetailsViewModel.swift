//
//  LeagueDetailsViewModel.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import Foundation


class LeagueDetailsViewModel{
    
    var networkManager : NetworkService!
    var myCoreData : MyCoreData!
    var bindUpcomingEvents : (()->()) = {}
    var bindPreviousEvents : (()->()) = {}
    
    var upcomingResult : [Event]!{
        didSet{
            bindUpcomingEvents()
        }
    }
    
    var previousResult : [Event]!{
        didSet{
            bindPreviousEvents()
        }
    }
    
    init(networkManager: NetworkService ,myCoreData : MyCoreData) {
        self.networkManager = networkManager
        self.myCoreData = myCoreData
    }
    
    
   func getUpcomingEvents(sportName : String, leagueId : Int){
        
       networkManager.getEvents(sportName: sportName,leagueId: leagueId, eventType: "future" ,complition: { myRes in
           self.upcomingResult = myRes
       })
    }
    
    func getPreviousEvents(sportName : String, leagueId : Int){
         
        networkManager.getEvents(sportName: sportName,leagueId: leagueId, eventType: "past" ,complition: { myRes in
            self.previousResult = myRes
        })
     }
    
    func insertLeague(league : League){
        
        myCoreData.insertLeague(league : league)
     }
    
    func isLeagueExist(league : League) -> Bool{
        
        return myCoreData.isLeagueExist(league : league)
    }
    
    func deleteLeague(league : League){
        
        myCoreData.deleteLeague(league : league)
    }
}
