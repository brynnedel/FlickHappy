//
//  MovieResponse.swift
//  foodmatch
//
//  Created by Brynne Delaney on 26/01/2024.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: jsonData)


// MARK: - MovieResponse
struct TitleDetails: Codable, Identifiable {
    let id: Int
    let title: String
//    let originalTitle, 
    let plotOverview: String?
    let type: String?
    let runtimeMinutes: Int?
    let year: Int?
//    let endYear: JSONNull?
    let releaseDate: String?
    let imdbID: String?
    let tmdbID: Int?
    let tmdbType: String?
    let genres: [Int]?
    let genreNames: [String]
//    let userRating: Double?
//    let criticScore: Int?
//    let usRating: JSONNull?
    let poster: String?
    let backdrop: String?
//    let originalLanguage: String?
//    let similarTitles: [Int]?
//    let networks, networkNames: JSONNull?
//    let relevancePercentile: Double?
//    let trailer: String?
//    let trailerThumbnail: String?
    let sources: [Source]

    enum CodingKeys: String, CodingKey {
        case id, title
//        case originalTitle = "original_title"
        case plotOverview = "plot_overview"
        case type
        case runtimeMinutes = "runtime_minutes"
        case year
//        case endYear = "end_year"
        case releaseDate = "release_date"
        case imdbID = "imdb_id"
        case tmdbID = "tmdb_id"
        case tmdbType = "tmdb_type"
        case genres
        case genreNames = "genre_names"
//        case userRating = "user_rating"
//        case criticScore = "critic_score"
//        case usRating = "us_rating"
        case poster, backdrop
//        case originalLanguage = "original_language"
//        case similarTitles = "similar_titles"
//        case networks
//        case networkNames = "network_names"
//        case relevancePercentile = "relevance_percentile"
//        case trailer
//        case trailerThumbnail = "trailer_thumbnail"
        case sources
    }
}

// MARK: - Source
struct Source: Codable {
    let sourceID: Int
    let name: String?
    let type: String?
//    let region: String?
//    let iosURL: String?
    //let androidURL: AndroidURLEnum?
    let webURL: String?
//    let format: Format?
    let price: Double?
    let seasons: Int?
    let episodes: Int?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case name, type
//        case iosURL = "ios_url"
        //case androidURL = "android_url"
        case webURL = "web_url"
        case price, seasons, episodes
    }
}

//enum AndroidURLEnum: String, Codable {
//    case deeplinksAvailableForPaidPlansOnly = "Deeplinks available for paid plans only."
//}

//enum Format: String, Codable {
//    case hd = "HD"
//    case sd = "SD"
//}

//enum Region: String, Codable {
//    case au = "AU"
//    case br = "BR"
//    case ca = "CA"
//    case gb = "GB"
//    case us = "US"
//}



// MARK: - SearchResponse
struct SearchResponse: Codable {
    let titleResults: [TitleResult]
    let peopleResults: [PeopleResult]

    enum CodingKeys: String, CodingKey {
        case titleResults = "title_results"
        case peopleResults = "people_results"
    }
}

// MARK: - PeopleResult
struct PeopleResult: Codable, Identifiable {
    let resultType: String
    let id: Int
    let name: String
    let mainProfession, imdbID: JSONNull?
    let tmdbID: Int

    enum CodingKeys: String, CodingKey {
        case resultType, id, name
        case mainProfession = "main_profession"
        case imdbID = "imdb_id"
        case tmdbID = "tmdb_id"
    }
}

// MARK: - TitleResult
struct TitleResult: Codable, Identifiable {
    let resultType: String
    let id: Int
    let name, type: String
    let year: Int?
    let imdbID: String?
    let tmdbID: Int
    let tmdbType: String

    enum CodingKeys: String, CodingKey {
        case resultType, id, name, type, year
        case imdbID = "imdb_id"
        case tmdbID = "tmdb_id"
        case tmdbType = "tmdb_type"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


// MARK: - ListTitlesResponse
struct ListTitlesResponse: Codable {
    let titles: [Title]
    let page, totalResults, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case titles, page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

// MARK: - Title
struct Title: Codable, Identifiable {
    let id: Int
    let title: String
    let year: Int
    let imdbID: String
    let tmdbID: Int
    let tmdbType, type: String

    enum CodingKeys: String, CodingKey {
        case id, title, year
        case imdbID = "imdb_id"
        case tmdbID = "tmdb_id"
        case tmdbType = "tmdb_type"
        case type
    }
}
// MARK: - ReleasesResponse
struct ReleasesResponse: Codable {
    let releases: [Release]
}

// MARK: - Release
struct Release: Codable, Identifiable {
    let id: Int
    let title: String
    let type: String?
    let tmdbID: Int
    let tmdbType: String?
    let imdbID: String
    let seasonNumber: Int?
    let posterURL: String
    let sourceReleaseDate: String
    let sourceID: Int
    let sourceName: String
    let isOriginal: Int

    enum CodingKeys: String, CodingKey {
        case id, title, type
        case tmdbID = "tmdb_id"
        case tmdbType = "tmdb_type"
        case imdbID = "imdb_id"
        case seasonNumber = "season_number"
        case posterURL = "poster_url"
        case sourceReleaseDate = "source_release_date"
        case sourceID = "source_id"
        case sourceName = "source_name"
        case isOriginal = "is_original"
    }
}

// MARK: - PersonResponse
struct PersonResponse: Codable, Identifiable {
    let id: Int
    let fullName: String
    let firstName, lastName: String?
    let tmdbID: Int?
    let imdbID, mainProfession, secondaryProfession, tertiaryProfession: String?
//    let dateOfBirth: String?
//    let dateOfDeath: JSONNull?
//    let placeOfBirth, gender: String?
    let headshotURL: String?
//    let knownFor: [Int]?
//    let relevancePercentile: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case tmdbID = "tmdb_id"
        case imdbID = "imdb_id"
        case mainProfession = "main_profession"
        case secondaryProfession = "secondary_profession"
        case tertiaryProfession = "tertiary_profession"
//        case dateOfBirth = "date_of_birth"
//        case dateOfDeath = "date_of_death"
//        case placeOfBirth = "place_of_birth"
//        case gender
        case headshotURL = "headshot_url"
//        case knownFor = "known_for"
//        case relevancePercentile = "relevance_percentile"
    }
}


enum TmdbEnum: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case tvMiniseries = "tv_miniseries"
    case tvMovie = "tv_movie"
    case tvSeries = "tv_series"
}
