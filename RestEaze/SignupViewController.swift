//
//  SignupViewController.swift
//  RestEaze
//
//  Created by William Jones on 4/2/21.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var NewUserPassword: UITextField!
    @IBOutlet weak var NewUserPasswordConfirm: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Name.delegate = self
        Email.delegate = self
        NewUserPassword.delegate = self
        NewUserPasswordConfirm.delegate = self
    }

    
    private func configureTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        print("Handle tap was called")
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func SignUpClicked(_ sender: Any) {
        //resigns keyboard
        view.endEditing(true)
        
        //struct for the api response
        struct SignupResponseBody: Decodable {
            var message: String
        }
        
        // creates a url session
        let session = URLSession(configuration: .default)
        let url = URL(string: "https://dev.tanzenmed.com/api/users")!
        
        //
        let passwordFinal: String
        let nameFinal = Name.text!
        let emailFinal = Email.text!
        
        // makes sure passwords match
        if NewUserPassword.text == NewUserPasswordConfirm.text{
            passwordFinal = NewUserPassword.text!
        }
        else{
            errorLabel.text = "Passwords must match"
            return
        }
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json",forHTTPHeaderField: "Content-Type")
            let json: [String: Any] = ["name": nameFinal, "email": emailFinal, "password": passwordFinal]
            let signupData = try? JSONSerialization.data(withJSONObject: json)
            request.httpBody = signupData
            //var dataTask = URLSessionDataTask()
            let dataTask = URLSession.shared.dataTask(with: request){data, response, _ in
            guard let jsonData = data else{
                return
                }
            do {
                let apiResponse = try JSONDecoder().decode(SignupResponseBody.self, from: jsonData)
                print(apiResponse.message)
                if apiResponse.message == Constants.Errors.nameShort {
                        DispatchQueue.main.sync {
                            self.errorLabel.textColor = UIColor.red
                            self.errorLabel.text = Constants.Strings.nameLength
                        }
                    
                }
                if apiResponse.message == "A verification email has been sent to \(emailFinal)." {
                    DispatchQueue.main.sync {
                        self.errorLabel.textColor = UIColor.green
                        self.errorLabel.text = "verification email has been sent. Follow the instructions in the email to verify your account"
                    }

                }
                if apiResponse.message == Constants.Errors.nameError{
                    DispatchQueue.main.sync {
                        self.errorLabel.textColor = UIColor.red
                        self.errorLabel.text = Constants.Strings.nameEmpty
                    }
                }
                if apiResponse.message == Constants.Errors.passwordError{
                    DispatchQueue.main.sync {
                        self.errorLabel.textColor = UIColor.red
                        self.errorLabel.text = Constants.Strings.passwordEmpty
                    }
                }
                if apiResponse.message == Constants.Errors.emailError{
                    DispatchQueue.main.sync {
                        self.errorLabel.textColor = UIColor.red
                        self.errorLabel.text = Constants.Strings.emailEmpty
                    }
                }
                    }
            catch DecodingError.keyNotFound(let key, let context) {
                Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
            } catch DecodingError.valueNotFound(let type, let context) {
                Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.typeMismatch(let type, let context) {
                Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.dataCorrupted(let context) {
                Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
            } catch let error as NSError {
                NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            }
            
                
                }
            dataTask.resume()
            }
        }

        }
