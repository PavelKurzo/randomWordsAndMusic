//
//  MusicFetcher.swift
//  randomWordsAndMusic
//
//  Created by Павел Курзо on 28.04.22.
//

import Foundation

struct MusicData {
    let description: String
    let word: WordsResult
}

protocol MusicFetching: AnyObject {
    func fetchMusic(for words: [WordsResult], completion: ((Result<[MusicData], Error>) -> Void)?)
}

class MusicFetcher: MusicFetching {
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func fetchMusic(for words: [WordsResult], completion: ((Result<[MusicData], Error>) -> Void)?) {
        
        let group = DispatchGroup()
        var fetchedData = [MusicData]()
        for (index, word) in words.map({ $0.word }).enumerated() {
            group.enter()
            apiService.fetchMusic(for: word) { result in
                switch result {
                case .success(let response):
                    if let music = self.convertResponse(response, word: words[index]) {
                        fetchedData.append(music)
                    }
                case .failure:
                    print("error")
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            completion?(.success(fetchedData))
        }
    }
    
    private func convertResponse(_ response: MusicResponse?, word: WordsResult) -> MusicData? {
        guard let recording = response?.recordings.first,
              let artist = recording.artist.first?.name,
              let albumName = recording.releases.first?.title
        else {
            return .init(description: "No recording found!", word: word)
        }
        let descriptionTemplate = "%@ - %@ - %@"
        return .init(description: String(format: descriptionTemplate, artist, albumName, recording.title), word: word)
    }
}
