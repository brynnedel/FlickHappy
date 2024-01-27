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
    case success//(movies: [Movie])
    case error(error: Error)
}
