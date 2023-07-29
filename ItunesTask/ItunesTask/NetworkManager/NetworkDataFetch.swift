//
//  NetworkDataFetch.swift
//  ItunesTask
//
//  Created by Сергей Сырбу on 27.07.2023.
//

import Foundation
// для работы с полученными данными
class NetworkDataFetch {
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchAlbum(urlString: String, response: @escaping(AlbumData?, Error?)-> Void){ //получаем либо модель либо ошибку на выходе нашего метода и обращаемся по URL
        NetworkRequest.shared.requestData(urlString: urlString) { result in // приходит result и у него есть два состояния и можем использвать свитч/ на выходе получаем либо структуру
            switch result {
                
            case .success(let data):
                do{// пытемся распарсить данные, которые получили в модель AlbumData
                    let albums = try JSONDecoder().decode(AlbumData.self, from: data) // from: data из той даты которой мы получаем мы пробуем все это декодировать в формат  AlbumData
                    response(albums,nil) // передаем данные которые уже рапарсились и ошибка нил потому что ее нет
                }catch let jsonError {
                    print("failed to decode JSON \(jsonError)")
                }
            case .failure(let error):
                print("Error reeiver reusting data: \(error.localizedDescription)")
                response(nil, error) // передаем оишбку наверх, nil - вместо модели
            }
        }
    }
    func fetchSong(urlString: String, response: @escaping(SongsModel?, Error?)-> Void){ //получаем либо модель либо ошибку на выходе нашего метода и обращаемся по URL
        NetworkRequest.shared.requestData(urlString: urlString) { result in // приходит result и у него есть два состояния и можем использвать свитч/ на выходе получаем либо структуру
            switch result {
                
            case .success(let data):
                do{// пытемся распарсить данные, которые получили в модель AlbumData
                    let songs = try JSONDecoder().decode(SongsModel.self, from: data) // from: data из той даты которой мы получаем мы пробуем все это декодировать в формат  AlbumData
                    response(songs,nil) // передаем данные которые уже рапарсились и ошибка нил потому что ее нет
                }catch let jsonError {
                    print("failed to decode JSON \(jsonError)")
                }
            case .failure(let error):
                print("Error reeiver reusting data: \(error.localizedDescription)")
                response(nil, error) // передаем оишбку наверх, nil - вместо модели
            }
        }
    }
    
}
