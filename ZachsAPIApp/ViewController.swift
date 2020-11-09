//
//  ViewController.swift
//  ZachsAPIApp
//
//  Created by  on 9/25/20.
//  Copyright © 2020 ZaCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var helperLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var numberButton: UIButton!
    
    @IBOutlet weak var numberTextfield: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        helperLabel.numberOfLines = 0
        answerLabel.numberOfLines = 0
        
        helperLabel.text = "Enter a number or \"random\" for a fact.\n numbersapi.com/\"Number\""
        answerLabel.text = ""
    }

    @IBAction func buttonTapped(_ sender: UIButton)
    {
        // figure out how to grab data from the API...
        var urlString = "http://numbersapi.com/"
        urlString += numberTextfield.text!
        if let url = URL(string: urlString)
        {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                        
                 guard let data = data else { return }
                 let result = String(data: data, encoding: .utf8)!
                 print(String(data: data, encoding: .utf8)!)
                        
                 DispatchQueue.main.async {
                    self.answerLabel.text = result
                 }
             }
             task.resume()
         }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}

