//
//  KeychainOperations.swift
//  KeychainExample
//
//  Created by heba isaa on 27/07/2022.
//

import Foundation
 class KeychainOperations: NSObject {
    /**
     Funtion to add an item to keychain
     - parameters:
     - value: Value to save in `data` format (String, Int, Double, Float, etc)
     - key: key name for keychain item
     */
     static func add(value: Data, key: String) throws {
        let status = SecItemAdd([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecAttrService: "Example",
            // Allow background access:
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
            kSecValueData: value,
            ] as NSDictionary, nil)
        guard status == errSecSuccess else { throw KeychainErrors.operationError }
    }
    /**
     Function to update an item to keychain
     - parameters:
     - value: Value to replace for
     - key: key name for keychain item
     */
     static func update(value: Data, key: String) throws {
        let status = SecItemUpdate([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecAttrService: "Example",
            ] as NSDictionary, [
                kSecValueData: value,
                ] as NSDictionary)
        guard status == errSecSuccess else { throw KeychainErrors.operationError }
    }
    /**
     Function to retrieve an item to keychain
     - parameters:
     - key: key name for keychain item
     */
     static func retreive(key: String) throws -> Data? {
        /// Result of getting the item
        var result: AnyObject?
        /// Status for the query
        let status = SecItemCopyMatching([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecAttrService: "Example",
            kSecReturnData: true,
            ] as NSDictionary, &result)
        // Switch to conditioning statement
        switch status {
        case errSecSuccess:
            return result as? Data
        case errSecItemNotFound:
            return nil
        default:
            throw KeychainErrors.operationError
        }
    }
    /**
     Function to delete a single item
     - parameters:
     - key: key name for keychain item
     */
     static func delete(key: String) throws {
        /// Status for the query
        let status = SecItemDelete([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecAttrService: "Example",
            ] as NSDictionary)
        guard status == errSecSuccess else { throw KeychainErrors.operationError }
    }
    /**
     Function to delete all items for the app
     */
     static func deleteAll() throws {
        let status = SecItemDelete([
            kSecClass: kSecClassGenericPassword,
            ] as NSDictionary)
        guard status == errSecSuccess else { throw KeychainErrors.operationError }
    }
    /**
     Function to check if we've an existing a keychain `item`
     - parameters:
     - key: String type with the name of the item to check
     - returns: Boolean type with the answer if the keychain item exists
     */
    static func exists(key: String) throws -> Bool {
        /// Constant with current status about the keychain to check
        let status = SecItemCopyMatching([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecAttrService: "Example",
            kSecReturnData: false,
            ] as NSDictionary, nil)
        // Switch to conditioning statement
        switch status {
        case errSecSuccess:
            return true
        case errSecItemNotFound:
            return false
        default:
            throw KeychainErrors.creatingError
        }
    }
}
 enum KeychainErrors: Error {
    /// Error with the keychain creting and checking
    case creatingError
    /// Error for operation
    case operationError
}



