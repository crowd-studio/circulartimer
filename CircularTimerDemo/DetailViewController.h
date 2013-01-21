//
//  DetailViewController.h
//  CircularTimerDemo
//
//  Created by Bernat Bombi Fernandez on 21/01/13.
//  Copyright (c) 2013 Crowd Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property float radius;
@property float internalRadius;
@property (nonatomic, strong) UIColor *circleStrokeColor;
@property (nonatomic, strong) UIColor *activeCircleStrokeColor;
@property (nonatomic, strong) NSDate *initialDate;
@property (nonatomic, strong) NSDate *finalDate;

@property (nonatomic, weak) IBOutlet UILabel *statusLabel;

@end
