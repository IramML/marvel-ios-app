//
//  ComicsRequester.swift
//  RequestManager
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation
import Data
import Domain

public class ComicsRequester: BaseRequester, ComicsRemoteDataSource {
    public func getComics(completion: @escaping (RemoteResult<[Comic]>) -> Void) {
        let timestamp = Int(Date().timeIntervalSince1970)
        let parametersString = [
            "api_key": RequestManagerConstants.publicKey,
            "hash": httpClient.MD5(string: "\(timestamp)\(RequestManagerConstants.privateKey)\(RequestManagerConstants.publicKey)"),
            "ts": "\(timestamp)"
        ]
        let urlStr = "\(RequestManagerConstants.baseURL)\(Endpoints.comics.path)"
        self.httpClient.get(url: urlStr, parameters: parametersString) { (result: RemoteResult<ComicsListResponse>) in
            switch result {
            case .success(let data):
                completion(.success(data: data.data.results.toDomain()))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}
