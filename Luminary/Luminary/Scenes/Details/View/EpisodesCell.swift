//
//  EpisodesCell.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

import SwiftUI

struct EpisodesCell: View {
    
    private var episode: Episode
    
    init(episode: Episode) {
        self.episode = episode
    }
    
    var body: some View {
        ZStack{
            Color(hex: "171412")
            HStack {
                AsyncImage(url: URL(string: episode.image ?? "")) { image in
                    image.image?.resizable()
                }
                .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .leading) {
                    Text(episode.title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                    
                    Text(episode.pubDate.description)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color(hex: "BAA89C"))
                    Text(episode.duration.description)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color(hex: "BAA89C"))                }.padding(.leading, 8)
                Spacer()
            }
        }
    }
}


