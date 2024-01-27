//
//  ContentView.swift
//  foodmatch
//
//  Created by Brynne Delaney on 02/12/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ReleasesViewModel()

    var body: some View {
        HomeView()
            .environmentObject(vm)
            .task {
                await vm.loadReleases()
            }
    }
}

#Preview {
    ContentView()
}
