//
//  RepoTableViewCell.swift
//  Github
//
//  Created by Mohamad Abdallah on 4/5/21.
//  Copyright © 2021 Abdallah. All rights reserved.
//

import UIKit
import AlamofireImage

class RepoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgRepo: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    
    @IBOutlet weak var viewStar: UIView!
    @IBOutlet weak var labelStar: UILabel!
    
    @IBOutlet weak var viewIssues: UIView!
    @IBOutlet weak var labelIssues: UILabel!
    
    @IBOutlet weak var labelSubmitBy: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgRepo.layer.cornerRadius = 6
        imgRepo.contentMode = .scaleAspectFill
        imgRepo.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
        viewStar.layer.borderWidth = 1
        viewStar.layer.cornerRadius = 5
        viewStar.layer.borderColor = UIColor.lightGray.cgColor
        
        viewIssues.layer.borderWidth = 1
        viewIssues.layer.cornerRadius = 5
        viewIssues.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    var data: ReposItem! {
        didSet {
            labelName.text = data.name
            labelDesc.text = data.description
            
            labelStar.text = "Stars: " + Helper.numberFormater(data.stargazers_count)
            labelIssues.text = "Issues: " + Helper.numberFormater(data.open_issues)
            
            labelSubmitBy.text = "Submitted " + getDuration(data.created_at) + " by " + data.owner
            
            imgRepo.image = nil
            if data.image == nil {
                let escapedString = (data.avatar_url).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                if let url = URL(string: escapedString!){
                    self.imgRepo.af_setImage(withURL: url, completion : { response in
                        self.data.image = response.value
                    })
                }
            }
            else {
                self.imgRepo.image = data.image
            }
        }
    }
    
    
    func getDuration(_ dateString: String) -> String {
        var result = ""
        
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formater.locale = Locale(identifier: "en")
        
        if let date = formater.date(from: dateString){
            // print("getDuration date: ",date)
            
            let diffDate = Date(timeIntervalSince1970: Date().timeIntervalSince1970 - date.timeIntervalSince1970)
            let components = Calendar.current.dateComponents([.year, .month, .day], from: diffDate)
            var year = components.year ?? 0
            var month = components.month ?? 0
            var day = components.day ?? 0
            
            if year >= 1970 {
                year = year - 1970
            }
            
            if month >= 1 {
                month = month - 1
            }
            
            if day >= 1 {
                day = day - 1
            }
            
            if year != 0 {
                result = "\(year) Year, "
            }
            
            if month != 0 {
                result += "\(month) Month, "
            }
            
            if day != 0 || result.isEmpty {
                result += "\(day) Day"
            }
            
            if result == "0 Day" {
                result = "today"
            }
            
            if (String(result.last ?? Character(""))) == "," {
                result.removeLast()
            }
        }
        else {
            result = dateString
        }
        
        return result
    }
    
}
