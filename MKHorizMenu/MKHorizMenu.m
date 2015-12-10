//
//  MKHorizMenu.m
//  MKHorizMenuDemo
//  Created by Mugunth on 09/05/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above
//  Read my blog post at http://mk.sg/8h on how to use this code

//  As a side note on using this code, you might consider giving some credit to me by
//	1) linking my website from your app's website 
//	2) or crediting me inside the app's credits page 
//	3) or a tweet mentioning @mugunthkumar
//	4) A paypal donation to mugunth.kumar@gmail.com
//
//  A note on redistribution
//	While I'm ok with modifications to this source code, 
//	if you are re-publishing after editing, please retain the above copyright notices

#import "MKHorizMenu.h"
#define kButtonBaseTag 10000
#define kLeftOffset 10

@implementation MKHorizMenu

- (void) awakeFromNib {
    self.bounces = YES;
    self.scrollEnabled = YES;
    self.alwaysBounceHorizontal = YES;
    self.alwaysBounceVertical = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self reloadData];
}
     
- (void) reloadData {
    NSArray *viewsToRemove = [self subviews];
	for (UIView *v in viewsToRemove) {
		[v removeFromSuperview];
	}
    
    self.itemCount = [self.dataSource numberOfItemsForMenu:self];
    self.backgroundColor = [self.dataSource backgroundColorForMenu:self];
    self.selectedImage = [self.dataSource selectedItemImageForMenu:self];

    UIFont *buttonFont = [UIFont boldSystemFontOfSize:15];
    int buttonPadding = 25;
    
    int tag = kButtonBaseTag;    
    int xPos = kLeftOffset;

    for(int i = 0 ; i < self.itemCount; i++) {
        NSString *title = [self.dataSource horizMenu:self titleForItemAtIndex:i];
        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [customButton setTitle:title forState:UIControlStateNormal];
        customButton.titleLabel.font = buttonFont;
        if ([self.dataSource respondsToSelector:@selector(itemTextColorForMenu:)]){
           [customButton setTitleColor:[self.dataSource itemTextColorForMenu:self] forState:UIControlStateNormal];
        } else {
            [customButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if ([self.dataSource respondsToSelector:@selector(itemTextSelectedColorForMenu:)]){
            [customButton setTitleColor:[self.dataSource itemTextSelectedColorForMenu:self] forState:UIControlStateSelected];
        } else {
            [customButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        }
        
        if ([self.dataSource respondsToSelector:@selector(itemTextFontForMenu:)]) {
            [customButton.titleLabel setFont:[self.dataSource itemTextFontForMenu:self]];
        }
        
        [customButton setBackgroundImage:self.selectedImage forState:UIControlStateSelected];
        
        customButton.tag = tag++;
        [customButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        
        NSMutableParagraphStyle *pragraphStyleAttribute = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [pragraphStyleAttribute setLineBreakMode:NSLineBreakByClipping];
        
        CGRect buttonRect = [title boundingRectWithSize:CGSizeMake(150, 28)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:customButton.titleLabel.font,
                                                          NSParagraphStyleAttributeName: pragraphStyleAttribute
                                                          }
                                                context:nil];
        
        customButton.frame = CGRectMake(xPos, 7, buttonRect.size.width + buttonPadding, 28);
        xPos += buttonRect.size.width;
        xPos += buttonPadding;
        [self addSubview:customButton];
    }
    
    // bretdabaker: added right padding to contentSize
    xPos += kLeftOffset;
    
    self.contentSize = CGSizeMake(xPos, 41);    
    [self layoutSubviews];  
}


- (void) setSelectedIndex:(int) index animated:(BOOL) animated {
    UIButton *thisButton = (UIButton*) [self viewWithTag:index + kButtonBaseTag];    
    thisButton.selected = YES;
    [self setContentOffset:CGPointMake(thisButton.frame.origin.x - kLeftOffset, 0) animated:animated];
    [self.itemSelectedDelegate horizMenu:self itemSelectedAtIndex:index];
}


- (void)deselectItemAtIndex:(int)index {
    UIButton *thisButton = (UIButton*) [self viewWithTag:index + kButtonBaseTag];
    thisButton.selected = NO;
}

- (void) buttonTapped:(id) sender {
    UIButton *button = (UIButton*) sender;
    
    for(int i = 0; i < self.itemCount; i++) {
        UIButton *thisButton = (UIButton*) [self viewWithTag:i + kButtonBaseTag];
        if(i + kButtonBaseTag == button.tag)
            thisButton.selected = YES;
        else
            thisButton.selected = NO;
    }
    
    [self.itemSelectedDelegate horizMenu:self itemSelectedAtIndex:button.tag - kButtonBaseTag];
}


@end
