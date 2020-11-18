//
//  ErrorHandler.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/17/20.
//

import UIKit

struct ErrorHandlers {
    
    /**
     Presents .alert style popup on given view controller with title "Sorry!" and action of .default style titled "OK"
     
     - Parameter withMessage: A string describing the error
     - Parameter onVC: The viewController to present on
     */
    static func presentError(withMessage: String, onVC: UIViewController) {
        
        let alert = UIAlertController(title: "Sorry!", message: withMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        onVC.present(alert, animated: true, completion: nil)
        
    }
    
    /**
     Presents .actionSheet style popup on given view controller with title passed in and action of .default style titled "OK"
     
     - Parameter forIssue: A string describing the error
     - Parameter onVC: The viewController to present on
     */
    static func showBottomErrorPopup(forIssue: String, onVC: UIViewController) {
        
        let alert = UIAlertController(title: forIssue, message: "The \(forIssue) is not formatted properly...try again.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        onVC.present(alert, animated: true, completion: nil)
        
    }
    
}
