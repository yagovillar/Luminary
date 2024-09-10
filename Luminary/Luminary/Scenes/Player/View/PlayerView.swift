//
//  PlayerView.swift
//  Luminary
//
//  Created by Yago Vanzan on 08/09/24.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    @State private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color(hex: "171412").ignoresSafeArea()
            VStack(alignment: .center) {
                AsyncImage(url: URL(string: viewModel.episode.image ?? "")) { image in
                    image.image?.resizable()
                }
                .frame(width: 256, height: 256)
                .clipShape(.rect(cornerRadius: 12))
                
                Text(viewModel.episode.title)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.top)
                
                Text(viewModel.episode.podcastName)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color(hex: "BAA89E"))
                
                Slider(value: Binding(get: { viewModel.player.currentTime }, set: { newValue in
                    viewModel.player.seekAudio(to: newValue)
                }), in: 0...viewModel.player.totalTime)
                .foregroundStyle(.white)
                .padding(.horizontal)
                HStack {
                    Text(viewModel.player.currentTime.toTimeString())
                        .foregroundStyle(Color(hex: "BAA89E"))
                        .font(.system(size: 12, weight: .regular))
                    Spacer()
                    Text(viewModel.player.episode?.duration.toTimeFormat() ?? "")
                        .foregroundStyle(Color(hex: "BAA89E"))
                        .font(.system(size: 12, weight: .regular))
                }
                
                HStack(spacing: 24) {
                    
                    Button(action: {
                        viewModel.player.seekAudio(to: viewModel.player.currentTime - 30.0)
                    }, label: {
                        Image(systemName: "backward.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white)
                            .font(.system(size: 30))
                    })
                    
                    Button(action: {
                        viewModel.player.playButtonTapped()
                    }, label: {
                        Image(uiImage: UIImage(named: viewModel.player.isPlaying ? "PauseButton" : "PlayButton") ?? UIImage())
                            .resizable()
                            .frame(width: 64, height: 64)
                            .clipShape(.rect(cornerRadius: 12))
                    })
                    
                    Button(action: {
                        viewModel.player.seekAudio(to: viewModel.player.currentTime + 30.0)
                    }, label: {
                        Image(systemName: "forward.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white)
                            .font(.system(size: 30))
                    })

                }.padding()
            }.onAppear(perform: {
                viewModel.player.loadAudio()
            })
            .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect(), perform: { _ in
                viewModel.player.updateProgress()
            })
            .toastView(toast: $viewModel.errorToast)
            .isLoading(viewModel.player.isLoading)
        }
    }
}

#Preview {
    PlayerView(viewModel: PlayerView.ViewModel(episode: Episode.getEmptyEpisode()))
}
