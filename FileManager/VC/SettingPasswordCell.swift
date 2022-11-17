//
//  SettingPasswordCell.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 16.11.2022.
//

import UIKit

class SettingPasswordCell: UITableViewCell {
    static let shared = SettingPasswordCell()
    
    lazy var passwordLabel: UILabel = {
        let password = UILabel()
        password.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuration() {
        contentView.addSubview(passwordLabel)
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            passwordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            passwordLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }
}
