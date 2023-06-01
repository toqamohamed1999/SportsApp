//
//  FakeNetwork.swift
//  Sports2Tests
//
//  Created by Mac on 24/05/2023.
//

import Foundation
@testable import Sports2

class FakeNetwork<T : Codable>{
    
    var shouldReturnError : Bool
    
    let jsonResponse = """
        {
          "success": 1,
          "result": [
                {
                  "league_key": 4,
                  "league_name": "UEFA Europa League",
                  "country_key": 1,
                  "country_name": "eurocups",
                  "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/",
                  "country_logo": null
                }
            ]
        }
"""
    
    
    init(shouldReturnError: Bool) {
        //true = error & false = data
        self.shouldReturnError = shouldReturnError
    }
}

extension FakeNetwork : NetworkService{
    
    func fetchData<T : Codable>(url : String , complition : @escaping (T?) -> ()){
        let data = Data(jsonResponse.utf8)
        do{
            let result = try JSONDecoder().decode(T.self, from: data)
            complition(result)
        }catch let error{
            print(error.localizedDescription)
            complition(nil)
        }
    }
    
//    func fetchData(url: String, complition: @escaping ((T)?) -> ()) {
//
//        if(!shouldReturnError){
//            complition(jsonResponse)
//
//        }else{
//            complition(nil)
//        }
//
//    }
    
}
