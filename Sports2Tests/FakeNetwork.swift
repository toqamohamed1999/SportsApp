//
//  FakeNetwork.swift
//  Sports2Tests
//
//  Created by Mac on 24/05/2023.
//

import Foundation
@testable import Sports2

class FakeNetwork<T : Decodable> {
    
    var shouldReturnError : Bool
    
    let jsonResponse = ""
//    {"success":1,"result":[{"league_key":4,"league_name":"UEFA Europa League","country_key":1,"country_name":"eurocups","league_logo":"https:\/\/apiv2.allsportsapi.com\/logo\/logo_leagues\/","country_logo":null},{"league_key":1,"league_name":"European Championship","country_key":1,"country_name":"eurocups","league_logo":null,"country_logo":null}]}
    
    
    init(shouldReturnError: Bool) {
        //true = error & false = data
        self.shouldReturnError = shouldReturnError
    }
}

extension FakeNetwork : NetworkService{
    
    func fetchData<T>(url: String, complition: @escaping (T?) -> ()) where T : Decodable, T : Encodable {
        
        if(!shouldReturnError){
            complition(jsonResponse as! T)

        }else{
            complition(nil)
        }
        
    }
    
}
