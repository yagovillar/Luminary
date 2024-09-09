//
//  View+Extensions.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

import Foundation
import SwiftUI

extension View {
    func navigationBarModifier(backgroundColor: UIColor = .systemBackground, foregroundColor: UIColor = .label, tintColor: UIColor?, withSeparator: Bool) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor, tintColor: tintColor, withSeparator: withSeparator))
    }
}

extension View {

  func toastView(toast: Binding<Toast?>) -> some View {
    self.modifier(ToastModifier(toast: toast))
  }
}
