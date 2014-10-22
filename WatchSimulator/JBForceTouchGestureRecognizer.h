//
//  JBForceTouchGestureRecognizer.h
//  touchRadius
//
//  Created by Joel Bernstein on 10/21/14.
//  Copyright (c) 2014 Joel Bernstein. All rights reserved.
//



#import <UIKit/UIKit.h>



@interface JBForceTouchGestureRecognizer : UIGestureRecognizer

@property (nonatomic, assign) IBInspectable CGFloat minimumTouchRadius;
@property (nonatomic, assign) IBInspectable CGFloat maximumDragDistance;
@property (nonatomic, assign) IBInspectable double timeout;

@end
