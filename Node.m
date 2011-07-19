//
//  Node.m
//  OSMImporter
//
//  Created by y0n3l http://www.twitter.com/y0n3l on 1/15/11.
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
