//
//  CryptoUtils.swift
//  currency
//
//  Created by Tanya Koldunova on 11.03.2022.
//


import Foundation

class APIManager {
    
    class func jsonGetRequest<T>(url: String, returningType: T.Type, completion: @escaping (T?, Error?)->Void) where T: Codable {
            guard let url = URL(string: url) else {return}
            var request = URLRequest(url: url)
            request.timeoutInterval=15
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let data = data else { completion(nil, nil); return }
                do {
                    let res = try JSONDecoder().decode(returningType.self, from: data)
                    completion(res, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
            task.resume()
        }
    
    
     func testData(url: String, completion: @escaping (Data?, Error?)->Void)  {
        guard let url = URL(string: url) else {return}
        var request = URLRequest(url: url)
        request.timeoutInterval=15
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
            }
            guard let data = data else { completion(nil, nil); return }
            completion(data, nil)
        }
        task.resume()
    }
        

}
