//
//  AppDelegate.swift
//  MagnetSDKSample
//
//  Created by Saeed on 11/26/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

// در قدم اول باید SDK مگنت را به پروژه خود اضافه کنید و در کلاسی که می خواهید از آن استفاده کنید آن را Import کنید
import MagnetSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // پس از لود اپلیکیشن باید مگنت را راه اندازی اولیه کنید برای این منظور در این قسمت از متد Initialize  در کلاس MagnetSDK استفاده می کنیم
        MagnetSDK.initialize()
        
        // پس از init کلاس MagnetSDK می توانید تنظیمات مگنت را تغییر دهید
        // برای تست مگنت می توانید به صورت زیر تست مد را فعال کنید:
        MagnetSDK.settings.testMode = true
        
        // با تنظیم زیر می توانید تعیین کنید که پخش صدا فعال باشد یا خیر
        MagnetSDK.settings.soundEnable = false
        MagnetSDK.settings.logging = true
        
        return true
    }
    
}

