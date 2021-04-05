//
//  Helper.swift
//  GithubIOSApp
//
//  Created by Mohamad Abdallah on 4/5/21.
//  Copyright © 2021 Abdallah. All rights reserved.
//

import Foundation

class Helper{
    
    static func GetSubstractedTodayDate (days:Int) -> String{
        
       let formater = DateFormatter()
       formater.dateFormat = "yyyy-MM-dd"
       formater.locale = Locale(identifier: "en")
        
       let date = Calendar.current.date(byAdding: .day, value: -days, to: Date())
       return formater.string(from: date!)
    }
    
    static func createURLRequest(endpoint: Endpoint) -> URLRequest{
        
       // URL
       let url = URL(string: endpoint.url)!
       var urlRequest = URLRequest(url: url)

       // HTTP Method
       urlRequest.httpMethod = endpoint.httpMethod

       // Header fields
       endpoint.headers?.forEach({ header in
           urlRequest.setValue(header.value as? String, forHTTPHeaderField: header.key)
       })
        return urlRequest
    }
}
