import Foundation
import Apollo

final class Network {
    
    static let shared = Network()
    
    private(set) lazy var apollo: ApolloClient = {
        let url = URL(string: "https://rickandmortyapi.com/graphql")!
        return .init(url: url)
    }()
    
}
