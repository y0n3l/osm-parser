//
//  OSMParserHandlerMotorway.m
//  OSMImporter
//
//  Created by Lionel Gueganton on 1/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OSMParserHandlerMotorway.h"


@implementation OSMParserHandlerMotorway

-(void) onWayFound:(Way *)way {
	if ([[way.tags objectForKey:@"highway"] isEqualToString:@"motorway"])
		[super onWayFound:way];
}

@end
