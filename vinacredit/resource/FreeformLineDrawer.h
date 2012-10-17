//
//  FreeformLineDrawer.h
//  MotionTrackingDemo
//
//  Created by Ying Quan Tan on 2/17/12.
//  Copyright (c) 2012 11 Under llc. All rights reserved.
//

#import <Foundation/Foundation.h>

//helper C functions
CGPoint midPoint(CGPoint p1, CGPoint p2);

@interface FreeformLineDrawer : NSObject {
  CGPoint previousPoint2; //2 points behind
  CGPoint previousPoint1; //1 point behind 
  CGPoint currentPoint;
  
  CFMutableArrayRef pathsSet; //an array to keep track of all the paths we have drawn
  CGMutablePathRef pathRef;
}

- (id)initWithStartPoint:(CGPoint)startPoint;
- (void)startNewPoint:(CGPoint)newPoint;
- (void)updatePoint:(CGPoint)newPoint;


@end
