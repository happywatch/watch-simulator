//
//  JBForceTouchGestureRecognizer.m
//  touchRadius
//
//  Created by Joel Bernstein on 10/21/14.
//  Copyright (c) 2014 Joel Bernstein. All rights reserved.
//



#import "JBForceTouchGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>



@interface JBForceTouchGestureRecognizer ()

@property (nonatomic, strong) NSMutableDictionary* initialTouchLocations;
@property (nonatomic, strong) NSMutableDictionary* initialTouchTimes;

@end



@implementation JBForceTouchGestureRecognizer

-(instancetype)init
{
    self = [super init];
    
    if(self)
    {
        _minimumTouchRadius = 30;
        _maximumDragDistance = 10;
        _timeout = 0.25;
    }
    
    return self;
}

-(void)testTouch:(UITouch*)touch
{
//    NSLog(@"%f, %f", touch.majorRadius - touch.majorRadiusTolerance, self.minimumTouchRadius);

    if(touch.majorRadius - touch.majorRadiusTolerance > self.minimumTouchRadius)
    {
        self.state = UIGestureRecognizerStateRecognized;
    }
}

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    for(UITouch* touch in touches) 
    {
        NSValue* touchKey = [NSValue valueWithPointer:(__bridge const void*)(touch)];
        
        self.initialTouchLocations[touchKey] = [NSValue valueWithCGPoint:[touch locationInView:self.view]];
        self.initialTouchTimes[touchKey] = @( [[NSDate date] timeIntervalSince1970] );

        [self testTouch:touch];
    }
}

- (void)rejectTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self ignoreTouch:touch forEvent:event];
    
    NSValue* touchKey = [NSValue valueWithPointer:(__bridge const void*)(touch)];

    [self.initialTouchLocations removeObjectForKey:touchKey];
    [self.initialTouchTimes removeObjectForKey:touchKey];
    
    if(self.initialTouchLocations.count == 0)
    {
        self.state = UIGestureRecognizerStateFailed;
    }
}

- (void)processTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSValue* touchKey = [NSValue valueWithPointer:(__bridge const void*)(touch)];
    
    CGPoint initialLocation = [self.initialTouchLocations[touchKey] CGPointValue];
    NSTimeInterval initialTime = [self.initialTouchTimes[touchKey] doubleValue];
    
    CGPoint currentLocation = [touch locationInView:self.view];
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    
    CGSize delta = CGSizeMake(currentLocation.x - initialLocation.x, currentLocation.y - initialLocation.y);
    
    if(currentTime - initialTime > self.timeout)
    {
        [self rejectTouch:touch withEvent:event];
    }
    else if(delta.width * delta.width + delta.height * delta.height > self.maximumDragDistance * self.maximumDragDistance)
    {
        [self rejectTouch:touch withEvent:event];
    }
    else
    {
        [self testTouch:touch];
    }
}

-(void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    for(UITouch* touch in touches) 
    {
        [self processTouch:touch withEvent:event];
    }
}

-(void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    for(UITouch* touch in touches) 
    {
        [self processTouch:touch withEvent:event];
        [self rejectTouch:touch withEvent:event];
    }
}

-(void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event
{
    for(UITouch* touch in touches) 
    {
        [self processTouch:touch withEvent:event];
        [self rejectTouch:touch withEvent:event];
    }
}

@end
