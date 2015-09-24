//
//  ConwayTests.swift
//  ConwayTests
//
//  Created by Andy Bartholomew on 9/16/15.
//  Copyright © 2015 Andy Bartholomew. All rights reserved.
//

import XCTest
@testable import Conway

class ConwayTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCountNeighbors() {
        let life = LifeController()

        let board = [
            [true, true, true],
            [true, true, true],
            [true, true, true],
        ]
        
        let neighborCount = life.countNeighbors(board, i: 1, j: 1)
        XCTAssertEqual(neighborCount, 8)
    }

    func testMakeArray2D() {
        let grid = MakeArray2D(2, numPerRow: 3, value: true)
        
        let expected = [
            [true, true, true],
            [true, true, true],
        ]
        XCTAssertEqual(grid, expected)
    }
    
}
