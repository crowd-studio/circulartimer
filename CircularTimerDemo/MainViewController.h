//
//  MainViewController.h
//  CircularTimerDemo
//
//  Created by Bernat Bombi Fernandez on 20/01/13.
//  Copyright (c) 2013 Crowd Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (nonatomic, weak) IBOutlet UISegmentedControl *circleStrokeColorSegmentedControl;
@property (nonatomic, weak) IBOutlet UISegmentedControl *activeCircleStrokeColorSegmentedControl;
@property (nonatomic, weak) IBOutlet UISlider *radiusSlider;
@property (nonatomic, weak) IBOutlet UISlider *internalRadiusSlider;
@property (nonatomic, weak) IBOutlet UIButton *initialDateButton;
@property (nonatomic, weak) IBOutlet UIButton *finalDateButton;
@property (nonatomic, weak) IBOutlet UILabel *radiusLabel;
@property (nonatomic, weak) IBOutlet UILabel *interalRadiusLabel;

- (IBAction)showPicker:(id)sender;
- (IBAction)slideRadius:(id)sender;

@end