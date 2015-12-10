//
//  RootViewController.m
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

- (void)viewDidLoad {
    self.items = [NSArray arrayWithObjects:@"Headlines", @"UK", @"International", @"Politics", @"Weather", @"Shou", @"Bob", @"Pascal", @"Sports", @"Pei", nil];
    [self.horizMenu reloadData];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    self.selectionItemLabel = nil;
}

-(void) viewDidAppear:(BOOL)animated {
    [self.horizMenu setSelectedIndex:5 animated:YES];
}

#pragma mark -
#pragma mark HorizMenu Data Source
- (UIImage*) selectedItemImageForMenu:(MKHorizMenu*) tabMenu {
    return [[UIImage imageNamed:@"ButtonSelected"] stretchableImageWithLeftCapWidth:16 topCapHeight:0];
}

- (UIColor *)itemTextColorForMenu:(MKHorizMenu *)tabView {
    return [UIColor whiteColor];
}

- (UIColor *)itemTextSelectedColorForMenu:(MKHorizMenu *)tabView {
    return [UIColor greenColor];
}

- (UIColor*) backgroundColorForMenu:(MKHorizMenu *)tabView {
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"MenuBar"]];
}

- (int) numberOfItemsForMenu:(MKHorizMenu *)tabView {
    return (int)[self.items count];
}

- (NSString*) horizMenu:(MKHorizMenu *)horizMenu titleForItemAtIndex:(NSUInteger)index {
    return [self.items objectAtIndex:index];
}

#pragma mark -
#pragma mark HorizMenu Delegate
-(void) horizMenu:(MKHorizMenu *)horizMenu itemSelectedAtIndex:(NSUInteger)index {        
    self.selectionItemLabel.text = [self.items objectAtIndex:index];
}
@end
