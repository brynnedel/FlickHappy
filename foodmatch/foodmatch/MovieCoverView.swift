//
//  MovieCoverView.swift
//  foodmatch
//
//  Created by Brynne Delaney on 26/01/2024.
//

import SwiftUI

struct MovieCoverView: View {
    var release: Release
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: release.posterURL)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        // Placeholder while loading or if there's an error
                        Color.gray
                    }   .frame(width: 100, height: 150)
//            Rectangle()
//                .frame(width: 100, height: 150)
//                .foregroundStyle(.gray)
            Text(release.title)
                .foregroundStyle(.white)
                .frame(width: 100)
        }
    }
}

#Preview {
    MovieCoverView(release: ReleasesViewModel.example)
}
