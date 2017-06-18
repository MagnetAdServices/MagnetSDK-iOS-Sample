# Magnet iOS SDK integration (Swift 3.1)

Sample project to integrate Magnet's advertising sdk

## 👉 [For Swift 3.0.2 Sample Click Here](https://github.com/MagnetAdServices/MagnetSDK-iOS-Sample/tree/3.0.2)


این متن جهت آماده سازی و استفاده از کتابخانه مگنت در برنامه‌ی کاربردی iOS شما تهیه شده است. در صورت داشتن هر گونه سوال، از طریق پست الکترونیک info@magnet.ir آن را با ما در میان بگذارید.

----------------------------------------------------------------------------


* ابتدا کتابخانه مگنت را از [اینجا][1] دریافت کرده و به پروژه  خود اضافه کنید و یا از همین Repository بردارید!
> برای اضافه کردن مگنت به پروژه تون فقط کافیه MagnetSDK.Framework را کشیده و در قسمت Embedded Binaries در تب General تنظیمات پروژه خود رها کنید
> ![import][2]

* در فایل `info.plist` برنامه خود متغیر زیر را مقدار دهی 
کنید یا در صورت نیاز آن را بسازید
> ![prop][3]

----------------------------------------------------------------------------

## راه اندازی سیستم تبلیغ

