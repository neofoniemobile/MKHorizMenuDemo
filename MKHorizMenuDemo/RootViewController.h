//
//  RootViewController.h
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKHorizMenu.h"

@interface RootViewController : UIViewController <MKHorizMenuDataSource, MKHorizMenuDelegate>

@property (nonatomic, retain) IBOutlet MKHorizMenu *horizMenu;
@property (nonatomic, retain) NSArray *items;
@property (nonatomic, assign) IBOutlet UILabel *selectionItemLabel;

@end
