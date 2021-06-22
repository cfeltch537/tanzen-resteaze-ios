//
//  apirequest.swift
//  RestEaze
//
//  Created by William Jones on 5/27/21.
//

import Foundation

enum APIError:Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct APIRequest {
    let session = URLSession(configuration: .default)
    let url = URL(string: "https://dev.tanzenmed.com/api/auth")!

    func buildRequest(_ email: String, password: String, completion: @escaping(Result<ResponseBody, APIError>) -> Void){
        do {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json",forHTTPHeaderField: "Content-Type")
            let json: [String: Any] = ["email": email, "password": password]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            request.httpBody = jsonData
        print(String(data: request.httpBody!, encoding: .utf8)!)
        
            let dataTask = URLSession.shared.dataTask(with: request){data, response, _ in
            guard let jsonData = data else{
                completion(.failure(.responseProblem))
                print("response problem")
                return
                }
                print("this is the json data: ", String(data: jsonData, encoding: .utf8)!)
            do {
                let userData = try JSONDecoder().decode(ResponseBody.self, from: jsonData)
                completion(.success(userData))
                print("this is the userData: ", userData)
                
            } catch DecodingError.keyNotFound(let key, let context) {
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


   