- [Initialize](#Initialize)
- [Mobile Banner](#mobile-banner)
- [MRect Banner](#mrect-banner)
- [Native Ad](#native-ad)
- [Magnet Events](#magnet-events)
- [Sample Projects](#sample-projects)

### تعریف رسانه

برای استفاده از سیستم تبلیغاتی مگنت ابتدا در قسمت رسانه ها یک رسانه تعریف کنید. پس از تعریف رسانه، به ازای هر جایگاه تبلیغاتی به شما یک کلید داده می‌شود. از این کلید برای دریافت تبلیغ توسط برنامه‌ی شما استفاده خواهد شد تا بتوانید در محل‌های مختلفی از برنامه‌ی خود تبلیغات مختلفی نمایش دهید.

## Initialize

برای استفاده از مگنت آن را به کلاس خود اضافه کنید

```
import MagnetSDK
```

بعد از `import` کردن مگنت به کلاس های خود نیاز به راه اندازی اولیه داریم که با قرار دادن کد زیر در متد `application` کلاس `AppDelegate.swift` برنامه شما انجام خواهد شد.

```
MagnetSDK.Initialize()
```

#### برای دسترسی به تنظیمات مگنت می توانید از همین کلاس استفاده کنید
> به عنوان مثال : جهت تست کتابخانه مگنت test mode را فعال نمایید و تنها در صورت نهایی شدن و قبل از انتشار برنامه آن را غیر فعال نمایید

```
MagnetSDK.settings.testMode = true
```

به عنوان مثال:

```
import MagnetSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?


func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

MagnetSDK.initialize()
MagnetSDK.settings.testMode = true

return true
}
}
```

----------------------------------------------------------------------------


## Mobile Banner

بنر موبایل تبلیغی است که معمولا به صورت نواری در پایین صفحه نمایش، نشان داده می‌شود و برای اضافه کردن آن ابتدا یک `UIView` به `View Controller` مورد نظر اضافه کرده و از قسمت `Custom Class` کلاس `MagnetMobileBannerView` را تایپ کنید و قسمت `Module` را با `MagnetSDK` مقدار دهی کنید 

![inheritance][4]

سپس در کنترولر:

برای استفاده از مگنت آن را به کلاس خود اضافه کنید

```
import MagnetSDK
```
ویوی مورد نظر را به کنترلر خود معرفی کنید

```
@IBOutlet weak var magnetAdMobileBannerView: MagnetAdMobileBannerView!
```

در صورتی که تمایل به استفاده از بنرموبایل در بالای صفحه دارید می توانید خصوصیت position را با enum عمومی top مقدار دهی کنید

```
magnetAdMobileBannerView.position = .top
```
توسط خصوصیت positionConstant میتوانید فاصله از بالا یا پایین برای بنر خود تعریف کنید

```
magnetAdMobileBannerView.positionConstant = 33
```
> عدد مثبت: فاصله از بالا

> عدد منفی: فاصله از پایین

برای لود تبلیغ تنها کافیست متد زیر را اجرا کنید

```
magnetAdMobileBannerView.loadRequest("adUnitId")
```

> `adUnitId` همان کلیدی است که هنگام ساخت رسانه از پنل کاربری خود دریافت می‌نمایید.

در صورتی که می خواهید event های مگنت را پیاده سازی کنید باید مقدار آن را برای مگنت ارسال کنید. برای این کار به جای استفاده از متد بالا باید از متد زیر استفاده کنید: 

```
magnetAdMobileBannerView.loadRequest("your adUnitId", delegate: self)
```
> `delegate` برای پیاده سازی آن در ادامه راهنما به قسمت [Magnet Events](#magnet-events) مراجعه شود.

به عنوان مثال:

```
import MagnetSDK

class ViewController: UIViewController {

@IBOutlet weak var magnetAdMobileBannerView: MagnetAdMobileBannerView!

override func viewDidLoad() {
super.viewDidLoad()

magnetAdMobileBannerView.loadRequest("your adUnitId")
// یا برای پیاده سازی با events
// magnetAdMobileBannerView.loadRequest("your adUnitId", delegate: self)
}
}
```

----------------------------------------------------------------------------

## MRect Banner

بنر مستطیلی تبلیغی است که در ابعاد مختلف نمایش داده می‌شود و ابعاد آن را شما می‌توانید بر اساس کاربردش در برنامه خودتان تعیین نمایید. همانند بنر موبایل، اضافه کردن آن به پروژه تنها به چند خط کد نیاز است.
برای اضافه کردن آن ابتدا یک `UIView` به `View Controller` مورد نظر اضافه کرده و از قسمت `Custom Class` کلاس `MagnetMRectView` را تایپ کنید و قسمت `Module` را با `MagnetSDK` مقدار دهی کنید 

![mrectCustomClass][5]

پس از آن باید اندازه UIView را مناسب با یکی از سایز های استاندارد مگنت تنظیم کنید
> به عنوان مثال:
> - 300 X 250
> - 300 X 90
> - 160 X 600
> - 960 X 144
> - ...
> برای اطلاع از سایر سایز های استاندارد به پنل مگنت مراجعه کنید

![mrectSize][6]

سپس در کنترولر:

برای استفاده از مگنت آن را به کلاس خود اضافه کنید

```
import MagnetSDK
```
ویوی مورد نظر را به کنترلر خود معرفی کنید

```
@IBOutlet weak var magnetAdMRectView: MagnetAdMRectView!
```

برای لود تبلیغ تنها کافیست متد زیر را اجرا کنید

```
magnetAdMRectView.loadRequest("adUnitId")
```

> `adUnitId` همان کلیدی است که هنگام ساخت رسانه از پنل کاربری خود دریافت می‌نمایید.

در صورتی که می خواهید event های مگنت را پیاده سازی کنید باید مقدار آن را برای مگنت ارسال کنید. برای این کار به جای استفاده از متد بالا باید از متد زیر استفاده کنید: 

```
magnetAdMRectView.loadRequest("your adUnitId", delegate: self)
```
> `delegate` برای پیاده سازی آن در ادامه راهنما به قسمت [Magnet Events](#magnet-events) مراجعه شود.

به عنوان مثال:

```
import MagnetSDK

class ViewController: UIViewController {

@IBOutlet weak var magnetAdMRectView: MagnetAdMRectView!

override func viewDidLoad() {
super.viewDidLoad()

magnetAdMRectView.loadRequest("your adUnitId")
// یا برای پیاده سازی با events
// magnetAdMRectView.loadRequest("your adUnitId", delegate: self)
}
}
```

----------------------------------------------------------------------------

## Native Ad

در صورتی که با تبلیغات همسان آشنایی ندارید، لطفا ابتدا به [آشنایی با تبلیغات][7] همسان مراجعه نمایید تا با تعریف و نحوه عملکرد آن آشنا شوید.

برای ساخت تبلیغات همسان ابتدا باید ویوی مورد نظر را مطابق با سلیقه و یا ساختار پروژه ی خود بسازید

![nativeView][8]

> همانگونه که در تصویر بالا می بینید ساختار ویوی شما حتما باید متشکل از سه قسمت ضروری زیر (که با ستاره مشخص شده اند) باشد اما شما میتوانید گزینه های بعدی را هم به تبلیغ خود اضافه کنید کنید
> - iconImage = UIImageView (*)
> - headlineLabel = UILabel (*)
> - actionButton = UIButton (*)
> - descriptionLabel = UILabel
> - mainImage = UIImageView

سپس در کنترولر:

برای استفاده از مگنت آن را به کلاس خود اضافه کنید

```
import MagnetSDK
```

ویو های خود را به کنترلر آن معرفی کنید

```
@IBOutlet weak var iconImage: UIImageView!
@IBOutlet weak var headLineLabel: UILabel!
@IBOutlet weak var actionButton: UIButton! 
@IBOutlet weak var descriptionLabel: UILabel!
@IBOutlet weak var mainImage: UIImageView!
```

در این قسمت باید ویوی هایی که در بالا ایجاد کردیم را به مگنت معرفی کنیم. برای این کار از کلاس MagnetNativeViewBinder استفاده می کنیم.
این کلاس یک builder می باشد که به صورت زیر پیاده سازی می شود

```
var binder: MagnetAdNative!

binder = MagnetAdNative (builder: { (binder) in
binder.iconImage = self.iconImage
binder.headLineLabel = self.headLineLabel
binder.descriptionLabel = self.adDescription
binder.actionButton = self.actionButton
binder.mainImage = self.mainImage
})
```

> `binder`ثابتی است که مقدار MagnetNativeViewBinder در خود نگه می دارد

> `views.iconImage` متغیری است که ویوی شما در آن قرار میگیرد

> `iconImage` همان ویویی است که در بالا ایجاد کردیم

برای لود تبلیغ تنها کافیست متد زیر را اجرا کنید

```
binder.loadRequest("adUnitId")
```

> `adUnitId` همان کلیدی است که هنگام ساخت رسانه از پنل کاربری خود دریافت می‌نمایید.

در صورتی که می خواهید event های مگنت را پیاده سازی کنید باید مقدار آن را برای مگنت ارسال کنید. برای این کار به جای استفاده از متد بالا باید از متد زیر استفاده کنید: 

```
binder.loadRequest("your adUnitId", delegate: self)
```
> `delegate` برای پیاده سازی آن در ادامه راهنما به قسمت [Magnet Events](#magnet-events) مراجعه شود.

به عنوان مثال:

```
import MagnetSDK

class ViewController: UIViewController {

@IBOutlet weak var iconImage: UIImageView!
@IBOutlet weak var headLineLabel: UILabel!
@IBOutlet weak var actionButton: UIButton! 
@IBOutlet weak var descriptionLabel: UILabel!
@IBOutlet weak var mainImage: UIImageView!

var binder: MagnetAdNative!

override func viewDidLoad() {
super.viewDidLoad()

binder = MagnetAdNative (builder: { (binder) in
binder.iconImage = self.iconImage
binder.headLineLabel = self.headLineLabel
binder.descriptionLabel = self.adDescription
binder.actionButton = self.actionButton
binder.mainImage = self.mainImage
})

binder.loadRequest("your adUnitId")
// یا برای پیاده سازی با events
// binder.loadRequest("your adUnitId", delegate: self)
}
}
```

----------------------------------------------------------------------------

## Magnet Events

برای اطلاع از وضعیت تبلیغ می توانید با ارث بری از پروتکل `MagnetEventsDelegate` متد های آن را پیاده سازی کنید

```
class ViewController: UIViewController, MagnetEventsDelegate 
```

در صورتی که MagnetEventsDelegate را پیاده سازی کرده باشید از طریق متد زیر می توانید ارور های مگنت را دریافت و چاپ نمایید

```
func magnetAdErrors(_ code: Int, message: String, type: String) {
print("Magnet ERROR: \(type) -> \(code): \(message)")
}
```

----------------------------------------------------------------------------


[1]:https://app.magnetadservices.com/FileHandler/Download/Swift
[2]:https://user-images.githubusercontent.com/6095298/27259253-ce8d04a8-5423-11e7-8ec9-a00fd5f62a2b.jpg
[3]:https://user-images.githubusercontent.com/6095298/27259256-cefc0326-5423-11e7-8bfa-fffb20a19411.jpg
[4]:https://user-images.githubusercontent.com/6095298/27259255-cebb740a-5423-11e7-8249-2e1d4a605084.jpg
[5]:https://user-images.githubusercontent.com/6095298/27259254-ceb99ba8-5423-11e7-8da1-814fba4db43d.jpg
[6]:https://user-images.githubusercontent.com/6095298/27259257-cefc1b5e-5423-11e7-8cd6-2954e4f99ed0.jpg
[7]:/devguides/introduction-to-native-ad
[8]:https://user-images.githubusercontent.com/6095298/27259299-aa81b30a-5424-11e7-893a-fb57484e2f97.png

