//
//  PushNetwork.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import Foundation

extension Network {
    
    func push<T: Decodable>(api: Network.Api, postData:Data?, type: T.Type, completion:@escaping(ErrorCode, T?) -> ()) {
        var request = URLRequest(url: URL(string:api.path)!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = api.method
        request.httpBody = postData
        
        let notInternet = "The Internet connection appears to be offline."
        var code = 100
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            //response
            if let httpResponse = response as? HTTPURLResponse { code = httpResponse.statusCode }
            
            //data
            guard let data = data else {
                if let error = error, error.localizedDescription == notInternet {
                    completion(ErrorCode(99), nil)
                    return
                }
                completion(ErrorCode(code), nil)
                return
            }
            
           print(String(data: data, encoding: .utf8)!)
            guard let object = try? JSONDecoder().decode(type.self, from: data) else {completion(ErrorCode(101), nil); return}
            completion(ErrorCode(200), object)
        }
        task.resume()
    }
}
