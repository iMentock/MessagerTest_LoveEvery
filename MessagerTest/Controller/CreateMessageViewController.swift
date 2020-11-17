//
//  CreateMessageViewController.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/16/20.
//

import UIKit

class CreateMessageViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var messageBodyTextView: UITextView!
    
    var placeHolder = "Enter message here"
    private var apiService = ApiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        messageBodyTextView.delegate = self
        
        let sendButton = UIBarButtonItem(title: "Send", style: .done, target: self, action: #selector(sendButtonPressed))
        sendButton.tintColor = #colorLiteral(red: 0.3494816422, green: 0.3450542688, blue: 0.3407886624, alpha: 1)
        navigationItem.rightBarButtonItem = sendButton
        
        usernameTextField.borderStyle = .none
        subjectTextField.borderStyle = .none
    }
    
    @objc func sendButtonPressed() {
        checkParamsAndSendMessage()
    }
    
    func checkParamsAndSendMessage() {
                
        guard let usernameText = usernameTextField.text else { return }
        guard let subjectText = subjectTextField.text else { return }
        guard let messageBodyText = messageBodyTextView.text else { return }
        
        let newMessage = Message(subject: subjectText, message: messageBodyText, username: usernameText)
        
        apiService.sendMessage(newMessage) { (result) in
            switch result {
            case .success(_):
                print("[DEBUG] Successfully sent message.")
//                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
                break
            case .failure(let error):
                // TODO: - Handle failed call
                print("[ERROR] \(error.localizedDescription)")
                break
            }
        }
    }
    
}

extension CreateMessageViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeHolder = textView.text ?? ""
        textView.text = ""
        textView.textColor = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeHolder
            textView.textColor = UIColor.lightGray
        }
    }
    
    
}
