//
//  Way.h
//  OSMImporter
//
//  Created by y0n3l http://www.twitter.com/y0n3l on 1/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class describes a Way as defined in a .osm XML file. 
 */
@interface Way : NSObject {
	NSUInteger wayId;
	NSMutableArray* nodesIds;
	NSArray* nodes;
	NSDictionary* tags;
	NSUInteger length;
}

-(NSInteger)getCommonNodeIdWith:(Way*)way;

/** Returns YES if the given nodeid is the first one of this way. */
-(BOOL) isFirstNodeId:(NSUInteger)nodeId;
/** Returns YES if the given nodeid is the last one of this way. */
-(BOOL) isLastNodeId:(NSUInteger)nodeId;
/** Returns the nodeid of the first node of this way. */
-(NSInteger) firstNodeId;
/** Returns the nodeid of the last node of this way. */
-(NSInteger) lastNodeId;

/** This way id. */
@property (readwrite) NSUInteger wayId;
/** Tags associated with this way. */
@property (readwrite, retain)NSDictionary* tags;
@property (readonly)NSMutableArray* nodesIds;
@property (readwrite, retain)NSArray* nodes;

@property (readwrite)NSUInteger length;

@end
