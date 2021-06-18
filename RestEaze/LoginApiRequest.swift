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

func buildRequest(_ userpass: UserPass, completion: @escaping(Result<UserPass, APIError>) -> Void){
    do {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try JSONEncoder().encode(userpass)
    
        let dataTask = URLSession.shared.dataTask(with: request){data, response, _ in
        guard let httpresponse = response as? HTTPURLResponse, let
                jsonData = data else{
            completion(.failure(.responseProblem))
            print("response problem")
            return
            }
        do {
            let userData = try JSONDecoder().decode(UserPass.self, from: jsonData)
            completion(.success(userData))
        } catch{
            completion(.failure(.decodingProblem))
            print("decoding problem")
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
