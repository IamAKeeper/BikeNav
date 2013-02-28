//
//  RouteView.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/26/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "RouteView.h"
#import "Route.h"

@implementation RouteView

@synthesize routePoints;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithOverlayAndPoints:(id<MKOverlay>)overlay points:(NSMutableArray *)points
{
    self = [super init];
    if (self){
        routePoints = points;
        NSLog(@"RouteView overlayview initialized");
    }
    
    return self;
}

- (void) drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context
{
    NSLog(@"drawing map rect");
    
    if([routePoints count] < 2) return;
    
    CGMutablePathRef path = NULL;
    
    CGFloat routeWidth = MKRoadWidthAtZoomScale(zoomScale);
    
    path = CGPathCreateMutable();
    
    for(int i=0; i < ([self.routePoints count] - 1); i++)
    {
       
        NSLog(@"adding new line segment");
        CLLocationCoordinate2D lastPoint = ((Route *) [routePoints objectAtIndex:i]).point;
        CLLocationCoordinate2D newPoint = ((Route *) [routePoints objectAtIndex:i+1]).point;
        
        CGPoint lastCGPoint = [self pointForMapPoint: MKMapPointForCoordinate(lastPoint)];
        CGPathMoveToPoint(path, NULL, lastCGPoint.x, lastCGPoint.y);
        
        CGPoint newCGPoint = [self pointForMapPoint: MKMapPointForCoordinate(newPoint)];
        CGPathAddLineToPoint(path, NULL, newCGPoint.x, newCGPoint.y);
        NSLog(@"line segment added");
        
    }
    
    CGContextAddPath(context, path);
    CGContextSetRGBStrokeColor(context, 0.0f, 0.0f, 1.0f, 0.5f);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, routeWidth);
    CGContextStrokePath(context);
    CGPathRelease(path);
    
    NSLog(@"Line segment drawn");

}

@end
