//
//  AudioPlayer.swift
//  Luminary
//
//  Created by Yago Vanzan on 10/09/24.
//

import Foundation
import AVKit
import Combine
import SwiftUI
import SwiftData

@Observable class AudioPlayer: ObservableObject {
    var totalTime: TimeInterval = 0.0
    var isPlaying = false
    var currentTime: TimeInterval = 0.0
    var isLoading = false
    var episode: Episode = Episode.getEmptyEpisode()
    
    private (set) var player: AVAudioPlayer?
    private var timer: AnyCancellable?
    private (set) var appDataManager: AppDataManager?

    
    // Singleton instance
    static let shared = AudioPlayer()
    
    // Private initializer to prevent instantiation from outside
    private init() {}
    
    // Setup with an episode
    @MainActor func setup(appManager: AppDataManager) {
        self.appDataManager = appManager
        self.loadAudio()
    }
    
    @MainActor func loadAudio() {
        appDataManager?.fetchPodcast(completion: { result in
            switch result {
            case .success(let success):
                guard let episode = success.playingEpisode, let url = URL(string: episode.audioUrl) else {
                    print("Invalid URL or Episode not set")
                    return
                }
                self.episode = episode
                self.isLoading = true
                
                URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                    guard let self = self else { return }
                    
                    DispatchQueue.main.async {
                        self.isLoading = false
                        
                        if let error = error {
                            print("Error loading audio: \(error.localizedDescription)")
                            return
                        }
                        
                        guard let data = data else {
                            print("No data received")
                            return
                        }
                        
                        do {
                            self.player = try AVAudioPlayer(data: data)
                            self.totalTime = self.player?.duration ?? 0
                            self.startTimer()
                        } catch {
                            print("Error creating audio player: \(error.localizedDescription)")
                        }
                    }
                }.resume()
            case .failure(let failure):
                print("Error creating audio player: \(failure.localizedDescription)")
            }
        })
    }
    
    func playButtonTapped() {
        guard let player = player else { return }
        
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
    }
    
    func updateProgress() {
        guard let player = player else { return }
        currentTime = player.currentTime
    }
    
    func seekAudio(to time: TimeInterval) {
        guard let player = player else { return }
        player.currentTime = max(time, 0)
    }
    
    @MainActor func moveFoward() {
        appDataManager?.fetchPodcast(completion: { result in
            switch result {
            case .success(let success):
                if let nextEpisode = self.get(nextEpisode: true, from: success.playingPodcast?.episodes ?? [], currentEpisode: self.episode) {
                    self.appDataManager?.updatePlayingEpisode(episode: nextEpisode)
                    if self.isPlaying{
                        self.playButtonTapped()
                    }
                    self.loadAudio()
                }
            case .failure(let failure):
                print("Error going foward: \(failure.localizedDescription)")
            }
        })
    }
    
    @MainActor func moveBackWards() {
        appDataManager?.fetchPodcast(completion: { result in
            switch result {
            case .success(let success):
                if let nextEpisode = self.get(nextEpisode: false, from: success.playingPodcast?.episodes ?? [], currentEpisode: self.episode) {
                    self.appDataManager?.updatePlayingEpisode(episode: nextEpisode)
                    if self.isPlaying{
                        self.playButtonTapped()
                    }
                    self.loadAudio()
                }
            case .failure(let failure):
                print("Error going foward: \(failure.localizedDescription)")
            }
        })
    }
    
    private func get(nextEpisode: Bool, from episodes: [Episode], currentEpisode: Episode) -> Episode? {
        guard let currentIndex = episodes.firstIndex(where: {$0.title == currentEpisode.title}) else {
            return nil // Current episode not found in the array
        }
        
        if nextEpisode {
            let nextIndex = currentIndex + 1
            if nextIndex < episodes.count {
                return episodes[nextIndex]
            } else {
                return nil // No next episode available
            }
        } else {
            let nextIndex = currentIndex - 1
            if nextIndex >= 0 {
                return episodes[nextIndex]
            } else {
                return nil // No next episode available
            }
        }

    }
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateProgress()
            }
    }
    
    deinit {
        timer?.cancel()
    }
}
