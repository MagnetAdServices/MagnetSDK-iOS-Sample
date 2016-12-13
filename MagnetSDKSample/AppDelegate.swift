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
        MagnetSDK.settings.soundEnable = true
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

