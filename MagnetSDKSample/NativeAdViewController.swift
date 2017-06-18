//
//  NativeAdViewController.swift
//  MagnetSDKSample
//
//  Created by Saeed on 12/18/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit
// در قدم اول باید SDK مگنت را به پروژه خود اضافه کنید
// و در کلاسی که می خواهید از آن استفاده کنید آن را Import کنید
import MagnetSDK

// پروتکل MagnetEventsDelegate را برای دریافت خطاهای هنگام اجرا می توانید پیاده سازی کنید
class NativeAdViewController: UIViewController, MagnetEventsDelegate {
    
    @IBOutlet weak var adTitle: UILabel!
    @IBOutlet weak var adDescription: UILabel!
    @IBOutlet weak var adIcon: UIImageView!
    @IBOutlet weak var adPicture: UIImageView!
    @IBOutlet weak var adButton: UIButton!
    
    var binder: MagnetAdNative!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ابتدا به وسیله ی builder زیر می توانید ویو های خود را به مگنت معرفی کنید  و در متغیر نگهداری داری کنید
        binder = MagnetAdNative (builder: { (binder) in
            binder.iconImage = self.adIcon
            binder.headLineLabel = self.adTitle
            binder.descriptionLabel = self.adDescription
            binder.actionButton = self.adButton
            binder.mainImage = self.adPicture
        })
        
        // س‍پس توسط متغییری که مقدار MagnetNativeViewBinder را نگهداری می کند دستور لود تبلیغ را صادر می کنیم
        //توجه داشته باشید که همراه دستور لود تبلیغ باید مقدرا adUnitId را ارسال کنید و برای دریافت خطاها delegate این کلاس را نیز ارسال کنید
        binder.loadRequest(adUnitId: "0ed6ce11664e48ac9cc8982f2fcbca3a", delegate: self)
    }

    // در صورتی که MagnetEventsDelegate را پیاده سازی کرده باشید از طریق متد زیر می توانید ارور های مگنت را دریافت و چاپ نمایید
    // درصورتی که این متد فراخوانی شود به این معنی میباشد که به دلایلی تبلیغ مورد نظر لود نشده است که علت آن از طریق پارامتر های این متد در دسترس است
    func magnetAdErrors(code: Int, message: String, adType: MagnetAdType) {
        print("\(Date().now) Magnet ERROR: \(adType) -> \(code): \(message)")
    }
}


