//
//  UserModel.swift
//  Gardenplanner
//
//  Created by Philipp on 14.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class UserModel: NSObject {

    fileprivate var model = ModelSingleton.sharedInstance
    
    func numberOfEntries() -> Int{
        return model.users.count
    }
    
    func add(user : UsersStruct){
        model.users.append(user)
    }
    
    func set(users : [UsersStruct]){
        model.users = users
    }
    
    func getElement(at position : Int) -> UsersStruct{
        return model.users[position]
    }
    
    func remove(at position : Int){
        model.users.remove(at: position)
    }
    
    func clear(){
        model.users = []
    }
}
