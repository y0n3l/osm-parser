//
//  Way.h
//  OSMImporter
//
//  Created by Lionel Gueganton on 1/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Way : NSObject {
	NSUInteger wayId;
	NSMutableArray* nodesIds;
	NSArray* nodes;
	NSDictionary* tags;
	NSUInteger length;
}

-(NSInteger)getCommonNodeIdWith:(Way*)way;

-(BOOL) isFirstNodeId:(NSUInteger)nodeId;

-(NSInteger) lastNodeId;
-(NSInteger) firstNodeId;

-(BOOL) isLastNodeId:(NSUInteger)nodeId;

@property (readonly)NSMutableArray* nodesIds;
@property (readwrite, retain)NSArray* nodes;
@property (readwrite) NSUInteger wayId;
@property (readwrite, retain)NSDictionary* tags;
@property (readwrite)NSUInteger length;

@end
