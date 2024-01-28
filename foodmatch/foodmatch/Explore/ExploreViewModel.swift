//
//  ExploreViewModel.swift
//  foodmatch
//
//  Created by Brynne Delaney on 27/01/2024.
//

import Foundation

enum ExploreLoadingState {
    case idle
    case loading
    case success(titles: [Title])
    case detailSuccess(TitleDetails: TitleDetails)
    case error(error: Error)
}

@MainActor
class ExploreViewModel: ObservableObject {
    @Published var state: ExploreLoadingState = .idle
    
    func loadTitles(type: String, source: Int, genre: Int) async {
        Task {
            do {
                self.state = .loading
                let response = try await MovieService.listTitles(type: type, source: source, genre: genre)
                print(response)
                self.state = .success(titles: response)
                print("success")
            } catch {
                self.state = .error(error: error)
            }
        }
    }
    
    func getTitleDetails(id: Int) async {
        Task {
            do {
                self.state = .loading
                let details = try await MovieService.getTitleDetails(id: id)
                self.state = .detailSuccess(TitleDetails: details)
            } catch {
                self.state = .error(error: error)
            }
        }
    }
    
    func resetPage() async {
        self.state = .idle
    }
}

extension ExploreViewModel {
   static let example = [Title(id: 1, title: "Today!", year: 2020, imdbID: "1", tmdbID: 1, tmdbType: "movie", type: "movie")]
}
