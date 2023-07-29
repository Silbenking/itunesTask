//
//  ViewController.swift
//  ItunesTask
//
//  Created by Сергей Сырбу on 17.07.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        return label
    }()
    
    let emailTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter email"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let passwordTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter password"
        return textField
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("SignIn", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.titleLabel?.textColor = .white
        return button
    }()
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("SignUp", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.titleLabel?.textColor = .white
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        setupTFDelegate()
       
    }
    func setupTFDelegate(){
        emailTF.delegate = self
        passwordTF.delegate = self
    }
    func initialize(){
        signUpButton.addTarget(self, action: #selector(registrationApp), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(albumTap), for: .touchUpInside)
        view.backgroundColor = .white
        view.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(300)
        }
        view.addSubview(emailTF)
        emailTF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginLabel.snp.bottom).offset(20)
            make.width.equalTo(350)
        }
        view.addSubview(passwordTF)
        passwordTF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTF.snp.bottom).offset(20)
            make.width.equalTo(350)
        }
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(passwordTF.snp.bottom).offset(20)
            make.width.equalTo(170)
            make.height.equalTo(40)
        }
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(passwordTF.snp.bottom).offset(20)
            make.width.equalTo(170)
            make.height.equalTo(40)
        }
    }
    @objc func registrationApp(){
        let vc = RegistrationViewController()
        present(vc, animated: true)
    }
    @objc func albumTap(){
    
        let vc = AlbumsTableView()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
//     
    }
// создаем метод, который позволит найти пользователя
    private func findUserDataBase(mail: String)->User? {
        
        let dataBase = UserData.shared.users // база данных тут сейчас сохранены все данные
        print(dataBase)
        for user in dataBase { //для каждого юзера в датабейс
            if user.email == mail{ //если майл подходит то возвращаем юзера
                return user
            }
        }
        return nil
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return true
    }
}

