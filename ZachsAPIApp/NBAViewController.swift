//
//  NBAViewController.swift
//  ZachsAPIApp
//
//  Created by  on 9/28/20.
//  Copyright © 2020 ZaCode. All rights reserved.
//

import UIKit

class NBAViewController: UIViewController {
    
    @IBOutlet weak var nbaTextField: UITextField!
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    
    let nbaDict = ["hawks": 1,
                  "celtics": 2,
                  "nets": 3,
                  "hornets": 4,
                  "bulls": 5,
                  "cavaliers": 6,
                  "mavericks": 7,
                  "nuggets": 8,
                  "pistons": 9,
                  "warriors": 10,
                  "rockets": 11,
                  "pacers": 12,
                  "clippers": 13,
                  "lakers": 14,
                  "memphis": 15,
                  "heat": 16,
                  "bucks": 17,
                  "timberwolves": 18,
                  "pelicans": 19,
                  "knicks": 20,
                  "thunder": 21,
                  "magic": 22,
                  "sixers": 23,
                  "76ers": 23,
                  "suns": 24,
                  "trail blazers": 25,
                  "kings": 26,
                  "spurs": 27,
                  "raptors": 28,
                  "jazz": 29,
                  "wizards": 30]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helpLabel.numberOfLines = 0
        helpLabel.text = "Enter the name of an NBA team to know their abbreviation, city, and conference.\n\nballdontlie.io/api/v1/teams/<ID>"
        helpLabel.textColor = UIColor.white
        
        teamLabel.numberOfLines = 0
        teamLabel.text = "Click on the NBA logo after typing a team. The NBA logo is the search button."
        teamLabel.textColor = UIColor.white
        
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        let searchText = nbaTextField.text!.lowercased()
        let keyExists = self.nbaDict[searchText] != nil
        
        if keyExists == true {
            let teamID = self.nbaDict[searchText]
            let newID = teamID! + 0
            let urlString = "http://balldontlie.io/api/v1/teams/\(newID)"
            if let url = URL(string: urlString)
            {
                
                let task = URLSession.shared.dataTask(with: url) {
                    (data, response, error) in
                    if let err = error {
                        print(err)
                        return
                    }

                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any]
                        let dictionary = json!
                        let city = dictionary["city"] as? String ?? "city error"
                        let abbreviation = dictionary["abbreviation"] as? String ?? "abbreviation error"
                        let conference = dictionary["conference"] as? String ?? "conference error"
                        
                        DispatchQueue.main.async {
                            self.teamLabel.text = "City: \(city)\nAbbreviation: \(abbreviation)\nConference: \(conference)"
                            self.view.endEditing(true)
                        }
                        print(json!)
                    } catch let jsonError {
                        print(jsonError)
                    }
                }
                task.resume()
            }

        }
        else {
           teamLabel.text = "Please type it in again. Team not found."
        }
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        helpLabel.text = "Enter the name of an NBA team to know their abbreviation, city, and conference.\n\nballdontlie.io/api/v1/teams/<ID>"
        
        teamLabel.text = "Click on the NBA logo after typing a team. The NBA logo is the search button."
        
        nbaTextField.text = ""
    }
    
}
