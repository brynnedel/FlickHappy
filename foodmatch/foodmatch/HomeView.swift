//
//  HomeView.swift
//  foodmatch
//
//  Created by Brynne Delaney on 26/01/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: ReleasesViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background").ignoresSafeArea()
                VStack (alignment: .leading){
                    Text("**New Movies**")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .padding()
                    Section {
                        switch vm.state {
                        case .idle:
                            Text("idle")
                        case .loading:
                            loadingView
                        case .success(let releases):
                            moviesList(releases)
                        case .error(let error):
                            errorView(error)
                        }
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                    Text("**New TV Shows**")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .padding()
                    Section {
                        switch vm.state {
                        case .idle:
                            Text("idle")
                        case .loading:
                            loadingView
                        case .success(let releases):
                            tvList(releases)
                        case .error(let error):
                            errorView(error)
                        }
                    }
                    Spacer()
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink {
                        ExploreView()
                    } label: {
                        Image(systemName: "safari")
                            .font(.title)
                            .foregroundStyle(.black)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        Search_View()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                            .foregroundStyle(.black)
                    }
                    
                }
            }
        }
    }
        

    
    @ViewBuilder
    private func moviesList(_ releases: [Release]) -> some View {
        ScrollView(.horizontal){
            HStack (alignment: .top){
                ForEach(releases) { release in
                    if release.type == "movie"{
                        NavigationLink {
                            MovieDetailsView(poster: release.posterURL,title: release.title, date:release.sourceReleaseDate, source: release.sourceName, sources: [])
                        } label: {
                            MovieCoverView(release: release)
                                .padding([.bottom, .leading])
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func tvList(_ releases: [Release]) -> some View {
        ScrollView(.horizontal){
            HStack (alignment: .top){
                ForEach(releases) { release in
                    if release.type == "tv_series" || release.type == "tv_miniseries"{
                        NavigationLink {
                            MovieDetailsView(poster: release.posterURL,title: release.title, date:release.sourceReleaseDate, source: release.sourceName, sources: [])
                        } label: {
                            MovieCoverView(release: release)
                                .padding([.bottom, .leading])
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var loadingView: some View {
        Text("Loading...")
    }
    
    @ViewBuilder
    private func errorView(_ error: Error) -> some View {
        Text(error.localizedDescription)
    }
}


#Preview {
    HomeView()
}
