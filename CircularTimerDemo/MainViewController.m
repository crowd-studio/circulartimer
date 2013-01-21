//
//  MainViewController.m
//  CircularTimerDemo
//
//  Created by Bernat Bombi Fernandez on 20/01/13.
//  Copyright (c) 2013 Crowd Studio. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"

@interface MainViewController () <UIPickerViewDelegate>

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDate *initialDate;
@property (nonatomic, strong) NSDate *finalDate;
@property (nonatomic, strong) UIView *hidePickerView;


@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.initialDate = [NSDate date];
    self.finalDate = [NSDate date];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height + 250, 325, 250)];
    self.datePicker.date = [NSDate date];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.datePicker.timeZone = [NSTimeZone localTimeZone];
    [self.datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];

    [self.view addSubview:self.datePicker];
}

- (IBAction)showPicker:(UIButton *)sender
{
    self.datePicker.tag = sender.tag;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.3 animations:^{
        self.datePicker.frame = CGRectMake(0, screenRect.size.height - 230, 320, 250);
    }];
    [self addCancelView];
}

- (void)addCancelView
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.hidePickerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0, 320, screenRect.size.height - 230)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePicker:)];
    [self.hidePickerView addGestureRecognizer:tap];
    self.hidePickerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.hidePickerView];
}

- (void)hidePicker:(UITapGestureRecognizer *)sender
{
    [self.hidePickerView removeFromSuperview];
    self.datePicker.tag = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.datePicker.frame = CGRectMake(0, self.view.frame.size.height + 250, 325, 250);
    }];
}

- (void)changeDate:(UIDatePicker *)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    if (sender.tag == 101) {
        self.initialDate = sender.date;
        [self.initialDateButton setTitle:[df stringFromDate:sender.date] forState:UIControlStateNormal];
    } else if (sender.tag == 202) {
        self.finalDate = sender.date;
        [self.finalDateButton setTitle:[df stringFromDate:sender.date] forState:UIControlStateNormal];
    }
}

- (IBAction)slideRadius:(UISlider *)sender
{
    NSString* formattedValue = [NSString stringWithFormat:@"%.f", sender.value];

    if (sender.tag == 303) {
        self.radiusLabel.text = [NSString stringWithFormat:@"Radius (%@)", formattedValue];
    } else if (sender.tag = 404) {
        self.interalRadiusLabel.text = [NSString stringWithFormat:@"Internal Radius (%@)", formattedValue];
    }
}

- (NSDate *)dateWithZeroSeconds:(NSDate *)date
{
    NSTimeInterval time = floor([date timeIntervalSinceReferenceDate] / 60.0) * 60.0;
    return  [NSDate dateWithTimeIntervalSinceReferenceDate:time];
}

- (UIColor *)getColorForSelectedSegmentedControl:(UISegmentedControl *)sg
{
    switch (sg.selectedSegmentIndex) {
        case 0:
            return [UIColor lightGrayColor];
            break;
        case 1:
            return [UIColor purpleColor];
            break;
        case 2:
            return [UIColor blackColor];
            break;
        case 3:
            return [UIColor redColor];
            break;
        default:
            break;
    }
    return [UIColor whiteColor];
}

#pragma mark
#pragma mark Segue
#pragma mark

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        DetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.radius = round(self.radiusSlider.value);
        detailViewController.internalRadius = round(self.internalRadiusSlider.value);
        detailViewController.initialDate = [self dateWithZeroSeconds:self.initialDate];
        detailViewController.finalDate = [self dateWithZeroSeconds:self.finalDate];
        detailViewController.activeCircleStrokeColor = [self getColorForSelectedSegmentedControl:self.activeCircleStrokeColorSegmentedControl];
        detailViewController.circleStrokeColor = [self getColorForSelectedSegmentedControl:self.circleStrokeColorSegmentedControl];        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
