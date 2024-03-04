// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CharacterDetailQuery: GraphQLQuery {
  public static let operationName: String = "CharacterDetail"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query CharacterDetail($id: ID!) {
        character(id: $id) {
          __typename
          id
          name
          image
          status
          species
          type
          gender
          origin {
            __typename
            id
            name
            type
            dimension
            residents {
              __typename
              id
              name
              image
            }
          }
          location {
            __typename
            id
            name
            type
            dimension
            residents {
              __typename
              id
              name
              image
            }
          }
          episode {
            __typename
            id
            name
            episode
            air_date
            characters {
              __typename
              id
              name
              image
            }
          }
        }
      }
      """#
    ))

  public var id: ID

  public init(id: ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: RickAndMortyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("character", Character?.self, arguments: ["id": .variable("id")]),
    ] }

    /// Get a specific character by ID
    public var character: Character? { __data["character"] }

    /// Character
    ///
    /// Parent Type: `Character`
    public struct Character: RickAndMortyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Character }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", RickAndMortyAPI.ID?.self),
        .field("name", String?.self),
        .field("image", String?.self),
        .field("status", String?.self),
        .field("species", String?.self),
        .field("type", String?.self),
        .field("gender", String?.self),
        .field("origin", Origin?.self),
        .field("location", Location?.self),
        .field("episode", [Episode?].self),
      ] }

      /// The id of the character.
      public var id: RickAndMortyAPI.ID? { __data["id"] }
      /// The name of the character.
      public var name: String? { __data["name"] }
      /// Link to the character's image.
      /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
      public var image: String? { __data["image"] }
      /// The status of the character ('Alive', 'Dead' or 'unknown').
      public var status: String? { __data["status"] }
      /// The species of the character.
      public var species: String? { __data["species"] }
      /// The type or subspecies of the character.
      public var type: String? { __data["type"] }
      /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
      public var gender: String? { __data["gender"] }
      /// The character's origin location
      public var origin: Origin? { __data["origin"] }
      /// The character's last known location
      public var location: Location? { __data["location"] }
      /// Episodes in which this character appeared.
      public var episode: [Episode?] { __data["episode"] }

      /// Character.Origin
      ///
      /// Parent Type: `Location`
      public struct Origin: RickAndMortyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Location }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", RickAndMortyAPI.ID?.self),
          .field("name", String?.self),
          .field("type", String?.self),
          .field("dimension", String?.self),
          .field("residents", [Resident?].self),
        ] }

        /// The id of the location.
        public var id: RickAndMortyAPI.ID? { __data["id"] }
        /// The name of the location.
        public var name: String? { __data["name"] }
        /// The type of the location.
        public var type: String? { __data["type"] }
        /// The dimension in which the location is located.
        public var dimension: String? { __data["dimension"] }
        /// List of characters who have been last seen in the location.
        public var residents: [Resident?] { __data["residents"] }

        /// Character.Origin.Resident
        ///
        /// Parent Type: `Character`
        public struct Resident: RickAndMortyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Character }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", RickAndMortyAPI.ID?.self),
            .field("name", String?.self),
            .field("image", String?.self),
          ] }

          /// The id of the character.
          public var id: RickAndMortyAPI.ID? { __data["id"] }
          /// The name of the character.
          public var name: String? { __data["name"] }
          /// Link to the character's image.
          /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
          public var image: String? { __data["image"] }
        }
      }

      /// Character.Location
      ///
      /// Parent Type: `Location`
      public struct Location: RickAndMortyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Location }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", RickAndMortyAPI.ID?.self),
          .field("name", String?.self),
          .field("type", String?.self),
          .field("dimension", String?.self),
          .field("residents", [Resident?].self),
        ] }

        /// The id of the location.
        public var id: RickAndMortyAPI.ID? { __data["id"] }
        /// The name of the location.
        public var name: String? { __data["name"] }
        /// The type of the location.
        public var type: String? { __data["type"] }
        /// The dimension in which the location is located.
        public var dimension: String? { __data["dimension"] }
        /// List of characters who have been last seen in the location.
        public var residents: [Resident?] { __data["residents"] }

        /// Character.Location.Resident
        ///
        /// Parent Type: `Character`
        public struct Resident: RickAndMortyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Character }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", RickAndMortyAPI.ID?.self),
            .field("name", String?.self),
            .field("image", String?.self),
          ] }

          /// The id of the character.
          public var id: RickAndMortyAPI.ID? { __data["id"] }
          /// The name of the character.
          public var name: String? { __data["name"] }
          /// Link to the character's image.
          /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
          public var image: String? { __data["image"] }
        }
      }

      /// Character.Episode
      ///
      /// Parent Type: `Episode`
      public struct Episode: RickAndMortyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Episode }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", RickAndMortyAPI.ID?.self),
          .field("name", String?.self),
          .field("episode", String?.self),
          .field("air_date", String?.self),
          .field("characters", [Character?].self),
        ] }

        /// The id of the episode.
        public var id: RickAndMortyAPI.ID? { __data["id"] }
        /// The name of the episode.
        public var name: String? { __data["name"] }
        /// The code of the episode.
        public var episode: String? { __data["episode"] }
        /// The air date of the episode.
        public var air_date: String? { __data["air_date"] }
        /// List of characters who have been seen in the episode.
        public var characters: [Character?] { __data["characters"] }

        /// Character.Episode.Character
        ///
        /// Parent Type: `Character`
        public struct Character: RickAndMortyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Character }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", RickAndMortyAPI.ID?.self),
            .field("name", String?.self),
            .field("image", String?.self),
          ] }

          /// The id of the character.
          public var id: RickAndMortyAPI.ID? { __data["id"] }
          /// The name of the character.
          public var name: String? { __data["name"] }
          /// Link to the character's image.
          /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
          public var image: String? { __data["image"] }
        }
      }
    }
  }
}
