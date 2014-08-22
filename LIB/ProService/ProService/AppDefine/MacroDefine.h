/*--------------------------------开发中常用到的宏定义--------------------------------------*/

//系统目录
#define kDocuments  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define ApplicationDocumentsDirectory [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]

//----------方法简写-------
#define mAppDelegate        (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define mWindow             [[[UIApplication sharedApplication] windows] lastObject]
#define mKeyWindow          [[UIApplication sharedApplication] keyWindow]
#define mUserDefaults       [NSUserDefaults standardUserDefaults]
#define mNotificationCenter [NSNotificationCenter defaultCenter]

//加载图片
#define mImageByName(name)        [UIImage imageNamed:name]
#define mImageByPath(name, ext)   [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:ext]]

//以tag读取View
#define mViewByTag(parentView, tag, Class)  (Class *)[parentView viewWithTag:tag]

//id对象与NSData之间转换
#define mObjectToData(object)   [NSKeyedArchiver archivedDataWithRootObject:object]
#define mDataToObject(data)     [NSKeyedUnarchiver unarchiveObjectWithData:data]

//度弧度转换
#define mDegreesToRadian(x)      (M_PI * (x) / 180.0)
#define mRadianToDegrees(radian) (radian*180.0) / (M_PI)

//颜色转换
#define mRGBColor(r, g, b)         [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define mRGBAColor(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//G－C－D
#define kGCDBackground(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define kGCDMain(block)       dispatch_async(dispatch_get_main_queue(),block)

//简单的以AlertView显示提示信息
#define mAlertView(title, msg) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil \
cancelButtonTitle:@"确定" \
otherButtonTitles:nil]; \
[alert show];


//----------页面设计相关-------
#define mScreenWidth          ([UIScreen mainScreen].bounds.size.width)
#define mScreenHeight         ([UIScreen mainScreen].bounds.size.height)


//----------设备系统相关---------
#define mRetina   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define Is_Pad    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define Is_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7_OR_LATER IOS_VERSION >= 7.0
#define WIN_SIZE [UIScreen mainScreen].bounds.size

#define mSystemVersion   ([[UIDevice currentDevice] systemVersion])
#define mCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define XcodeAppVersion  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define mAPPVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

//--------调试相关-------

//ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
#define mSafeRelease(object)     [object release];  x=nil
#endif

//调试模式下输入NSLog，发布后不再输入。
#ifndef __OPTIMIZE__
#define NSLog(...)  { printf("%s Line:%d Time:",__func__, __LINE__) ;NSLog(__VA_ARGS__);}
#else
#define NSLog(...) {}
#endif

#if mTargetOSiPhone
//iPhone Device
#endif

#if mTargetOSiPhoneSimulator
//iPhone Simulator
#endif

//单例模式的宏 使用宏模版生成单例所需要的code SINGLETON_FOR_CLASS(AppPreference)

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}
