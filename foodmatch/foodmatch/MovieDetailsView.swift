//
//  MovieDetailsView.swift
//  foodmatch
//
//  Created by Brynne Delaney on 26/01/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    var poster: String?
    var title: String?
    var date: String?
    var source: String?
    var sources: [Source]
    var description: String?
    
    var possibleSources: [String] = [
        "Netflix", "Hulu", "Prime Video", "Max", "Apple TV"
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                VStack (alignment: .leading){
                    HStack (alignment: .top){
                        if (poster != nil) {
                            AsyncImage(url: URL(string: poster ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 100, height: 150)
                            
                            VStack (alignment: .leading){
                                Text(title ?? "")
                                    .font(.title2)
                                    .padding(.bottom, 4)
                                ForEach(possibleSources, id: \.self) {option in
                                    if sources.contains(where: { $0.name == option }) {
                                        Text(option)
                                            .font(.callout)
                                    }
                                }
                                Text(source ?? "")
                                    .font(.callout)
                                Text(date ?? "")
                                    .font(.caption)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)

                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                    
                    Text("Description")
                        .font(.title3)
                        .padding([.horizontal, .top])
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Color("Accent"))
                        .frame(height: 250)
                        .overlay {
                            VStack (alignment: .leading){

                                Text(description ?? "Description unavailable at this time.")
                                    .font(.callout)
                                    .padding()
                            }
                        }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MovieDetailsView(sources: [])
}
