//
//  MovieDetailsView.swift
//  foodmatch
//
//  Created by Brynne Delaney on 26/01/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    @EnvironmentObject private var vm: ReleasesViewModel
    var release: Release?
    var title: TitleDetails?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                VStack (alignment: .leading){
                    HStack (alignment: .top){
                        if (release != nil) {
                            AsyncImage(url: URL(string: release?.posterURL ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                // Placeholder while loading or if there's an error
                                Color.gray
                            }
                            .frame(width: 100, height: 150)
                            
                            VStack (alignment: .leading){
                                Text(release?.title ?? "")
                                    .font(.title2)
                                    .padding(.bottom, 4)
                                Text(release?.sourceName ?? "")
                                    .font(.callout)
                                Text(release?.sourceReleaseDate ?? "")
                                    .font(.caption)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MovieDetailsView(release: ReleasesViewModel.example)
}
