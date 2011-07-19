//
//  Way.m
//  OSMImporter
//
//  Created by y0n3l http://www.twitter.com/y0n3l on 1/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Way.h"

@implementation Way

@synthesize wayId, nodesIds, tags, nodes, length;

-(id) init {
	if (self!=[super init])
		return nil;
	nodesIds = [[NSMutableArray alloc] init];
	return self;
}

-(BOOL) isFirstNodeId:(NSUInteger)nodeId {
	return [[nodesIds objectAtIndex:0] intValue]==nodeId;
}

-(BOOL) isLastNodeId:(NSUInteger)nodeId {
	return [[nodesIds objectAtIndex:[nodesIds count]-1] intValue]==nodeId;
}

-(NSInteger) lastNodeId {
	if ([nodesIds count]==0)
		return -1;
	else
		return [[nodesIds objectAtIndex:[nodesIds count]-1] intValue];
}

-(NSInteger) firstNodeId {
	if ([nodesIds count]==0)
		return -1;
	else
		return [[nodesIds objectAtIndex:0] intValue];
}

-(NSInteger)getCommonNodeIdWith:(Way*)way {
	NSInteger commonNodeId = -1;
	if ([way.nodesIds count]==0 || [self.nodesIds count]==0)
		return commonNodeId;
	NSUInteger selfStartNode = [[self.nodesIds objectAtIndex:0] intValue];
	NSUInteger selfEndNode = [[self.nodesIds objectAtIndex:[self.nodesIds count]-1]intValue];
	NSUInteger wayStartNode = [[way.nodesIds objectAtIndex:0]intValue];
	NSUInteger wayEndNode = [[way.nodesIds objectAtIndex:[way.nodesIds count]-1] intValue];
	if (selfStartNode==wayStartNode || selfStartNode==wayEndNode)
		commonNodeId= selfStartNode;
	else if (selfEndNode == wayStartNode || selfEndNode == wayEndNode)
		commonNodeId= selfEndNode;
	return commonNodeId;
}

-(NSString*) description {
	return [NSString stringWithFormat:@"Way(%i)%i nodes", wayId, [nodesIds count]];
}

-(void) dealloc {
	[nodesIds release];
	[nodes release];
	[tags release];
	[super dealloc];
}

@end
