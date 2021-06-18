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
    }

}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
