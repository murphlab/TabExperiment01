//
//  DashboardTabButton.m
//  TabExperiment01
//
//  Created by Ken Murphy on 6/8/16.
//  Copyright © 2016 Murphlab. All rights reserved.
//

#import "DashboardTabButton.h"

const static CGFloat barWidthFactor = 0.66;
const static CGFloat barHeightFactor = 0.08;

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
    }
    return _selectedBarLayer;
}

- (void)updateSelected
{
    if (self.selected) {
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES]; // Prevent animation
        
        CGFloat barWidth = barWidthFactor * self.bounds.size.width;
        CGFloat barHeight = barHeightFactor * self.bounds.size.height;
        
        self.selectedBarLayer.frame = CGRectMake(self.bounds.origin.x + (self.bounds.size.width - barWidth) / 2,
                                                 self.bounds.origin.y + self.bounds.size.height - barHeight,
                                                 barWidth,
                                                 barHeight);

        [self.layer addSublayer:self.selectedBarLayer];
        [CATransaction commit];
        
    } else {
        [self.selectedBarLayer removeFromSuperlayer];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateSelected];
}

@end
