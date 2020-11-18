//
//  DecodedUserMessageArray.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/18/20.
//

import Foundation


struct DecodedUserMessageArray: Decodable {

    var user: String
    var message: [UserSearchMessage]
    
    private enum CodingKeys: String, CodingKey {
        
        case user, message
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        user = try container.decode(String.self, forKey: .user)
        message = try container.decode(Array<UserSearchMessage>.self, forKey: .message)
        
    }
    
}
