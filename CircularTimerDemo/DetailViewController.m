//
//  DetailViewController.m
//  CircularTimerDemo
//
//  Created by Bernat Bombi Fernandez on 21/01/13.
//  Copyright (c) 2013 Crowd Studio. All rights reserved.
//

#import "DetailViewController.h"
#import "CircularTimer.h"

@interface DetailViewController ()

@property (nonatomic, strong) CircularTimer *circularTimer;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self createCircle];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)createCircle
{
    self.circularTimer = [[CircularTimer alloc] initWithPosition:CGPointMake(10.0f, 10.0f)
                                                          radius:self.radius
                                                  internalRadius:self.internalRadius
                                               circleStrokeColor:self.circleStrokeColor
                                         activeCircleStrokeColor:self.activeCircleStrokeColor
                                                     initialDate:self.initialDate
                                                       finalDate:self.finalDate
                                                   startCallback:^{
                                                       self.statusLabel.text = @"Running!";
                                                   }
                                                     endCallback:^{
                                                         self.statusLabel.text = @"Not running anymore!";
                                                     }];
    
    self.statusLabel.text = ([self.circularTimer willRun]) ? @"Circle will run" : @"Circle won't run";
    
    [self.view addSubview:self.circularTimer];
}

- (IBAction)dismiss:(id)sender
{
    self.circularTimer = nil;
    [self.circularTimer removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
