//
//  ComicsRepositoryTests.swift
//  DataTests
//
//  Created by Iram Martinez on 06/11/22.
//

import XCTest
@testable import Data
import Domain

final class ComicsRepositoryTests: XCTestCase {
    
    func test_getComicsWithSuccess() {
        let (repository, remoteDS, localDS) = makeSUT()
        
        var response: [Comic]? = nil
        let exp = expectation(description: "Wait for get comics completion")
        repository.getComics { (result: RemoteResult<[Comic]>) in
            switch result {
            case .success(let data):
                response = data
            case .failure(let error):
                XCTFail("Get comics got failure completion with error \(error)")
            }
            exp.fulfill()
        }
        let comics = [anyComic(), anyComic(), anyComic()]
        remoteDS.performGetComics(withSuccess: comics, byIndex: 0)
        wait(for: [exp], timeout: 2.0)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.count, comics.count)
        XCTAssertEqual(remoteDS.getComicsCompletions.count, 1)
        XCTAssertEqual(localDS.comicsCompletions, [])
    }
    
    func test_getComicsWithFailure() {
        let (repository, remoteDS, localDS) = makeSUT()
        
        var response: RemoteError? = nil
        let exp = expectation(description: "Wait for get comics completion")
        repository.getComics { (result: RemoteResult<[Comic]>) in
            switch result {
            case .success(let data):
                XCTFail("Get comics got success completion with data \(data)")
            case .failure(let error):
                response = error
            }
            exp.fulfill()
        }
        let error = anyRemoteError()
        remoteDS.performGetComics(withError: error, byIndex: 0)
        wait(for: [exp], timeout: 2.0)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(remoteDS.getComicsCompletions.count, 1)
        XCTAssertEqual(localDS.comicsCompletions, [])
    }
    
    // MARK - Helpers
    private func makeSUT() -> (repository: ComicsRepository, remoteDS: ComicsRemoteDataSourceSpy, localDS: ComicsLocalDataSourceSpy) {
        let remoteDS = ComicsRemoteDataSourceSpy()
        let localDS = ComicsLocalDataSourceSpy()
        let repository = ComicsRepository(comicsRemoteDataSource: remoteDS, comicsLocalDataSource: localDS)
        addTeardownBlock { [weak remoteDS, weak localDS, weak repository] in
            // Track memory leaks
            XCTAssertNil(remoteDS)
            XCTAssertNil(localDS)
            XCTAssertNil(repository)
        }
        return (repository, remoteDS, localDS)
    }
    
    private func anyComic() -> Comic {
        Comic(id: 0, digitalId: 0, title: "any", issueNumber: 0, variantDescription: "any", description: "any", modified: "any", isbn: "any", diamondCode: "any", format: "any", pageCount: "any", textObjects: ComicTextObject(type: "any", language: "any", text: "any"), series: ComicResource(resourceURI: "any", name: "any"), variants: [ComicResource(resourceURI: "any", name: "any")], collections: [ComicResource(resourceURI: "any", name: "any")], collectedIssues: [ComicResource(resourceURI: "any", name: "any")], dates: [ComicDate(type: "any", date: "any")], prices: [ComicPrice(type: "any", price: "any")], thumbnail: ComicImage(path: "any", extensionImg: "any"), images: [ComicImage(path: "any", extensionImg: "any")], creators: ComicCreators(available: 0, returned: 0, collectionURI: "any", items: [ComicCreatorsItem(resourceURI: "any", name: "any", role: "any")]))
    }
    
    private func anyRemoteError() -> RemoteError {
        .httpError
    }
    
}
