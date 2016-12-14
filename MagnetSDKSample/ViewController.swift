//
//  ViewController.swift
//  MagnetSDKSample
//
//  Created by Saeed on 11/26/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit
import CoreLocation

// در قدم اول باید SDK مگنت را به پروژه خود اضافه کنید
//و در کلاسی که می خواهید از آن استفاده کنید آن را Import کنید
import MagnetSDK

// پروتکل MagnetEventsDelegate را برای دریافت خطاهای هنگام اجرا می توانید پیاده سازی کنید

class ViewController: UIViewController, MagnetEventsDelegate {

    // MARK: My AD Views
    // ویو (View) های خود را که در قسمت Custom Class شان از کلاس های مگنت به ارث برده اید در کنترلر خود تعریف کنید
    @IBOutlet weak var magnetMRectAd: MagnetMRectView!
    @IBOutlet weak var magnetMobileBannerAd: MagnetMobileBannerView!
    
    // شناسه ی adUnit خود را که از پنل مگنت دریافت نموده اید در یک constant نگهداری کنید
    let myAdUnitId = "your adUnitId"
    
    // MARK: ---------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // برای لود تبلیغ تنها کافیست متد زیر را اجرا کنید
        // magnetMRectAd.loadRequest(myAdUnitId)
        // و یا برای موبایل بنر:
        // magnetMobileBannerAd.loadRequest(myAdUnitId)
        
        
        // در صورتی که می خواهید خطاهای هنگام اجرای برنامه را مشاهده کنید می توانید delegate مگنت را نیز در کلاس کنترلر خود به ارث برده و همرا با متد loadRequest به آن معرفی کنید. مانند زیر:
        magnetMRectAd.loadRequest(myAdUnitId, delegate: self)
        
        // برای موبایل بنر هم همین روند را طی می کنیم
        magnetMobileBannerAd.loadRequest(myAdUnitId, delegate: self)
        
        // در صورتی که تمایل به استفاده از بنرموبایل در بالای صفحه دارید می توانید خصوصیت position را با enum عمومی top مقدار دهی کنید
        // magnetMobileBannerAd.position = .top
        // توسط خصوصیت positionConstant میتوانید فاصله از بالا یا پایین برای بنر خود تعریف کنید
        // عدد مثبت: فاصله از بالا
        // عدد منفی: فاصله از پایین
        // magnetMobileBannerAd.positionConstant = 33
        
    }
    
    // در صورتی که MagnetEventsDelegate را پیاده سازی کرده باشید از طریق متد زیر می توانید ارور های مگنت را دریافت و چاپ نمایید
    //درصورتی که این متد فراخوانی شود به این معنی میباشد که به دلایلی تبلیغ مورد نظر لود نشده است که علت آن از طریق پارامتر های این متد در دسترس است
    func onMagnetAdError(_ code: Int, message: String, type: String) {
        print("Magnet ERROR: \(type) -> \(code): \(message)")
        
        if code == 41 || code == 31 {
            switch type {
            case "mRect":
                DispatchQueue.main.async {
                    self.magnetMRectAd.stop()
                    self.magnetMRectAd.removeFromSuperview()
                }
            case "mobileBanner":
                DispatchQueue.main.async {
                    self.magnetMobileBannerAd.stop()
                    self.magnetMobileBannerAd.removeFromSuperview()
                }
            default: break
            }
            
        }
    }

}

