//
//  FavViewModel.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import Foundation


class FavViewModel{
    
    var networkManager : NetworkService!
    var myCoreData : MyCoreData!
    var bindStoredLeagues : (()->()) = {}
    
    var result : [League]!{
        didSet{
            bindStoredLeagues()
        }
    }
    
    
    init(networkManager: NetworkService ,myCoreData : MyCoreData) {
        self.networkManager = networkManager
        self.myCoreData = myCoreData
    }
    
    
    func getStoredLeagues(){
        
        result = myCoreData.getStoredLeagues()
    }
    
    func insertLeague(league : League){
        
        myCoreData.insertLeague(league : league)
    }
    
    func deleteLeague(league : League){
        
        myCoreData.deleteLeague(league : league)
    }
    
    
    
}
