//
//  APIService.swift
//  randomWordsAndMusic
//
//  Created by Павел Курзо on 28.04.22.
//

import Foundation

enum APIError: Error {
    case noAnyData
}

class APIService {
    
    let wordsUrl = "https://random-words-api.vercel.app/word"
    let musicUrl = "https://musicbrainz.org/ws/2/recording/?query=%@&fmt=json"
    
    func fetchWords(completion: @escaping (Result<WordsResult, Error>) -> Void) {
        guard let url = URL(string: wordsUrl) else { return }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.noAnyData))
                return
            }
            do {
                let result = try JSONDecoder().decode([WordsResult].self, from: data)
                if let result = result.first {
                    completion(.success(result))
                } else {
                    completion(.failure(APIError.noAnyData))
                }
            } catch {
                completion(.failure(error))
            }
        })
        task.resume()
    }
    
    func fetchMusic(for word: String, completion: @escaping (Result<MusicResponse, Error>) -> Void) {
        let stringUrl = String(format: musicUrl, word)
        guard let url = URL(string: stringUrl) else { return }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.noAnyData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MusicResponse.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        })
        task.resume()
    }
}

