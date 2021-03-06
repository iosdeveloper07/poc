//
//  POCTests.swift
//  POCTests
//
//  Created by Shashank on 21/07/20.
//  Copyright © 2020 Shashank. All rights reserved.
//

import XCTest
@testable import POC

class POCTests: XCTestCase {
    var controller: ItemListViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ItemListViewController") as? ItemListViewController else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }
        controller = vc
        controller.loadViewIfNeeded()
        
    }
    
    override func tearDown() {
          // Put teardown code here. This method is called after the invocation of each test method in the class.
      }
    
    func testAllDataLoaded(){
        var array : [Any] = []
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: Constant.KConstant.url)!
        let expectation = XCTestExpectation(description: "GET \(url)")
        
        let task = session.dataTask(with: url) { data, response, error in
            // if there is no error for this  response
            
            guard error == nil else {
                print ("error: \(error!)")
                XCTAssert(false,"giving error") // Here StatusCode is accessible inside the block
                expectation.fulfill()
                return
            }
            // if there is some data  from this  response
            guard let content = data else {
                print("there is no data")
                XCTAssert(false,"if the data from server is empty") // Here StatusCode is accessible inside the block
                           
                expectation.fulfill()
                return
            }
            let str_data = String(data: content, encoding: .isoLatin1)?.data(using: .utf8)
            // serialise the data  into Dictionary
            guard let json = (try? JSONSerialization.jsonObject(with: str_data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                XCTAssert(false,"Not containing JSON") // Here StatusCode is accessible inside the block
                expectation.fulfill()
                
                return
            }
            print("json response dictionary is \n \(json)")
            if let array_data = json["rows"] as? [Any]{
                array = array_data
                XCTAssertGreaterThan(array.count, 0)
            }

        }
        task.resume()
    }
    
    func testControllerHasTableView() {
         XCTAssertNotNil(controller.tblViewItem,
                         "Controller should have a tableview")
     }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
