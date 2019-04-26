//
//  AppDelegate.swift
//  SMFInventory
//
//  Created by Emerio-Mac2 on 15/09/18.
//  Copyright © 2018 Emerio-Mac2. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    private func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        FirebaseApp.configure()
        GADMobileAds.configure(withApplicationID: "ca-app-pub-2551441341997407~4062270142")
        return true
    }



}

