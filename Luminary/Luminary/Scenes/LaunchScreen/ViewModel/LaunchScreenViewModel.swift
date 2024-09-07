//
//  LaunchScreenViewModel.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

import Foundation
import SwiftUI

extension LaunchScreenView {
    @Observable
    class ViewModel {
            
        private let router = Router.shared

        func navigateToHome() {
            router.navigate(to: .homeScreen)
        }
    }
}
