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

    @StateObject private var appRootManager = AppRootManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentRoot {
                case .launch:
                    LaunchScreenView()
                case .home:
                    HomeView()
                }
            }
            .environmentObject(appRootManager)
        }
    }
}
