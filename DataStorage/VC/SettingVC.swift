//
//  SettingVC.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 12.11.2022.
//

import UIKit

extension Notification.Name {
    static let isChangedValue = Notification.Name("isChangedValue")
}

class SettingVC: UITableViewController, Storyboarded {

    weak var coordinator: SettingCoordinator?
    
    @IBOutlet weak var switchLabel: UISwitch! {
        didSet {
            switchLabel.setOn(UserDefaults.standard.bool(forKey: "SwitchValue"), animated: true)
        }
    }
    
    @IBOutlet weak var sortingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Настройка"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func didTpaswitch(_ sender: Any) {
        var isChanged = Bool()
        guard switchLabel.isOn else {
            isChanged = false
            UserDefaults.standard.set(isChanged, forKey: "SwitchValue")
            return
        }
        isChanged = true
        UserDefaults.standard.set(isChanged, forKey: "SwitchValue")
        NotificationCenter.default.post(name: .isChangedValue, object: isChanged)
    }
    
    @IBAction func didTapChangePassword(_ sender: Any) {
        coordinator?.authChangedPassword()
    }

}
