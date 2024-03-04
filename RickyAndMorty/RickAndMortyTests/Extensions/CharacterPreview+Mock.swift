//
//  CharacterPreview+Mock.swift
//  RickAndMortyTests
//
//  Created by Victor Kreniski on 03/03/24.
//

import Foundation
@testable import RickAndMorty

extension Character.Preview {
    static let mockRicky: Self = .init(
        id: "1",
        imagePath: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
        name: "Ricky Sanchez",
        status: "Alive",
        species: "Human",
        gender: "Male"
    )
}
