//
//  SearchViewModel.swift
//  foodmatch
//
//  Created by Brynne Delaney on 26/01/2024.
//

import Foundation

enum SearchLoadingState {
    case idle
    case loading
    case success(SearchResponse: SearchResponse)
    case error(error: Error)
}

struct ConvertedSearch {
    var titleResults: [TitleDetails] = []
    var peopleResults: [PersonResponse] = []
}

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchTerm = ""
    @Published var state: SearchLoadingState = .idle
    
    func loadSearch() async {
        Task {
            do {
                self.state = .loading
                let response = try await MovieService.getSearch(searchTerm: searchTerm)
//                var converted = ConvertedSearch()
                
//                for result in response.titleResults {
//                    let titleDetails = try await MovieService.getTitleDetails(id: result.id)
//                    converted.titleResults.append(titleDetails)
//                }
//                print("converted w/ title: \(converted)")
//                for result in response.peopleResults {
//                    let personResponse = try await MovieService.getPersonDetails(id: result.id)
//                    converted.peopleResults.append(personResponse)
//                }
//                print("converted w/ people: \(converted)")
                self.state = .success(SearchResponse: response)
            } catch {
                self.state = .error(error: error)
            }
        }
    }
}
