//
//  TeamsDetailsViewModel.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import Foundation

class TeamDetailsViewModel{
    
    var networkManager : NetworkService!
    var bindTeamDetails : (()->()) = {}
    
    var result : [Team]!{
        didSet{
            bindTeamDetails()
        }
    }
    
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    
    func getTeamDetails(teamKey : Int){
        
        networkManager.getTeamDetails(teamKey : teamKey, complition: { myRes in
            self.result = myRes
        })
    }
    
}
