//
//  CreateMessageViewController.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/16/20.
//

import UIKit

class CreateMessageViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var messageBodyTextView: UITextView!
    
    // MARK: Instantiate
    var placeHolder = "Enter message here"
    private var messageViewModel = MessageViewModel()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        // Set delegate(s)
        messageBodyTextView.delegate = self
        usernameTextField.delegate = self
        subjectTextField.delegate = self
        
        configureUI()
    
        // Gesture recognizer to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    // MARK: Helpers
    private func configureUI() {
        
        // Configure Nav Items and add actions
        let sendButton = UIBarButtonItem(title: "Send", style: .done, target: self, action: #selector(sendButtonPressed))
        sendButton.tintColor = #colorLiteral(red: 0.3494816422, green: 0.3450542688, blue: 0.3407886624, alpha: 1)
        navigationItem.rightBarButtonItem = sendButton
        
        // Configure text fields to comply with UX
        usernameTextField.borderStyle = .none
        subjectTextField.borderStyle = .none
        
        // Keep behaviour of placeholder but change color
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Your username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        subjectTextField.attributedPlaceholder = NSAttributedString(string: "Subject of message", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
    }
    
    @objc private func sendButtonPressed() {
        
        guard let usernameText = usernameTextField.text else { return }
        guard let subjectText = subjectTextField.text else { return }
        guard let messageBodyText = messageBodyTextView.text else { return }

        if fieldsAreValid(usernameText, subjectText, messageBodyText) {
            
            let newMessage = Message(subject: subjectText, message: messageBodyText, username: usernameText)
            
            messageViewModel.send(message: newMessage) { (error) in
                
                if let _ = error {
                    ErrorHandlers.presentError(withMessage: "Could not send message.", onVC: self)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
            
        }
        
    }
    
    /**
     Ensures values are present for text fields and presents error if not.
     
     - Parameter usernameText: username field value.
     - Parameter subjectText: username field value.
     - Parameter messageBodyText: username field value.
     - Returns: True if all valid or False if not (with a popup to user)
     */
    private func fieldsAreValid(_ usernameText: String, _ subjectText: String, _ messageBodyText: String) -> Bool {
        
        if checkLength(forString: usernameText, isLessThan: 2) {
            ErrorHandlers.showBottomErrorPopup(forIssue: "Username", onVC: self)
            return false
        }
        
        if checkLength(forString: subjectText, isLessThan: 2) {
            ErrorHandlers.showBottomErrorPopup(forIssue: "Subject", onVC: self)
            return false
        }
        
        if checkLength(forString: messageBodyText, isLessThan: 2) {
            ErrorHandlers.showBottomErrorPopup(forIssue: "Message", onVC: self)
            return false
        }
        
        return true
        
    }
    
    private func checkLength(forString: String, isLessThan: Int) -> Bool {
        
        if forString.count < isLessThan {
            return true
        }
        
        return false
        
    }
    
    
    
}

// MARK: - Text View
extension CreateMessageViewController: UITextViewDelegate {
    
    // Prettying text view and interaction
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        placeHolder = textView.text ?? ""
        textView.text = ""
        textView.textColor = #colorLiteral(red: 0.3494816422, green: 0.3450542688, blue: 0.3407886624, alpha: 1)
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "" {
            textView.text = placeHolder
            textView.textColor = UIColor.lightGray
        }
        
    }
    
}

// MARK: - Text Field
extension CreateMessageViewController: UITextFieldDelegate {
    
    // Ensuring 'next' button on keyboard goes to next text entry (quality of life)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if textField == usernameTextField {
            subjectTextField.becomeFirstResponder()
        }
        
        if textField == subjectTextField {
            messageBodyTextView.becomeFirstResponder()
        }
        
        return true
        
    }

}
