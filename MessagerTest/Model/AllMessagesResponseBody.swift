//
//  AllMessagesResponseBody.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/18/20.
//

import Foundation

/**
 The parent body of a getAllMessages call
 stores "body" inside a decodedArray to attribute the username keys to an array of structured [Messages]
 
 The response from AWS is structured:
 
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

struct Body: Decodable {
    
    let statusCode: Int
    let body: DecodedArray
    
    private enum CodingKeys: String, CodingKey {
        
        case statusCode, body
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        statusCode = try container.decode(Int.self, forKey: .statusCode)
        
        // Get the string
        let dataString = try container.decode(String.self, forKey: .body)

        body = try JSONDecoder().decode(DecodedArray.self, from: Data(dataString.utf8))
        
    }
    
}
