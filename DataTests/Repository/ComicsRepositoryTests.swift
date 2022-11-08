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
    
    enum ComicsRepositoryCompletion {
        case getComics
        case getFavoriteComics
        case getFavoriteComic
        case addFavoriteComic
        case removeFavoriteComic
    }
    
    func test_getComicsWithSuccess() {
        let comics = [anyComic(), anyComic(), anyComic()]
        perform(.getComics, data: comics, error: nil, then: { (response: [Comic]?, error: RemoteError?) in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.count, comics.count)
        })
    }
    
    func test_getComicsWithFailure() {
        let error = anyRemoteError()
        perform(.getComics, data: nil, error: error, then: { (response: [Comic]?, error: RemoteError?) in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
        })
    }
    
    func test_getFavoriteComicsWithSuccess() {
        let comics = [anyComic(), anyComic(), anyComic()]
        perform(.getFavoriteComics, data: comics, error: nil, then: { (response: [Comic]?, error: LocalError?) in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.count, comics.count)
        })
    }
    
    func test_getFavoriteComicsWithFailure() {
        let error = anyLocalError()
        perform(.getFavoriteComics, data: nil, error: error, then: { (response: [Comic]?, error: LocalError?) in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
        })
    }
    
    func test_getFavoriteComicWithSuccess() {
        let comic = anyComic()
        perform(.getFavoriteComic, data: comic, error: nil, then: { (response: Comic?, error: LocalError?) in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.id, comic.id)
        })
    }
    
    func test_getFavoriteComicWithFailure() {
        let error = anyLocalError()
        perform(.getFavoriteComic, data: nil, error: error, then: { (response: Comic?, error: LocalError?) in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
        })
    }
    
    func test_addFavoriteComicWithSuccess() {
        let added = true
        perform(.addFavoriteComic, data: added, error: nil, then: { (response: Bool?, error: LocalError?) in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            XCTAssertEqual(response, added)
        })
    }
    
    func test_addFavoriteComicWithFailure() {
        let error = anyLocalError()
        perform(.addFavoriteComic, data: nil, error: error, then: { (response: Bool?, error: LocalError?) in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
        })
    }
    
    func test_removeFavoriteComicWithSuccess() {
        let removed = true
        perform(.removeFavoriteComic, data: removed, error: nil, then: { (response: Bool?, error: LocalError?) in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            XCTAssertEqual(response, removed)
        })
    }
    
    func test_removeFavoriteComicWithFailure() {
        let error = anyLocalError()
        perform(.removeFavoriteComic, data: nil, error: error, then: { (response: Bool?, error: LocalError?) in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
        })
    }
    
    func perform<T>(_ comicsRepositoryCompletion: ComicsRepositoryCompletion, data: T?, error: RemoteError?, then: @escaping (T?, RemoteError?) -> Void) {
        let (repository, remoteDS, _) = makeSUT()
        
        let exp = expectation(description: "Wait for completion")
        var responseData: T? = nil
        var responseError: RemoteError? = nil
        switch comicsRepositoryCompletion {
        case .getComics:
            repository.getComics { (result: RemoteResult<[Comic]>) in
                switch result {
                case .success(let data):
                    responseData = data as? T
                case .failure(let error):
                    responseError = error
                }
                exp.fulfill()
            }
            if let data = data {
                remoteDS.performGetComics(withSuccess: data as! [Comic], byIndex: 0)
            }
            if let error = error {
                remoteDS.performGetComics(withError: error, byIndex: 0)
            }
            
        case .getFavoriteComics:
            break
        case .getFavoriteComic:
            break
        case .addFavoriteComic:
            break
        case .removeFavoriteComic:
            break
        }
        wait(for: [exp], timeout: 2.0)
        
        then(responseData, responseError)
    }
    
    func perform<T>(_ comicsRepositoryCompletion: ComicsRepositoryCompletion, data: T?, error: LocalError?, then: @escaping (T?, LocalError?) -> Void) {
        let (repository, _, localDS) = makeSUT()
        
        let exp = expectation(description: "Wait for completion")
        var responseData: T? = nil
        var responseError: LocalError? = nil
        switch comicsRepositoryCompletion {
        case .getComics:
            break
        case .getFavoriteComics:
            repository.getFavoriteComics { (result: LocalResult<[Comic]>) in
                switch result {
                case .success(let data):
                    responseData = data as? T
                case .failure(let error):
                    responseError = error
                }
                exp.fulfill()
            }
            if let data = data {
                localDS.perform(.getComics, withSuccess: data, byIndex: 0)
            }
            if let error = error {
                localDS.perform(.getComics, withError: error, byIndex: 0)
            }
        case .getFavoriteComic:
            repository.getFavoriteComic(byId: 0) { (result: LocalResult<Comic?>) in
                switch result {
                case .success(let data):
                    responseData = data as? T
                case .failure(let error):
                    responseError = error
                }
                exp.fulfill()
            }
            if let data = data {
                localDS.perform(.getComic, withSuccess: data, byIndex: 0)
            }
            if let error = error {
                localDS.perform(.getComic, withError: error, byIndex: 0)
            }
        case .addFavoriteComic:
            repository.addFavoriteComic(comic: anyComic()) { (result: LocalResult<Bool>) in
                switch result {
                case .success(let data):
                    responseData = data as? T
                case .failure(let error):
                    responseError = error
                }
                exp.fulfill()
            }
            if let data = data {
                localDS.perform(.addComic, withSuccess: data, byIndex: 0)
            }
            if let error = error {
                localDS.perform(.addComic, withError: error, byIndex: 0)
            }
        case .removeFavoriteComic:
            repository.removeFavoriteComic(byId: 0) { (result: LocalResult<Bool>) in
                switch result {
                case .success(let data):
                    responseData = data as? T
                case .failure(let error):
                    responseError = error
                }
                exp.fulfill()
            }
            if let data = data {
                localDS.perform(.removeComic, withSuccess: data, byIndex: 0)
            }
            if let error = error {
                localDS.perform(.removeComic, withError: error, byIndex: 0)
            }
        }
        wait(for: [exp], timeout: 2.0)
        
        then(responseData, responseError)
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
        Comic(id: 0, digitalId: 0, title: "any", issueNumber: 0, variantDescription: "any", description: "any", modified: "any", isbn: "any", diamondCode: "any", format: "any", pageCount: 0, textObjects: [ComicTextObject(type: "any", language: "any", text: "any")], series: ComicResource(resourceURI: "any", name: "any"), variants: [ComicResource(resourceURI: "any", name: "any")], collections: [ComicResource(resourceURI: "any", name: "any")], collectedIssues: [ComicResource(resourceURI: "any", name: "any")], dates: [ComicDate(type: "any", date: "any")], prices: [ComicPrice(type: "any", price: 20)], thumbnail: ComicImage(path: "any", extensionImg: "any"), images: [ComicImage(path: "any", extensionImg: "any")], creators: ComicCreators(available: 0, returned: 0, collectionURI: "any", items: [ComicCreatorsItem(resourceURI: "any", name: "any", role: "any")]))
    }
    
    private func anyRemoteError() -> RemoteError {
        .httpError
    }
    
    private func anyLocalError() -> LocalError {
        .databaseError
    }
    
}
