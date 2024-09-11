//
//  PodcastDataModel.swift
//  Luminary
//
//  Created by Yago Vanzan on 10/09/24.
//

import Foundation
import SwiftData

@Model class PodcastDataModel {
    @Attribute(.unique) var id: String
    var recentPodcasts: [Podcast]
    var playingPodcast: Podcast?
    var playingEpisode: Episode?
    
    init(id: String, recentPodcasts: [Podcast] = [], playingPodcast: Podcast? = nil, playingEpisode: Episode? = nil) {
        self.id = id
        self.recentPodcasts = recentPodcasts
        self.playingPodcast = playingPodcast
        self.playingEpisode = playingEpisode
    }
}
