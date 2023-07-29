//
//  ModelAlbums.swift
//  ItunesTask
//
//  Created by Сергей Сырбу on 25.07.2023.
//

import Foundation

struct AlbumData: Decodable, Equatable{
    let results: [Album]
}

struct Album: Decodable, Equatable {
    
    let artistName: String
    let collectionName: String
    let artworkUrl100: String? //если ссылка то в формате стринг а не  URL
    let trackCount: Int
    let releaseDate: String
    let collectionId: Int
}
