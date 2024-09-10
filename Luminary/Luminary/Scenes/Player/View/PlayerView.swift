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
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color(hex: "171412").ignoresSafeArea()
            
            VStack(alignment: .center) {
                AsyncImage(url: URL(string: viewModel.episode.image ?? "")) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 256, height: 256)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
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
                
                ControlsView(viewModel: viewModel)
            }
            .onAppear {
                viewModel.player.loadAudio()
            }
            .toastView(toast: $viewModel.errorToast)
            .isLoading(viewModel.player.isLoading)
        }
    }
}

struct ControlsView: View {
    @State var viewModel: PlayerView.ViewModel
    
    var body: some View {
        HStack(spacing: 24) {
            Button(action: {
                viewModel.player.seekAudio(to: viewModel.player.currentTime - 30.0)
            }) {
                Image(systemName: "backward.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white)
                    .font(.system(size: 30))
            }
            
            Button(action: {
                viewModel.player.playButtonTapped()
            }) {
                Image(uiImage: UIImage(named: viewModel.player.isPlaying ? "PauseButton" : "PlayButton") ?? UIImage())
                    .resizable()
                    .frame(width: 64, height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            Button(action: {
                viewModel.player.seekAudio(to: viewModel.player.currentTime + 30.0)
            }) {
                Image(systemName: "forward.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white)
                    .font(.system(size: 30))
            }
        }
        .padding()
    }
}

#Preview {
    PlayerView(viewModel: PlayerView.ViewModel(episode: Episode.getEmptyEpisode()))
}
