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
        if podcastTitle == "" {
            podcastTitle = title
        }
    }
    
    func appendPodcastDescription(_ description: String) {
            podcastDescription += description
    }
    
    func setPodcastImageUrl(_ url: String) {
        if podcastImageUrl == "" {
            podcastImageUrl = url
        }
    }
    
    // MARK: - Episode Parsing Methods
    
    func startNewEpisode() {
        currentEpisode = Episode(
            title: "", description: "", pubDate: "", audioUrl: "", duration: "", isExplicit: false, guid: "", author: "", podcastName: podcastTitle
        )
    }
    
    func appendCurrentEpisodeTitle(_ title: String) {
        if currentEpisode?.title == "" {
            currentEpisode?.title = title
        }
    }
    
    func setCurrentEpisodeDuration(_ duration: String) {
        if currentEpisode?.duration == "" {
            currentEpisode?.duration = duration.toTimeFormat() ?? ""
        }
    }
    
    func appendCurrentEpisodeDescription(_ description: String) {
        if currentEpisode?.description == "" {
            currentEpisode?.description = description
        }
    }
    
    func appendCurrentPubDate(_ pubDate: String) {
        if let date = DateFormatter.convertPubDate(pubDate) {
            currentEpisode?.pubDate = date.timeAgoSinceNow()
        }
    }
    
    func setCurrentAudioUrl(_ url: String) {
        currentEpisode?.audioUrl = url
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
        if var episode = currentEpisode {
            episode.image = podcastImageUrl
            episodes.append(episode)
        }
        currentEpisode = nil
    }
    
    // MARK: - Final Build Methods
    
    func finishPodcast() {
        if let data = podcastDescription.data(using: .utf8) {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            
            if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
                let plainText = attributedString.string
                podcastDescription = plainText
            }
        }
    }
    
    func build() -> Podcast? {
        guard !podcastTitle.isEmpty else { return nil }
        
        return Podcast(
            title: podcastTitle,
            description: podcastDescription,
            image: PodcastImage(url: podcastImageUrl, title: "", link: ""),
            author: podcastAuthor,
            episodes: episodes
        )
    }
}
