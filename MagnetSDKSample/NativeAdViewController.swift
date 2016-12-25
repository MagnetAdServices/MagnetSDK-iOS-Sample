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
    
    @IBOutlet weak var headLine: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var main: UIImageView!
    @IBOutlet weak var action: UIButton!
    
    var binder: MagnetNativeViewBinder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ابتدا به وسیله ی builder زیر می توانید ویو های خود را به مگنت معرفی کنید  و در متغیر نگهداری داری کنید
        binder = MagnetNativeViewBinder {
            $0.headLineLabel = headLine
            $0.descriptionLabel = des
            $0.iconImage = icon
            $0.mainImage = main
            $0.actionButton = action
        }
        
        // س‍پس توسط متغییری که مقدار MagnetNativeViewBinder را نگهداری می کند دستور لود تبلیغ را صادر می کنیم
        //توجه داشته باشید که همراه دستور لود تبلیغ باید مقدرا adUnitId را ارسال کنید و برای دریافت خطاها delegate این کلاس را نیز ارسال کنید
        binder.loadRequest("YourAdUnitId", delegate: self)
    }

    // در صورتی که MagnetEventsDelegate را پیاده سازی کرده باشید از طریق متد زیر می توانید ارور های مگنت را دریافت و چاپ نمایید
    // درصورتی که این متد فراخوانی شود به این معنی میباشد که به دلایلی تبلیغ مورد نظر لود نشده است که علت آن از طریق پارامتر های این متد در دسترس است
    func onMagnetAdError(_ code: Int, message: String, type: String) {
        print("Magnet ERROR: \(type) -> \(code): \(message)")
    }

}
