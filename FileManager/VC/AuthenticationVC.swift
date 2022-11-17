//
//  AuthenticationVC.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 11.11.2022.
//

import UIKit
import KeychainAccess

enum BottonValue: String {
    case create = "Создать пароль"
    case login = "Введите пароль"
    case repeatPass = "Повторите пароль"
}

enum AuthError: String, Error {
    case leastCharacters = "Пароль должен состоять минимум из четырёх символов"
    case passwordError = "Пароль не подтвержден"
    case fieldIsEmpty = "Поле пусто"
}

enum Status {
    
}

class AuthenticationVC: UIViewController {
    
    weak var coordinator: AuthCoordinator?
    var authViewModel: AuthDelegate?
    lazy var passwordEnter = ""
    
    lazy var loginTextField: UITextField = {
        let login = UITextField()
        login.borderStyle = .none
        login.textAlignment = .center
        login.font = UIFont.systemFont(ofSize: 20)
        login.isSecureTextEntry = true
        login.placeholder = "Введите пароль"
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
        
    }()

    lazy var createPasswordButton: UIButton = {
        let password = UIButton(type: .system)
        password.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        password.addTarget(self, action: #selector(didTapCreate), for: .touchUpInside)
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        
        guard let isWas = authViewModel?.isAuth(), isWas else {
            createPasswordButton.setTitle(BottonValue.create.rawValue, for: .normal)
            return
        }
        createPasswordButton.setTitle(BottonValue.login.rawValue, for: .normal)
    }
    
    private func configuration() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(loginTextField)
        view.addSubview(createPasswordButton)
     
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            loginTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            loginTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
           
            createPasswordButton.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30),
            createPasswordButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            createPasswordButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
    }
    
    @objc func didTapCreate() {
        guard let isWas = authViewModel?.isAuth(), isWas else {
            createAccount()
            return
        }
        signInAccount()
    }
    
    private func messageAlerte(_ message: String) {
        let arlet = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        arlet.addAction(UIAlertAction(title: "Хорошо", style: .destructive))
        present(arlet, animated: true)
    }
}

extension AuthenticationVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AuthenticationVC {
    func createAccount() {
        guard let login = loginTextField.text else { return }
        guard !login.isEmpty else {
            messageAlerte(AuthError.fieldIsEmpty.rawValue)
            return
        }
        guard login.count >= 4 else {
            messageAlerte(AuthError.leastCharacters.rawValue)
            return
        }
        guard passwordEnter != "" else {
            createPasswordButton.setTitle(BottonValue.repeatPass.rawValue, for: .normal)
            loginTextField.text = ""
            passwordEnter = login
            return
        }
        guard passwordEnter == login else {
            loginTextField.text = ""
            passwordEnter = ""
            createPasswordButton.setTitle(BottonValue.create.rawValue, for: .normal)
            messageAlerte(AuthError.passwordError.rawValue)
            return
        }
        authViewModel?.createPassword(login)
        coordinator?.tabBar()
        dismiss(animated: true)
    }
    
    func signInAccount() {
        guard let login = loginTextField.text else { return }
        guard !login.isEmpty else {
            messageAlerte(AuthError.fieldIsEmpty.rawValue)
            return
        }
        guard login.count >= 4 else {
            messageAlerte(AuthError.leastCharacters.rawValue)
            return
        }
        
        guard login == authViewModel?.enterPassword() else {
            messageAlerte(AuthError.passwordError.rawValue)
            loginTextField.text = ""
            return
        }
        coordinator?.tabBar()
    }
}
