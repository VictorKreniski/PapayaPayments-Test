//
//  CharacterPreview.swift
//  RickAndMorty
//
//  Created by Victor Kreniski on 03/03/24.
//

import SwiftUI

struct CharacterPreview: View {
    
    let character: Character.Preview
    
    var body: some View {
        VStack {
            AsyncImage(url: character.imagePath) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .clipShape(Circle())
            Text(character.name)
                .lineLimit(1)
        }
    }
}

#Preview {
    CharacterPreview(
        character: .init(
            id: "1",
            imagePath: .init(
                string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
            )!,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            gender: "Male"
        )
    )
}
