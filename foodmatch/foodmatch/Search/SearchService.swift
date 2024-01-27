//
//  SearchService.swift
//  foodmatch
//
//  Created by Brynne Delaney on 26/01/2024.
//

import Foundation

struct SearchService {
    private static let session = URLSession.shared
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
    
//    public static func getSearch(searchTerm: String) async throws -> SearchResponse {
//        let baseURL = "https://api.watchmode.com/v1/search/?apiKey=\(myKey)"
//        let url = URL(string: baseURL)!
//        
//        var components = URLComponents(string: baseURL)
//        components?.queryItems = [
//            URLQueryItem(name: "search_value", value: "\(searchTerm)"),
//            URLQueryItem(name: "search_field", value: "name")
//        ]
//        guard let url = components?.url else { fatalError("Invalid URL")}
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        do {
//            let(data, _) = try await session.data(for: request)
//            printData(data: data)
//            let response = try decoder.decode(SearchResponse.self, from: data)
//            print(response)
//            return response
//        } catch {
//            print("this is the error: \(error.localizedDescription)" )
//            throw error
//        }
//    }
    
    private static func printData(data: Data) {
        let string = String(data: data, encoding: .utf8)!
        print(string)
    }
}
