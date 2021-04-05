//
//  Endpoint.swift
//  GithubIOSApp
//
//  Created by Mohamad Abdallah on 4/5/21.
//  Copyright © 2021 Abdallah. All rights reserved.
//



import Foundation

protocol Endpoint {
    var httpMethod: String { get }
    var baseURLString: String { get }
    var path: String { get }
    var headers: [String: Any]? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    // a default extension that creates the full URL
    var url: String {
        return baseURLString + path
    }
}

enum HTTPRequestMethod: String {
       case get = "GET"
       case post = "POST"
       case put = "PUT"
       case delete = "DELETE"
   }

enum EndpointCases: Endpoint {
    
    case getReposData(page:Int, date:String)
    
    var httpMethod: String {
        switch self {
        case .getReposData:
            return HTTPRequestMethod.get.rawValue
        }
    }
    
    var baseURLString: String {
        switch self {
        case .getReposData:
            return "https://api.github.com/"
        }
    }
    
    var path: String {
        switch self {
        case .getReposData(let page, let date):
            return "search/repositories?q=created:%3E" + date + "&sort=stars&order=desc&page=" + String(page)
        }
    }
    
    var headers: [String: Any]? {
        switch self {
        case .getReposData:
            return ["Content-Type": "application/json",
                    "Accept": "application/json"]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .getReposData:
            return [:]
        }
    }
}
