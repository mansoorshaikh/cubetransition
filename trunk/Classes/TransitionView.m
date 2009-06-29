//
//  TransitionView.m
//  GameEffects
//
//  Created by Anto on 5/11/09.
//  Copyright 2009 JPAStudio,Inc. All rights reserved.
//

#import "TransitionView.h"
#import "Constants.h"

#define radians(degrees) degrees * M_PI / 180
#define CUBE_VERTICAL_WIDTH PAGE_VERTICAL_WIDTH
#define CUBE_VERTICAL_HEIGHT PAGE_VERTICAL_HEIGHT
#define CUBESIZE 320.0f
#define MASKALPHA 0.4f

#define kAnimationKey @"TransitionViewAnimation"


@implementation TransitionView
@synthesize mySubView, delegate, transitioning;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        mySubView = nil;
        transitioning = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)addSubview:(UIView *)view
{
    if (view != nil)
    {
        self.mySubView = view;
        [super addSubview:view];
    }
}

//Transition preparation for Cube effect
- (id) captureView:(UIView*)view {
    UIGraphicsBeginImageContext(view.frame.size);
	[view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    return (id) [newImage CGImage];
}

- (id) captureView:(UIView *)view isMasked:(BOOL)aIsMasked
{
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    if (aIsMasked)
    {
        CGContextSetRGBFillColor (UIGraphicsGetCurrentContext(), 0, 0, 0, MASKALPHA);
        CGContextFillRect (UIGraphicsGetCurrentContext(), view.frame);
    }
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    return (id) [newImage CGImage];
}

- (CALayer*) makeSurface:(CATransform3D)t withView:(UIView *)aNewView isMasked:(BOOL)aIsMasked {
    CGRect rect = CGRectMake(0, 0, CUBE_VERTICAL_WIDTH, CUBE_VERTICAL_HEIGHT);
    
    CALayer *imageLayer = [CALayer layer];
    imageLayer.anchorPoint = CGPointMake(1, 1);
    imageLayer.frame = rect;
    imageLayer.transform = t;  
    imageLayer.contents = [self captureView:aNewView isMasked:aIsMasked];
    return imageLayer;
}

- (void)constuctRotateLayer:(UIView *)aNewView direction:(TranDirection)aDirection isMasked:(BOOL)aIsMasked
{
    //init transformed Layer
    transformed = [CALayer layer];
    transformed.frame = self.bounds;
    transformed.anchorPoint = CGPointMake(0.5f, 0.5f);
    CATransform3D sublayerTransform = CATransform3DIdentity; 
    /* Set perspective */ 
    sublayerTransform.m34 = 1.0 / -1000;
    [transformed setSublayerTransform:sublayerTransform];
    
    [self.layer addSublayer:transformed];
    //init Sublayers
    CATransform3D t = CATransform3DMakeTranslation(0, 0, 0);
    [transformed addSublayer:[self makeSurface:t withView:mySubView isMasked:aIsMasked]];
    [mySubView setHidden:YES];
    if (aDirection == RTOL)
    {
        t = CATransform3DRotate(t, radians(90), 0, 1, 0);
        t = CATransform3DTranslate(t, CUBESIZE, 0, 0);
        [transformed addSublayer:[self makeSurface:t withView:aNewView isMasked:aIsMasked]];
    } else {
        t = CATransform3DRotate(t, radians(90), 0, 1, 0);
        t = CATransform3DTranslate(t, CUBESIZE, 0, 0);
        t = CATransform3DRotate(t, radians(90), 0, 1, 0);
        t = CATransform3DTranslate(t, CUBESIZE, 0, 0);
        t = CATransform3DRotate(t, radians(90), 0, 1, 0);
        t = CATransform3DTranslate(t, CUBESIZE, 0, 0);
        [transformed addSublayer:[self makeSurface:t withView:aNewView isMasked:aIsMasked]];
        
    }
}

- (void)destroyRotateLayer
{
    [transformed removeFromSuperlayer];
}

-(void)moveFrom:(TranDirection)aDirection duration:(float)aDuration
{
    [CATransaction flush];
    CABasicAnimation *rotation;
    CABasicAnimation *translationX;
    CABasicAnimation *translationZ;
    CAAnimationGroup *group = [CAAnimationGroup animation]; 
    group.delegate = self; 
    group.duration = aDuration; 

    if (aDirection == RTOL)
    {
        translationX = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.translation.x"];
        translationX.toValue = [NSNumber numberWithFloat:-(CUBE_VERTICAL_WIDTH / 2)];
        rotation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.rotation.y"]; 
        rotation.toValue = [NSNumber numberWithFloat:radians(-90)];
    } else {
        translationX = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.translation.x"];
        translationX.toValue = [NSNumber numberWithFloat:(CUBE_VERTICAL_WIDTH / 2)];
        rotation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.rotation.y"]; 
        rotation.toValue = [NSNumber numberWithFloat:radians(90)] ;
    }

    translationZ = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.translation.z"];
    translationZ.toValue = [NSNumber numberWithFloat:-(CUBE_VERTICAL_WIDTH / 2)];
    group.animations = [NSArray arrayWithObjects: rotation, translationX, translationZ, nil];
    group.fillMode = kCAFillModeForwards; 
    group.removedOnCompletion = NO;
    [transformed addAnimation:group forKey:kAnimationKey];
}

-(void)replaceSubviewInCube:(UIView *)aNewView direction:(TranDirection)aDirection duration:(float)aDuration {
    [self replaceSubviewInCube:aNewView direction:aDirection duration:aDuration isMasked:YES];
}

-(void)replaceSubviewInCube:(UIView *)aNewView direction:(TranDirection)aDirection duration:(float)aDuration isMasked:(BOOL)aIsMasked {
    // If a transition is in progress, do nothing
	if(transitioning || aNewView == nil)
        return;
    //If there's a new view and it doesn't already have a superview, insert it where the old view was
	if (mySubView == nil)
    {
        [self addSubview:aNewView];
        return;
    }
    
    if ([aNewView superview] != nil)
        [aNewView removeFromSuperview];
    myNewView = aNewView;
    [self constuctRotateLayer:aNewView direction:aDirection isMasked:aIsMasked];
    [self moveFrom:aDirection duration:aDuration];
}

// Not used in this example, but may be useful in your own project
- (void)cancelTransition {
	// Remove the animation -- cleanup performed in animationDidStop:finished:
	[[self layer] removeAnimationForKey:kAnimationKey];
}

- (void)animationDidStart:(CAAnimation *)animation {
	
	transitioning = YES;
    [mySubView removeFromSuperview];
    [mySubView setHidden:NO];
    // Record the current value of userInteractionEnabled so it can be reset in animationDidStop:finished:
    wasEnabled = self.userInteractionEnabled;
	
	// If user interaction is not already disabled, disable it for the duration of the animation
	if (wasEnabled) {
		self.userInteractionEnabled = NO;
    }
    
	// Inform the delegate if the delegate implements the corresponding method
	if(delegate != nil && [delegate respondsToSelector:@selector(TransitionViewDidStart:)]) {
		[delegate TransitionViewDidStart:self];
    }
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)finished {
	
	transitioning = NO;
    [self addSubview:myNewView];
    [self destroyRotateLayer];
    myNewView = nil;
    
	// Reset the original value of userInteractionEnabled
	if (wasEnabled) {
		self.userInteractionEnabled = YES;
    }
    
	// Inform the delegate if it implements the corresponding method
	if (finished) {
		if (delegate != nil && [delegate respondsToSelector:@selector(TransitionViewDidFinish:)]) {
			[delegate TransitionViewDidFinish:self];
        }
	}
	else {
		if (delegate != nil && [delegate respondsToSelector:@selector(TransitionViewDidCancel:)]) {
			[delegate TransitionViewDidCancel:self];
        }
	}
}

- (void)dealloc {
    [mySubView release];
    [super dealloc];
}
@end
