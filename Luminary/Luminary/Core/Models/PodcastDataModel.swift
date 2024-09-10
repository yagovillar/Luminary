//
//  PodcastDataModel.swift
//  Luminary
//
//  Created by Yago Vanzan on 10/09/24.
//

import Foundation
import SwiftData

@Model class PodcastDataModel {
    var recentPodcasts: [Podcast]
    var playingPodcast: Podcast
}
