//
//  LeaguesViewModel.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import Foundation


class LeaguesViewModel<T : Codable>{
    
    var networkManager : NetworkService!
    var bindResultToViewController : (()->()) = {}
    
    var result : T!{
        didSet{
            bindResultToViewController()
        }
    }
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    
   func getLeagues(sportName : String){
       
       let url = getURL(fetchType: "leagues", sportName: sportName)
        
       networkManager.fetchData(url : url,complition: { myRes in
           self.result = myRes
       })
    }
}
