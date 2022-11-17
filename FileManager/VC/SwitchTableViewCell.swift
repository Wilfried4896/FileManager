//
//  SwitchTableViewCell.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 15.11.2022.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    static let identifier = "SettingCell"
    lazy var switchBotton: UISwitch = {
        let bottonSwich = UISwitch()
        bottonSwich.translatesAutoresizingMaskIntoConstraints = false
        bottonSwich.addTarget(self, action: #selector(didTpaswitch), for: .valueChanged)
        return bottonSwich
    }()
    
    lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 20)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuration() {
        contentView.addSubview(switchBotton)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        
            switchBotton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            switchBotton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            switchBotton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    
    @objc func didTpaswitch() {
        guard switchBotton.isOn else {
            UserDefaults.standard.set(false, forKey: "SwitchValue")
            return
        }
        UserDefaults.standard.set(true, forKey: "SwitchValue")
    }
}
