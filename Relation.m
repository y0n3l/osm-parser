//
//  Relation.m
//  OSMImporter
//
//  Created by y0n3l http://www.twitter.com/y0n3l on 1/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Relation.h"

@implementation Member

@synthesize type, ref, role;

@end


@implementation Relation

@synthesize relationId, members, tags;

-(id) init {
	if (self!=[super init]) {
		return nil;
	}
	members = [[NSMutableArray alloc] initWithCapacity:0];
	return self;
}

-(void) dealloc {
	[members release];
	[tags release];
	[super dealloc];
}

@end
