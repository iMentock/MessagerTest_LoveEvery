//
//  MessageTableViewCell.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/16/20.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var subject: UILabel!
    
    // Setup Message(s)
    func setCellWithValuesOf(_ message: Message) {
        updateUI(username: message.username, subject: message.subject, message: message.message)
    }
    
    private func updateUI(username: String?, subject: String?, message: String?) {
        self.messageText.text = message
        self.subject.text = subject
        self.username.text = username
    }
    

}
