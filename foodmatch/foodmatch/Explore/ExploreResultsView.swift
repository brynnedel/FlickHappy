//
//  ExploreResultsView.swift
//  foodmatch
//
//  Created by Brynne Delaney on 27/01/2024.
//

import SwiftUI

struct ExploreResultsView: View {
    @ObservedObject var vm: ExploreViewModel
    var titles: [Title]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                VStack (alignment: .leading) {
                    ForEach(titles) { title in
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
            }
        }
    }
}

#Preview {
    ExploreResultsView(vm: ExploreViewModel(), titles: ExploreViewModel.example)
}
