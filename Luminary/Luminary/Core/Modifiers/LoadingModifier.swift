//
//  LoadingModifier.swift
//  Luminary
//
//  Created by Yago Vanzan on 09/09/24.
//

import Foundation
import SwiftUI

struct LoadingModifier: ViewModifier {
    let isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? 3 : 0)
            
            if isLoading {
                    ZStack {
                        VStack {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .controlSize(.extraLarge)
                        }
                    }
            }
        }.ignoresSafeArea()
    }
}
