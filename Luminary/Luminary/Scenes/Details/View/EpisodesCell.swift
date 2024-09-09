//
//  EpisodesCell.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

import SwiftUI

struct EpisodesCell: View {
    var body: some View {
        ZStack{
            Color(hex: "171412")
            HStack {
                Image(uiImage: UIImage(named: "LaunchScreenImage") ?? UIImage())
                    .resizable()
                    .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .leading) {
                    Text("The Joe Rogan Experience #1756 - Dr. Mark Gordon")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                    
                    Text("3 days ago")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color(hex: "BAA89C"))
                    Text("2h 24m")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color(hex: "BAA89C"))                }.padding(.leading, 8)
                Spacer()
            }
        }
    }
}

#Preview {
    EpisodesCell()
}
