//
//  SongsModel.swift
//  ItunesTask
//
//  Created by Сергей Сырбу on 28.07.2023.
//

import Foundation

struct SongsModel: Decodable {
    let results: [Song]
}

struct Song: Decodable{
    let trackName: String?
}
