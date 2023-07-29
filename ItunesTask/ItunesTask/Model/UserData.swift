//
//  UserData.swift
//  ItunesTask
//
//  Created by Сергей Сырбу on 24.07.2023.
//

import Foundation

class UserData{ // что то типо базыданных 
    static let shared = UserData() // создаем синголтон
    
    let defualts = UserDefaults.standard
    
    enum SettingKeys: String {
        case users
    }
    let userKey = SettingKeys.users.rawValue
    
    var users: [User] {
        get { // когда будем к Юзер обращаться все надо сделать в обратном порядке, когда будем получать оттуда данные
            if let data = defualts.value(forKey: userKey) as? Data { // запрашиваем данные по ключу и проверяем сможем получить их них дату или нет
                return try! PropertyListDecoder().decode([User].self, from: data) //пытаемся декодировать в модель юзер
            } else {
                return [User]() // если нет , то возвращаем пустой юзер
            }
        }
        set {// передаем модель
            if let data = try? PropertyListEncoder().encode(newValue){// пытаемся получить данные и закодировать их
                defualts.set(data, forKey: userKey) // сохраняем в юзерДефолтс
            }
        }
    }
    
    // метод при помощи которго будем все сохранять
    func saveUser(firstName: String, secondName: String, phone: String, email: String, password: String, age: Date){
        let user = User(firstName: firstName, secondName: secondName, phone: phone, email: email, password: password, age: age)
        users.insert(user, at: 0)
    }
    
}
