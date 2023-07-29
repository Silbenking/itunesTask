//
//  ActiveUserViewController.swift
//  ItunesTask
//
//  Created by Сергей Сырбу on 19.07.2023.
//

import UIKit
import SnapKit

class ActiveUserViewController: UIViewController {

    let ferstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "ferstName"
        return label
    }()
    let secondNameLabel: UILabel = {
        let label = UILabel()
        label.text = "secondName"
        return label
    }()
    let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "age"
        return label
    }()
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "phone"
        return label
    }()
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "email"
        return label
    }()
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "password"
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialze()
        setUser()
        
    }
    func setUser(){
        let userData = UserData.shared.users
        
        let dateFormatter = DateFormatter()//переводим дату в текст
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateUser = dateFormatter.string(from: userData.first!.age)
        
        ferstNameLabel.text = userData.first?.firstName
        secondNameLabel.text = userData.first?.secondName
        ageLabel.text = dateUser
        phoneLabel.text = userData.first?.phone
        emailLabel.text = userData.first?.email
        passwordLabel.text = userData.first?.password

    }
    
    func initialze(){
        view.backgroundColor = .white
        navigationItem.title = "Active User"
        let stackView = UIStackView()
        stackView.addArrangedSubview(ferstNameLabel)
        stackView.addArrangedSubview(secondNameLabel)
        stackView.addArrangedSubview(ageLabel)
        stackView.addArrangedSubview(phoneLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(passwordLabel)
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY .equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
    }

}
