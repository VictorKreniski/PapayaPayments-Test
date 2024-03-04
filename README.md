
# PapayaPayments-Test: Rick and Morty GraphQL (18 hours)

<img src="https://github.com/VictorKreniski/PapayaPayments-Test/assets/14129867/98934b1b-dfbd-42ff-ac02-a5613ba3799b" width="300">
<img src="https://github.com/VictorKreniski/PapayaPayments-Test/assets/14129867/71949ec4-c0e9-4c5b-bf22-61dc8d11b222" width="300">

This project demonstrates a basic integration using Apollo, GraphQL, SwiftUI, and Combine.  It utilizes MVVM architecture and leverages modern Swift features like async/await for a clean and concise implementation.

## Learning Curve with Apollo:

The limited development time presented a challenge as I learned GraphQL and integrated Apollo. This involved understanding proper Apollo setup, schema retrieval, query construction with parameters, and the importance of using Swift Package Manager (SPM) as recommended in documentation. While I initially attempted manual integration through Xcode's "embedInTarget" feature, it caused errors.

## Prioritizing Core Functionalities:

To focus on core functionalities and showcase my skills in MVVM, Combine, async/await, and testing, I temporarily deferred UI development. This initial iteration prioritized integrating Apollo and demonstrating proficiency in these areas. Future iterations will address UI design.

## Project Timeline:

- March 2nd (4 hours): Initial project setup, core functionalities implemented.
- March 3rd (Full Day): Continued development, refined functionalities, completed core features.
- March 4th (Short Session): Added CI with unit and snapshot tests using GitHub Actions.

## Technologies:

- Apollo & GraphQL: Data fetching and management.
- SwiftUI: User interface development.
- Combine: Reactive data flow and state management.
- Async/await: Asynchronous programming with improved readability.
- Unit Tests: Comprehensive unit testing for core functionalities.
- Snapshot Tests: Visual regression testing for UI consistency.
- Swift Package Manager (SPM): Dependency management.

## Architecture:

- MVVM: Model-View-ViewModel architecture for separation of concerns.

# Points of interest

- [iOS YML](.github/workflows/ios.yml) To make it possible to execute unit tests on CI
- [RickAndMortyAPI - SPM](RickyAndMorty/RickAndMortyAPI) The SPM I created while following the [Apollo documentation](https://www.apollographql.com/docs/ios/get-started/#1-install-the-apollo-frameworks)
- [Apollo Codegen Config](RickyAndMorty/apollo-codegen-config.json)
- [Character Model](RickyAndMorty/RickAndMorty/Models/Character.swift)
- [Characters Repository](RickyAndMorty/RickAndMorty/Repositories/CharactersRepository.swift)
- Features
  - [CharacterList](RickyAndMorty/RickAndMorty/Features/Characters%20List) - Infinite scrolling 2 columns grid
  - [CharacterDetail](RickyAndMorty/RickAndMorty/Features/Character%20Detail) - Character Detail View
- [Testing ViewModels](RickyAndMorty/RickAndMortyTests/ViewModels) Here is a brief show in how I test ViewModels
- [Snapshot Testing](RickyAndMorty/RickAndMortyTests/Views/CharactersListViewTests.swift) Here I show how I'm used to do snapshot testing
  - [Images](RickyAndMorty/RickAndMortyTests/Views/__Snapshots__/CharactersListViewTests) Snapshot images recorded on iPhone SE (3rd Generation ) this is the most optimized device due to the image size output
 
## Improvements

- Image cache for downloaded characters
- A better search bar using categories like: specie, world, gender
- Search GraphQL Request, instead of searching downloaded characters
- Abstract Network Service with a protocol and inject into CharactersRepository, instead of using the singleton
- Create a script to automatically execute bash commands to continously keep Apollo updated at Build Phases
