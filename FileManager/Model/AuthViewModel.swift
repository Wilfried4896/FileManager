//
//  AuthViewModel.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 11.11.2022.
//

import Foundation
import KeychainAccess

protocol AuthDelegate: AnyObject {
    func isAuth() -> Bool
    func createPassword(_ password: String)
    func enterPassword() -> String
    func removePassword()
    func oldPassword() -> String
}

class AuthViewModel: AuthDelegate {
    let keyChain = Keychain()
    
    func enterPassword() -> String {
        do {
            let password = try keyChain.get("PasswordAuth")
            return password ?? ""
        } catch {
            return error.localizedDescription
        }
    }
    
    func isAuth() -> Bool {
        let password =  keyChain["PasswordAuth"]
        guard password != nil else {
            return false
        }
        return true
    }
    
    func createPassword(_ password: String) {
        do {
            try keyChain.set(password, key: "PasswordAuth")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removePassword() {
        keyChain["PasswordAuth"] = nil
    }
    
    func oldPassword() -> String {
        print(#function)
        if let password = keyChain["PasswordAuth"] {
            return password
        } else {
            return ""
        }
    }
   
}
