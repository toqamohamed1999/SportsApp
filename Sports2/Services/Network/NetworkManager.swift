//
//  NetworkManager.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

//My API KEY = 57b39cb2a9e26b94227ea074cbcd0f4400f01cc3ccac93956639610ee12dfa69
//https://apiv2.allsportsapi.com/football/?met=Teams&?met=Leagues&leagueId=4&APIkey=key

import Foundation
import Alamofire
import SwiftUI

protocol NetworkService{
    
    func fetchData<T : Codable>(url : String , complition : @escaping (T?) -> ())
}

class NetworkManager : NetworkService {
    
    static let sharedInstance = NetworkManager()

    
    func fetchData<T : Codable>(url : String , complition : @escaping (T?) -> ()){
                        
        print("#############"+url)
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response{ resp in
                switch resp.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode(T.self, from: data!)
                        
                        complition(jsonData)
                        
                        
                    } catch {
                        print(error.localizedDescription)
                        complition(nil)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    complition(nil)
                }
            }
    }
}
