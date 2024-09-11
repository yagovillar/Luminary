//
//  AppDataManager.swift
//  Luminary
//
//  Created by Yago Vanzan on 10/09/24.
//

import Foundation
import SwiftData

class AppDataManager: ObservableObject, Observable {
    
    // Singleton instance for global access
    static let shared = AppDataManager()
    
    // Initialize the `SwiftData` container
    let container: ModelContainer
    
    init() {
        do {
            // Load your models into the container
            container = try ModelContainer(for: PodcastDataModel.self)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    // MARK: - Save data
    @MainActor func appendPodcast(podcast: Podcast) {
        let fetchRequest = FetchDescriptor<PodcastDataModel>()
        do {
            if let podcastModel = try container.mainContext.fetch(fetchRequest).first {
                if !podcastModel.recentPodcasts.contains(where: {$0.title == podcast.title}) {
                    podcastModel.recentPodcasts.append(podcast)
                }
                try container.mainContext.save()
            } else {
                let podcastModel = PodcastDataModel(id: "1", recentPodcasts: [podcast])
                savePodcast(podcastModel: podcastModel)
            }
        } catch {
            print("Error fetching products: \(error)")
        }
    }
    
    @MainActor func updatePlayingPodcast(podcast: Podcast) {
        let fetchRequest = FetchDescriptor<PodcastDataModel>()
        do {
            let podcastModel = try container.mainContext.fetch(fetchRequest).first
            podcastModel?.playingPodcast = podcast
            try container.mainContext.save()
        } catch {
            print("Error fetching products: \(error)")
        }    }
    
    @MainActor func updatePlayingEpisode(episode: Episode) {
        let fetchRequest = FetchDescriptor<PodcastDataModel>()
        do {
            let podcastModel = try container.mainContext.fetch(fetchRequest).first
            podcastModel?.playingEpisode = episode
            try container.mainContext.save()
        } catch {
            print("Error fetching products: \(error)")
        }
    }
    
    // MARK: - Fetch data
    
    @MainActor func fetchPodcast(completion: @escaping (Result<PodcastDataModel, PodcastError>) -> Void) {
        let fetchRequest = FetchDescriptor<PodcastDataModel>()
        
        do {
            // Fetch the first podcast
            if let podcast = try container.mainContext.fetch(fetchRequest).first {
                // On success, call completion with the podcast data
                completion(.success(podcast))
            } else {
                // Handle case where no podcasts are found
                completion(.failure(.notFound))
            }
        } catch {
            // On error, call completion with the error
            completion(.failure(.unknownError))
        }
    }
    
    @MainActor func savePodcast(podcastModel: PodcastDataModel) {
        let context = container.mainContext

        // Assuming PodcastDataModel is an entity managed by SwiftData
        let newPodcast = PodcastDataModel(id: "0")
        newPodcast.recentPodcasts = podcastModel.recentPodcasts
        
        do {
            context.insert(newPodcast)
            try context.save()
            print("Product saved successfully")
        } catch {
            print("Error saving product: \(error)")
        }
    }

    
    // MARK: - Delete data
    
    @MainActor func deletePodcast(_ podcast: PodcastDataModel) {
        do {
            container.mainContext.delete(podcast)
            try container.mainContext.save()
            print("Product deleted successfully")
        } catch {
            print("Error deleting product: \(error)")
        }
    }
}
