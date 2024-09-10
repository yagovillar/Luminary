//
//  DetailsVIew.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

import SwiftUI

struct DetailsView: View {
    
    @State private var viewModel: ViewModel
    @State private var showPlayer = false
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        ScrollView {
            ZStack{
                Color(hex: "171412").ignoresSafeArea()
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: viewModel.podcast?.image.url ?? "")) { image in
                        image.image?.resizable()
                    }
                    .frame(height: 136)
                    
                    Text(viewModel.podcast?.title ?? "")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top)
                    
                    Text(viewModel.podcast?.description ?? "")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.white)
                        .padding(.top)
                    
                    Text("Episodes")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top)
                    
                    LazyVStack(alignment:.leading) {
                        ForEach(0..<(viewModel.podcast?.episodes.count ?? 0),id: \.self) { number in
                            NavigationLink(destination: PlayerView(viewModel: PlayerView.ViewModel(episode: getEpisode(at: number)))) {
                                    EpisodesCell(episode: self.getEpisode(at: number)).padding(.vertical, 5)
                                }
                            }
                        }
                    
                    
                    Spacer()
                }.padding()

            }.navigationBarModifier(backgroundColor: UIColor(Color(hex: "171412")), foregroundColor: .white, tintColor: nil, withSeparator: false)
                .navigationTitle(viewModel.podcast?.title ?? "")
                .navigationBarTitleDisplayMode(.inline)
                .toastView(toast: $viewModel.errorToast)
                .isLoading(viewModel.isLoading)
                .onAppear(perform: {
                    viewModel.fetchPodcast()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        showPlayer = AudioPlayer.shared.player != nil
                    })
            })
                .sheet(isPresented: $showPlayer) {
                        TabBarPlayerView()
                            .interactiveDismissDisabled()
                            .presentationDetents([.height(120)])
                            .presentationBackgroundInteraction(.enabled(upThrough: .height(120)))
                }
        }.background(
            Color(hex: "171412")
        )
    }
    
    func getEpisode(at index: Int) -> Episode {
        guard var episode = viewModel.podcast?.episodes[index] else { return Episode.getEmptyEpisode() }
        episode.image = viewModel.podcast?.image.url
        return episode
    }
}
