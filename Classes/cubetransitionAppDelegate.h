//
//  cubetransitionAppDelegate.h
//  cubetransition
//
//  Created by Anto on 6/29/09.
//  Copyright JPAStudio,Inc 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GlobalViewController;
@interface cubetransitionAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GlobalViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) GlobalViewController *viewController;

@end

