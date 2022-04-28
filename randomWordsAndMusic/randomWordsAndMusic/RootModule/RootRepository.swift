//
//  RootRepository.swift
//  randomWordsAndMusic
//
//  Created by Павел Курзо on 28.04.22.
//

import Foundation

class RootRepository {
    
    private let musicFetcher: MusicFetching
    private let wordsFetcher: WordsFetching
    
    init(musicFetcher: MusicFetching = MusicFetcher(),
         wordsFetcher: WordsFetching = WordsFetcher()) {
        self.musicFetcher = musicFetcher
        self.wordsFetcher = wordsFetcher
    }
    
    func fetchWords(_ number: Int, completion: @escaping (Result<[WordsResult], Error>) -> Void) {
        wordsFetcher.fetchWords(number, completion: completion)
    }
    
    func fetchMusic(for words: [WordsResult], completion: ((Result<[MusicData], Error>) -> Void)?) {
        musicFetcher.fetchMusic(for: words, completion: completion)
    }
}
