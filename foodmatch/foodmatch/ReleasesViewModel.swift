//
//  ReleasesViewModel.swift
//  foodmatch
//
//  Created by Brynne Delaney on 26/01/2024.
//

import Foundation

enum ReleasesLoadingState {
    case idle
    case loading
    case success(releases: [Release])
    case error(error: Error)
}

@MainActor
class ReleasesViewModel: ObservableObject {
    @Published var state: ReleasesLoadingState = .idle
    
    func loadReleases() async {
        Task {
            do {
                self.state = .loading
                let response = try await MovieService.getReleases()
                print(response)
                self.state = .success(releases: response)
                print("success")
            } catch {
                self.state = .error(error: error)
            }
        }
    }
}

extension ReleasesViewModel {
    static let example = Release(id: 1, title: "Brynne", type: .movie, tmdbID: 1, tmdbType: .movie, imdbID: "imdbid", seasonNumber: 1, posterURL: "www", sourceReleaseDate: "aday", sourceID: 1, sourceName: "source", isOriginal: 1)
}
