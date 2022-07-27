//
//  ViewController.swift
//  KeychainExample
//
//  Created by heba isaa on 27/07/2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeData()
        getData()
        
        
    }
    
    //MARK - STORE DATA
    
    func storeData(){
        
        do{
            try KeychainWrapper.set(value: "Value", key: "heba")
        } catch let error {
            
            print(error)
        }
        
    }
    //MARK: - GET DATA STORED
    
    func getData(){
        
        do{
            let token = try KeychainWrapper.get(key: "heba")
            print(token ?? "")
        } catch let error {
            
            print(error)
        }
        
    }
    
}
