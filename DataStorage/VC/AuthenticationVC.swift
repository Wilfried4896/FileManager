//
//  AuthenticationVC.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 11.11.2022.
//

import UIKit

class AuthenticationVC: UIViewController {

    weak var coordinator: AuthCoordinator?
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var confirmedPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmedPasswordButton.layer.cornerRadius = 10
    }
    
    @IBAction func didTapConfirmed(_ sender: Any) {
    }
}
