//
//  MessageDetailViewController.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/16/20.
//

import Foundation

import UIKit

class MessageDetailViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var messageBodyTextView: UITextView!
    
    var message: Message?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureUI()
    }
    
    private func configureUI() {
        if let message = message {
            usernameLabel.text = message.username
            subjectLabel.text = message.subject
            messageBodyTextView.text = message.message
        }
    }
}
