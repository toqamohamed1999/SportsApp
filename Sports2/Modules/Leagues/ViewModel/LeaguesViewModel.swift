//
//  LeaguesViewModel.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import Foundation


class LeaguesViewModel{
    
    var networkManager : NetworkService!
    var bindResultToViewController : (()->()) = {}
    
    var result : [League]!{
        didSet{
            bindResultToViewController()
        }
    }
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    
   func getLeagues(sportName : String){
        
       networkManager.getLeagues(sportName: sportName,complition: { myRes in
           self.result = myRes
       })
    }
}
