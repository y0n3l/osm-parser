//
//  OSMParserHandlerAllRoads.m
//  OSMImporter
//
//  Created by Lionel Gueganton on 2/11/11.
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
	if (highwayValue!=nil && ![highwayValue isEqualTo:@"service"])
		[super onWayFound:way];
}

@end
