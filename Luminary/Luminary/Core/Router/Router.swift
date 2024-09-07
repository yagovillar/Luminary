//
//  Router.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    
    static let shared = Router()
    
    public enum Destination: Codable, Hashable {
        case livingroom
        case test
    }
    
    private init() {}
    
    @Published var navPath = NavigationPath()

    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
