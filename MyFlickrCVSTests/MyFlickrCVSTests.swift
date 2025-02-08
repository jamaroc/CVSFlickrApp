//
//  MyFlickrCVSTests.swift
//  MyFlickrCVSTests
//
//  Created by Jesus Amaro on 2/7/25.
//

// MyFlickrCVSMockTests.swift
// MyFlickrCVSTests

// MyFlickrCVSMockTests.swift
// MyFlickrCVSTests

import XCTest
@testable import MyFlickrCVS

final class MyFlickrCVSMockTests: XCTestCase {

    var mockService: MockFlickrService!
    
    override func setUpWithError() throws {
        // Initialize mock service before each test
        mockService = MockFlickrService()
    }

    override func tearDownWithError() throws {
        // Clean up after each test
        mockService = nil
    }

    func testSearchImages() throws {
        // Given
        let expectation = self.expectation(description: "Searching images")
        var results: [ImageModel]?
        mockService.searchImagesResult = .success([ImageModel(title: "Test Image", description: "Desc", author: "Author", published: Date(), imageURL: URL(string: "https://via.placeholder.com/150")!)])
        
        // When
        mockService.searchImages(query: "test") { result in
            results = try? result.get()
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(results)
        XCTAssertEqual(results?.count, 1)
        XCTAssertEqual(results?.first?.title, "Test Image")
    }
}

// Mock service implementation
class MockFlickrService: FlickrAPIService {
    var searchImagesResult: Result<[ImageModel], Error>?
    
    override func searchImages(query: String, completion: @escaping (Result<[ImageModel], Error>) -> Void) {
        if let result = searchImagesResult {
            completion(result)
        }
    }
}
