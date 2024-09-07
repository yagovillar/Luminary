//
//  ContentView.swift
//  Luminary
//
//  Created by Yago Vanzan on 06/09/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @ObservedObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                LaunchScreenView()
                .navigationDestination(for: Router.Destination.self) { destination in
                    switch destination {
                    case .livingroom:
                        LaunchScreenView()
                    }
                }
            }
            .environmentObject(router)
        }
    }
}

#Preview {
    ContentView()
}
