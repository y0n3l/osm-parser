//
//  Node.m
//  OSMImporter
//
//  Created by Lionel Gueganton on 1/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Node.h"


@implementation Node

@synthesize nodeId, latitude, longitude, tags;

-(NSString*) description {
	return [NSString stringWithFormat:@"Node(%i)%f,%f", nodeId, latitude, longitude];
}

-(void) dealloc {
	[tags release];
	[super dealloc];
}

@end
