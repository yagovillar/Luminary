//
//  LuminaryApp.swift
//  Luminary
//
//  Created by Yago Vanzan on 06/09/24.
//

import SwiftUI
import SwiftData

@main
struct LuminaryApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    @ObservedObject var router = Router.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                LaunchScreenView()
                .navigationDestination(for: Router.Destination.self) { destination in
                    switch destination {
                    case .launchScreen:
                        LaunchScreenView()
                    case .homeScreen:
                        Text("TESTE")
                    }
                }
            }
        }
    }
}
