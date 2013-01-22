# CircularTimer

CircularTimer is a class that creates a custom circular timer, showing the percentage completed between two dates.

## Installation
===

Drop the files `CircularTimer.h` and `CircularTimer.m` into your Xcode project.

## Usage
===

In your ViewController import the header file `CircularTimer.h`, and create a CircularTimer property to keep a reference:

`@property (nonatomic, strong) CircularTimer *circularTimer;`

Then, to create the object use a code like this:

```
self.circularTimer = 
[[CircularTimer alloc] initWithPosition:CGPointMake(0.0f, 0.0f)
                                 radius:radius
                         internalRadius:internalRadius
                      circleStrokeColor:circleStrokeColor
                activeCircleStrokeColor:activeCircleStrokeColor
                            initialDate:initialDate
                              finalDate:finalDate
                          startCallback:^{
                              //do something
                          }
                            endCallback:^{
                                //do something
                            }];
```                              

and add it as subview

```
[self.view addSubview:self.circularTimer];
```

## Methods
===

Create a CircularTimer using:

```
- (id)initWithPosition:(CGPoint)position
                radius:(float)radius
        internalRadius:(float)internalRadius
     circleStrokeColor:(UIColor *)circleStrokeColor
activeCircleStrokeColor:(UIColor *)activeCircleStrokeColor
           initialDate:(NSDate *)initialDate
             finalDate:(NSDate *)finalDate
         startCallback:(void (^)(void))startBlock
           endCallback:(void (^)(void))endBlock;       
```

You can see the meaning of `radius`, `internalRadius`, `circleStrokeColor` and `activeCircleStrokeColor` in this image:

![image](https://github.com/crowd-studio/circulartimer/blob/master/Assets/circleinfo.png?raw=true)

```
- (BOOL)isRunning;
```
Indicates if the CircularTimer is currently running.

```
- (BOOL)willRun;
```
Indicates if the CircularTimer will run (in other words, if the current time is smaller than the CircularTimer `finalDate`).

```
- (void)stop;
```
Stops the CircularTimer.

```
- (NSTimeInterval)intervalLength;
```
Returns the interval between the `initialDate` and the `finalDate`.

```
- (NSTimeInterval)runningElapsedTime;
```
Returns the interval of time elapsed since the CircularTimer started running.

## Demo

You can find a demo project in this repository. Meanwhile, you can watch a teaser:

[https://vimeo.com/57868337](https://vimeo.com/57868337)

## About us
===

##### CROWD STUDIO

[@crowdstudio_](http://twitter.com/crowdstudio_)

[http://crowd-studio.com/](http://crowd-studio.com/)

[http://facebook.com/thisiscrowd](http://facebook.com/thisiscrowd)

## Licence
===
  
Copyright (C) 2013 CROWD STUDIO

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
