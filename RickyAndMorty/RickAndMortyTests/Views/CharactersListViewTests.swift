//
//  CharactersListViewTests.swift
//  RickAndMortyTests
//
//  Created by Victor Kreniski on 03/03/24.
//

import XCTest
@testable import RickAndMorty
import SnapshotTesting

final class CharactersListViewTests: XCTestCase {
    func testCharacterListViewWhenEmpty() {
        let sut = CharactersListView(viewModel: MockCharactersViewModel())
        assertSnapshot(of: sut.asViewController, as: .image)
    }
    
    func testCharacterListViewWhenFilled() {
        let viewModel = MockCharactersViewModel()
        viewModel.currentCharacters = [.mockRicky]
        let sut = CharactersListView(viewModel: viewModel)
        assertSnapshot(of: sut.asViewController, as: .image)
    }
    
    func testCharactersListViewWhenSearching() {
        let viewModel = MockCharactersViewModel()
        viewModel.currentCharacters = [.mockRicky]
        viewModel.searchText = "Crazy thing happening here"
        let sut = CharactersListView(viewModel: viewModel)
        assertSnapshot(of: sut.asViewController, as: .image)
    }
}

private extension CharactersListViewTests {
    final class MockCharactersViewModel: CharactersListViewDataSource {
        var currentCharacters: [Character.Preview] = []
        
        var searchText: String = ""
        
        var error: Error?
        
        func onTaskCalled() {}
        
        func requestViewModel(for character: RickAndMorty.Character.Preview) -> CharacterDetailViewModel { .init(character: character) }
        
        func loadNewPageIfNeeded(characterIndex: Int) {}
    }
}
