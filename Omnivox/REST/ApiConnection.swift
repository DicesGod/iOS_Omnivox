//
//  ApiConnection.swift
//  Omnivox
//
//  Created by english on 2019-07-18.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit

class ApiConnection {
    
    func getJsonEntities(withURL url: String, callback: @escaping (HTTPURLResponse, [[String: Any]]) -> ()) {
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                        if let json = json, let httpResponse = response as? HTTPURLResponse {
                            DispatchQueue.main.sync {
                                callback(httpResponse, json)
                            }
                        }
                    } catch let error as NSError {
                        print("Cannot convert response body to Json!")
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
        }
    }
    
    func postJsonEntity(withForm form: ApiJsonForm, callback: @escaping (HTTPURLResponse) -> ()) {
        if let url = URL(string: form.getURL()) {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            if let data = form.getJsonData() {
                request.httpBody = data
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let httpResponse = response as? HTTPURLResponse {
                        DispatchQueue.main.sync {
                            callback(httpResponse)
                        }
                    }
                }
                task.resume()
            }
        }
    }
}

protocol ApiJsonForm {
    
    func getURL() -> String
    
    func getJsonData() -> Data?
}
