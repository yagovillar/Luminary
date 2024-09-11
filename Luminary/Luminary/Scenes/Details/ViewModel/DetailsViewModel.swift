//
//  DetailsViewModel.swift
//  Luminary
//
//  Created by Yago Vanzan on 09/09/24.
//

import Foundation
import SwiftUI

extension DetailsView {
    @Observable
    class ViewModel: ObservableObject {
        private var podcastService: PodcastService
        private var podcastUrl: String
        private (set) var podcast: Podcast?
        private var appManager = AppDataManager.shared
        
        var errorToast: Toast?
        var isLoading: Bool = false
        
        init(podcastService: PodcastService, podcastUrl: String, podcast: Podcast? = nil) {
            self.podcastService = podcastService
            self.podcastUrl = podcastUrl
            self.podcast = podcast
        }
        
        @MainActor func fetchPodcast() {
            isLoading.toggle()
            if let podcast = self.podcast {
                self.appManager.updatePlayingPodcast(podcast: podcast)
                self.appManager.appendPodcast(podcast: podcast)
                isLoading.toggle()
            } else {
                self.podcastService.fetchPodcast(from: podcastUrl) { [weak self] result in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            self.podcast = success
                            self.appManager.updatePlayingPodcast(podcast: success)
                            self.appManager.appendPodcast(podcast: success)
                        case .failure(let failure):
                            self.errorToast = Toast(style: .error, message: failure.localizedDescription)
                        }
                        self.isLoading.toggle()
                    }
                }

            }
        }
    }
}
