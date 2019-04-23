//
//  Notifications.swift
//  SMFInventory
//
//  Created by Emerio-Mac2 on 18/09/18.
//  Copyright © 2018 Emerio-Mac2. All rights reserved.
//

import Foundation

struct Notifications : Codable {
    let notification_id:Int
    let title:String
    let description:String
    let status:String
    let notifications_image:String
    let created_date:String
}
