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
    @EnvironmentObject var appDataManager: AppDataManager

    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
                ZStack {
                    Color(hex: "171412").ignoresSafeArea()
                    
                    VStack(alignment: .leading) {
                        podcastImage
                        podcastTitle
                        podcastDescription
                        episodesSection

                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .padding()
                }
                .navigationBarModifier(
                    backgroundColor: UIColor(Color(hex: "171412")),
                    foregroundColor: .white, tintColor: .white,
                    withSeparator: false
                )
                .navigationTitle(viewModel.podcast?.title ?? "")
                .navigationBarTitleDisplayMode(.inline)
                .toastView(toast: $viewModel.errorToast)
                .isLoading(viewModel.isLoading)
                .onAppear(perform: setup)
            .   background(Color(hex: "171412"))
        }
    }
    
    private var podcastImage: some View {
        AsyncImage(url: URL(string: viewModel.podcast?.image.url ?? "")) { image in
            image.image?.resizable()
        }
        .frame(height: 136)
        .padding(.top, 80)
    }
    
    private var podcastTitle: some View {
        Text(viewModel.podcast?.title ?? "")
            .font(.system(size: 22, weight: .bold))
            .foregroundStyle(.white)
            .padding(.top)
    }
    
    private var podcastDescription: some View {
        Text(viewModel.podcast?.podDescription ?? "")
            .font(.system(size: 16, weight: .regular))
            .foregroundStyle(.white)
            .padding(.top)
    }
    
    private var episodesSection: some View {
        VStack(alignment: .leading) {
            Text("Episodes")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.white)
                .padding(.top)
            
            List {
                ForEach(viewModel.podcast?.episodes ?? []) { episode in
                    NavigationLink(destination: PlayerView(viewModel: PlayerView.ViewModel(episode: episode))) {
                        EpisodesCell(episode: episode).padding(.vertical, 5)
                    }
                }
            }
        }
    }
    
    @MainActor private func setup() {
        viewModel.fetchPodcast()
    }
}
