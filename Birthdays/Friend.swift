//
//  Friend.swift
//  Birthdays
//
//  Created by Scholar on 8/8/25.
//

import Foundation
import SwiftData

// adding name and birthday
@Model
class Friend {
    var name: String
    var birthday: Date
    
init(name: String, birthday: Date) {
        self.name = name
        self.birthday = birthday
    }
    
} // end of class Friend :3
