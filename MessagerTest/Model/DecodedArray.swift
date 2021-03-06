//
//  MessagesData.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/15/20.
//

import Foundation

/**
Parses a JSON (Data) type that represents the "body" parameter of a getAllMessages response
*/
struct DecodedArray: Decodable {

    var array: [[Message]]
    
    private struct DynamicCodingKeys: CodingKey {
        
        // The response is keyed by strings representing usernames ie. 'Dan'
        var stringValue: String
        init?(stringValue: String) {
            
            self.stringValue = stringValue
            
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            
            return nil
            
        }
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        var tempArray = [[Message]]()
        
        for key in container.allKeys {
            
            // The object will be a [Message]
            let decodedObject = try container.decode(Array<Message>.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            
            tempArray.append(decodedObject)
            
        }
        
        array = tempArray
        
    }
 
}
