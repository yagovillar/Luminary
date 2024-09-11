//
//  TextFieldStyle.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

import Foundation
import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        GeometryReader { geometry in
            configuration
                .frame(height: 40)
                .padding(16)
                .background(
                    Color(hex: "26211C")
                        .cornerRadius(12) // Adiciona o corner radius ao fundo
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(hex: "54453B"), lineWidth: 1)
                )
        }
    }
}
