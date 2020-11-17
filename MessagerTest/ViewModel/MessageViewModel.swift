//
//  MessageViewModel.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/15/20.
//

import Foundation

class MessageViewModel {
    
    // MARK: Instantiate
    private var apiService = ApiService() // Dependency
    private var messages = [Message]()
    
    // MARK: Helpers
    func getAllMessagesData(completion: @escaping (Error?) -> ()) {
        
        apiService.getAllMessages { [weak self] (result) in
            switch result {
            
            case .success(let listOf):
                // Flatten array
                self?.messages = listOf.array.reduce([],  +)
                completion(nil)
                break
                
            case .failure(let error):
                completion(error)
                break
                
            }
        }
        
    }
    
    func getAllMessagesData(forUser: String, completion: @escaping (Error?) -> ()) {
        
        apiService.getMessagesForUser(forUser) { [weak self] (result) in
            switch result {
            
            case .success(let listOf):
                var tempArray = [Message]()
                // O(n) - kinda ugly but does keep data as one type [Message]
                for element in listOf {
                    let newMessage = Message(subject: element.subject, message: element.message, username: forUser)
                    tempArray.append(newMessage)
                }
                self?.messages = tempArray
                completion(nil)
                break
                
            case .failure(let error):
                completion(error)
                break
                
            }
        }
        
    }
    
    func send(message:Message, completion: @escaping(Error?) -> ()) {
        
        apiService.sendMessage(message) { [weak self] (result) in
            switch result {
            
            case .success(_):
                completion(nil)
                break
            
            case .failure(let error):
                completion(error)
                break
            
            }
        }
        
    }
    
    
    func numberOfRowsInSection(section: Int) -> Int {
        if messages.count != 0 {
            return messages.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) ->  Message {
        return messages[indexPath.row]
    }
 
}
