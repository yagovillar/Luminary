//
//  RecentCell.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

import SwiftUI

struct RecentCell: View {
    
    private var podcast: Podcast
    
    init(podcast: Podcast) {
        self.podcast = podcast
    }
    
    var body: some View {
        ZStack{
            Color(hex: "171412")
            HStack {
                AsyncImage(url: URL(string: podcast.image.url ?? "")){ image in
                    image.image?.resizable()
                }
                    .frame(width: 56, height: 56, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .leading) {
                    Text(podcast.title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                }.padding(.leading, 8)
                Spacer()
            }
        }
    }
}

//#Preview {
//    RecentCell()
//}
