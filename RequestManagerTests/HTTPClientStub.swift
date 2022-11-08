//
//  HTTPClientStub.swift
//  MarvelComicsTests
//
//  Created by Iram Martinez on 07/11/22.
//

import XCTest
@testable import Data
@testable import Domain
@testable import RequestManager

final class HTTPClientStub: HTTPClient {
    private static var stub: Stub? = nil
    
    struct Stub {
        var result: Codable?
        var error: RemoteError?
    }
    
    func get<T: Codable>(url: String, parameters: [String : String], completion: @escaping (RemoteResult<T>) -> Void) {
        guard let stub = HTTPClientStub.stub, (stub.result != nil || stub.error != nil) else {
            completion(.failure(error: .httpError))
            return
        }
        
        if let result = stub.result {
            completion(.success(data: result as! T))
        } else if let error = stub.error {
            completion(.failure(error: error))
        } else {
            completion(.failure(error: .httpError))
        }
    }
    
    private func resetStub() {
        HTTPClientStub.stub = nil
    }
        
    static func stub(result: Codable?, error: RemoteError?) {
        self.stub = Stub(result: result, error: error)
    }
}
