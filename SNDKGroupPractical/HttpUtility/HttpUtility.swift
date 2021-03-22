//
//  HttpUtility.swift
//  SNDKGroupPractical
//
//  Created by Manish Sharma on 21/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import Foundation

public struct HttpUtility {

    static let shared = HttpUtility()
    
    
    func userLogin(urlRequest: URLRequest, completion: @escaping (UserResponse) -> ()) {
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if (data != nil && data?.count != 0) {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let userDisplayName = try decoder.decode(UserResponse.self, from: data!)
                    print(userDisplayName)
                    completion(userDisplayName)
                } catch let jsonErr {
                    print(jsonErr.localizedDescription)
                }
            }
        }.resume()
    }

}
