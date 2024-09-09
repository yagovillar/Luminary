//
//  PodcastService.swift
//  Luminary
//
//  Created by Yago Vanzan on 08/09/24.
//

import Foundation

enum PodcastError: Error {
    case networkError
    case parsingError
    case unknownError
    case notFound

    var localizedDescription: String {
        switch self {
        case .networkError:
            return "Network error occurred. Please check your internet connection and try again."
        case .parsingError:
            return "Failed to parse the podcast data. The data format might be incorrect."
        case .unknownError:
            return "An unknown error occurred. Please try again later."
        case .notFound:
            return "Podcast not found. The URL might be incorrect or the podcast might not be available."
        }
    }
}

class PodcastService {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchPodcast(from url: String) async -> Result<Podcast, PodcastError> {
        guard let feedUrl = URL(string: url) else {
            return .failure(.notFound)
        }

        do {
            let (data, response) = try await session.data(from: feedUrl)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return .failure(.networkError)
            }

            let parser = PodcastXMLParser()
            let podcast = try parser.parse(data)
            return .success(podcast)
            
        } catch {
            if let urlError = error as? URLError {
                return .failure(.networkError)
            } else if let parsingError = error as? PodcastError {
                return .failure(parsingError)
            } else {
                return .failure(.unknownError)
            }
        }
    }
}
