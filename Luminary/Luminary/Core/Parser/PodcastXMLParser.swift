//
//  PodcastXMLParser.swift
//  Luminary
//
//  Created by Yago Vanzan on 09/09/24.
//

import Foundation

class PodcastXMLParser: NSObject, XMLParserDelegate {
    private var podcastBuilder: PodcastBuilder = PodcastBuilder()
    private var currentElement = ""
    private var currentChannelElement = ""
    private var currentImageUrl = ""
    private var isParsingItem = false
    private var isParsingImage = false
    
    func parse(_ data: Data) throws -> Podcast {
        let parser = XMLParser(data: data)
        parser.delegate = self
        
        guard parser.parse() else {
            throw PodcastError.parsingError
        }
        
        guard let podcast = podcastBuilder.build() else {
            throw PodcastError.notFound
        }
        
        return podcast
    }

    // MARK: - XMLParserDelegate Methods
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        switch elementName {
        case "item":
            isParsingItem = true
            podcastBuilder.startNewEpisode()
            
        case "enclosure":
            if let url = attributeDict["url"] {
                podcastBuilder.setCurrentAudioUrl(url)
            }
            
        case "image":
            isParsingImage = true
            
            
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch currentElement {
        case "title":
            isParsingItem ? podcastBuilder.appendCurrentEpisodeTitle(trimmedString) : podcastBuilder.appendPodcastTitle(trimmedString)
            
        case "description":
            isParsingItem ? podcastBuilder.appendCurrentEpisodeDescription(trimmedString) : podcastBuilder.appendPodcastDescription(trimmedString)
            
        case "pubDate":
            podcastBuilder.appendCurrentPubDate(trimmedString)
            
        case "itunes:duration":
            podcastBuilder.setCurrentEpisodeDuration(trimmedString)
            
        case "itunes:explicit":
            podcastBuilder.setCurrentExplicit(trimmedString.lowercased() == "yes")
            
        case "guid":
            podcastBuilder.setCurrentGuid(trimmedString)
            
        case "itunes:author", "author":
            podcastBuilder.setCurrentAuthor(trimmedString)
            
        case "url":
            isParsingImage ? podcastBuilder.setPodcastImageUrl(trimmedString) : nil
            
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            podcastBuilder.finishCurrentEpisode()
            isParsingItem = false
        }
        
        if elementName == "channel" {
            podcastBuilder.finishPodcast()
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Parsing error occurred: \(parseError.localizedDescription)")
    }
}
