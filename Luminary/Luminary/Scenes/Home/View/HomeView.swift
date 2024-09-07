//
//  HomeView.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

import SwiftUI

struct HomeView: View {
    @State private var rss = ""

    var body: some View {
        ZStack{
            Color(.black).ignoresSafeArea()
            VStack{
                VStack { // TextField
                    VStack(alignment: .leading) {
                        Text("RSS")
                            .font(.headline)
                            .foregroundStyle(.white)

                        TextField("", text: $rss, prompt: Text("Paste  the RSS URL").foregroundStyle(Color(hex: "BAA89C")))
                        .foregroundStyle(Color(hex: "BAA89C"))
                            .textFieldStyle(CustomTextFieldStyle())
                    }
                }.padding()
                    .frame(height: 112)
                
                VStack(alignment: .leading) {
                    Text("Recently Played")
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    ScrollView {
                        
                    }
                }.padding(.top, 30)
                    .padding()
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    HomeView()
}
