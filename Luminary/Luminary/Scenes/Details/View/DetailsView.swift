//
//  DetailsVIew.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

import SwiftUI

struct DetailsView: View {
    var body: some View {
        ZStack{
            Color(hex: "171412").ignoresSafeArea()
            VStack(alignment: .leading) {
                Image(uiImage: UIImage(named: "LaunchScreenImage") ?? UIImage())
                    .resizable()
                    .frame(height: 136)
                
                Text("About the Show")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.top)
                
                Text("The Joe Rogan Experience podcast is a long form conversation hosted by comedian Joe Rogan with friends and guests that have included comedians, actors, musicians, MMA instructors and commentators, authors, artists, and beyond. ")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(.white)
                    .padding(.top)
                
                Text("Episodes")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.top)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(0..<10, id: \.self) { number in
                            EpisodesCell().padding(.vertical, 5)
                        }
                    }
                }
                
                Spacer()
            }.padding()

        }.navigationBarModifier(backgroundColor: UIColor(Color(hex: "171412")), foregroundColor: .white, tintColor: nil, withSeparator: false)
            .navigationTitle("Podcast Name")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailsView()
}
