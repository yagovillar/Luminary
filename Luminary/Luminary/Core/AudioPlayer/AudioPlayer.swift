//
//  AudioPlayer.swift
//  Luminary
//
//  Created by Yago Vanzan on 10/09/24.
//

import Foundation
import AVKit
import Combine

@Observable class AudioPlayer: ObservableObject {
    var totalTime: TimeInterval = 0.0
    var isPlaying = false
    var currentTime: TimeInterval = 0.0
    var isLoading = false
    
    private (set) var episode: Episode?
    private (set) var player: AVAudioPlayer?
    private var timer: AnyCancellable?
    
    // Singleton instance
    static let shared = AudioPlayer()
    
    // Private initializer to prevent instantiation from outside
    private init() {}
    
    // Setup with an episode
    func setup(with episode: Episode) {
        self.episode = episode
    }
    
    func loadAudio() {
        guard let episode = episode, let url = URL(string: episode.audioUrl) else {
            print("Invalid URL or Episode not set")
            return
        }
        
        isLoading = true
        
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
                    self.episode?.isPlaying = true
                    self.startTimer()
                } catch {
                    print("Error creating audio player: \(error.localizedDescription)")
                }
            }
        }.resume()
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
