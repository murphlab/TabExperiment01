//
//  DashboardTabButton.m
//  TabExperiment01
//
//  Created by Ken Murphy on 6/8/16.
//  Copyright © 2016 Murphlab. All rights reserved.
//

#import "DashboardTabButton.h"

@interface DashboardTabButton ()
@property (nonatomic, strong) CALayer *selectedBarLayer;
@end

@implementation DashboardTabButton

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateSelected];
}

- (CALayer *)selectedBarLayer;
{
    if (!_selectedBarLayer) {
        _selectedBarLayer = [CALayer layer];
        _selectedBarLayer.backgroundColor = [UIColor whiteColor].CGColor;
        _selectedBarLayer.frame = CGRectMake(0, 0, self.bounds.size.width, 10 );
    }
    return _selectedBarLayer;
}

- (void)updateSelected
{
    if (self.selected) {
        [self.layer addSublayer:self.selectedBarLayer];
    } else {
        [self.selectedBarLayer removeFromSuperlayer];
    }
}

/*
- (void)layoutSubviews
{
    [self updateSelected];
}
 */

@end
