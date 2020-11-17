//
//  MessageDetailViewController.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/16/20.
//

import Foundation

import UIKit

class MessageDetailViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var messageBodyTextView: UITextView!
    
    // MARK: Instantiate
    var message: Message?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Helpers
    
    /*
     
     Prepare the screen with passed in Message data
     
     */
    private func configureUI() {
        if let message = message {
            usernameLabel.text = message.username
            subjectLabel.text = message.subject
            messageBodyTextView.text = message.message
        }
    }
}
