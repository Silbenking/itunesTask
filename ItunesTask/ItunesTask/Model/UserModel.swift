//
//  UserModel.swift
//  ItunesTask
//
//  Created by Сергей Сырбу on 24.07.2023.
//

import Foundation

struct User: Codable { // сначала данные нужно будет закодировать, потом раскодировать
    let firstName: String
    let secondName: String
    let phone: String
    let email: String
    let password: String
    let age: Date
    
}
