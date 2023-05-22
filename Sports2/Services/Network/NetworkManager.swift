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
    
    func getLeagues(sportName : String, complition : @escaping ([League]) -> ())
    
    func getEvents(sportName : String, leagueId : Int, eventType : String, complition : @escaping ([Event]) -> ())
    
    func getTeamDetails(teamKey : Int, complition : @escaping ([Team]) -> ())
}

class NetworkManager : NetworkService {
    
    let API_KEY = "57b39cb2a9e26b94227ea074cbcd0f4400f01cc3ccac93956639610ee12dfa69"
    
    static let sharedInstance = NetworkManager()
    
    func getLeagues(sportName : String, complition : @escaping ([League]) -> ()){
        
        let url = "https://apiv2.allsportsapi.com/"+sportName+"/?met=Leagues&APIkey="+API_KEY
        
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response{ resp in
                switch resp.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode(LeaguesResult.self, from: data!)
                        
                        complition(jsonData.result)
                        
                       
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    complition([])
                }
            }
        
    }
    
    func getEvents(sportName : String, leagueId : Int, eventType : String, complition : @escaping ([Event]) -> ()){
        
        var url = ""
        if(eventType.elementsEqual("future")){
            url = "https://apiv2.allsportsapi.com/"+sportName+"?met=Fixtures&leagueId="+String(leagueId)+"&from="+getCurrentDate()+"&to="+getFutureDate()+"&APIkey="+API_KEY
            

        }else{
            url = "https://apiv2.allsportsapi.com/"+sportName+"?met=Fixtures&leagueId="+String(leagueId)+"&from="+getPastDate()+"&to="+getCurrentDate()+"&APIkey="+API_KEY
            
        }
        
     //  print("####################### "+url)
                
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response{ resp in
                switch resp.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode(EventResult.self, from: data!)
                        
                        complition(jsonData.result)
                        
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    complition([])
                }
            }
        
    }
    
    func getTeamDetails(teamKey : Int, complition : @escaping ([Team]) -> ()){
        
        let url = "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId="+String(teamKey)+"&APIkey="+API_KEY
                
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response{ resp in
                switch resp.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode(TeamResult.self, from: data!)
                        
                        complition(jsonData.result)
                        
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    complition([])
                }
            }
        
    }
}
