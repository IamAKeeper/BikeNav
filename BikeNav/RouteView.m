//
//  RouteView.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/26/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "RouteView.h"
#import "Route.h"
#import <MapKit/MapKit.h>


@implementation RouteView



- (void) drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context
{
    
    Route *aRoute = (Route *)(self.overlay);
    
    CGFloat lineWidth = MKRoadWidthAtZoomScale(zoomScale);
    
    MKMapRect clipRect = MKMapRectInset(mapRect, -lineWidth, -lineWidth);
    
    CGPathRef path = [self newPathForPoints:aRoute.points
                                 pointCount: aRoute.pointCount
                                   clipRect: clipRect
                                  zoomScale: zoomScale];
    
    if (path != nil)
    {
        
        CGContextAddPath(context, path);
        CGContextSetRGBStrokeColor(context, 0.0f, 0.0f, 1.0f, 0.5f);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextSetLineCap(context, kCGLineJoinRound);
        CGContextSetLineWidth(context, lineWidth);
        CGContextStrokePath(context);
        CGPathRelease(path);
    }

}

static BOOL lineIntersectsRect(MKMapPoint p0, MKMapPoint p1, MKMapRect r)
{
    
    double minX = MIN(p0.x, p1.x);
    double minY = MIN(p0.y, p1.y);
    double maxX = MAX(p0.x, p1.x);
    double maxY = MAX(p0.y, p1.y);
    
    MKMapRect r2 = MKMapRectMake(minX, minY, maxX - minX, maxY - minY);
    
    
    
    return MKMapRectIntersectsRect(r, r2);
    
    
}


#define MIN_POINT_DELTA 5.0
#define POW2(a) ((a) * (a))

- (CGPathRef) newPathForPoints:(MKMapPoint *)points pointCount:(NSUInteger)pointCount clipRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale
{
    if(pointCount < 2)
        return NULL;
    
    CGMutablePathRef path = NULL;
    
    BOOL needsMove = YES;
    
    double minPointDelta = MIN_POINT_DELTA / zoomScale;
    double c2 = POW2(minPointDelta);
    
    MKMapPoint point, lastPoint = points[0];
    NSUInteger i;
    
    for (i = 1; i < pointCount - 1; i++)
    {
        point = points[i];
        double a2b2 = (POW2(point.x - lastPoint.x) + POW2(point.y - lastPoint.y));
        
        if(a2b2 >= c2)
        {
            if (lineIntersectsRect(point, lastPoint, mapRect))
            {
                if(!path)
                    path = CGPathCreateMutable();
                if(needsMove)
                {
                    CGPoint lastCGPoint = [self pointForMapPoint:lastPoint];
                    CGPathMoveToPoint(path, NULL, lastCGPoint.x, lastCGPoint.y);
                }
                
                CGPoint cgPoint = [self pointForMapPoint:point];
                CGPathAddLineToPoint(path, NULL, cgPoint.x, cgPoint.y);
            }
            else
            {
                needsMove = YES;
            }
            
            lastPoint = point;
        }
    }
    
#undef POW2
    
    //Adding the last line segment seperate in case it intersects mapRect

    point = points[pointCount -1];
    if(lineIntersectsRect(lastPoint, point, mapRect))
    {
        if(!path)
            path = CGPathCreateMutable();
        if(needsMove)
        {
            CGPoint lastCGPoint = [self pointForMapPoint:lastPoint];
            CGPathMoveToPoint(path, NULL, lastCGPoint.x, lastCGPoint.y);
        }
        
        CGPoint cgPoint = [self pointForMapPoint:point];
        CGPathAddLineToPoint(path, NULL, cgPoint.x, cgPoint.y);
    }
    
    return path;

}

@end



