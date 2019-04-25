//
//  UserResponse.swift
//  SMFInventory
//
//  Created by Emerio-Mac2 on 17/09/18.
//  Copyright © 2018 Emerio-Mac2. All rights reserved.
//

import Foundation
struct UserResponse : Codable {
    let error:Bool
    let data:User
}
