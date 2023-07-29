//
//  AlertOk.swift
//  ItunesTask
//
//  Created by Сергей Сырбу on 24.07.2023.
//

import UIKit

extension UIViewController {
    func alertOk(name: String, mesaage: String) {
        let alert = UIAlertController(title: name, message: mesaage, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok" , style: .cancel)
        alert.addAction(alertOk)
        present(alert, animated: true )
    }
    
}
