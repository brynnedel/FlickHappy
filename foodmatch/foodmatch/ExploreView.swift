//
//  ExploreView.swift
//  foodmatch
//
//  Created by Brynne Delaney on 27/01/2024.
//

import SwiftUI

struct ExploreView: View {
    mutating func getSourceID() {
        switch source {
        case "Netflix":
            self.sourceID = 203
        case "Hulu":
            self.sourceID = 157
        case "Prime Video":
            self.sourceID = 26
        case "Max":
            self.sourceID = 387
        case "Apple TV":
            self.sourceID = 371
        default:
            self.sourceID = 0
        }
    }
    
    var selected: Bool {
        if (type == "" || source == "" || genre == "") {
            return false
        }
        return true
    }
    var sourceID: Int = 0
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

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
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
                    

                    Section {
                        optionsView(type: type, genre: genre, source: source)
                    }
                        
                    if (selected) {
                        Rectangle()
                            .foregroundStyle(.white)
                            .frame(height: 1)
                            .padding()
                        
                        Button {
                            
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
                    
                    Spacer()
                    
                }
                
            }
            .navigationTitle("Explore New Titles")
        }
    }
    
    @ViewBuilder
    private func optionsView(type: String, genre: String, source: String) -> some View {
        GeometryReader { geometry in
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
            }
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    ExploreView()
}
