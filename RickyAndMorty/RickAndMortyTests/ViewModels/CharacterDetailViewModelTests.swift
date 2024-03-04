//
//  CharacterDetailViewModelTests.swift
//  RickAndMortyTests
//
//  Created by Victor Kreniski on 03/03/24.
//

import XCTest
import Combine
@testable import RickAndMorty

final class CharacterDetailViewModelTests: XCTestCase {

    private var sut: CharacterDetailViewModel!
    private var mockCharacterDetailRequester: MockCharacterDetailRequester!
    private var cancellable: Cancellable!
    
    override func setUp() {
        super.setUp()
        mockCharacterDetailRequester = .init(characterDetail: .mockRicky)
        sut = .init(
            character: .mockRicky,
            characterDetailRequester: mockCharacterDetailRequester
        )
    }
    
    override func tearDown() {
        sut = nil
        mockCharacterDetailRequester = nil
        cancellable = nil
        super.tearDown()
    }
    
    func testInitialValues() throws {
        let url = try XCTUnwrap(URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
        XCTAssertEqual(sut.character, .init(id: "1", imagePath: url, name: "Ricky Sanchez"))
    }
    
    func testOnTaskCalled() {
        
        let expectation: XCTestExpectation = .init(description: "Waiting for Details to be called")
        
        mockCharacterDetailRequester.requestDetailsCalledCallback = {
            expectation.fulfill()
        }

        sut.onTaskCalled()
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(mockCharacterDetailRequester.characterIDSent, "1")
    }
    
    func testOnTaskCalledCharacterValueUpdated() {
        
        let expectation: XCTestExpectation = .init(description: "Waiting for Character to be updated")
        
        cancellable = sut.objectWillChange.sink(receiveValue: { Void in
            expectation.fulfill()
        })

        sut.onTaskCalled()
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(sut.character, .mockRicky)
    }
    
    func testRequestViewModelForCharacter() throws {
        let otherViewModel = sut.requestViewModel(for: .mockRicky)
        let url = try XCTUnwrap(URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
        XCTAssertEqual(otherViewModel.character, .init(id: "1", imagePath: url, name: "Ricky Sanchez"))
    }
}

private extension CharacterDetailViewModelTests {
    final class MockCharacterDetailRequester: CharactersDetailRequester {
        enum Errors: Error {
            case mock
        }
                
        var shouldThrow: Error?
        var characterDetail: Character.Detail
        
        init(characterDetail: Character.Detail) {
            self.characterDetail = characterDetail
        }
        
        private(set) var characterIDSent: String?
        var requestDetailsCalledCallback: (() -> Void)?
        func requestDetails(characterID: String) async throws -> Character.Detail {
            defer { requestDetailsCalledCallback?() }
            characterIDSent = characterID
            if let shouldThrow {
                throw shouldThrow
            }
            return characterDetail
        }
    }
}
