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

class SettingVC: UITableViewController {

    weak var coordinator: SettingCoordinator?
    private var viewModel: SettingModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Настройка"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        viewModel = SettingModel(delegate: self)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
 
}

extension SettingVC: SettingModelDelegate {
    func sorting() {
        //
    }
    
    func passwordChanged() {
        coordinator?.authChangedPassword()
    }
    
    
}
