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

func buildRequest(_ userpass: UserPass, completion: @escaping(Result<ResponseBody, APIError>) -> Void){
    do {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try JSONEncoder().encode(userpass)
    print(String(data: request.httpBody!, encoding: .utf8)!)
    
        let dataTask = URLSession.shared.dataTask(with: request){data, response, _ in
        guard let httpresponse = response as? HTTPURLResponse, let
                jsonData = data else{
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
    }catch{
        completion(.failure(.encodingProblem))
        print("encoding problem")
        }
    }
}


//
//
//struct APIRequest {
//    let resourceURL: URL
//
//    init() {
//        let resourceString = "https://dev.tanzenmed.com/api/auth"
//        guard let resourceURL = URL(string: resourceString) else {fatalError()}
//        self.resourceURL = resourceURL
//    }
//
//
//
//    func request (_ userpassToRequest:UserPass, completion: @escaping(Result<UserPass, APIError>)) -> Void {
//
//    do {
//        var urlRequst = URLRequest(url: resourceURL)
//        urlRequst.httpMethod = "POST"
//        urlRequst.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        urlRequst.httpBody = try JSONEncoder().encode(userpassToRequest)
//
//        let dataTask = URLSession.shared.dataTask(with: urlRequst){ data, response, _ in
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else{
//                return
//            }
//            do {
//                let requestData = try JSONDecoder().decode(httpResponse, from: jsonData)
//            }
//        }
//
//        }
//    }
//}
