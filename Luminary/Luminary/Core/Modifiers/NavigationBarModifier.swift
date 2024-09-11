//
//  NavigationBarModifier.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

import Foundation
import SwiftUI
import UIKit

struct NavigationBarModifier: ViewModifier {
    
    init(backgroundColor: UIColor = .systemBackground, foregroundColor: UIColor = .blue, tintColor: UIColor?, withSeparator: Bool = true) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: foregroundColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor]
        navBarAppearance.backgroundColor = backgroundColor
        
        if withSeparator {
            navBarAppearance.shadowColor = .clear
        }
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().prefersLargeTitles = false
        
        if let tintColor = tintColor {
            UINavigationBar.appearance().tintColor = tintColor
        }
        
        // Remove o texto do botão de voltar
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]  // Deixa o texto invisível
        
        navBarAppearance.backButtonAppearance = backButtonAppearance
        UINavigationBar.appearance().topItem?.backButtonDisplayMode = .minimal  // Remove o texto no back button
        
        // Remove o texto do botão de volta para toda a aplicação
        UINavigationBar.appearance().topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func body(content: Content) -> some View {
        content
    }
}
