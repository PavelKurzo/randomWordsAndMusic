//
//  Artist.swift
//  randomWordsAndMusic
//
//  Created by Павел Курзо on 28.04.22.
//

import Foundation

struct MusicResponse: Decodable {
    let recordings: [Recording]
}

struct Recording: Decodable {
    let title: String
    let artist: [Artist]
    let releases: [Release]
    
    enum CodingKeys: String, CodingKey {
        case title
        case artist = "artist-credit"
        case releases
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        artist = try container.decode([Artist].self, forKey: .artist)
        releases = try container.decode([Release].self, forKey: .releases)
    }
}

struct Artist: Decodable {
    let name: String
}

struct Release: Decodable {
    let title: String
}
