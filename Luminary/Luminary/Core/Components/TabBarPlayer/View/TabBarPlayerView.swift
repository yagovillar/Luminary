//
//  TabBarPlayerView.swift
//  Luminary
//
//  Created by Yago Vanzan on 08/09/24.
//

import SwiftUI

struct TabBarPlayerView: View {
    
    @Binding var value: Double

    var body: some View {
        ZStack {
            Color(hex: "382E29").ignoresSafeArea()
            VStack {
                HStack {
                    Image(uiImage: UIImage(named: "LaunchScreenImage") ?? UIImage())
                        .resizable()
                        .frame(width: 56, height: 56)
                        .clipShape(.rect(cornerRadius: 12))
                    
                    VStack(alignment: .leading) {
                        Text("Episode Name")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                        Text("Podcast Name")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(Color(hex: "BAA89E"))
                    }
                    Spacer()
                    Image(uiImage: UIImage(named: "PlayButton") ?? UIImage())
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(.rect(cornerRadius: 12))
                }
                
                CustomSlider(value: $value)
                HStack {
                    Text("0:00")
                        .foregroundStyle(Color(hex: "BAA89E"))
                        .font(.system(size: 12, weight: .regular))
                    Spacer()
                    Text("0:00")
                        .foregroundStyle(Color(hex: "BAA89E"))
                        .font(.system(size: 12, weight: .regular))
                }
                
            }.padding()
        }.frame(width: UIScreen.main.bounds.width, height: 132)
            .clipShape(RoundedCorner(radius: 12, corners: [.topLeft, .topRight]))
    }
}

#Preview {
    TabBarPlayerView(value: .constant(5.0))
}
