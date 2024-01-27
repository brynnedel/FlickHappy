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
    
    private static func printData(data: Data) {
        let string = String(data: data, encoding: .utf8)!
        print(string)
    }
}
