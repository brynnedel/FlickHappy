//
//  ExploreView.swift
//  foodmatch
//
//  Created by Brynne Delaney on 27/01/2024.
//

import SwiftUI

struct ExploreView: View {
    var sourceID: Int {
        switch source {
        case "Netflix":
            return 203
        case "Hulu":
            return 157
        case "Prime Video":
            return 26
        case "Max":
            return 387
        case "Apple TV":
            return 371
        default:
            return 0
        }
    }
    
    var typeString: String {
        switch type {
        case "Movie":
            return "movie"
        case "Series":
            return "tv_series"
        case "Mini Series":
            return "tv_miniseries"
        case "Short Film":
            return "short_film"
        default:
            return ""
        }
    }
    
    var genreID: Int {
        switch genre {
        case "Comedy":
            return 4
        case "Documentary":
            return 6
        case "Action":
            return 1
        case "Drama":
            return 7
        case "Crime":
            return 5
        case "Horror":
            return 11
        case "Romance":
            return 14
        default:
            return 0
        }
    }
    
    var selected: Bool {
        if (type == "" || source == "" || genre == "") {
            return false
        }
        return true
    }
    
    var types: [String] = [
        "Movie", "Series", "Mini Series", "Short Film"
    ]
    var sources: [String] = [
        "Netflix", "Hulu", "Prime Video", "Max", "Apple TV"
    ]
    var genres: [String] = [
        "Comedy", "Documentary", "Action", "Drama", "Crime", "Horror", "Romance"
    ]
    @State var type: String = ""
    @State var source: String = ""
    @State var genre: String = ""
    @StateObject var vm = ExploreViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                VStack {
                    Section {
                        switch vm.state {
                        case .idle:
                            optionsView(type: $type, genre: $genre, source: $source)
                        case .loading:
                            loadingView
                        case .success(let response):
                            ExploreResultsView(titles: response)
                        case .error(let error):
                            errorView(error)
                        }
                    }
                }
                
            }
            .navigationTitle("Explore New Titles")
        }
    }
    
    @ViewBuilder
    private func optionsView(type: Binding<String>, genre: Binding<String>, source: Binding<String>) -> some View {
        
        GeometryReader { geometry in
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(height: 125)
                    .foregroundStyle(Color("Accent"))
                    .overlay {
                        Text("Welcome to FlickHappy's explore page. Select different paramenters based on your preferences, then press Go to generate a list of movies to explore!")
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 8)
                    
                Rectangle()
                    .foregroundStyle(.white)
                    .frame(height: 1)
                    .padding()
                

                VStack (alignment: .leading) {
                    Text("Media Type")
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(types, id: \.self) { type in
                            Button {
                                if (self.type == type) {
                                    self.type = ""
                                } else {
                                    self.type = type
                                }
                            } label: {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 100,height: 35)
                                    .foregroundStyle(self.type == type ? .indigo : Color("Accent"))
                                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                    .overlay {
                                        Text(type)
                                            .foregroundStyle(.white)
        
                                    }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.bottom)
                    
                    Text("Genres")
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(genres, id: \.self) { genre in
                            Button {
                                if (self.genre == genre) {
                                    self.genre = ""
                                } else {
                                    self.genre = genre
                                }
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 100,height: 35)
                                    .foregroundStyle(self.genre == genre ? .indigo : Color("Accent"))
                                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                    .overlay {
                                        Text(genre)
                                            .foregroundStyle(.white)
        
                                    }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.bottom)
                    
                    Text("Streaming Platform")
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(sources, id: \.self) { source in
                            Button {
                                if (self.source == source) {
                                    self.source = ""
                                } else {
                                    self.source = source
                                }
                            } label: {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 100,height: 35)
                                    .foregroundStyle(self.source == source ? .indigo : Color("Accent"))
                                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                    .overlay {
                                        Text(source)
                                            .foregroundStyle(.white)
                                        
                                    }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.bottom)
                    VStack (alignment: .center) {
                        if (selected) {
                            Rectangle()
                                .foregroundStyle(.white)
                                .frame(height: 1)
                                .padding()
                            
                            Button {
                                Task {
                                    await vm.loadTitles(type: typeString, source: sourceID, genre: genreID)
                                }
                            } label: {
                                Text("Go!")
                            }
                            .frame(width: 50, height: 30)
                            .background(
                                Capsule()
                                    .fill(.indigo)
                            )
                            .buttonStyle(.plain)
                        }
                    }
                
                Spacer()
                
            }
            
            }
            
        }
        .padding(.horizontal)
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
    ExploreView()
}
