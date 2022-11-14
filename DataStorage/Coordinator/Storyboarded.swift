//
//  Storyboarded.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 12.11.2022.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "AppStoryboard", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
