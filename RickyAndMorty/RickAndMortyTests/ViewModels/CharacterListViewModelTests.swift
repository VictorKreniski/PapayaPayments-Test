//
//  CharacterListViewModelTests.swift
//  RickAndMortyTests
//
//  Created by Victor Kreniski on 03/03/24.
//

import XCTest
import Combine
@testable import RickAndMorty

final class CharacterListViewModelTests: XCTestCase {

    private var sut: CharactersListViewModel!
    private var spyPaginationRequester: SpyPaginationRequester!
    private var mockCharacterObserver: MockCharactersObserver!
    private var cancellable: Cancellable!
    
    override func setUp() {
        super.setUp()
        
        spyPaginationRequester = .init()
        mockCharacterObserver = .init(characters: [.mockRicky])
        
        sut = .init(
            paginationRequester: spyPaginationRequester,
            charactersObserver: mockCharacterObserver
        )
    }
    
    override func tearDown() {
        sut = nil
        spyPaginationRequester = nil
        mockCharacterObserver = nil
        cancellable = nil
        super.tearDown()
    }
    
    func testErrorInitialValue() {
        XCTAssertNil(sut.error)
    }
    
    func testCurrentCharacters() {
        XCTAssertEqual(sut.currentCharacters, [])
        
        let expectation = XCTestExpectation(description: "Waiting for observer to receive changes")
        
        cancellable = sut.objectWillChange.sink(receiveValue: { Void in
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(sut.currentCharacters, [.mockRicky])
    }
    
    func testCurrentCharactersWhenTextIsInvalid() {
        sut.searchText = "Quentin Tarantino is the best :)"
        
        XCTAssertEqual(sut.currentCharacters, [])
    }
    
    func testCurrentCharactersWhenTextIsValid() {
        let expectation = XCTestExpectation(description: "Waiting for observer to receive changes")
        
        cancellable = sut.objectWillChange.sink(receiveValue: { Void in
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1)
        
        sut.searchText = "R"
        
        XCTAssertEqual(sut.currentCharacters, [.mockRicky])
    }
    
    func testOnTaskCalled() {
        sut.onTaskCalled()
        
        XCTAssertTrue(spyPaginationRequester.requestNewPageCalled)
    }
    
    func testRequestViewModel() throws {
        let viewModel = sut.requestViewModel(for: .mockRicky)
        let url = try XCTUnwrap(URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
        XCTAssertEqual(viewModel.character, .init(id: "1", imagePath: url, name: "Ricky Sanchez"))
    }
    
    func testLoadNewPageIfNeeded() {
        sut.loadNewPageIfNeeded(characterIndex: 1)
        
        XCTAssertTrue(spyPaginationRequester.requestNewPageCalled)
    }
    
    func testObservingCharacters() {
        let expectation = XCTestExpectation(description: "Waiting for observer to receive changes")
        
        cancellable = sut.objectWillChange.sink(receiveValue: { Void in
            expectation.fulfill()
        })
        
        mockCharacterObserver.charactersCurrentValueSubject.send([
            .mockRicky,
            .mockRicky,
            .mockRicky
        ])
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(sut.currentCharacters, [.mockRicky, .mockRicky, .mockRicky])
    }
}

private extension CharacterListViewModelTests {
    final class SpyPaginationRequester: CharacterPaginationRequester {
        private(set) var requestNewPageCalled = false
        func requestNewPage() {
            requestNewPageCalled = true
        }
    }
    
    final class MockCharactersObserver: CharacterObserver {
        var charactersPublisher: AnyPublisher<[Character.Preview], CharactersRepository.Errors> {
            charactersCurrentValueSubject.eraseToAnyPublisher()
        }
        
        var charactersCurrentValueSubject: CurrentValueSubject<[Character.Preview], CharactersRepository.Errors>
        
        init(characters: [Character.Preview]) {
            self.charactersCurrentValueSubject = .init(characters)
        }
    }
}
