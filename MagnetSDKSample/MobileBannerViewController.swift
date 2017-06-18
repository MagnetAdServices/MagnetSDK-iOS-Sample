//
//  MobileBannerViewController.swift
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
class MobileBannerViewController: UIViewController, MagnetEventsDelegate {
    
        // ویو (View) های خود را که در قسمت Custom Class شان از کلاس های مگنت به ارث برده اید در کنترلر خود تعریف کنید
    @IBOutlet weak var magnetAdMobileBannerView: MagnetAdMobileBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // برای لود تبلیغ تنها کافیست متد زیر را اجرا کنید
//        magnetAdMobileBannerView.loadRequest("YourAdUnitId")
        
        // در صورتی که می خواهید خطاهای هنگام اجرای برنامه را مشاهده کنید می توانید delegate مگنت را نیز در کلاس کنترلر خود به ارث برده و همرا با متد loadRequest به آن معرفی کنید. مانند زیر:
        magnetAdMobileBannerView.loadRequest(adUnitID: "0ed6ce11664e48ac9cc8982f2fcbca3a", delegate: self)
        
        
        // در صورتی که تمایل به استفاده از بنرموبایل در بالای صفحه دارید می توانید خصوصیت position را با enum عمومی top مقدار دهی کنید
        // magnetAdMobileBannerView.position = .top
        // توسط خصوصیت positionConstant میتوانید فاصله از بالا یا پایین برای بنر خود تعریف کنید
        // عدد مثبت: فاصله از بالا
        // عدد منفی: فاصله از پایین
        // magnetAdMobileBannerView.positionConstant = 33
    }
    
    
    // در صورتی که MagnetEventsDelegate را پیاده سازی کرده باشید از طریق متد زیر می توانید ارور های مگنت را دریافت و چاپ نمایید
    // درصورتی که این متد فراخوانی شود به این معنی میباشد که به دلایلی تبلیغ مورد نظر لود نشده است که علت آن از طریق پارامتر های این متد در دسترس است
    func magnetAdErrors(code: Int, message: String, adType: MagnetAdType) {
        print("\(Date().now) Magnet ERROR: \(adType) -> \(code): \(message)")
    }

}
