//
//  AuthViewModel.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 11.11.2022.
//

import Foundation
import KeychainAccess

enum AuthError: String, Error {
    case leastCharacters = "Минимум из четырёх символов"
    case passwordError = "Password is not confirmed"
    case fieldIsEmpty = "The field is empty"
}

protocol AuthDelegate: AnyObject {
    func isAuth() -> Bool
    func createPassword(_ password: String, _ repeatPassord: String, _ completion: (Result<(), AuthError>) -> Void)
    func enterPassword(_ password: String, _ repeatPassord: String, _ completion: (Result<(), AuthError>) -> Void)
}

class AuthViewModel: AuthDelegate {
    let numberChar = 4
    let keyChain = Keychain(service: "-.DataStorage")
    
    func isAuth() -> Bool {
        let password =  keyChain["PasswordAuth"]
        guard let password, !password.isEmpty else {
            return false
        }
        return true
    }
    
    
    func createPassword(_ password: String, _ repeatPassord: String, _ completion: (Result<(), AuthError>) -> Void) {
        guard !password.isEmpty, !repeatPassord.isEmpty else {
            completion(.failure(.fieldIsEmpty))
            return
        }
        guard password.count >= numberChar, repeatPassord.count >= numberChar else {
            completion(.failure(.leastCharacters))
            return
        }
        guard password == repeatPassord else {
            completion(.failure(.passwordError))
            return
        }
        
        do {
            completion(.success( try keyChain
                .set(password, key: "PasswordAuth")))
            completion(.success(()))
            } catch {
                completion(.failure(AuthError(rawValue: error.localizedDescription)!))
                print(error.localizedDescription)
            }
    }
    
    func enterPassword(_ password: String, _ repeatPassord: String, _ completion: (Result<(), AuthError>) -> Void) {
        
        guard !password.isEmpty, !repeatPassord.isEmpty else {
            completion(.failure(.fieldIsEmpty))
            return
        }
        guard password.count >= numberChar, repeatPassord.count >= numberChar else {
            completion(.failure(.leastCharacters))
            return
        }
        do {
            let passwordEnter = try keyChain
                .accessibility(.whenUnlocked)
                .get("PasswordAuth")
            guard password == passwordEnter else {
                completion(.failure(.passwordError))
                return
            }
            completion(.success(()))
        } catch {
            completion(.failure(AuthError(rawValue: error.localizedDescription)! ))
        }
    }
}
