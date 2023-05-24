//
//  TeamsDetailsViewModel.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import Foundation

class TeamDetailsViewModel<T : Codable>{
    
    var networkManager : NetworkService!
    var bindTeamDetails : (()->()) = {}
    
    var result : T!{
        didSet{
            bindTeamDetails()
        }
    }
    
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    
    func getTeamDetails(teamKey : Int){
        
        let url = getURL(fetchType: "team", teamKey: teamKey)
        
        networkManager.fetchData(url: url, complition: { myRes in
            self.result = myRes
        })
    }
    
}
