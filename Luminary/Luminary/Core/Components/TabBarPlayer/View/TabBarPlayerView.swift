//
//  TabBarPlayerView.swift
//  Luminary
//
//  Created by Yago Vanzan on 08/09/24.
//

import SwiftUI

struct TabBarPlayerView: View {
    
    @ObservedObject private var player = AudioPlayer.shared

    var body: some View {
        ZStack {
            Color(hex: "382E29").ignoresSafeArea()
            VStack {
                HStack {
                    AsyncImage(url: URL(string: player.episode.image ?? "")) { image in
                        image.image?.resizable()
                    }
                        .frame(width: 56, height: 56)
                        .clipShape(.rect(cornerRadius: 12))
                    
                    VStack(alignment: .leading) {
                        Text(player.episode.title)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                        Text(player.episode.podcastName)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(Color(hex: "BAA89E"))
                    }
                    Spacer()
                    Button(action: {
                        player.playButtonTapped()
                    }, label: {
                        Image(uiImage: UIImage(named: player.isPlaying ? "PauseButton" : "PlayButton") ?? UIImage())
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(.rect(cornerRadius: 12))
                    })
                }
                
                Slider(value: Binding(get: { player.currentTime }, set: { newValue in
                    player.seekAudio(to: newValue)
                }), in: 0...player.totalTime)
                HStack {
                    Text(player.currentTime.toTimeString())
                        .foregroundStyle(Color(hex: "BAA89E"))
                        .font(.system(size: 12, weight: .regular))
                    Spacer()
                    Text(player.totalTime.toTimeString())
                        .foregroundStyle(Color(hex: "BAA89E"))
                        .font(.system(size: 12, weight: .regular))
                }
                
            }.padding()
        }.frame(width: UIScreen.main.bounds.width, height: 132)
            .clipShape(RoundedCorner(radius: 12, corners: [.topLeft, .topRight]))
            .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect(), perform: { _ in
                player.updateProgress()
            })
    }
}






