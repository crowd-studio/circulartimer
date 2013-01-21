//
//  CircularTimer.m
//
//  Copyright (c) 2013 Crowd Studio. All rights reserved.
//

#import "CircularTimer.h"

typedef void(^CircularTimerBlock)(void);

@interface CircularTimer ()

@property float radius;
@property float interalRadius;
@property (nonatomic, strong) UIColor *circleStrokeColor;
@property (nonatomic, strong) UIColor *activeCircleStrokeColor;
@property (nonatomic, strong) NSDate *initialDate;
@property (nonatomic, strong) NSDate *finalDate;
@property (nonatomic, copy) CircularTimerBlock startBlock;
@property (nonatomic, copy) CircularTimerBlock endBlock;
@property (nonatomic, strong) NSTimer *timer;
@property float percentageCompleted;
@property BOOL running;

@end

@implementation CircularTimer

#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)

- (id)initWithPosition:(CGPoint)position
                radius:(float)radius
        internalRadius:(float)internalRadius
     circleStrokeColor:(UIColor *)circleStrokeColor
activeCircleStrokeColor:(UIColor *)activeCircleStrokeColor
           initialDate:(NSDate *)initialDate
             finalDate:(NSDate *)finalDate
         startCallback:(void (^)(void))startBlock
           endCallback:(void (^)(void))endBlock
{
    
    self = [super initWithFrame:CGRectMake(position.x, position.y, radius * 2, radius * 2)];
    if (self) {
        self.radius = radius;
        self.interalRadius = internalRadius;
        self.circleStrokeColor = circleStrokeColor;
        self.activeCircleStrokeColor = activeCircleStrokeColor;
        self.initialDate = initialDate;
        self.finalDate = finalDate;
        self.startBlock = startBlock;
        self.endBlock = endBlock;
        [self setup];
    }
    return self;
}

- (void)setup
{    
    [self customizeAppearance];
    if ([self.finalDate compare:self.initialDate] == NSOrderedAscending) {
        NSLog(@"Final date is smaller than initial.");
    } else {    
        self.percentageCompleted = 0.0f;
        self.running = NO;
        if ([self worthToRun]) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                          target:self
                                                        selector:@selector(updateCircle:)
                                                        userInfo:nil
                                                         repeats:YES];
        }
    }
}

- (void)customizeAppearance
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect
{
    //General circle info
    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    float strokeWidth = self.radius - self.interalRadius;
    float radius = self.interalRadius + strokeWidth / 2;
    
    //Background circle
    UIBezierPath *circle1 = [UIBezierPath bezierPathWithArcCenter:center
                                                           radius:radius
                                                       startAngle:DEGREES_TO_RADIANS(0.0f)
                                                         endAngle:DEGREES_TO_RADIANS(360.0f)
                                                        clockwise:YES];
    [self.circleStrokeColor setStroke];
    circle1.lineWidth = strokeWidth;
    [circle1 stroke];
    
    //Active circle
    float startAngle = 0.0f;
    float degrees = 360.0f;
    
    if ([self worthToRun]) {
        [self updatePercentageCompleted];
        startAngle = 270.0f;
        float tempDegrees = self.percentageCompleted * 360.0 / 100.f;
        degrees = (tempDegrees < 90) ? 270 + tempDegrees : tempDegrees - 90;
    }
    
    UIBezierPath *circle2 = [UIBezierPath bezierPathWithArcCenter:center
                                                           radius:radius
                                                       startAngle:DEGREES_TO_RADIANS(startAngle)
                                                         endAngle:DEGREES_TO_RADIANS(degrees)
                                                        clockwise:YES];
    [self.activeCircleStrokeColor setStroke];
    circle2.lineWidth = strokeWidth;
    [circle2 stroke];
    
}

- (void)updateCircle:(NSTimer *)theTimer
{
    if (![self worthToRun]) {
        [self completeRun];
    } else {
        if ([self.initialDate compare:[self getCurrentDateGMT]] == NSOrderedAscending &&
              [self.finalDate compare:[self getCurrentDateGMT]] == NSOrderedDescending) {
            [self startRun];
        }
    }
}

- (void)startRun
{
    if (!self.running) {
        self.running = YES;
        if (self.startBlock != nil) {
            self.startBlock();
        }
    }
    [self setNeedsDisplay];
}

- (void)completeRun
{
    self.running = NO;
    [self.timer invalidate];
    self.percentageCompleted = 100.0f;
    [self setNeedsDisplay];
    if (self.endBlock != nil) {
        self.endBlock();
    }
}

- (void)updatePercentageCompleted
{
    if ([self.initialDate compare:[self getCurrentDateGMT]] == NSOrderedAscending &&
        [self.finalDate compare:[self getCurrentDateGMT]] == NSOrderedDescending) {
        float total = [self.finalDate timeIntervalSince1970] - [self.initialDate timeIntervalSince1970];
        float current = [[NSDate date] timeIntervalSince1970] - [self.initialDate timeIntervalSince1970];
        self.percentageCompleted = current / total * 100;
    } else {
        self.percentageCompleted = 0.0f;
    }
}

- (BOOL)worthToRun
{
    return ([self.finalDate timeIntervalSince1970] > [[self getCurrentDateGMT] timeIntervalSince1970]);
}

- (NSDate *)getCurrentDateGMT
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    return [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
}

#pragma mark
#pragma mark Public
#pragma mark

- (BOOL)isRunning
{
    return self.running;
}

- (BOOL)willRun
{
    return [self worthToRun];
}

- (void)stop
{
    [self.timer invalidate];
}

- (NSTimeInterval)intervalLength
{
    return [self.finalDate timeIntervalSinceDate:self.initialDate];
}

- (NSTimeInterval)runningElapsedTime
{
    NSTimeInterval interval = 0;
    if (self.running) {
        interval = [[self getCurrentDateGMT] timeIntervalSinceDate:self.initialDate];
    }
    return interval;
}

@end
