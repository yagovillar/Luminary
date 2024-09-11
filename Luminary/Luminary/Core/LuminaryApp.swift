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

    @StateObject private var appRootManager = AppRootManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appDataManager = AppDataManager.shared

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
            .environment(appDataManager)
        }
    }
}
