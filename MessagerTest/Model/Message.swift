//
//  Message.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/18/20.
//

import Foundation

/**
 Decodable struct used to parse message(s) from the AWS service
 
 response from AWS structure is:
 
 {
     "statusCode": 200,
     "body": {
        "dan": [ <-- KEY
 
            *** MESSAGE STRUCT ***
            {
                "subject": "pets",
                "message": "dogs are happy"
            },
            ///////////////////////////////////////////
 
            *** MESSAGE STRUCT ***
            {
                "subject": "pets",
                "message": "cats are grumpy"
            }
            ///////////////////////////////////////////
 
        ],
         "bob": [  <-- KEY 
 
            *** MESSAGE STRUCT ***
            {
                 "subject": "bob stuff",
                 "message": "bob bob bob"
            },
            ////////////////////////////////////////////
 
            *** MESSAGE STRUCT ***
            {
                 "subject": "bob stuff",
                 "message": "there once was a guy named bob"
            }
            ////////////////////////////////////////////
 
        ]
    }
 }
 
 */

struct Message: Decodable {
    
    let subject: String
    let message: String
    let username: String
    
    private enum CodingKeys: CodingKey {
        
        case subject
        case message
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        subject = try container.decode(String.self, forKey: .subject)
        message = try container.decode(String.self, forKey: .message)
        
        username = container.codingPath.first!.stringValue
        
    }
    
    init(subject: String, message: String, username: String) {
        
        self.subject = subject
        self.message = message
        self.username = username
        
    }
    
}
