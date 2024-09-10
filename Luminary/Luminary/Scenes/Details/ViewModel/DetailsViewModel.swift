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
    class ViewModel {
        private var podcastService: PodcastService
        private var podcastUrl: String
        private (set) var podcast: Podcast?
        
        var errorToast: Toast?
        var isLoading: Bool = false
        
        init(podcastService: PodcastService, podcastUrl: String) {
            self.podcastService = podcastService
            self.podcastUrl = podcastUrl
        }
        
        func fetchPodcast() {
            isLoading.toggle()
            self.podcastService.fetchPodcast(from: podcastUrl) { result in
                switch result {
                case .success(let success):
                    self.podcast = success
                    self.isLoading.toggle()
                case .failure(let failure):
                    self.errorToast = Toast(style: .error, message: failure.localizedDescription)
                    self.isLoading.toggle()
                }
            }
        }
    }
}
