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
        var errorToast: Toast?
        var shouldNavigate: Bool = false
        var isLoading: Bool = false
        
        init(podcastService: PodcastService) {
            self.podcastService = podcastService
        }
        
        func validate(url: String) {
            isLoading.toggle()
            podcastService.validateRSSURL(url) { result in
                switch result {
                case .success(let success):
                    self.shouldNavigate = success
                    self.isLoading.toggle()
                case .failure(let failure):
                    self.errorToast = Toast(style: .error, message: failure.localizedDescription)
                    self.isLoading.toggle()
                }
            }
        }
        
    }
}
