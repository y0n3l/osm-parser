//
//  GeoTools.m
//  VariousTests
//
//  Created by Lionel Gueganton on 4/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GeoTools.h"


@implementation GeoTools

+(double) orientationForCoord:(CLLocationCoordinate2D)firstCoord andCoord:(CLLocationCoordinate2D)secondCoord {
	//NSLog(@"angle betweeb %f,%f AND %f,%f", firstCoord.latitude, firstCoord.longitude, secondCoord.latitude, secondCoord.longitude);
	double deltaLongitude = secondCoord.longitude - firstCoord.longitude;
	double deltaLatitude = secondCoord.latitude - firstCoord.latitude;
	double tan = fabs(deltaLongitude) / fabs(deltaLatitude);
	double angle = atan(tan);
	//double foundAngleAsDegrees = [GeoTools toDegrees:angle];
	//the return angle for atan is ]-PI/2 +PI/2[
	
	if (deltaLatitude<0) {
		if (deltaLongitude<0) {
			//BOTTOM LEFT 
			//the angle is between -PI< x < -PI/2
			angle = -PI + angle;
		} else {
			//BOTTOM RIGHT
			//the angle is between PI/2< x < PI
			angle = PI - angle;
		}
	} else {
		if (deltaLongitude<0) {
			//TOP LEFT
			angle = - angle;
		} else {
			//the angle is already correct
		}
	}
	
	//get back the angle between [0 2PI[
	angle = angle+2*PI;
	while (angle>=2*PI)
		angle = angle - 2*PI;
	
	return  angle;
}

+(NSString*)stringFromCourse:(double)course {
	if ((course>=0 && course<=22.5) || (course>337.5 && course<=360))
		return @"N";
	else if (course>22.5 && course<=67.5) 
		return @"NE";
	else if (course>67.5 && course<=112.5) 
		return @"E";
	else if (course>112.5 && course<=157.5) 
		return @"SE";
	else if (course>157.5 && course<=202.5) 
		return @"S";
	else if (course>202.5 && course<=247.5) 
		return @"SO";
	else if (course>247.5 && course<=292.5) 
		return @"O";
	else if (course>292.5 && course<=337.5) 
		return @"NO";
	else 
		return @"-";
}

+(double) toDegrees:(double)radians {
	return radians*180/PI;
}

+(double) toRadians:(double)degrees {
	return degrees*PI/180;
}

double toRad(double angleInDegrees) {
	return angleInDegrees*PI/180;
}

double toDeg(double angleInRadians) {
	return angleInRadians*180/PI;
}

double oppositeAngle (double angle) {
	return ((NSInteger)(angle+180)) % 360;
	
}

double distance(double lat1, double lon1, double lat2, double lon2) {
	double R = 6365000; // meters
	double dLat = toRad( (lat2-lat1) );
	double dLon = toRad( (lon2-lon1) ); 
	double a = sin(dLat/2) * sin(dLat/2) + 
	cos(toRad( lat1 )) * cos(toRad(lat2)) * sin(dLon/2) * sin(dLon/2); 
	double c = 2 * atan2(sqrt(a), sqrt(1-a)); 
	double d = R * c;
	return d;
}

@end
