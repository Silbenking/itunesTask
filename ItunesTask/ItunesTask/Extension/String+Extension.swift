//
//  String+Extension.swift
//  ItunesTask
//
//  Created by Сергей Сырбу on 22.07.2023.
//

import Foundation
 
extension String { // расширение для строки
    enum ValidTypes{
        case name // проверка по имени
        case email // проверка почты
        case password //проверка пароля
    }
    enum Regex: String {// здесь пишем реглярные выражения которые будут использоваться при проверке нашего имени
        case name = "[a-zA-Z]{1,}" // {1, } количетво минимальных и максимальных символово соответсвенно, когдва вводим текст выражение проверяет входит ли наш тескт в это множество [a-zA-Z]
        case email = "[a-zA-Z0-9._]+@[a-z0-9._]+\\.[a-zA-Z]{2,64}"
         case password = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}"
    }
    func isValid(validType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@" // формат для предиката - проверяме на соответчстие, при помощи предиката фильтруем  - соответсвтуют ли строки нашему регулярному выражению
        var regex = ""
        
        switch validType {
        case .name:
            regex = Regex.name.rawValue
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        }
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
