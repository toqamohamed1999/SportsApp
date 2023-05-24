//
//  MockNetworkManager.swift
//  Sports2Tests
//
//  Created by Mac on 24/05/2023.
//

import Foundation


import XCTest
@testable import Sports2

final class MockNetworkManager: XCTestCase {
    
    var networkManager :  NetworkService!
    
    override func setUpWithError() throws {
        
        networkManager = FakeNetwork<LeaguesResult>(shouldReturnError: false) //true = error
    }
    
    override func tearDownWithError() throws {
        
        networkManager = nil
    }
    
    
    func testfetchData(){
       
        var myResult : LeaguesResult!
        
        networkManager.fetchData(url: "", complition: {result in
            myResult = result
         
            if(myResult == nil){

                print("########## no data found")
                XCTFail()

            }else{

                XCTAssertNotNil(myResult)
                XCTAssertEqual(myResult.result.count, 1)
            }
        })

    }
                                 
                                 
    
    
  
}
