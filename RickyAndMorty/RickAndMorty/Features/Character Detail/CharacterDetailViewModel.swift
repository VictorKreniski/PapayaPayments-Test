//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Victor Kreniski on 03/03/24.
//

import Foundation

final class CharacterDetailViewModel: CharacterDetailViewDataSource {

    @Published private(set) var character: Character.Detail
    
    private let characterDetailRequester: CharactersDetailRequester
    
    init(
        character: Character.Preview,
         characterDetailRequester: CharactersDetailRequester = CharactersRepository.shared
    ) {
        self.character = .init(preview: character)
        self.characterDetailRequester = characterDetailRequester
    }
    
    func onTaskCalled() {
        Task(priority: .userInitiated) { [weak self] in
            guard let self else { return }
            let detail = try await characterDetailRequester.requestDetails(
                characterID: character.id
            )
            
            DispatchQueue.main.async {
                self.character = detail
            }
        }
    }
    
    func requestViewModel(for character: Character.Preview) -> CharacterDetailViewModel {
        .init(character: character)
    }
}

private extension Character.Detail {
    init(preview: Character.Preview) {
        self.init(
            id: preview.id,
            imagePath: preview.imagePath,
            name: preview.name
        )
    }
}
