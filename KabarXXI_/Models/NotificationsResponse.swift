//
//  NotificationsResponse.swift
//  SMFInventory
//
//  Created by Emerio-Mac2 on 18/09/18.
//  Copyright © 2018 Emerio-Mac2. All rights reserved.
//

import Foundation
struct NotificationsResponse : Codable {
    let error: Bool
    let notifications: [Notifications]
}
