//
//  SettingsView.swift
//  foodmatch
//
//  Created by Brynne Delaney on 26/01/2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background").ignoresSafeArea()
                VStack {
                    Text("Settings")
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
