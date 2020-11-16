//
//  MessageViewModel.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/15/20.
//

import Foundation

class MessageViewModel {
    
    private var apiService = ApiService()
    private var messages = [[Message]]()
    
    func fetchMessagesData(completion: @escaping () -> ()) {
        
        apiService.getAllMessages { [weak self] (result) in
            switch result {
            case .success(let listOf):
                print(listOf)
                self?.messages = listOf.array
                completion()
            case .failure(let error):
                // TODO: - handle error
                print("[ERROR] Error processing JSON data: \(error)")
            }
        }
    }
    
    
    func numberOfRowsInSection(section: Int) -> Int {
        if messages.count != 0 {
            return messages.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) ->  [Message] {
        return messages[indexPath.row]
    }
 
}
