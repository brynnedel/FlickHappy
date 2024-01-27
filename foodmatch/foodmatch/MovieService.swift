//
//  MovieService.swift
//  foodmatch
//
//  Created by Brynne Delaney on 26/01/2024.
//

import Foundation

struct MovieService {
    private static let myKey = "hMkcRLKvzReBrzAawmx4EP7vUu15OHSv6SRmCmDO"
    private static let session = URLSession.shared
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
    
    public static func getReleases() async throws -> [Release] {
        let limit = 10
        let baseUrl = "https://api.watchmode.com/v1/releases/?apiKey=\(myKey)&limit=\(limit)"
        
        if let url = URL(string: baseUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            do {
                let (data, _) = try await session.data(for: request)
                printData(data: data)
                let response = try decoder.decode(ReleasesResponse.self, from: data)
                print(response)
                return response.releases
            } catch {
                
                print("this is the error: \(error.localizedDescription)" )
                throw error
            }
        }
        return []

    }
    
    public static func getSearch(searchTerm: String) async throws -> SearchResponse {
        let baseURL = "https://api.watchmode.com/v1/search/"
//        let url = URL(string: baseURL)!
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "apiKey", value: "\(myKey)"),
            URLQueryItem(name: "search_value", value: "\(searchTerm)"),
            URLQueryItem(name: "search_field", value: "name")
        ]
        guard let url = components?.url else { fatalError("Invalid URL")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let(data, _) = try await session.data(for: request)
//            printData(data: data)
            let response = try decoder.decode(SearchResponse.self, from: data)
//            print(response)
            return response
        } catch {
            print("this is the error: \(error.localizedDescription)" )
            throw error
        }
    }
    
    public static func getTitleDetails(id: Int) async throws -> TitleDetails {
        let baseURL = "https://api.watchmode.com/v1/title/\(id)/details/"
//        let url = URL(string: baseURL)!
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "apiKey", value: "\(myKey)"),
            URLQueryItem(name: "append_to_response", value: "sources")
        ]
        guard let url = components?.url else {fatalError("Invalid URL")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do{
            let(data, _) = try await session.data(for: request)
//            print("title details data: ")
            printData(data: data)
            let response = try decoder.decode(TitleDetails.self, from: data)
//            print("title after decode")
//            print(response)
            return response
        } catch {
            print("this is the error in title: \(error.localizedDescription)")
            throw error
        }
    }
    
    public static func getPersonDetails(id: Int) async throws -> PersonResponse {
        let baseURL = "https://api.watchmode.com/v1/person/\(id)"
//        let url = URL(string: baseURL)!
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "apiKey", value: "\(myKey)")
        ]
        guard let url = components?.url else {fatalError("Invalid URL")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await session.data(for: request)
            print("person details data: ")
            printData(data: data)
            let response = try decoder.decode(PersonResponse.self, from: data)
            print("person after decode")
            print(response)
            return response
        } catch {
            print("this is the error: \(error.localizedDescription)")
            throw error
        }
    }
    
    private static func printData(data: Data) {
        let string = String(data: data, encoding: .utf8)!
        print(string)
    }
}
