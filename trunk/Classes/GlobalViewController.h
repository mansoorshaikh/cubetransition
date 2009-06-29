//
//  GlobalViewController.h
//  cubetransition
//
//  Created by Anto on 6/29/09.
//  Copyright 2009 JPAStudio,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionView.h"


@interface GlobalViewController : UIViewController <TransitionViewDelegate>{
    TransitionView *myContentPanel;
    UIView *viewOne;
    UIView *viewTwo;
}
@property (nonatomic, retain) TransitionView *myContentPanel;
@end
