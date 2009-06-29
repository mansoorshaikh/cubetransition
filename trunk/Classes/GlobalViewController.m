//
//  GlobalViewController.m
//  cubetransition
//
//  Created by Anto on 6/29/09.
//  Copyright 2009 JPAStudio,Inc. All rights reserved.
//

#import "GlobalViewController.h"
#import "Constants.h"


@implementation GlobalViewController
@synthesize myContentPanel;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (void)loadView {
    UIView *startView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [startView setBackgroundColor:[UIColor whiteColor]];
    self.view = startView;
    [startView release];
}

- (void)viewDidLoad {
    //init content panel
    TransitionView *contentPanel = [[TransitionView alloc] initWithFrame: CGRectMake(0, 0, PAGE_VERTICAL_WIDTH, PAGE_VERTICAL_HEIGHT)];
    contentPanel.delegate = self;
    self.myContentPanel = contentPanel;
    [contentPanel release];
    [myContentPanel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:myContentPanel];
    
    //init view one
    viewOne = [[UIView alloc]initWithFrame:CGRectZero]; 
    viewOne.frame = CGRectMake(0, 0, PAGE_VERTICAL_WIDTH, PAGE_VERTICAL_HEIGHT);
    viewOne.backgroundColor = [UIColor orangeColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"View One";
    CGSize size = [titleLabel.text sizeWithFont:titleLabel.font forWidth:PAGE_HORIZONTAL_WIDTH lineBreakMode:UILineBreakModeTailTruncation];
    titleLabel.frame = CGRectMake((int)((PAGE_VERTICAL_WIDTH - size.width) / 2), (int)((PAGE_VERTICAL_HEIGHT - size.height) / 2), size.width, size.height);
    [viewOne addSubview:titleLabel];
    [titleLabel release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(15.0f, 15.0f, 60.0f, 30.0f);
    [button setTitle:@"NEXT" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onclickNext:) forControlEvents:UIControlEventTouchUpInside];
    [viewOne addSubview:button];
    
    //init view two
    viewTwo = [[UIView alloc]initWithFrame:CGRectZero]; 
    viewTwo.frame = CGRectMake(0, 0, PAGE_VERTICAL_WIDTH, PAGE_VERTICAL_HEIGHT);
    viewTwo.backgroundColor = [UIColor yellowColor];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"View Two";
    size = [titleLabel.text sizeWithFont:titleLabel.font forWidth:PAGE_HORIZONTAL_WIDTH lineBreakMode:UILineBreakModeTailTruncation];
    titleLabel.frame = CGRectMake((int)((PAGE_VERTICAL_WIDTH - size.width) / 2), (int)((PAGE_VERTICAL_HEIGHT - size.height) / 2), size.width, size.height);
    [viewTwo addSubview:titleLabel];
    [titleLabel release];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(15.0f, 15.0f, 60.0f, 30.0f);
    [button setTitle:@"BACK" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onclickBack:) forControlEvents:UIControlEventTouchUpInside];
    [viewTwo addSubview:button];
    
    //add viewOne as the first view
    [myContentPanel addSubview:viewOne];
    [super viewDidLoad];
}

-(IBAction) onclickNext:(id)sender {
    [myContentPanel replaceSubviewInCube:viewTwo direction:RTOL duration:1.0f];
}

-(IBAction) onclickBack:(id)sender {
    [myContentPanel replaceSubviewInCube:viewOne direction:LTOR duration:1.0f];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return NO;
}


- (void)TransitionViewDidStart:(TransitionView *)view
{
    //impelement for status update
}

- (void)TransitionViewDidFinish:(TransitionView *)view
{
    //impelement for status update
}

- (void)TransitionViewDidCancel:(TransitionView *)view
{
    //impelement for status update
}

- (void)dealloc {
    [viewOne release];
    [viewTwo release];
    [myContentPanel release];
    [super dealloc];
}
@end
