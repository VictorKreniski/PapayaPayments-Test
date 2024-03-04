//
//  Character.swift
//  RickAndMorty
//
//  Created by Victor Kreniski on 03/03/24.
//

import Foundation

enum Character {
    struct Preview: Identifiable, Hashable, Equatable {
        enum Status: String {
            case alive = "Alive", unknown = "Unknown", dead = "Dead"
        }
        
        let id: String
        let imagePath: URL
        let name: String
        let status: String?
        let species: String?
        let gender: String?
        
        var currentStatus: Status? {
            guard let status else { return nil}
            return .init(rawValue: status)
        }
        
        init(id: String, imagePath: URL, name: String, status: String? = nil, species: String? = nil, gender: String? = nil) {
            self.id = id
            self.imagePath = imagePath
            self.name = name
            self.status = status
            self.species = species
            self.gender = gender
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    struct Detail: Identifiable, Equatable {
        let id: String
        let imagePath: URL
        let name: String
        let status: String?
        let species: String?
        let type: String?
        let gender: String?
        let origin: Origin?
        let location: Location?
        let episode: [Episode]?
        
        init(
            id: String,
            imagePath: URL,
            name: String,
            status: String? = nil,
            species: String? = nil,
            type: String? = nil,
            gender: String? = nil,
            origin: Origin? = nil,
            location: Location? = nil,
            episode: [Episode]? = nil
        ) {
            self.id = id
            self.imagePath = imagePath
            self.name = name
            self.status = status
            self.species = species
            self.type = type
            self.gender = gender
            self.origin = origin
            self.location = location
            self.episode = episode
        }
    }
    
    struct Origin: Equatable {
        let id: String
        let name: String
        let type: String
        let dimension: String
        let residents: [Character.Preview]
    }
    
    struct Location: Equatable {
        let id: String
        let name: String
        let type: String
        let dimension: String
        let residents: [Character.Preview]
    }
    
    struct Episode: Equatable {
        let id: String
        let name: String
        let episode: String
        let airDate: String
        let characters: [Character.Preview]
    }
}
