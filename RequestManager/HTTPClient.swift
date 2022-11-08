//
//  HTTPClient.swift
//  RequestManager
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation
import Data
import CryptoKit

public protocol HTTPClient {
    func get<T: Codable>(url: String, parameters: [String: String], completion: @escaping (RemoteResult<T>) -> Void)
}

extension HTTPClient {
    func stringFromHttpParameters(_ paramenters: [String: String]) -> String {
        let parameterArray = paramenters.map { (key, value) -> String in
            let percentEscapedKey = stringByAddingPercentEncodingForURLQueryValue(key)!
            
            let percentEscapedValue = stringByAddingPercentEncodingForURLQueryValue(value)!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joined(separator: "&")
    }

    func stringByAddingPercentEncodingForURLQueryValue(_ str: String) -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        return str.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }

}
