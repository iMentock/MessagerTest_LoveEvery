//
//  UserSearchMessageBody.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/18/20.
//

import Foundation

/**
 The parent structure of a message search filtered by users
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

struct UserMessageBody: Decodable {
    
    let statusCode: Int
    let body: DecodedUserMessageArray
    
    private enum CodingKeys: String, CodingKey {
        
        case statusCode, body
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        statusCode = try container.decode(Int.self, forKey: .statusCode)

        // Get the string
        let dataString = try container.decode(String.self, forKey: .body)
        
        body = try JSONDecoder().decode(DecodedUserMessageArray.self, from: Data(dataString.utf8))
        
    }
    
}
