//
//  KeychainWrapper.swift
//  KeychainExample
//
//  Created by heba isaa on 27/07/2022.
//

import Foundation
public class KeychainWrapper: NSObject {
    /**
     Function to store a keychain item
     - parameters:
     - value: Value to store in keychain in `data` format
     - key: key name for keychain item
     */
    
    
    public static func set(value: String, key: String) throws {
        // If the value exists `update the value`
        guard let value = value.data(using: .utf8) else{
            throw  KeychainErrors.creatingError
        }
        if try KeychainOperations.exists(key: key) {
            try KeychainOperations.update(value: value, key: key)
        } else {
            // Just insert
            try KeychainOperations.add(value: value, key: key)
        }
    }
    /**
     Function to retrieve an item in ´Data´ format (If not present, returns nil)
     - parameters:
     - key: key name for keychain item
     - returns: Data from stored item
     */
    public static func get(key: String) throws -> String? {
        if try KeychainOperations.exists(key: key) {
            guard let data = try KeychainOperations.retreive(key: key) else {return nil }
            return String(data: data , encoding: .utf8)
        } else {
            throw KeychainErrors.operationError
        }
    }
    /**
     Function to delete a single item
     - parameters:
     - key: key name for keychain item
     */
    public static func delete(key: String) throws {
        if try KeychainOperations.exists(key: key) {
            return try KeychainOperations.delete(key: key)
        } else {
            throw KeychainErrors.operationError
        }
    }
    /**
     Function to delete all items
     */
    public static func deleteAll() throws {
        try KeychainOperations.deleteAll()
    }
}



