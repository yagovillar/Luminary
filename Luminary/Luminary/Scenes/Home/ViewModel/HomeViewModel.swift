//
//  HomeViewModel.swift
//  Luminary
//
//  Created by Yago Vanzan on 08/09/24.
//

import Foundation
import SwiftUI

extension HomeView {
    @Observable class ViewModel {
        private var podcastService: PodcastService
        private (set) var podcast: Podcast?
        var errorToast: Toast?
        
        init(podcastService: PodcastService) {
            self.podcastService = podcastService
        }
        
        func fetchPodcast() {
            podcastService.fetchPodcast(from: "https://feeds.megaphone.fm/la-cotorrisa") { result in
                switch result {
                case .success(let success):
                    self.podcast = success
                case .failure(let failure):
                    self.errorToast = Toast(style: .error, message: failure.localizedDescription)
                }
            }
        }
    }
}
