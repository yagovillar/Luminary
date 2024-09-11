//
//  Podcast.swift
//  Luminary
//
//  Created by Yago Vanzan on 08/09/24.
//

import Foundation

struct Podcast: Codable, Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var podDescription: String
    var image: PodcastImage
    var author: String
    var episodes: [Episode]
}
