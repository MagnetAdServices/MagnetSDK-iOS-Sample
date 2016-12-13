# Magnet iOS SDK integration (Swift 3.1)
Sample project to integrate Magnet's advertising sdk

<div style="direction: rtl">
این متن جهت آماده سازی و استفاده از کتابخانه مگنت در برنامه‌ی کاربردی iOS شما تهیه شده است. در صورت داشتن هر گونه سوال، از طریق پست الکترونیک info@magnet.ir آن را با ما در میان بگذارید.

----------------------------------------------------------------------------


* ابتدا کتابخانه مگنت را از [اینجا](http://25.io/smaller/) دریافت کرده و به پروژه  خود اضافه کنید
> برای اضافه کردن مگنت به پروژه تون فقط کافیه MagnetSDK.Framework را کشیده و در قسمت Embedded Binaries در تب General تنظیمات پروژه خود رها کنید
> ![import](/uploads/56e2090a1a04f085ff4324b0ac368471/import.png)

* در فایل `info.plist` برنامه خود متغیر زیر را مقدار دهی 
کنید یا در صورت نیاز آن را بسازید
> ![prop](/uploads/30b518e296ff0e0de0eb219ab273e8cb/prop.png)

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

![inheritance](/uploads/fa9319ebaf91767c26d89954778f560e/inheritance.png)

سپس در کنترولر:

برای استفاده از مگنت آن را به کلاس خود اضافه کنید

```
import MagnetSDK
```
ویوی مورد نظر را به کنترلر خود معرفی کنید

```
@IBOutlet weak var magnetMobileBannerView: MagnetMobileBannerView!
```

در صورتی که تمایل به استفاده از بنرموبایل در بالای صفحه دارید می توانید خصوصیت position را با enum عمومی top مقدار دهی کنید

```
magnetMobileBannerView.position = .top
```
توسط خصوصیت positionConstant میتوانید فاصله از بالا یا پایین برای بنر خود تعریف کنید

```
magnetMobileBannerView.positionConstant = 33
```
> عدد مثبت: فاصله از بالا

> عدد منفی: فاصله از پایین

برای لود تبلیغ تنها کافیست متد زیر را اجرا کنید

```
magnetMobileBannerView.loadRequest("adUnitId")
```

> `adUnitId` همان کلیدی است که هنگام ساخت رسانه از پنل کاربری خود دریافت می‌نمایید.

در صورتی که می خواهید event های مگنت را پیاده سازی کنید باید مقدار آن را برای مگنت ارسال کنید. برای این کار به جای استفاده از متد بالا باید از متد زیر استفاده کنید: 

```
magnetMobileBannerView.loadRequest("your adUnitId", delegate: self)
```
> `delegate` برای پیاده سازی آن در ادامه راهنما به قسمت [Magnet Events](#magnet-events) مراجعه شود.

به عنوان مثال:

```
import MagnetSDK

class ViewController: UIViewController {

    @IBOutlet weak var magnetMobileBannerView: MagnetMobileBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
            
        magnetMobileBannerView.loadRequest("your adUnitId")
        // یا برای پیاده سازی با events
        // magnetMobileBannerView.loadRequest("your adUnitId", delegate: self)
    }
}
```

----------------------------------------------------------------------------

## MRect Banner

بنر مستطیلی تبلیغی است که در ابعاد مختلف نمایش داده می‌شود و ابعاد آن را شما می‌توانید بر اساس کاربردش در برنامه خودتان تعیین نمایید. همانند بنر موبایل، اضافه کردن آن به پروژه تنها به چند خط کد نیاز است.
 برای اضافه کردن آن ابتدا یک `UIView` به `View Controller` مورد نظر اضافه کرده و از قسمت `Custom Class` کلاس `MagnetMRectView` را تایپ کنید و قسمت `Module` را با `MagnetSDK` مقدار دهی کنید 

![mrectCustomClass](/uploads/971a01d5f76e8e74acfb4ece5480c1dd/mrectCustomClass.png)

پس از آن باید اندازه UIView را مناسب با یکی از سایز های استاندارد مگنت تنظیم کنید
> به عنوان مثال:
> - 300 X 250
> - 300 X 90
> - 160 X 600
> - 960 X 144
> - ...
> برای اطلاع از سایر سایز های استاندارد به پنل مگنت مراجعه کنید

![mrectSize](/uploads/1c398fc53829ffa747cec4277703e515/mrectSize.png)

سپس در کنترولر:

برای استفاده از مگنت آن را به کلاس خود اضافه کنید

```
import MagnetSDK
```
ویوی مورد نظر را به کنترلر خود معرفی کنید

```
@IBOutlet weak var magnetMRectView: MagnetMRectView!
```

برای لود تبلیغ تنها کافیست متد زیر را اجرا کنید

```
magnetMRectView.loadRequest("adUnitId")
```

> `adUnitId` همان کلیدی است که هنگام ساخت رسانه از پنل کاربری خود دریافت می‌نمایید.

در صورتی که می خواهید event های مگنت را پیاده سازی کنید باید مقدار آن را برای مگنت ارسال کنید. برای این کار به جای استفاده از متد بالا باید از متد زیر استفاده کنید: 

```
magnetMRectView.loadRequest("your adUnitId", delegate: self)
```
> `delegate` برای پیاده سازی آن در ادامه راهنما به قسمت [Magnet Events](#magnet-events) مراجعه شود.

به عنوان مثال:

```
import MagnetSDK

class ViewController: UIViewController {

    @IBOutlet weak var magnetMRectView: MagnetMobileBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
            
        magnetMRectView.loadRequest("your adUnitId")
        // یا برای پیاده سازی با events
        // magnetMRectView.loadRequest("your adUnitId", delegate: self)
    }
}
```

----------------------------------------------------------------------------

## Native Ad

در صورتی که با تبلیغات همسان آشنایی ندارید، لطفا ابتدا به [آشنایی با تبلیغات](http://magnetadservices.com/DevGuides/NativeDefinition) همسان مراجعه نمایید تا با تعریف و نحوه عملکرد آن آشنا شوید.

برای ساخت تبلیغات همسان ابتدا باید ویوی مورد نظر را مطابق با سلیقه و یا ساختار پروژه ی خود بسازید

![nativeView](/uploads/3725c8474be40e1a8a98dfec8fc115e4/nativeView.png)

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
let binder = MagnetNativeViewBinder { (views) in
    views.iconImage = iconImage
    views.headLineLabel = headLineLabel
    views.actionButton = actionButton
    views.descriptionLabel = descriptionLabel
    views.mainImage = mainImage
}
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let binder = MagnetNativeViewBinder { (views) in
            views.iconImage = iconImage
            views.headLineLabel = headLineLabel
            views.actionButton = actionButton
            views.descriptionLabel = descriptionLabel
            views.mainImage = mainImage
        }

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
func onMagnetAdError(_ code: Int, message: String, type: String) {
        print("Magnet ERROR: \(type) -> \(code): \(message)")
}
```

----------------------------------------------------------------------------

## Sample Projects

برای آشنایی بیشتر می توانید از پروژه های نمونه در github استفاده کنید:

- [Swift 3.1 Sample](http://github.com)
- [Swift 2.3 Sample](http://github.com)
- [Objective-C Sample](http://github.com)

</div>

