//
//  NetworkConnection.swift
//  dust
//
//  Created by 신한섭 on 2020/04/01.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class NetworkConnection {
    class func request(resource: String, handlder: @escaping (Data) -> Void){
        let defaultSession = URLSession(configuration: .default)
        guard let url = URL(string: resource) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = defaultSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                print("Error occur: \(String(describing: error))")
                
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            handlder(data)
        }
        
        dataTask.resume()
    }
}
