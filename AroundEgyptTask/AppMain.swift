//
//  AppMain.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import SwiftUI

@main
struct AppMain: App {
    @StateObject private var homeVM = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeScreen()
                    .environmentObject(homeVM)
            }
        }
    }
}
