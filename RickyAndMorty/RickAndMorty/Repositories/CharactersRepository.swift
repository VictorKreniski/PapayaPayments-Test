//
//  CharactersRepository.swift
//  RickAndMorty
//
//  Created by Victor Kreniski on 03/03/24.
//

import Foundation
import Combine
import Apollo
import RickAndMortyAPI

protocol CharacterPaginationRequester {
    func requestNewPage()
}

protocol CharactersDetailRequester {
    func requestDetails(characterID: String) async throws -> Character.Detail
}

protocol CharacterObserver {
    var charactersPublisher: AnyPublisher<[Character.Preview], CharactersRepository.Errors> { get }
}

final class CharactersRepository {
    
    static let shared: CharactersRepository = .init()
    
    enum Errors: Error {
        case generic
    }
    
    private var charactersSubject: CurrentValueSubject<[Character.Preview], Errors> = .init([])
    private var currentPage: Int = 1
    private var hasAnotherPage = true
    private var cancellable: Apollo.Cancellable?
    private var canRequestMoreCharacters = true

    private init() {}
}

extension CharactersRepository: CharacterPaginationRequester {
    func requestNewPage() {
        guard
            hasAnotherPage,
            canRequestMoreCharacters
        else { return }
        
        currentPage += 1
        requestCharactersList()
    }
}

extension CharactersRepository: CharactersDetailRequester {
    func requestDetails(characterID: String) async throws -> Character.Detail {
        try await withCheckedThrowingContinuation { continuation in
            cancellable = Network.shared.apollo.fetch(query: CharacterDetailQuery(id: characterID)) { result in
                switch result {
                case .success(let characterDetailResult):
                    guard
                        let character = characterDetailResult.data?.character,
                        let characterDetail = Character.Detail(character: character)
                    else {
                        continuation.resume(throwing: Errors.generic)
                        return
                    }
                    continuation.resume(returning: characterDetail)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

extension CharactersRepository: CharacterObserver {
    var charactersPublisher: AnyPublisher<[Character.Preview], Errors> {
        charactersSubject.eraseToAnyPublisher()
    }
}


private extension CharactersRepository {
    func requestCharactersList() {
        guard canRequestMoreCharacters else { return }
        canRequestMoreCharacters = false
        cancellable = Network.shared.apollo.fetch(query: CharactersListQuery(page: currentPage)) { [weak self] result in
            switch result {
            case .success(let charactersResult):
                if let characters = charactersResult.data?.characters {
                    if let info = characters.info {
                        self?.hasAnotherPage = info.next != nil
                    }
                    
                    guard let newCharacters = characters.results?
                        .compactMap({ $0 })
                        .compactMap({ characterResult in
                            Character.Preview(character: characterResult)
                        }) else {
                        return
                    }
                    
                    self?.charactersSubject.value.append(contentsOf: newCharacters)
                
                } else if charactersResult.errors != nil {
                    self?.charactersSubject.send(completion: .failure(.generic))
                }
            case .failure:
                self?.charactersSubject.send(completion: .failure(.generic))
            }
            self?.canRequestMoreCharacters = true
        }
    }
}

private extension Character.Preview {
    init?(character: CharactersListQuery.Data.Characters.Result) {
        guard let id = character.id,
              let imagePath = character.image,
              let imageURL = URL(string: imagePath),
              let characterName = character.name,
              let status = character.status,
              let species = character.species,
              let gender = character.gender
        else {
            return nil
        }
        
        self.init(id: id, imagePath: imageURL, name: characterName, status: status, species: species, gender: gender)
    }
}

private extension Character.Detail {
    init?(character: CharacterDetailQuery.Data.Character) {
        guard let id = character.id,
              let imagePath = character.image,
              let imageURL = URL(string: imagePath),
              let characterName = character.name
        else {
            return nil
        }
        
        self.init(
            id: id,
            imagePath: imageURL,
            name: characterName,
            status: character.status,
            species: character.species,
            type: character.type,
            gender: character.gender,
            origin: character.origin != nil ? .init(origin: character.origin!) : nil ,
            location: character.location != nil ? .init(location: character.location!) : nil,
            episode: character.episode.compactMap({ $0 }).compactMap({ .init(episode: $0) })
        )
    }
}

private extension Character.Origin {
    init?(origin: CharacterDetailQuery.Data.Character.Origin) {
        guard
            let id = origin.id,
            let name = origin.name,
            let type = origin.type,
            let dimension = origin.dimension
        else { return nil }
        
        let residents: [Character.Preview] = origin.residents.compactMap({ $0 }).compactMap({ .init(character: $0) })

        self.init(id: id, name: name, type: type, dimension: dimension, residents: residents)
    }
}

private extension Character.Preview {
    init?(character: CharacterDetailQuery.Data.Character.Origin.Resident) {
        guard let id = character.id,
              let imagePath = character.image,
              let imageURL = URL(string: imagePath),
              let characterName = character.name
        else {
            return nil
        }
        
        self.init(id: id, imagePath: imageURL, name: characterName)
    }
}

private extension Character.Location {
    init?(location: CharacterDetailQuery.Data.Character.Location) {
        guard
            let id = location.id,
            let name = location.name,
            let type = location.type,
            let dimension = location.dimension
        else { return nil }
        
        let residents: [Character.Preview] = location.residents.compactMap({ $0 }).compactMap({ .init(character: $0) })
        
        self.init(id: id, name: name, type: type, dimension: dimension, residents: residents)
    }
}

private extension Character.Preview {
    init?(character: CharacterDetailQuery.Data.Character.Location.Resident) {
        guard let id = character.id,
              let imagePath = character.image,
              let imageURL = URL(string: imagePath),
              let characterName = character.name
        else {
            return nil
        }
        
        self.init(id: id, imagePath: imageURL, name: characterName)
    }
}

private extension Character.Episode {
    init?(episode: CharacterDetailQuery.Data.Character.Episode) {
        guard
            let id = episode.id,
            let name = episode.name,
            let airDate = episode.air_date,
            let episodeString = episode.episode
        else { return nil }
        
        let characters: [Character.Preview] = episode.characters.compactMap({ $0 }).compactMap({ .init(character: $0) })

        self.init(
            id: id,
            name: name,
            episode: episodeString,
            airDate: airDate,
            characters: characters
        )
    }
}

private extension Character.Preview {
    init?(character: CharacterDetailQuery.Data.Character.Episode.Character) {
        guard let id = character.id,
              let imagePath = character.image,
              let imageURL = URL(string: imagePath),
              let characterName = character.name
        else {
            return nil
        }
        
        self.init(id: id, imagePath: imageURL, name: characterName)
    }
}

