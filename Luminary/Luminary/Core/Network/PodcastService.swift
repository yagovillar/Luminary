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

class PodcastService: NSObject, XMLParserDelegate {
    private var episodes: [Episode] = []
    private var currentElement = ""
    private var isParsingItem = false  // Flag para verificar se estamos em um item (episódio)
    
    // Campos do podcast
    private var podcastTitle = ""
    private var podcastDescription = ""
    private var podcastImageUrl = ""
    private var podcastAuthor = ""
    
    // Campos do episódio
    private var currentTitle = ""
    private var currentDescription = ""
    private var currentPubDate = ""
    private var currentAudioUrl = ""
    private var currentDuration = 0
    private var currentExplicit = false
    private var currentGuid = ""
    private var currentAuthor = ""
    
    // Formato de data primário
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX") // Garantir formato consistente
        formatter.dateFormat = "E,ddMMMyyyyHH:mm:ssZ" // Formato correto para "Wed, 03 Apr 2019 18:55:00 -0000"
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // Garantir que o timezone seja UTC/Zulu
        return formatter
    }()
    
    // Outros possíveis formatos de data
    private var alternativeDateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    // Adicionando mais formatos alternativos
    private var alternativeDateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "E,ddMMMyyyyHH:mm:ssZ"
        return formatter
    }()
    
    // Adicionando mais formatos alternativos
    private var alternativeDateFormatter3: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "E,dMMMyyyy"
        return formatter
    }()
    
    private func cleanString(_ str: String) -> String {
        let characterSet = CharacterSet.whitespacesAndNewlines
        return str.components(separatedBy: characterSet).joined()
    }
    
    // Função para converter a data de publicação, tentando vários formatos
    private func convertPubDate(_ pubDateString: String) -> Date? {
        let dateStr = self.cleanString(pubDateString)
        if let date = dateFormatter.date(from: dateStr) {
            return date
        } else if let altDate1 = alternativeDateFormatter1.date(from: dateStr) {
            return altDate1
        } else if let altDate2 = alternativeDateFormatter2.date(from: dateStr) {
            return altDate2
        } else if let altDate3 = alternativeDateFormatter3.date(from: dateStr) {
            return altDate3
        } else {
            print("Formato de data desconhecido: \(dateStr)")
            return nil
        }
    }
    
    // Função para baixar e parsear o RSS
    func fetchPodcast(from url: String, completion: @escaping (Result<Podcast, PodcastError>) -> Void) {
        guard let feedUrl = URL(string: url) else {
            print("URL inválida")
            completion(.failure(.networkError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: feedUrl) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Erro ao carregar dados: \(error?.localizedDescription ?? "Unknown error")")
                completion(.failure(.networkError))
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            let success = parser.parse()
            
            if success {
                // Criar o podcast com base nos episódios parseados
                let podcast = Podcast(
                    title: self?.podcastTitle ?? "Unknown Podcast",
                    description: self?.podcastDescription ?? "No description available",
                    imageUrl: self?.podcastImageUrl ?? "",
                    author: self?.podcastAuthor ?? "Unknown Author",
                    episodes: self?.episodes ?? []
                )
                print("Podcast carregado: \(podcast.title), com \(podcast.episodes.count) episódios.")
                completion(.success(podcast))
            } else {
                print("Falha ao parsear XML")
                completion(.failure(.parsingError))
            }
        }
        
        task.resume()
    }

    
    // Métodos do XMLParserDelegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if elementName == "item" {
            isParsingItem = true  // Entramos em um item (episódio)
            
            // Resetar os valores ao começar um novo item (episódio)
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
            currentAudioUrl = ""
            currentDuration = 0
            currentExplicit = false
            currentGuid = ""
            currentAuthor = ""
            
            print("Iniciando parsing de um novo episódio.")
        }
        
        if elementName == "enclosure", let url = attributeDict["url"] {
            currentAudioUrl = url
        }
        
        if elementName == "itunes:image", let imageUrl = attributeDict["href"] {
            podcastImageUrl = imageUrl
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title":
            if isParsingItem {
                currentTitle += string
            } else {
                podcastTitle += string
            }
        case "description":
            if isParsingItem {
                currentDescription += string
            } else {
                podcastDescription += string
            }
        case "pubDate":
            currentPubDate += string
        case "itunes:duration":
            currentDuration = Int(string) ?? 0
        case "itunes:explicit":
            currentExplicit = (string.lowercased() == "yes")
        case "guid":
            currentGuid = string
        case "itunes:author":
            currentAuthor = string
        case "author":
            if currentAuthor.isEmpty {
                currentAuthor = string
            }
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            // Tentar converter a data de publicação usando múltiplos formatos
            let pubDate = convertPubDate(currentPubDate)
            
            if let pubDate = pubDate {
                let episode = Episode(
                    title: currentTitle,
                    description: currentDescription,
                    pubDate: pubDate,
                    audioUrl: currentAudioUrl,
                    duration: currentDuration,
                    isExplicit: currentExplicit,
                    guid: currentGuid,
                    author: currentAuthor,
                    podcastName: podcastTitle
                )
                episodes.append(episode)
                print("Episódio adicionado: \(episode.title)")
            } else {
                print("Falha ao converter a data de publicação para o episódio: \(currentTitle)")
            }
            
            isParsingItem = false  // Saímos do item (episódio)
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Erro ao parsear XML: \(parseError.localizedDescription)")
    }
}
