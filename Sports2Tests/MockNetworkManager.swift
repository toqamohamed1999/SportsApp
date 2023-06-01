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
    
    var networkManager :  FakeNetwork<LeaguesResult>!
    
    override func setUpWithError() throws {
        
        networkManager = FakeNetwork(shouldReturnError: false) //true = error
    }
    
    override func tearDownWithError() throws {
        
        networkManager = nil
    }
    
    
    func testfetchData(){
        
        networkManager.fetchData(url : ""){(it : LeaguesResult?) in
            
            if(it == nil){

                print("########## no data found")
                XCTFail()

            }else{
                XCTAssertNotNil(it)
              //  XCTAssertEqual(result.result.count, 1)
            }
            
        }
        

    }
                                 
                                 
    
    
  
}
