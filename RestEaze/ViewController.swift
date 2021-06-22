//
//  ViewController.swift
//  RestEaze
//
//  Created by Ian Jones on 4/2/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // Variables that point to what the user enters
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Creates delegate objects out of the text fields
        Username.delegate = self
        Password.delegate = self
    }
    
    private func configureTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        print("Handle tap was called")
        view.endEditing(true)
    }
    
    // Creates delegate objects out of the text fields
    
    // Brings down the keyboard after clicking return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    @IBAction func LoginTapped(_ sender: Any) {
        let UsernameFinal = Username.text!
        let PasswordFinal = Password.text!
        //Resigns the keyboard
        view.endEditing(true)
        
        
        let postRequest = APIRequest()
        
        postRequest.buildRequest(UsernameFinal, password: PasswordFinal, completion: {result in
            switch result {
            case .success(_):
                print("Everything went smooth")
            case .failure(_):
                print("There was an error getting the results")
            }
        })
    }
    
}

