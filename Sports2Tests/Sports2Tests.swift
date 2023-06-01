//
//  Sports2Tests.swift
//  Sports2Tests
//
//  Created by Mac on 24/05/2023.
//

import XCTest
@testable import Sports2
//Helper  file methods test

final class Sports2Tests: XCTestCase {

    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
    
    }
    
    func testGetCurrentDate(){
        
        let res = getCurrentDate()
        
        XCTAssertNotNil(res)
        XCTAssertEqual(res.count, 10)
    }
    
    
    func testGetTeamPlaceolder(){
        
        let res = getTeamPlaceolder(sportName: "Tennis")
        
        //print("##############  \(res)")
        XCTAssertNotNil(res)
        XCTAssertEqual(res, "tennisTeam")
    }
    
    func testGetTeamPlaceolderDefault(){
        
        let res = getTeamPlaceolder(sportName: "basket")
        
        XCTAssertNotNil(res)
        XCTAssertEqual(res, "soccer")
    }
    
    func testGetLeaguePlaceholder(){
        
        let res = getLeaguePlaceolder(sportName: "Football")
        
        XCTAssertNotNil(res)
        XCTAssertEqual(res, "soccerLeague ")
    }
    
    func testURL(){
        
        let res = getURL(fetchType: "teams")
        
        XCTAssertEqual(res, "")
    }

}
