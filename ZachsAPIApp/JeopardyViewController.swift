//
//  JeopardyViewController.swift
//  ZachsAPIApp
//
//  Created by  on 9/26/20.
//  Copyright © 2020 ZaCode. All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController {

    @IBOutlet weak var apiLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerTextfield: UITextField!
    
    var answer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLabel.text = ""
        answerLabel.text = ""
        
        displayLabel.numberOfLines = 0
        answerLabel.numberOfLines = 0
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton)
    {
        if answerTextfield.text?.lowercased() == answer.lowercased()
        {
            answerLabel.text = "CORRECT!\n\(answer)"
            view.backgroundColor = UIColor.green
            
        }
        else
        {
            answerLabel.text = "INCORRECT!\n\(answer)"
            view.backgroundColor = UIColor.red
        }
        
        
    }
    
    @IBAction func questionButton(_ sender: UIButton)
    {
        answerLabel.text = ""
        let urlString = "http://jservice.io/api/random"
        
        if let url = URL(string: urlString)
        {
            let task = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                if let err = error {
                    print(err)
                    return
                }

                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String: Any]]
                    
                    let dictionary = json![0]
                    let theQuestion = dictionary["question"] as? String ?? "clue error"
                    self.answer = dictionary["answer"] as? String ?? "answer error"
                    DispatchQueue.main.async {
                        
                        self.displayLabel.text = theQuestion
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

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?)
    {
        displayLabel.text = ""
        answerLabel.text = ""
        answerTextfield.text = ""
        view.backgroundColor = UIColor.systemBlue
    }
}
