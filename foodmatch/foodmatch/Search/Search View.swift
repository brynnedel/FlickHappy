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
                            titleResult(response)
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
                        SettingsView()
                    } label: {
                        Image(systemName: "gear")
                            .font(.title)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func titleResult(_ response: SearchResponse) -> some View {
        ScrollView {
//            ForEach(response.titleResults.indices, id: \.self) { index in
//                NavigationLink {
//                    MovieDetailsView()
//                } label: {
//                    HStack {
//                        Rectangle()
//                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 150)
//                            .foregroundStyle(.gray)
//                            .padding()
//                        VStack (alignment: .leading){
//                            Text(response.titleResults[index].title)
//                                .font(.title)
//                            Text("Sources")
//                                .font(.caption)
//                            Text ("Genres")
//                                .font(.caption)
//                                .padding(.bottom)
//                            Text("Description")
//                        }
//                        Spacer()
//                    }
//                    .frame(height: 170)
//                    Rectangle()
//                        .frame(height: 1)
//                        .foregroundStyle(.white)
//                        .padding(.horizontal, 8)
//                }
//            }
//            ForEach(response.peopleResults.indices, id: \.self) { index in
//                HStack {
//                    Rectangle()
//                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 150)
//                        .foregroundStyle(.gray)
//                        .padding()
//                    VStack (alignment: .leading){
//                        Text(response.peopleResults[index].fullName)
//                            .font(.title)
//                        Text("Sources")
//                            .font(.caption)
//                        Text ("Genres")
//                            .font(.caption)
//                            .padding(.bottom)
//                        Text("Description")
//                    }
//                    Spacer()
//                }
//                .frame(height: 170)
//                Rectangle()
//                    .frame(height: 1)
//                    .foregroundStyle(.white)
//                    .padding(.horizontal, 8)
//            }
        }
    }
    
    @ViewBuilder
    private func peopleResult(_ people: [PeopleResult]) -> some View {
        ScrollView {
            ForEach(people) { person in
                
                HStack {
                    Rectangle()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 150)
                        .foregroundStyle(.gray)
                        .padding()
                    VStack (alignment: .leading){
                        Text(person.name)
                            .font(.title)
                        Text("Sources")
                            .font(.caption)
                        Text ("Genres")
                            .font(.caption)
                            .padding(.bottom)
                        Text("Description")
                    }
                    Spacer()
                }
                .frame(height: 170)
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
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
