//
//  GetComicsUseCaseTests.swift
//  UseCaseTests
//
//  Created by Iram Martinez on 07/11/22.
//

import XCTest
@testable import Data
@testable import UseCase
@testable import Domain

final class GetComicsUseCaseTests: XCTestCase {
    
    func test_getComicsWithSuccess() {
        let (useCase, remoteDS) = makeSUT()
        
        var responseData: [Comic]? = nil
        var responseError: RemoteError? = nil
        let exp = expectation(description: "Wait for get comics completion")
        useCase.invoke { (result: RemoteResult<[Comic]>) in
            switch result {
            case .success(let data):
                responseData = data
            case .failure(let error):
                responseError = error
            }
            exp.fulfill()
        }
        let comics = [anyComic(), anyComic(), anyComic()]
        remoteDS.performGetComics(withSuccess: comics, byIndex: 0)
        wait(for: [exp], timeout: 2.0)
        
        XCTAssertNotNil(responseData)
        XCTAssertNil(responseError)
        XCTAssertEqual(responseData?.count, comics.count)
    }
    
    func test_getComicsWithFailure() {
        let (useCase, remoteDS) = makeSUT()
        
        var responseData: [Comic]? = nil
        var responseError: RemoteError? = nil
        let exp = expectation(description: "Wait for get comics completion")
        useCase.invoke { (result: RemoteResult<[Comic]>) in
            switch result {
            case .success(let data):
                responseData = data
            case .failure(let error):
                responseError = error
            }
            exp.fulfill()
        }
        let error = anyRemoteError()
        remoteDS.performGetComics(withError: error, byIndex: 0)
        wait(for: [exp], timeout: 2.0)
        
        XCTAssertNil(responseData)
        XCTAssertNotNil(responseError)
    }

    // Mark - Helpers
    private func makeSUT() -> (useCase: GetComicsUseCase, remoteDS: ComicsRemoteDataSourceSpy) {
        let remoteDS = ComicsRemoteDataSourceSpy()
        let localDS = ComicsLocalDataSourceSpy()
        let repository = ComicsRepository(comicsRemoteDataSource: remoteDS, comicsLocalDataSource: localDS)
        let useCase = GetComicsUseCase(comicsRepository: repository)
        addTeardownBlock { [weak remoteDS, weak localDS, weak repository, weak useCase] in
            // Track for memory leaks
            XCTAssertNil(remoteDS)
            XCTAssertNil(localDS)
            XCTAssertNil(repository)
            XCTAssertNil(useCase)
        }
        return (useCase, remoteDS)
    }
    
    private func anyComic() -> Comic {
        Comic(id: 0, digitalId: 0, title: "any", issueNumber: 0, variantDescription: "any", description: "any", modified: "any", isbn: "any", diamondCode: "any", format: "any", pageCount: "any", textObjects: ComicTextObject(type: "any", language: "any", text: "any"), series: ComicResource(resourceURI: "any", name: "any"), variants: [ComicResource(resourceURI: "any", name: "any")], collections: [ComicResource(resourceURI: "any", name: "any")], collectedIssues: [ComicResource(resourceURI: "any", name: "any")], dates: [ComicDate(type: "any", date: "any")], prices: [ComicPrice(type: "any", price: "any")], thumbnail: ComicImage(path: "any", extensionImg: "any"), images: [ComicImage(path: "any", extensionImg: "any")], creators: ComicCreators(available: 0, returned: 0, collectionURI: "any", items: [ComicCreatorsItem(resourceURI: "any", name: "any", role: "any")]))
    }
    
    private func anyRemoteError() -> RemoteError {
        .httpError
    }
}
