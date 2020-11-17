//
//  ErrorHandler.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/17/20.
//

import UIKit

struct ErrorHandler {
    
    func presentError(withMessage: String, onVC: UIViewController) {
        let alert = UIAlertController(title: "Sorry!", message: withMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        onVC.present(alert, animated: true, completion: nil)
    }
}
