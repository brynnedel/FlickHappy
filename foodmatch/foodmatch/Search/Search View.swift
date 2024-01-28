//
//  Search View.swift
//  foodmatch
//
//  Created by Brynne Delaney on 26/01/2024.
//

import SwiftUI

struct Search_View: View {
    @FocusState private var focused: Bool?
    @StateObject private var vm = SearchViewModel()
    
    var givenType : String = ""
    func getType(type: String) -> String {
        switch type {
            case "movie":
                return "Movie"
            case "tv_series":
                return "Series"
            case "tv_miniseries":
                return "Mini Series"
            case "short_film":
                return "Short Film"
            default:
                return ""
            }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background").ignoresSafeArea()
                VStack {
                    Section {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(height: 40)
                                .foregroundStyle(.white)
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .font(.title)
                                    .foregroundStyle(.black)
                                    .padding(.leading)
                                TextField("Search for titles or people", text: $vm.searchTerm)
                                    .focused($focused, equals: true)
                                    .onAppear { focused = true }
                                Button {
                                    Task {
                                        await vm.loadSearch()
                                    }
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .frame(width: 50, height:30)
                                        Text("Go")
                                            .foregroundStyle(.white)
                                    }
                                    .padding(.trailing, 8)
                                }
                                
                            }
                        }
                    }
                    .padding([.horizontal, .top])
                    Section {
                        switch vm.state {
                        case .idle:
                            EmptyView()
                        case .loading:
                            loadingView
                        case .success(let response):
                            result(response)
                        case .detailSuccess(let details):
                            MovieDetailsView(poster: details.poster, title: details.title, date: details.releaseDate, sources: details.sources, description: details.plotOverview)
                        case .error(let error):
                            errorView(error)
                        }
                    }
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        ExploreView()
                    } label: {
                        Image(systemName: "safari")
                            .font(.title)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func result(_ response: SearchResponse) -> some View {
        ScrollView {
            VStack (alignment: .leading) {
                ForEach(response.titleResults) { title in
                    Button {
                        Task {
                            await vm.getTitleDetails(id: title.id)
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color("Accent"))
                            .frame(height: 100)
                            .overlay {
                                VStack {
                                    Text(title.name)
                                        .font(.title2)
                                    Text(self.getType(type: title.type))
                                    
                                }
                            }
                            .padding()
                    }
                    .buttonStyle(.plain)
                
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                }
            }
            ForEach(response.peopleResults) {person in
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(Color("Accent"))
                    .frame(height: 100)
                    .overlay {
                        VStack {
                            Text(person.name)
                                .font(.title2)
                        }
                    }
                    .padding()
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
    Search_View()
}
