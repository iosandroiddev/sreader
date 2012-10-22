//
//  AppDelegate.m
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//
#import "WelcomeViewController.h"
#import "AppDelegate.h"
#import "Macros.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    WelcomeViewController *welcomeController;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        welcomeController = [[WelcomeViewController alloc] initWithNibName:@"WelcomeViewController" bundle:[NSBundle mainBundle]];
        BUILD_IPHONE_OR_IPAD = TRUE;
    }
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        welcomeController = [[WelcomeViewController alloc] initWithNibName:@"WelcomeViewControllerIpad" bundle:[NSBundle mainBundle]];
        BUILD_IPHONE_OR_IPAD = FALSE;
    }        
    navigationController = [[UINavigationController alloc]initWithRootViewController:welcomeController];
   
    //=========
    // NSLog(@"window @c",_window);
    navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.window addSubview:navigationController.view];
    navigationController.view.frame = [self.window bounds];

    [self.window makeKeyAndVisible];
    
    [self initVariableGlobal];
    
    return YES;
}
- (void)initVariableGlobal{
    TAX_RATE_VALUE      = @"0 %";
    TAX_STATUS_VALUE    = TRUE;
    SALE_SUM_VALUE      = @"0";    
    IMG_SIGNATURE       = nil;
    IMG_IDENTIFY        = nil;
    
    GET_TIME_PAYMENT    = @""; // time when complete bill, end interface done
    GET_DATE_PAYMENT    = @""; // date when complete bill, end interface done
    
    EMAIL_LOGIN_VALUE   = @"";
    PASS_LOGIN_VALUE    = @"";

        //INFORMATION ACCOUNT
    INFO.FIRST_NAME_STR      = @"";
    INFO.LAST_NAME_STR       = @"";
    INFO.COMPANY_NAME_STR    = @"";
    INFO.ADDRESS_STR         = @"";
    INFO.OLDPASS_STR         = @"";
    INFO.PASSWORD_STR        = @"";
    INFO.CONFIRMPASS_STR     = @"";
    INFO.USER_IMAGE          = nil;
    INFO.NOTIFY_ERROR_STR    = @"";

}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
