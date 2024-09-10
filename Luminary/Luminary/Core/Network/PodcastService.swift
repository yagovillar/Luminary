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
    

    func validateRSSURL(_ urlString: String, completion: @escaping (Result<Bool, PodcastError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.notFound))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.networkError))
                return
            }
            
            guard let data = data,
                  let xmlString = String(data: data, encoding: .utf8) else {
                completion(.failure(.notFound))
                return
            }
            
            let isRSS = xmlString.contains("<rss") ||
                        xmlString.contains("<feed") ||
                        xmlString.contains("<channel") ||
                        xmlString.contains("<item>")
            
            completion(.success(isRSS))
        }
        
        task.resume()
    }

    func fetchPodcast(from url: String, completion: @escaping (Result<Podcast, PodcastError>) -> Void) {
        guard let feedUrl = URL(string: url) else {
            completion(.failure(.notFound))
            return
        }

        let task = session.dataTask(with: feedUrl) { data, response, error in
            if let error = error {
                completion(.failure(.networkError))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.networkError))
                return
            }

            guard let data = data else {
                completion(.failure(.unknownError))
                return
            }

            let parser = PodcastXMLParser()
            do {
                let podcast = try parser.parse(data)
                completion(.success(podcast))
            } catch {
                if let parsingError = error as? PodcastError {
                    completion(.failure(parsingError))
                } else {
                    completion(.failure(.unknownError))
                }
            }
        }

        task.resume()
    }
}
