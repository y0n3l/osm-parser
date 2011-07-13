//
//  GeoTools.h
//  VariousTests
//
//  Created by Lionel Gueganton on 4/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define PI 3.1415926535


@interface GeoTools : NSObject {

}

+(NSString*)stringFromCourse:(double)course;

+(double) orientationForCoord:(CLLocationCoordinate2D)firstCoord andCoord:(CLLocationCoordinate2D)secondCoord;

+(double) toDegrees:(double)radians;

+(double) toRadians:(double)degrees;

@end

#pragma mark -
#pragma mark C functions
double toRad(double angleInDegrees);

double distance(double lat1, double lon1, double lat2, double lon2);

double oppositeAngle(double angle);
