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
    @IBOutlet weak var errorLabel: UILabel!
    var UserID:String?
    var ResponseMessage: String?

    
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
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        enum APIError:Error {
            case responseProblem
            case decodingProblem
            case encodingProblem
        }

        struct ResponseBody: Decodable{
            var message: String
            var name: String
            var email: String
            var _id: String
        }
        
            let session = URLSession(configuration: .default)
            let url = URL(string: "https://dev.tanzenmed.com/api/auth")!

            let UsernameFinal = Username.text!
            let PasswordFinal = Password.text!
            //Resigns the keyboard
            view.endEditing(true)
            do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                request.addValue("application/json",forHTTPHeaderField: "Content-Type")
                let json: [String: Any] = ["email": UsernameFinal, "password": PasswordFinal]
                let jsonData = try? JSONSerialization.data(withJSONObject: json)
                request.httpBody = jsonData
            print(String(data: request.httpBody!, encoding: .utf8)!)
            
                let dataTask = URLSession.shared.dataTask(with: request){data, response, _ in
                guard let jsonData = data else{

                    return
                    }
                do {
                    let userData = try JSONDecoder().decode(ResponseBody.self, from: jsonData)
    //                completion(.success(userData))
                    
                    // Saves the user id and message
                    self.UserID = userData._id
                    self.ResponseMessage = userData.message
                    print(self.ResponseMessage!, " was stored and so was ", self.UserID!)
                    
                    if self.ResponseMessage == Constants.Strings.successMessage{
                        DispatchQueue.main.async {
                            self.navigationController?.pushViewController(homeViewController!, animated: true)
                        }
                    }
                // Catching Errors
                }catch DecodingError.keyNotFound(let key, let context) {
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
                    if self.ResponseMessage == nil {
                        DispatchQueue.main.sync {
                            self.errorLabel.text = "Incorrect Email or Password"
                        }
                    }
                }
                dataTask.resume()
            }        
        }
    }


