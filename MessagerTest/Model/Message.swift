//
//  Message.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/15/20.
//

import Foundation

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
}

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
