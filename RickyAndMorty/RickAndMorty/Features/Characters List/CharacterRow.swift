//
//  CharacterRow.swift
//  RickAndMorty
//
//  Created by Victor Kreniski on 03/03/24.
//

import SwiftUI

struct CharacterRow: View {
    
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
            .clipShape(RoundedRectangle(cornerRadius: 8))
            HStack {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(character.currentStatus?.color ?? Color.yellow)
                Text(character.name)
                    .lineLimit(1)
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .bold()
            }
        }
        .frame(minWidth: 0, idealWidth: 50, maxWidth: .infinity, minHeight: 0, idealHeight: 200, maxHeight: .infinity, alignment: .center)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.cyan)
                .shadow(radius: 4)
        )
    }
}

private extension Character.Preview.Status {
    var color: Color {
        switch self {
        case .alive:
            return Color.green
        case .unknown:
            return Color.yellow
        case .dead:
            return Color.black
        }
    }
}

#Preview {
    CharacterRow(
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
