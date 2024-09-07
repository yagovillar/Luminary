//
//  LaunchScreenView.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

import SwiftUI

struct LaunchScreenView: View {
        
    var body: some View {
        NavigationStack {
            ZStack(content: {
                Color(.black).ignoresSafeArea()
                VStack(content: {
                    Image(uiImage: UIImage(named: "LaunchScreenImage") ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: UIScreen.main.bounds.width, height: 218, alignment: .center)
                        .padding(.top, 20)
                    
                    Text("Luminary")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 25)
                    
                    Text("Listen to the best podcasts, ad free.")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 25)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        NavigationLink(destination: HomeView(), label: <#T##() -> View#>)
                    }) {
                        Text("Clique Aqui")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .background(Color(hex: "DE6612"))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                    
                    Spacer()
                })
            })
            .navigationTitle("Luminary")
            .navigationBarModifier(backgroundColor: .systemBackground, foregroundColor: .white, tintColor: nil, withSeparator: true)
        
        }
    }
}

