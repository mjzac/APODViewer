//
//  APODModelTests.swift
//  APODViewer
//
//  Created by Melson Zacharias on 24/02/17.
//  Copyright © 2017 Perleybrook Labs LLC. All rights reserved.
//

import XCTest

import Argo
import Moya
import Moya_Argo

@testable import APODViewer

class APODModelTests: XCTestCase {
    
    let provider:MoyaProvider<NasaAPI> = MoyaProvider(stubClosure: { _ in return .immediate })
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDefaultAPIKeyIsDemoKey() {
        let config = NasaAPI.getAPODConfig()
        switch config {
        case .apod(let key,_,_):
            XCTAssertTrue(key == "DEMO_KEY")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
