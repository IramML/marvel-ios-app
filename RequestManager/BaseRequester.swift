//
//  BaseRequester.swift
//  RequestManager
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation

public class BaseRequester {
    let httpClient: HTTPClient
    
    public init(httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.httpClient = httpClient
    }
    
}
