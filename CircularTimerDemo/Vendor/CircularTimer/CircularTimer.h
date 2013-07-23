//
//  CircularTimer.h
//
//  Copyright (c) 2013 Crowd Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CircularTimerBlock)(void);

@interface CircularTimer : UIView

- (id)initWithPosition:(CGPoint)position
                radius:(float)radius
        internalRadius:(float)internalRadius
     circleStrokeColor:(UIColor *)circleStrokeColor
activeCircleStrokeColor:(UIColor *)activeCircleStrokeColor
           initialDate:(NSDate *)initialDate
             finalDate:(NSDate *)finalDate
         startCallback:(void (^)(void))startBlock
           endCallback:(void (^)(void))endBlock;

- (BOOL)isRunning;
- (BOOL)willRun;
- (void)setup;
- (void)stop;
- (NSTimeInterval)intervalLength;
- (NSTimeInterval)runningElapsedTime;


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
