//
//  CharacterDetail+Mock.swift
//  RickAndMortyTests
//
//  Created by Victor Kreniski on 03/03/24.
//

import Foundation
@testable import RickAndMorty

extension Character.Detail {
    static let mockRicky: Self = .init(
        id: "1",
        imagePath: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
        name: "Ricky Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: .init(
            id: "1",
            name: "Earth (C-137)",
            type: "Planet",
            dimension: "Dimension C-137",
            residents: [
                .mockRicky
            ]
        ),
        location: .init(
            id: "3",
            name: "Citadel of Ricks",
            type: "Space station",
            dimension: "unknown",
            residents: [
                .mockRicky
            ]),
        episode: [
            .init(
                id: "1",
                name: "Pilot",
                episode: "S01E01",
                airDate: "December 2, 2013",
                characters: [
                    .mockRicky
                ]
            )
        ]
    )
}
