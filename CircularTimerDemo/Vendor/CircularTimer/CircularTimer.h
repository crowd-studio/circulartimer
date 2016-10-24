//
//  CircularTimer.h
//
//  Copyright (c) 2013 Crowd Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CircularTimerBlock)(void);

@interface CircularTimer : UIView

- (id)initWithPosition:(CGPoint)position
           outerRadius:(float)outerRadius
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


@property (nonatomic, strong) UIColor * inactiveCircleStrokeColor;
@property (nonatomic, strong) UIColor *activeCircleStrokeColor;
@property (nonatomic, strong) NSDate *initialDate;
@property (nonatomic, strong) NSDate *finalDate;
@property (nonatomic, copy) CircularTimerBlock startBlock;
@property (nonatomic, copy) CircularTimerBlock endBlock;
@property (nonatomic, strong) NSTimer *timer;
@property float percentageCompleted;
@property BOOL running;

@property (nonatomic) float radius;

@property (nonatomic) float activeCircleStrokeWidth;
@property (nonatomic) float inactiveCircleStrokeWidth;


@end
