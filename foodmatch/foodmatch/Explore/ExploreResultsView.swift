//
//  ExploreResultsView.swift
//  foodmatch
//
//  Created by Brynne Delaney on 27/01/2024.
//

import SwiftUI

struct ExploreResultsView: View {
    var titles: [Title]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                VStack (alignment: .leading){
                    ForEach(titles) { title in
                        Text(title.title)
                    }
                }
            }
        }
    }
}

#Preview {
    ExploreResultsView(titles: ExploreViewModel.example)
}
