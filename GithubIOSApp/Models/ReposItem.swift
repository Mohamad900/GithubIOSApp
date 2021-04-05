//
//  ReposItem.swift
//  GithubIOSApp
//
//  Created by user on 4/5/21.
//  Copyright © 2021 Abdallah. All rights reserved.
//

import UIKit

class ReposItem {
    var name, description , avatar_url: String
    var stargazers_count , open_issues: String
    var owner, updated_at, created_at, pushed_at: String
    var image: UIImage!
    
    init(name: String, description: String, avatar_url: String, stargazers_count: String, open_issues: String,  owner: String, updated_at: String, created_at: String, pushed_at: String) {
        self.name = name
        self.description = description
        self.avatar_url = avatar_url
        self.stargazers_count = stargazers_count
        self.open_issues = open_issues
        self.owner = owner
        self.updated_at = updated_at
        self.created_at = created_at
        self.pushed_at = pushed_at
    }
}
