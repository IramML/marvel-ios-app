//
//  ComicsRequesterTests.swift
//  MarvelComicsTests
//
//  Created by Iram Martinez on 07/11/22.
//

import XCTest
@testable import Domain
@testable import Data
@testable import RequestManager

final class ComicsRequesterTests: XCTestCase {
    func test_getComicsListWithSuccess() {
        let sut = makeSUT()
        
        let comicsList: ComicsListResponse = anyComicListResponse()
        HTTPClientStub.stub(result: comicsList, error: nil)
        
        var response: [Comic]? = nil
        let exp = expectation(description: "Wait for comics list completion")
        sut.getComics { (result: RemoteResult<[Comic]>) in
            switch result {
            case .success(let data):
                response = data
            case .failure(let error):
                XCTFail("Get comics got failure result \(error)")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2.0)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.count, comicsList.data.results.count)
    }
    
    func test_getComicsListWithFailure() {
        let sut = makeSUT()
        
        let error: RemoteError = anyRemoteError()
        HTTPClientStub.stub(result: nil, error: error)
        
        var response: RemoteError? = nil
        let exp = expectation(description: "Wait for comics list completion")
        sut.getComics { (result: RemoteResult<[Comic]>) in
            switch result {
            case .success(let data):
                XCTFail("Get comics got success result \(data)")
            case .failure(let error):
                response = error
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2.0)
        
        XCTAssertNotNil(response)
    }
    
    // MARK - Helpers
    private func makeSUT() -> ComicsRequester {
        let httpClient = HTTPClientStub()
        let requester = ComicsRequester(httpClient: httpClient)
        
        addTeardownBlock { [weak httpClient, weak requester] in
            XCTAssertNil(httpClient)
            XCTAssertNil(requester)
        }
        
        return requester
    }
    
    private func anyComicListResponse() -> ComicsListResponse {
        ComicsListResponse(data: ComicsListResponseData(results: [anyComic(), anyComic(), anyComic()]))
    }
    
    private func anyComic() -> RemoteComic {
        RemoteComic(id: 0, digitalId: 0, title: "any", issueNumber: 0, variantDescription: "any", description: "any", modified: "any", isbn: "any", diamondCode: "any", format: "any", pageCount: "any", textObjects: RemoteComicTextObject(type: "any", language: "any", text: "any"), series: RemoteComicResource(resourceURI: "any", name: "any"), variants: [RemoteComicResource(resourceURI: "any", name: "any")], collections: [RemoteComicResource(resourceURI: "any", name: "any")], collectedIssues: [RemoteComicResource(resourceURI: "any", name: "any")], dates: [RemoteComicDate(type: "any", date: "any")], prices: [RemoteComicPrice(type: "any", price: "any")], thumbnail: RemoteComicImage(path: "any", extensionImg: "any"), images: [RemoteComicImage(path: "any", extensionImg: "any")], creators: RemoteComicCreators(available: 0, returned: 0, collectionURI: "any", items: [RemoteComicCreatorsItem(resourceURI: "any", name: "any", role: "any")]))
    }
    
    private func anyRemoteError() -> RemoteError {
        .httpError
    }
}
