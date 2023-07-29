//
//  NetworkRequest.swift
//  ItunesTask
//
//  Created by Сергей Сырбу on 27.07.2023.
//

import Foundation
//для получения данных
class NetworkRequest{// создаем через синглтон
    static let shared = NetworkRequest()
    
    private init() {}
    
    func requestData(urlString: String, complition: @escaping (Result<Data, Error>) -> Void){
        // проверяем можем ли получить url
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in // указываем url  который получили и получаем ответ
            //далее работаем в асинхронном режиме
            DispatchQueue.main.async {
                if let error = error { // если получаем ошибку, то передаем ошибку
                    complition(.failure(error))
                    return
                }// если ошибки нет то пытаемся получить дату
                guard let data = data else {return} // ули можем получить какие то данные , то получаем succsess
                complition(.success(data))
            }
        }.resume()
    }
}
