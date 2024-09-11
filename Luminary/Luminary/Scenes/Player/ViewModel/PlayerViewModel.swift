//
//  File.swift
//  Luminary
//
//  Created by Yago Vanzan on 10/09/24.
//

import Foundation
import SwiftUI
import AVKit

extension PlayerView {
    @Observable
    class ViewModel {
        private (set) var episode: Episode = AudioPlayer.shared.episode
        private (set) var player = AudioPlayer.shared
        
        var errorToast: Toast?
        var isLoading: Bool = false
        
        
        init(episode: Episode) {
            self.episode = episode
        }
        
        func setupViewModel(appDataManager: AppDataManager) {
            DispatchQueue.main.async {
                appDataManager.updatePlayingEpisode(episode: self.episode)
                self.player.setup(appManager: appDataManager)
            }
        }
        
        
    }
}
