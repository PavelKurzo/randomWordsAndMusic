//
//  WordsFetching.swift
//  randomWordsAndMusic
//
//  Created by Павел Курзо on 28.04.22.
//

import Foundation

protocol WordsFetching: AnyObject {
    func fetchWords(_ count: Int, completion: @escaping (Result<[WordsResult], Error>) -> Void)
}

class WordsFetcher: WordsFetching {
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func fetchWords(_ count: Int, completion: @escaping (Result<[WordsResult], Error>) -> Void) {
        var words: [WordsResult] = []
        var counter = 0
        let group = DispatchGroup()
        for _ in 1...count {
            group.enter()
            apiService.fetchWords { result in
                switch result {
                case .success(let data):
                    if words.filter({$0.word == data.word}).count > 0 {
                        counter += 1
                    } else {
                        words.append(data)
                    }
                case .failure:
                    counter += 1
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            if counter > 0 {
                self.refetchWords(counter, oldWords: words, completion: completion)
            } else {
                completion(.success(words))
            }
        }
    }

    func refetchWords(_ count: Int, oldWords: [WordsResult] = [], completion: @escaping (Result<[WordsResult], Error>) -> Void) {
        fetchWords(count) { result in
            switch result {
            case .success(let data):
                let allWords = data + oldWords
                completion(.success(allWords))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
