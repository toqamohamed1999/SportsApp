//
//  LeagueDetailsViewModel.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import Foundation


class LeagueDetailsViewModel<T : Codable>{
    
    var networkManager : NetworkService!
    var myCoreData : MyCoreData!
    var bindUpcomingEvents : (()->()) = {}
    var bindPreviousEvents : (()->()) = {}
    
    var upcomingResult : T!{
        didSet{
            bindUpcomingEvents()
        }
    }
    
    var previousResult : T!{
        didSet{
            bindPreviousEvents()
        }
    }
    
    init(networkManager: NetworkService ,myCoreData : MyCoreData) {
        self.networkManager = networkManager
        self.myCoreData = myCoreData
    }
    
    
   func getUpcomingEvents(sportName : String, leagueId : Int){
       
       let url = getURL(fetchType: "upcoming" , sportName: sportName, leagueId: leagueId)
        
       networkManager.fetchData(url : url ,complition: { myRes in
           self.upcomingResult = myRes
       })
    }
    
    func getPreviousEvents(sportName : String, leagueId : Int){
         
        let url = getURL(fetchType: "latest" , sportName: sportName, leagueId: leagueId)
         
        networkManager.fetchData(url : url ,complition: { myRes in
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
