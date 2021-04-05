//
//  APIClient.swift
//  GithubIOSApp
//
//  Created by Mohamad Abdallah on 4/5/21.
//  Copyright © 2021 Abdallah. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import KRProgressHUD

class APIClient{
    

    static func fetchReposData(endpoint: Endpoint, completion: @escaping ([ReposItem]?, AFError?) -> Void){
        
        var reposData = [ReposItem]()
        let urlRequest = Helper.createURLRequest(endpoint: endpoint)
        
//        if !Reachability.isConnectedToNetwork() {
//           completion(nil, ServiceError.noInternetConnection)
//           return nil
//        }
        
        Alamofire.request(urlRequest).responseJSON { response in
                
            switch response.result{
                    
                case .success:
                    
                    let result = JSON(response.result.value!)
                    
                      if !result["items"].arrayValue.isEmpty {
                    
                        
                          result["items"].arrayValue.forEach { (res) in
                            
                              let item = ReposItem(name: res["name"].stringValue,
                                                  description: res["description"].stringValue,
                                                  avatar_url: res["owner"]["avatar_url"].stringValue,
                                                  stargazers_count: res["stargazers_count"].stringValue,
                                                  open_issues: res["open_issues"].stringValue,
                                                  owner: res["owner"]["login"].stringValue,
                                                  updated_at: res["updated_at"].stringValue,
                                                  created_at: res["created_at"].stringValue,
                                                  pushed_at: res["pushed_at"].stringValue)
                            
                              reposData.append(item)
                            }
                        
                                completion(reposData,nil)
                            
                      }
                      else {
                          completion(nil, nil)
                      }
                    
                case .failure(let error):
                      completion(nil, error as? AFError)
                }
                
        }
        
    }
    
}

