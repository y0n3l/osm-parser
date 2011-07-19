//
//  OSMParserHandlerAllRoads.m
//  OSMImporter
//
//  Created by y0n3l http://www.twitter.com/y0n3l on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OSMParserHandlerAllRoads.h"

@implementation OSMParserHandlerAllRoads

-(id) initWithOutputFilePath:(NSString*)output {
	if (self!=[super initWithOutputFilePath:output])
		return nil;
	bufferMaxSize=30000;
	return self;
}


-(void) onWayFound:(Way *)way {
	NSString* highwayValue = [way.tags objectForKey:@"highway"]; 
	if (highwayValue!=nil && ![highwayValue isEqualToString:@"service"])
		[super onWayFound:way];
}

@end
