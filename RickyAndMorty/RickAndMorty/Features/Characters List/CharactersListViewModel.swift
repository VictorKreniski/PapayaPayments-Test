//
//  CharactersListViewModel.swift
//  RickAndMorty
//
//  Created by Victor Kreniski on 03/03/24.
//

import Foundation
import Combine

final class CharactersListViewModel: CharactersListViewDataSource {
    
    var currentCharacters: [Character.Preview] {
        guard !searchText.isEmpty else { return characters }
        return characters.filter({ $0.name.contains(searchText) })
    }
    
    @Published private var characters: [Character.Preview] = []
    @Published private(set) var error: Error?
    
    @Published var searchText: String = ""
    
    private let paginationRequester: CharacterPaginationRequester
    private let charactersObserver: CharacterObserver
    private var cancellable: Cancellable?
    
    init(
        paginationRequester: CharacterPaginationRequester = CharactersRepository.shared,
        charactersObserver: CharacterObserver = CharactersRepository.shared
    ) {
        self.paginationRequester = paginationRequester
        self.charactersObserver = charactersObserver

        subscribeToCharactersPublisher()
    }
    
    func onTaskCalled() {
        paginationRequester.requestNewPage()
    }
    
    func requestViewModel(for character: Character.Preview) -> CharacterDetailViewModel {
        .init(
            character: character
        )
    }
    
    func loadNewPageIfNeeded(characterIndex: Int) {
        if characters.count <= characterIndex + 5 {
            paginationRequester.requestNewPage()
        }
    }
}

private extension CharactersListViewModel {
    func subscribeToCharactersPublisher() {
        cancellable = charactersObserver
            .charactersPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                guard case .failure(let repositoryError) = error else { return }
                self?.error = repositoryError
        } receiveValue: { [weak self] characters in
            self?.characters = characters
        }
    }
}
