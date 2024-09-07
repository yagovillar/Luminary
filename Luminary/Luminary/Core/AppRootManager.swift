//
//  AppRootManager.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

import Foundation

final class AppRootManager: ObservableObject {
    
    @Published var currentRoot: eAppRoots = .launch
    
    enum eAppRoots {
        case launch
        case home
    }
}
