//
//  cubetransitionAppDelegate.m
//  cubetransition
//
//  Created by Anto on 6/29/09.
//  Copyright JPAStudio,Inc 2009. All rights reserved.
//

#import "cubetransitionAppDelegate.h"
#import "GlobalViewController.h"

@implementation cubetransitionAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    viewController = [[GlobalViewController alloc]init];
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
