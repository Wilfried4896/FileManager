//
//  AuthenticationVC.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 11.11.2022.
//

import UIKit
import KeychainAccess

enum KeyValue: String {
    case create = "Создать пароль"
    case login = "Введите пароль"
    case repeatPass = "Повторите пароль"
}

class AuthenticationVC: UIViewController, Storyboarded {

    weak var coordinator: AuthCoordinator?
    var authViewModel: AuthDelegate?
    var isAuthen = Bool()
    
    @IBOutlet weak var loginTextField: UITextField! {
        didSet {
            loginTextField.delegate = self
            loginTextField.tag = 0
        }
    }
    
    @IBOutlet weak var repeatTeField: UITextField! {
        didSet {
            repeatTeField.delegate = self
            repeatTeField.tag = 1
        }
    }
    
    @IBOutlet weak var createPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Authentication"
        
        isAuthen = ((authViewModel?.isAuth()) != nil)
//
//        guard isAuthen else {
//            createPasswordButton.setTitle(KeyValue.create.rawValue, for: .normal)
//            return
//        }
//        createPasswordButton.setTitle(KeyValue.login.rawValue, for: .normal)
    }
    
    @IBAction func didTapCreate(_ sender: Any) {
        guard let loginTextField = loginTextField.text, let repeatTeField = repeatTeField.text else { return }

        authViewModel?.createPassword(loginTextField, repeatTeField, { auth in
            switch auth {
            case .success(_):
                coordinator?.tabBar()
            case .failure(let error):
                switch error {
                case .leastCharacters:
                    messageAlerte(error.rawValue)
                case .passwordError:
                    messageAlerte(error.rawValue)
                case .fieldIsEmpty:
                    messageAlerte(error.rawValue)
                }
            }
        })
    }

    
    private func messageAlerte(_ message: String) {
        let arlet = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        arlet.addAction(UIAlertAction(title: "Хорошо", style: .destructive))
        present(arlet, animated: true)
    }
}

extension AuthenticationVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            createPasswordButton.setTitle(KeyValue.repeatPass.rawValue, for: .normal)
        } else {
            createPasswordButton.setTitle(KeyValue.create.rawValue, for: .normal)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        createPasswordButton.setTitle(KeyValue.create.rawValue, for: .normal)
        return true
    }
}
