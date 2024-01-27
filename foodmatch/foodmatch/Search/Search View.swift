//
//  Search View.swift
//  foodmatch
//
//  Created by Brynne Delaney on 26/01/2024.
//

import SwiftUI

struct Search_View: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background").ignoresSafeArea()
                VStack {
                    Text("Search")
                }
            }
        }
    }
}

#Preview {
    Search_View()
}
