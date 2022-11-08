//
//  AddFavoriteComicUseCaseTests.swift
//  UseCaseTests
//
//  Created by Iram Martinez on 07/11/22.
//

import XCTest
@testable import Data
@testable import UseCase
@testable import Domain

final class AddFavoriteComicUseCaseTests: XCTestCase {
    func test_addComicWithSuccess() {
        let (useCase, localDS) = makeSUT()
        
        var responseData: Bool? = nil
        var responseError: LocalError? = nil
        let exp = expectation(description: "Wait for add comic to favorite completion")
        let comic = anyComic()
        useCase.invoke(comic: comic) { (result: LocalResult<Bool>) in
            switch result {
            case .success(let data):
                responseData = data
            case .failure(let error):
                responseError = error
            }
            exp.fulfill()
        }
        
        localDS.perform(.addComic, withSuccess: true, byIndex: 0)
        wait(for: [exp], timeout: 2.0)
        
        XCTAssertNotNil(responseData)
        XCTAssertNil(responseError)
    }

    func test_getComicWithFailure() {
        let (useCase, localDS) = makeSUT()
        
        var responseData: Bool? = nil
        var responseError: LocalError? = nil
        let exp = expectation(description: "Wait for add comic to favorite completion")
        let comic = anyComic()
        useCase.invoke(comic: comic) { (result: LocalResult<Bool>) in
            switch result {
            case .success(let data):
                responseData = data
            case .failure(let error):
                responseError = error
            }
            exp.fulfill()
        }
        let error = anyLocalError()
        localDS.perform(.addComic, withError: error, byIndex: 0)
        wait(for: [exp], timeout: 2.0)
        
        XCTAssertNil(responseData)
        XCTAssertNotNil(responseError)
    }

    // Mark - Helpers
    private func makeSUT() -> (useCase: AddFavoriteComicUseCase, localDS: ComicsLocalDataSourceSpy) {
        let remoteDS = ComicsRemoteDataSourceSpy()
        let localDS = ComicsLocalDataSourceSpy()
        let repository = ComicsRepository(comicsRemoteDataSource: remoteDS, comicsLocalDataSource: localDS)
        let useCase = AddFavoriteComicUseCase(comicsRepository: repository)
        addTeardownBlock { [weak remoteDS, weak localDS, weak repository, weak useCase] in
            // Track for memory leaks
            XCTAssertNil(remoteDS)
            XCTAssertNil(localDS)
            XCTAssertNil(repository)
            XCTAssertNil(useCase)
        }
        return (useCase, localDS)
    }

    private func anyComic() -> Comic {
        Comic(id: 0, digitalId: 0, title: "any", issueNumber: 0, variantDescription: "any", description: "any", modified: "any", isbn: "any", diamondCode: "any", format: "any", pageCount: 0, textObjects: [ComicTextObject(type: "any", language: "any", text: "any")], series: ComicResource(resourceURI: "any", name: "any"), variants: [ComicResource(resourceURI: "any", name: "any")], collections: [ComicResource(resourceURI: "any", name: "any")], collectedIssues: [ComicResource(resourceURI: "any", name: "any")], dates: [ComicDate(type: "any", date: "any")], prices: [ComicPrice(type: "any", price: 0)], thumbnail: ComicImage(path: "any", extensionImg: "any"), images: [ComicImage(path: "any", extensionImg: "any")], creators: ComicCreators(available: 0, returned: 0, collectionURI: "any", items: [ComicCreatorsItem(resourceURI: "any", name: "any", role: "any")]))
    }

    private func anyLocalError() -> LocalError {
        .databaseError
    }
}
