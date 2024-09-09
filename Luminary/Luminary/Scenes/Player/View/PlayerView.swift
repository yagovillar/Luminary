//
//  PlayerView.swift
//  Luminary
//
//  Created by Yago Vanzan on 08/09/24.
//

import SwiftUI

struct PlayerView: View {
    var body: some View {
        ZStack {
            Color(hex: "171412").ignoresSafeArea()
            VStack(alignment: .center) {
                Image(uiImage: UIImage(named: "LaunchScreenImage") ?? UIImage())
                    .resizable()
                    .frame(width: 256, height: 256)
                    .clipShape(.rect(cornerRadius: 12))
                
                Text("Episode Name")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.top)
                
                Text("Podcast Name")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color(hex: "BAA89E"))
                
                CustomSlider(value: .constant(5.0))
                    .padding(.vertical)
                HStack {
                    Text("0:00")
                        .foregroundStyle(Color(hex: "BAA89E"))
                        .font(.system(size: 12, weight: .regular))
                    Spacer()
                    Text("0:00")
                        .foregroundStyle(Color(hex: "BAA89E"))
                        .font(.system(size: 12, weight: .regular))
                }
                
                HStack(spacing: 24) {
                    Image(systemName: "backward.end.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white)
                        .font(.system(size: 30))
                    
                    Image(systemName: "backward.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white)
                        .font(.system(size: 30))
                    
                    Image(uiImage: UIImage(named: "PlayButton") ?? UIImage())
                        .resizable()
                        .frame(width: 64, height: 64)
                        .clipShape(.rect(cornerRadius: 12))

                    Image(systemName: "forward.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white)
                        .font(.system(size: 30))
                    
                    Image(systemName: "forward.end.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white)
                        .font(.system(size: 30))
                }.padding()
                
                Spacer()
            }.padding()
                .padding(.top, 80)
        }
    }
}

#Preview {
    PlayerView()
}
