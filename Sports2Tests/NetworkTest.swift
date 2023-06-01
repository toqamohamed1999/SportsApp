//
//  NetworkTest.swift
//  Sports2Tests
//
//  Created by Mac on 01/06/2023.
//

import XCTest
@testable import Sports2

final class NetworkTest : XCTestCase {
    
    var networkManager :  NetworkService!

    override func setUpWithError() throws {
        
        networkManager = NetworkManager()
    }

    override func tearDownWithError() throws {
        
        networkManager = nil
    }

  
    func testLoadData(){
        
        var leaguesArr : [League]!
        let myExpectation = expectation(description: "Waiting for API data")
        
        networkManager.fetchData(url : "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=57b39cb2a9e26b94227ea074cbcd0f4400f01cc3ccac93956639610ee12dfa69"){(it : LeaguesResult?) in
                
                if(it == nil){
                    
                    print("########## no data found")
                    XCTFail()
                    
                }else{
                    
                    leaguesArr =  it?.result ?? [League]()
                    
                    XCTAssertEqual(leaguesArr.count, 785)
                    myExpectation.fulfill()
                }
        }
        waitForExpectations(timeout: 10)
    }

}
