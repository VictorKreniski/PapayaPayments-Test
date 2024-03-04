//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Victor Kreniski on 03/03/24.
//

import SwiftUI

protocol CharacterDetailViewDataSource: ObservableObject {
    var character: Character.Detail { get }
    
    func onTaskCalled()
    func requestViewModel(for character: Character.Preview) -> CharacterDetailViewModel
}

struct CharacterDetailView<ViewModel: CharacterDetailViewDataSource>: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {
            Section {
                AsyncImage(url: viewModel.character.imagePath) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            Text(viewModel.character.name).font(.title)
            Text("Status: \(viewModel.character.status ?? "Unknown")")
            Text("Species: \(viewModel.character.species ?? "Unknown")")
            Text("Type: \(viewModel.character.type ?? "Unknown")")
            Text("Gender: \(viewModel.character.gender ?? "Unknown")")
            
            Section(header: Text("Origin")) {
                if let origin = viewModel.character.origin {
                    Text("Name: \(origin.name)")
                    Text("Type: \(origin.type)")
                    Text("Dimension: \(origin.dimension)")
                    VStack(alignment: .leading) {
                        Text("\(origin.residents.count) Residents:")
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(origin.residents, id: \.id) { character in
                                    NavigationLink {
                                        CharacterDetailView<CharacterDetailViewModel>(
                                            viewModel: viewModel.requestViewModel(
                                                for: character
                                            )
                                        )
                                    } label: {
                                        CharacterPreview(character: character)
                                    }
                                    .frame(width: 100, height: 100)
                                }
                            }
                        }
                    }
                } else {
                    Text("No origin information available")
                }
            }
            
            Section(header: Text("Location")) {
                if let location = viewModel.character.location {
                    Text("Name: \(location.name)")
                    Text("Type: \(location.type)")
                    Text("Dimension: \(location.dimension)")
                    VStack(alignment: .leading) {
                        Text("\(location.residents.count) Residents:")
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(location.residents, id: \.id) { character in
                                    NavigationLink {
                                        CharacterDetailView<CharacterDetailViewModel>(
                                            viewModel: viewModel.requestViewModel(
                                                for: character
                                            )
                                        )
                                    } label: {
                                        CharacterPreview(character: character)
                                    }
                                    .frame(width: 100, height: 100)
                                }
                            }
                        }
                    }
                } else {
                    Text("No location information available")
                }
            }
            
            Section(header: Text("Episodes")) {
                if let episodes = viewModel.character.episode {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(episodes, id: \.name) { episode in
                            VStack(alignment: .leading) {
                                Text("\(episode.name) (\(episode.episode))")
                                Text("\(episode.airDate)").foregroundStyle(.secondary)
                            }
                        }
                    }
                    
                } else {
                    Text("No episode information available")
                }
            }
        }
        .listStyle(.insetGrouped)
        .task {
            viewModel.onTaskCalled()
        }
    }
}

#Preview {
    CharacterDetailView(
        viewModel: CharacterDetailViewModel(
            character: .init(
                id: "1",
                imagePath: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
                name: "Ricky Sanchez",
                status: "Alive",
                species: "Human",
                gender: "Male"
            ), characterDetailRequester: CharactersRepository.shared
        )
    )
}
