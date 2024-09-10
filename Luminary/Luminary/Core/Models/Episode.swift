//
//  Episode.swift
//  Luminary
//
//  Created by Yago Vanzan on 08/09/24.
//

import Foundation

struct Episode: Hashable {
    var title: String
    var description: String
    var pubDate: String
    var audioUrl: String
    var duration: String
    var isExplicit: Bool
    var guid: String
    var author: String
    var podcastName: String
    var image: String?
    var isPlaying: Bool = false
    
    static func getEmptyEpisode() -> Episode {
        return Episode(title: "", description: "", pubDate: "", audioUrl: "", duration: "", isExplicit: false, guid: "", author: "", podcastName: "")
    }
}
