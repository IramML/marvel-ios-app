//
//  URLSessionHTTPClient.swift
//  RequestManager
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation
import Data
import Domain

public class URLSessionHTTPClient: HTTPClient {
    
    public init() { }

    public func get<T: Codable>(url: String, parameters: [String : String], completion: @escaping (RemoteResult<T>) -> Void) {
        let parameterString = stringFromHttpParameters(parameters)
        let urlStr = "\(url)?\(parameterString)"
        
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        var urlRequest = URLRequest(url: URL(string: urlStr)!)
        
        urlRequest.cachePolicy = .returnCacheDataDontLoad
        
        if Reachability.isConnectedToNetwork() {
            urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        }

        urlSession.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(.failure(error: .httpError))
                return
            }
            let decoder = JSONDecoder()
            
            if let response = try? decoder.decode(T.self, from: data) {
                completion(.success(data: response))
            } else {
                completion(.failure(error: .castingError))
            }
            
        }.resume()
    }
    
    
}
