//
//  TransitionView.h
//  GameEffects
//
//  Created by Anto on 5/11/09.
//  Copyright 2009 JPAStudio,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class TransitionView;

@protocol TransitionViewDelegate <NSObject>
@optional
- (void)TransitionViewDidStart:(TransitionView *)view;
- (void)TransitionViewDidFinish:(TransitionView *)view;
- (void)TransitionViewDidCancel:(TransitionView *)view;
@end

typedef enum {
    LTOR = 0,
    RTOL,
} TranDirection;

@interface TransitionView : UIView {
    id<TransitionViewDelegate> delegate;
@private
    CALayer *transformed;
    UIView *mySubView;
    UIView *myNewView;
    BOOL transitioning, wasEnabled;
}

@property(nonatomic, retain) UIView *mySubView;
@property (assign) id<TransitionViewDelegate> delegate;
@property (readonly, getter=isTransitioning) BOOL transitioning;

//Don't have mask effect by default
-(void)replaceSubviewInCube:(UIView *)aNewView direction:(TranDirection)aDirection duration:(float)aDuration;
-(void)replaceSubviewInCube:(UIView *)aNewView direction:(TranDirection)aDirection duration:(float)aDuration isMasked:(BOOL)aIsMasked;
@end
