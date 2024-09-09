//
//  PodcastBuilder.swift
//  Luminary
//
//  Created by Yago Vanzan on 09/09/24.
//

import Foundation

class PodcastBuilder {
    private var podcastTitle = ""
    private var podcastDescription = ""
    private var podcastImageUrl = ""
    private var podcastAuthor = ""
    private var episodes: [Episode] = []
    
    private var currentEpisode: Episode?
    
    // MARK: - Podcast Parsing Methods
    
    func appendPodcastTitle(_ title: String) {
        podcastTitle += title
    }
    
    func appendPodcastDescription(_ description: String) {
        podcastDescription += description
    }
    
    func setPodcastImageUrl(_ url: String) {
        podcastImageUrl = url
    }
    
    // MARK: - Episode Parsing Methods
    
    func startNewEpisode() {
        currentEpisode = Episode(
            title: "", description: "", pubDate: Date(), audioUrl: "", duration: 0, isExplicit: false, guid: "", author: "", podcastName: podcastTitle
        )
    }
    
    func appendCurrentEpisodeTitle(_ title: String) {
        currentEpisode?.title += title
    }
    
    func appendCurrentEpisodeDescription(_ description: String) {
        currentEpisode?.description += description
    }
    
    func appendCurrentPubDate(_ pubDate: String) {
        if let date = DateFormatter.convertPubDate(pubDate) {
            currentEpisode?.pubDate = date
        }
    }
    
    func setCurrentAudioUrl(_ url: String) {
        currentEpisode?.audioUrl = url
    }
    
    func setCurrentDuration(_ duration: String) {
        currentEpisode?.duration = Int(duration) ?? 0
    }
    
    func setCurrentExplicit(_ isExplicit: Bool) {
        currentEpisode?.isExplicit = isExplicit
    }
    
    func setCurrentGuid(_ guid: String) {
        currentEpisode?.guid = guid
    }
    
    func setCurrentAuthor(_ author: String) {
        currentEpisode?.author = author
    }
    
    func finishCurrentEpisode() {
        if let episode = currentEpisode {
            episodes.append(episode)
        }
        currentEpisode = nil
    }
    
    // MARK: - Final Build Methods
    
    func finishPodcast() {
        // This could also set other podcast-level info if necessary
    }
    
    func build() -> Podcast? {
        guard !podcastTitle.isEmpty else { return nil }
        
        return Podcast(
            title: podcastTitle,
            description: podcastDescription,
            imageUrl: podcastImageUrl,
            author: podcastAuthor,
            episodes: episodes
        )
    }
}
