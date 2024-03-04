//
//  CharactersList.swift
//  RickAndMorty
//
//  Created by Victor Kreniski on 03/03/24.
//

import SwiftUI

protocol CharactersListViewDataSource: ObservableObject {
    var currentCharacters: [Character.Preview] { get }
    var searchText: String { get set }
    var error: Error? { get }
    
    func onTaskCalled()
    func requestViewModel(for character: Character.Preview) -> CharacterDetailViewModel
    func loadNewPageIfNeeded(characterIndex: Int)
}

struct CharactersListView<ViewModel: CharactersListViewDataSource>: View {
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: .init(repeating: .init(.flexible()), count: 2)) {
                    ForEach(Array(viewModel.currentCharacters.enumerated()), id: \.element) { index, character  in
                        NavigationLink {
                            CharacterDetailView(
                                viewModel: viewModel.requestViewModel(
                                    for: character
                                )
                            )
                        } label: {
                            CharacterRow(character: character)
                                .onAppear {
                                    viewModel.loadNewPageIfNeeded(characterIndex: index)
                                }
                        }
                        .padding(10)
                    }
                }
                .padding(.horizontal)
            }
            .searchable(text: $viewModel.searchText)
            .navigationTitle("Characters")
        }
        .task(priority: .high, {
            viewModel.onTaskCalled()
        })
    }
}

#Preview {
    CharactersListView(viewModel: CharactersListViewModel())
}
