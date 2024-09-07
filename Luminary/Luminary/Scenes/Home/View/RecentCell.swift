//
//  RecentCell.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

import SwiftUI

struct RecentCell: View {
    var body: some View {
        ZStack{
            Color(hex: "171412")
            HStack {
                Image(uiImage: UIImage(named: "LaunchScreenImage") ?? UIImage())
                    .resizable()
                    .frame(width: 56, height: 56, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .leading) {
                    Text("RSS")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                    
                    Text("RSS")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.white)
                }.padding(.leading, 8)
                Spacer()
            }
        }
    }
}

#Preview {
    RecentCell()
}
