//
//  SettingModel.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 15.11.2022.
//

import UIKit

struct SettingSection {
    var title: String
    var cell: [SettingItem]
}

struct SettingItem {
    var createdCell: () -> UITableViewCell
    var action: ((SettingItem) -> Void)?
}

protocol SettingModelDelegate: AnyObject {
    func sorting()
    func passwordChanged()
}

class SettingModel: NSObject {
    static let identifier = "SettingCell"
    private var tableSections = [SettingSection]()
    private var delegate: SettingModelDelegate?
    
    init(delegate: SettingModelDelegate) {
        super.init()
        self.delegate = delegate
        configuration()
    }
    
    private func configuration() {
        let switchSection = SettingSection(
            title: "Сортировка",
            cell: [
                SettingItem(
                    createdCell: {
                        let cell = SwitchTableViewCell(style: .subtitle, reuseIdentifier: Self.identifier)
                        cell.nameLabel.text = "Сортировка"
                        return cell
                    },
                    action: { [weak self] _ in  self?.delegate?.sorting()}
                )
            ])
        
        let passwordSection = SettingSection(
            title: "Пароль",
            cell: [
                SettingItem(
                    createdCell: {
                        let cell = SettingPasswordCell(style: .subtitle, reuseIdentifier: Self.identifier)
                        cell.passwordLabel.text = "Поменять пароль"
                        cell.accessoryType = .disclosureIndicator
                        return cell
                    },
                    action: { [weak self] _ in self?.delegate?.passwordChanged()}
                )
            ])
        tableSections = [switchSection, passwordSection]
    }
}

extension SettingModel: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableSections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableSections[section].cell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableSections[indexPath.section].cell[indexPath.row]
        return cell.createdCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableSections[indexPath.section].cell[indexPath.row]
        cell.action?(cell)
    }
  
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return tableSections[section].title
        }
}
