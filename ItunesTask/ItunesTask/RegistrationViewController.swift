//
//  RegistrationViewController.swift
//  ItunesTask
//
//  Created by Сергей Сырбу on 18.07.2023.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    let deviceBg = #colorLiteral(red: 0, green: 0.3725490196, blue: 1, alpha: 1)
    
    let scrollView = UIScrollView()
    let viewA = UIView()
    
    let registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        return label
    }()
    
    let firstNameTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let reqFerstNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Required field"
        return label
    }()
    let secondNameTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Second name"
        return textField
    }()
    let reqSecondNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Required field"
        return label
    }()
    let ageTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Age"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let reqAgeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Required field"
        return label
    }()
    let numberPhoneTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad 
        textField.placeholder = "Number phone"
        return textField
    }()
    let reqNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Required field"
        return label
    }()
    let emailTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter email"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let reqEmailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Required field"
        return label
    }()
    let passwordTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter password"
        return textField
    }()
    let reqPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Required field"
        return label
    }()
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("SignUp", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.titleLabel?.textColor = .white
        return button
    }()
    let datePicker = UIDatePicker()
    
    let nameValidType: String.ValidTypes = .name
    let emailValidType: String.ValidTypes = .email
    let passwordValidType: String.ValidTypes = .password

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        setupDatePicker()
        setupTFDelegate()
        registerKeyBoardNotification()
    }
    deinit {
        removeKeyBoardNotification()
    }
    func setupTFDelegate(){
        firstNameTF.delegate = self
        secondNameTF.delegate = self
        numberPhoneTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
    }
    
    func setupDatePicker(){
        ageTF.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.layer.borderColor = UIColor.lightGray.cgColor
        datePicker.layer.borderWidth = 1
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 6
        datePicker.tintColor = .black
        //doneButton
        let toolBarDate = UIToolbar()
        toolBarDate.sizeToFit()
        let doneButtonDate = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneActiion))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBarDate.setItems([flexSpace, doneButtonDate], animated: true)
        ageTF.inputAccessoryView = toolBarDate
    }
    func initialize(){
        signUpButton.addTarget(self, action: #selector(signUpTap), for: .touchUpInside)
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.trailing.bottom.leading.equalToSuperview()
        }
        scrollView.addSubview(viewA)
        viewA.snp.makeConstraints { make in
            make.top.trailing.bottom.leading.equalTo(scrollView)
            make.centerX.equalTo(scrollView)
        }
        scrollView.addSubview(registrationLabel)
        registrationLabel.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(scrollView).inset(150)
        }
        scrollView.addSubview(firstNameTF)
        firstNameTF.snp.makeConstraints { make in
            make.centerX.equalTo(viewA)
            make.top.equalTo(registrationLabel.snp.bottom).offset(20)
            make.width.equalTo(350)
        }
        scrollView.addSubview(reqFerstNameLabel)
        reqFerstNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(firstNameTF.snp.bottom).offset(5)
        }
        scrollView.addSubview(secondNameTF)
        secondNameTF.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(firstNameTF.snp.bottom).offset(25)
            make.width.equalTo(350)
        }
        scrollView.addSubview(reqSecondNameLabel)
        reqSecondNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(secondNameTF.snp.bottom).offset(5)
        }
        scrollView.addSubview(ageTF)
        ageTF.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(secondNameTF.snp.bottom).offset(25)
            make.width.equalTo(350)
        }
        scrollView.addSubview(reqAgeLabel)
        reqAgeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(ageTF.snp.bottom).offset(5)
        }
        scrollView.addSubview(numberPhoneTF)
        numberPhoneTF.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(ageTF.snp.bottom).offset(25)
            make.width.equalTo(350)
        }
        scrollView.addSubview(reqNumberLabel)
        reqNumberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(numberPhoneTF.snp.bottom).offset(5)
        }
        scrollView.addSubview(emailTF)
        emailTF.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(numberPhoneTF.snp.bottom).offset(25)
            make.width.equalTo(350)
        }
        scrollView.addSubview(reqEmailLabel)
        reqEmailLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(emailTF.snp.bottom).offset(5)
        }
        scrollView.addSubview(passwordTF)
        passwordTF.snp.makeConstraints { make in
            make.centerX.equalTo(viewA)
            make.top.equalTo(emailTF.snp.bottom).offset(25)
            make.width.equalTo(350)
        }
        scrollView.addSubview(reqPasswordLabel)
        reqPasswordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(passwordTF.snp.bottom).offset(5)
        }
        
        scrollView.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.leading.equalTo(scrollView).inset(40)
            make.top.equalTo(reqPasswordLabel.snp.bottom).offset(40)
            make.trailing.equalTo(scrollView).inset(40)
            make.height.equalTo(40)
        }
        
    }
    private func setTextField(textField: UITextField, label: UILabel, validType: String.ValidTypes, valideMessage: String, wrongMessage: String, string: String, range: NSRange){//функция для валидации полей в текстфмлдах
        let text = (textField.text ?? "") + string
        let result: String
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        textField.text = result
        
        if result.isValid(validType: validType){
            label.text = valideMessage
            label.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            textField.layer.borderWidth = 1
            textField.layer.borderColor = #colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1).cgColor
        }else{
            label.text = wrongMessage
            label.textColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
            textField.layer.borderWidth = 1
            textField.layer.borderColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1).cgColor
        }
    }
    private func setPhoneNumberMask(textField: UITextField, mask: String, string: String, range: NSRange)-> String{// маска для номера телефона
        let text = textField.text ?? ""
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X"{
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
            if result.count == 18 {
                reqNumberLabel.text = "Number is valid"
                reqNumberLabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                textField.layer.borderWidth = 1
                textField.layer.borderColor = #colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1).cgColor
            }else{
                reqNumberLabel.text = "Number is not valid"
                reqNumberLabel.textColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
                textField.layer.borderWidth = 1
                textField.layer.borderColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1).cgColor
            }
        }
        return result
    }
    private func ageIsValid()-> Bool{
        let calendar = NSCalendar.current // каледнарь
        let dateNow = Date() // дата запуска приложения
        let birthDay = datePicker.date // день рождение
        
        let age = calendar.dateComponents([.year], from: birthDay, to: dateNow) // нас интересуют года от даты рождения до сегодншней даты
        let ageYear = age.year
        guard let ageUser = ageYear else {return false}
        return(ageUser < 18 ? false:true)
    }
    
    @objc func doneActiion() { // кнопка доне для даты
        let fotmatter = DateFormatter()
        fotmatter.dateStyle = .long
        ageTF.text = fotmatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    @objc func signUpTap(){ // проверяем все ли поля валдины, если да, то сохраняем данные
        let firstNameText = firstNameTF.text ?? ""
        let secondNameText = secondNameTF.text ?? ""
        let numberPhoneText = numberPhoneTF.text ?? ""
        let emailText = emailTF.text ?? ""
        let passwordText = passwordTF.text ?? ""
        let ageText = ageTF.text ?? ""

        if firstNameText.isValid(validType: nameValidType) && secondNameText.isValid(validType: nameValidType) && emailText.isValid(validType: emailValidType) && passwordText.isValid(validType: passwordValidType) && numberPhoneText.count == 18 && ageIsValid() == true {
            UserData.shared.saveUser(firstName: firstNameText, secondName: secondNameText, phone: numberPhoneText, email: emailText, password: passwordText, age: datePicker.date)
            registrationLabel.text = "Registration complete!"
        } else {
            registrationLabel.text = "Registration"
            alertOk(name: "Ошибка", mesaage: "Введите корреткные данные(Возраст 18+)")
        }
    }
}
extension RegistrationViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField{
        case firstNameTF: setTextField(textField: firstNameTF, label:  reqFerstNameLabel, validType:  nameValidType, valideMessage: "Name is valid", wrongMessage: "Only A-Z characters, min 1 character", string: string, range: range)
        case secondNameTF: setTextField(textField: secondNameTF, label: reqSecondNameLabel, validType: nameValidType, valideMessage: "Second name is vsalid", wrongMessage: "Only A-Z characters, min 1 character", string: string, range: range)
        case emailTF: setTextField(textField: emailTF, label: reqEmailLabel, validType: emailValidType, valideMessage: "Email is valid", wrongMessage: "Enter in the format Example@mail.ru", string: string, range: range)
        case passwordTF: setTextField(textField: passwordTF, label: reqPasswordLabel, validType: passwordValidType, valideMessage: "password is valid", wrongMessage: "Only 1 A-Z, 1 a-z, 0-9 characters, min 6 character ", string: string, range: range)
        case numberPhoneTF: numberPhoneTF.text = setPhoneNumberMask(textField: numberPhoneTF, mask: "+X (XXX) XXX-XX-XX", string: string, range: range)
        default:
            break
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTF.resignFirstResponder()
        secondNameTF.resignFirstResponder()
        numberPhoneTF.resignFirstResponder()
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return true
    }
}
extension RegistrationViewController{
    private func registerKeyBoardNotification(){ // поднимаем и опускам сожержимое при поднятиии клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil) // когда клваиутура будет подлниматьсяю будет вызываться этот метод
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil) //когда клавиатура будет опускаться
    }
    //после того как пероисходить деинт вьюконтроллера мы должны их удалить
    private func removeKeyBoardNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    @objc func keyBoardWillShow(notification: Notification){// когда клвиатура будет появляться
        let userInfo = notification.userInfo // через юзеринфо достаем высоту клавиатуры
        let keyBoardHeght = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue //получаем высоту клавиатуры
        scrollView.contentOffset = CGPoint(x: 0, y: keyBoardHeght.height/2)
    }
    @objc func keyBoardWillHide(notification: Notification) {// когда клвиатура будет появляться
        scrollView.contentOffset = CGPoint.zero
    }
}
