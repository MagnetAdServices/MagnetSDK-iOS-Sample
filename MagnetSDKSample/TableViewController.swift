//
//  TableViewController.swift
//  MagnetSDKSample
//
//  Created by Saeed on 11/26/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

// در قدم اول باید SDK مگنت را به پروژه خود اضافه کنید
//و در کلاسی که می خواهید از آن استفاده کنید آن را Import کنید
import MagnetSDK

// پروتکل MagnetEventsDelegate را برای دریافت خطاهای هنگام اجرا می توانید پیاده سازی کنید
class TableViewController: UITableViewController, MagnetEventsDelegate {
    
    // یک آرایه برای مقدار دهی ایجاد می کنیم
    // برای این کار می توانیم از یک مدل داده استفاده کنیم.
    private var array = [DataModel?]()
    private var ads = [MagnetNativeViewBinder?]()
    
    // شناسه ی adUnit خود را که از پنل مگنت دریافت نموده اید در یک constant نگهداری کنید
    let myAdUnitId = "0ed6ce11664e48ac9cc8982f2fcbca3a" //"Your adUnitId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // آرایه ای که ساختیم را با مقادیری که می خواهیم پر می کنیم و برای قسمت هایی که تبلیغ باید جایگزین آن شود مقدار nil را جایگذاری می کنیم
        // توجه: این تنها یک پیشنهاد است و شما به هر روشی که خواستید می توانید برنامه خود را پیاده سازی کنید
        let img = UIImage(named: "magnet")!
        array.append(DataModel(headLine: "تیتر اول", description: "توضیحات اول", icon: img, mainImage: img, actionBtn: "ادامه"))
        array.append(nil)
        array.append(DataModel(headLine: "تیتر دوم", description: "توضیحات دوم", icon: img, mainImage: img, actionBtn: "ادامه"))
        array.append(nil)
        array.append(DataModel(headLine: "تیتر سوم", description: "توضیحات سوم", icon: img, mainImage: img, actionBtn: "ادامه"))
        array.append(DataModel(headLine: "تیتر چهارم", description: "توضیحات چهارم", icon: img, mainImage: img, actionBtn: "ادامه"))
        array.append(DataModel(headLine: "تیتر پنجم", description: "توضیحات پنجم", icon: img, mainImage: img, actionBtn: "ادامه"))
        array.append(nil)
        array.append(DataModel(headLine: "تیتر ششم", description: "توضیحات ششم", icon: img, mainImage: img, actionBtn: "ادامه"))
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        // ابتدا به وسیله ی builder زیر می توانید ویو های خود را به مگنت معرفی کنید  و در متغیر نگهداری داری کنید
        let binder = MagnetNativeViewBinder {
            $0.headLineLabel = cell.headLine
            $0.descriptionLabel = cell.descriptionLabel
            $0.iconImage = cell.iconImage
            $0.mainImage = cell.mainImage
            $0.actionButton = cell.action
        }
        
        if let row = array[indexPath.row] {
            // خانه های آرایه که دارای مقدار هستند در این قسمت در جایگاه خود قرار می گیرند
            cell.headLine.text = row.headLine
            cell.descriptionLabel.text = row.description
            cell.iconImage.image = row.icon
            cell.mainImage.image = row.mainImage
            cell.action.setTitle(row.actionBtn, for: .normal)
            return cell
            
        } else {
            
// اما در این قسمت خانه هایی که مقدار nil گرفته اند ابتدا مقدار دهی اولیه می شوند تا در صورت  تاخیر در لود تبلیغ فضای خالی نداشته باشیم
            
            let img = UIImage(named: "no_cover")!
            cell.headLine.text = "تبلیغات"
            cell.descriptionLabel.text = "توضیح تبلیغات"
            cell.iconImage.image = img
            cell.mainImage.image = img
            cell.action.setTitle("...", for: .normal)

            // س‍پس توسط متغییری که مقدار MagnetNativeViewBinder را نگهداری می کند دستور لود تبلیغ را صادر می کنیم
            //توجه داشته باشید که همراه دستور لود تبلیغ باید مقدرا adUnitId را ارسال کنید و برای دریافت خطاها delegate این کلاس را نیز ارسال کنید
            
            for cel in cell.contentView.subviews {
                cel.removeFromSuperview()
            }
            
            
            binder.loadRequest(myAdUnitId, delegate: self)
//            if !ads.isEmpty, let reservedAd = ads[indexPath.row] {
//                cell.headLine = reservedAd.headLineLabel
//                cell.descriptionLabel = reservedAd.descriptionLabel
//                cell.iconImage = reservedAd.iconImage
//                cell.mainImage = reservedAd.mainImage
//                cell.action = reservedAd.actionButton
//            } else {
//                let binder = MagnetNativeViewBinder {
//                    $0.headLineLabel = cell.headLine
//                    $0.descriptionLabel = cell.descriptionLabel
//                    $0.iconImage = cell.iconImage
//                    $0.mainImage = cell.mainImage
//                    $0.actionButton = cell.action
//                }
//                binder.loadRequest(myAdUnitId, delegate: self)
//                //ads[indexPath.row] = binder
//            }
            
            
//            binder.loadRequest(myAdUnitId, delegate: self)
//            ads[indexPath.row] = binder

            return cell
        }
    }
    
    // در صورتی که MagnetEventsDelegate را پیاده سازی کرده باشید از طریق متد زیر می توانید ارور های مگنت را دریافت و چاپ نمایید
    //درصورتی که این متد فراخوانی شود به این معنی میباشد که به دلایلی تبلیغ مورد نظر لود نشده است که از طریق پارامتر های آن به این متد ارسال می شود
    func onMagnetAdError(_ code: Int, message: String, type: String) {
        print("Magnet ERROR: \(type) -> \(code): \(message)")
        
        // در صورتی که تبلیغی وجود نداشته باشد و یا به هر دلیل دیگری قادر به دریافت تبلیغ نباشید می توانید cell های تبلیغاتی را حذف کنید .
        array = array.filter({ $0 != nil })
        tableView.reloadData()
    }
    
}
