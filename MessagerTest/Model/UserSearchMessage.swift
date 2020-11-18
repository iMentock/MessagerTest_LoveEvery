//
//  UserSearchMessage.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/18/20.
//

import Foundation

/**
 The child of a message search filtered by users
 Reason: The resposne is structured slightly different than the get all messages response
 
 The response from AWS is structured:
 
 {
     "statusCode": 200,
     "body":  {
        "user": "dan",
        "message": [
 
            *** USERSEARCHMESSAGE STRUCT ***
             {
                "subject": "pets",
                "message": "dogs are happy"
             },
            ///////////////////////////////////////////
 
            *** USERSEARCHMESSAGE STRUCT ***
             {
                "subject": "pets",
                "message": "cats are grumpy"
             }
            ///////////////////////////////////////////
        ]
    }
}

 */
struct UserSearchMessage: Decodable {
    
    let subject: String
    let message: String
    
    private enum CodingKeys: CodingKey {
        
        case subject
        case message
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        subject = try container.decode(String.self, forKey: .subject)
        message = try container.decode(String.self, forKey: .message)
        
    }
    
    init(subject: String, message: String, username: String) {
        
        self.subject = subject
        self.message = message
        
    }
    
}
