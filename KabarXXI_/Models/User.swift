//
//  User.swift
//  SMFInventory
//
//  Created by Emerio-Mac2 on 16/09/18.
//  Copyright © 2018 Emerio-Mac2. All rights reserved.
//

import Foundation
struct User : Codable {
    let username:String
    let email:String
    let phone:String
    let address:String
    let instagram:String
    let facebook:String
    let image_user:String
    let encrypted_password:String
}
