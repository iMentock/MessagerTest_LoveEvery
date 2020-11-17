//
//  MessageViewModel.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/15/20.
//

import Foundation

class MessageViewModel {
    
    private var apiService = ApiService()
    private var messages = [Message]()
    
    func getAllMessagesData(completion: @escaping () -> ()) {
        
        apiService.getAllMessages { [weak self] (result) in
            switch result {
            case .success(let listOf):
                // Flatten array
                self?.messages = listOf.array.reduce([],  +)
                completion()
            case .failure(let error):
                // TODO: - handle error
                print("[ERROR] Error processing JSON data: \(error)")
            }
        }
        
    }
    
    func getAllMessagesData(forUser: String, completion: @escaping () -> ()) {
        
        apiService.getMessagesForUser(forUser) { [weak self] (result) in
            switch result {
            case .success(let listOf):
                print("[DEBUG] Successfully got message for user \(forUser)")
                print(listOf)
                
                var tempArray = [Message]()
                
                // O(n) - kinda ugly but does keep one truth to data
                for element in listOf {
                    let newMessage = Message(subject: element.subject, message: element.message, username: forUser)
                    tempArray.append(newMessage)
                }
                
                self?.messages = tempArray
                completion()
                break
            case .failure(let error):
                // TODO: - Handle error
                print("[ERROR] \(error.localizedDescription)")
                break
                
            }
        }
        
    }
    
    
    func numberOfRowsInSection(section: Int) -> Int {
        if messages.count != 0 {
            print("There should be \(messages.count) cells")
            return messages.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) ->  Message {
        return messages[indexPath.row]
    }
 
}
