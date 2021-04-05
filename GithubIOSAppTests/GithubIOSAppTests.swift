//
//  GithubIOSAppTests.swift
//  GithubIOSAppTests
//
//  Created by Mohamad Abdallah on 4/5/21.
//  Copyright © 2021 Abdallah. All rights reserved.
//

import XCTest
@testable import GithubIOSApp

class GithubIOSAppTests: XCTestCase {

   override func setUp() {
           super.setUp()
       }

       override func tearDown() {
           super.tearDown()
       }
       
    func testInvalidDate() {
           
            var expectedResponse:[ReposItem]? = nil
            let getReposEndPoint = EndpointCases.getReposData(page: 1, date: "2222-33-55")
            let excpetion = self.expectation(description: "Network call failed.")
            
            APIClient.fetchReposData(endpoint: getReposEndPoint, completion: { (repos, error) in
                     expectedResponse = repos
                     excpetion.fulfill()
            })
            
            waitForExpectations(timeout: 5, handler: nil)
            XCTAssertNil(expectedResponse)
         
         }
       
       func testInvalidDateFormat() {
                  
          var expectedResponse:[ReposItem]? = nil
          let getReposEndPoint = EndpointCases.getReposData(page: 1, date: "03-2021-05")
          let excpetion = self.expectation(description: "Network call failed.")
          
           APIClient.fetchReposData(endpoint: getReposEndPoint, completion: { (repos, error) in
                   expectedResponse = repos
                   excpetion.fulfill()
          })
          
          waitForExpectations(timeout: 5, handler: nil)
           XCTAssertNil(expectedResponse)
       
       }
       
       func testEmptyListOfRepos_InavlidPageNumber() {
              
             var expectedResponse:[ReposItem]? = nil
              let date = Helper.GetSubstractedTodayDate(days: 30)
              let getReposEndPoint = EndpointCases.getReposData(page: -100, date: date)
              let excpetion = self.expectation(description: "Network call failed.")
                    
              APIClient.fetchReposData(endpoint: getReposEndPoint, completion: { (repos, error) in
                         expectedResponse = repos
                         excpetion.fulfill()
                })
              
              waitForExpectations(timeout: 5, handler: nil)
              XCTAssertNotNil(expectedResponse)
          
          }
       
       func testHasRepos() {
           
           var expectedResponse:[ReposItem]? = nil
           let date = Helper.GetSubstractedTodayDate(days: 30)
           let getReposEndPoint = EndpointCases.getReposData(page: 1, date: date)
           let excpetion = self.expectation(description: "Network call failed.")
           
           APIClient.fetchReposData(endpoint: getReposEndPoint, completion: { (repos, error) in
                    expectedResponse = repos
                    excpetion.fulfill()
           })
           
           waitForExpectations(timeout: 5, handler: nil)
           XCTAssertNotNil(expectedResponse)
       
       }

}
