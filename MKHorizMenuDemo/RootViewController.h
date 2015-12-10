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

@property (nonatomic, weak) IBOutlet MKHorizMenu *horizMenu;
@property (nonatomic, copy) NSArray *items;
@property (nonatomic, weak) IBOutlet UILabel *selectionItemLabel;

@end
