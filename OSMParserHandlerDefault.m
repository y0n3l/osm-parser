//
//  OSMParserHandlerDefault.m
//  OSMImporter
//
//  Created by y0n3l http://www.twitter.com/y0n3l on 1/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OSMParserHandlerDefault.h"

@interface OSMParserHandlerDefault (privateAPI)
-(BOOL) checkForWaysFlush;
-(BOOL) checkForNodesFlush;
@end


@implementation OSMParserHandlerDefault

@synthesize ignoreNodes;
@synthesize bufferMaxSize;

-(id) initWithOutputFilePath:(NSString*)output {
	return [self initWithOutputFilePath:output overrideIfExists:YES];
}

-(id) initWithOutputFilePath:(NSString*)filePath overrideIfExists:(BOOL)override {
	if (self!=[super init])
		return nil;
	outputDao=[[OSMDAO alloc] initWithFilePath:filePath overrideIfExists:override];
	nodesBuffer=[[NSMutableArray alloc] init];
	waysBuffer=[[NSMutableArray alloc] init];
	bufferMaxSize=30000;
	return self;
}

-(void) dealloc {
	[outputDao release];
	[super dealloc];
}

#pragma mark -
#pragma mark Parser delegate
-(void) didStartParsingNodes {
	NSLog(@"[NOW PARSING NODES]"); 
}
-(void) didStartParsingWays {
	[self checkForNodesFlush];
	NSLog(@"[NOW PARSING WAYS]"); 
}
-(void) didStartParsingRelations {
	[self checkForWaysFlush];
	NSLog(@"[NOW PARSING RELATIONS]"); 
}


-(void) onNodeFound:(Node *)node {
	if (!ignoreNodes) {
		//[roadNetwork addNodes:[NSArray arrayWithObject:node]];
		[nodesBuffer addObject:node];
		//if (node.tags) 
		//	NSLog(@"this node has tags : %@", node.tags);
		nodesCounter++;
		if (nodesCounter%bufferMaxSize==0) {
			[self checkForNodesFlush];
		}
	}
}

-(void) onWayFound:(Way *)way {
	[waysBuffer addObject:way];
	if ([way.nodesIds count]==0)
		NSLog(@"WARNING No Node for WAY %@i", way.wayId);
	//NSLog(@"Way %i has nodes : %@", way.wayId, way.nodesIds);
	waysCounter++;
	if (waysCounter%(bufferMaxSize/20)==0) {
		[self checkForWaysFlush];
	}
}

-(void) onRelationFound:(Relation *)relation {
	//NSLog(@"relation found");
	[outputDao addRelation:relation];
}

-(BOOL) checkForNodesFlush {
	if ([nodesBuffer count]!=0) {
		NSLog(@"parsed %i nodes", nodesCounter);
		[outputDao addNodes:nodesBuffer];
		[nodesBuffer removeAllObjects];
		return YES;
	} else {
		return NO;
	}
}

-(BOOL) checkForWaysFlush {
	if ([waysBuffer count]!=0) {
		NSLog(@"parsed %i ways", waysCounter);
		NSLog(@"now populating corresponding nodes");
		for (int i=0; i<[waysBuffer count]; i++) {
			Way* w =[waysBuffer objectAtIndex:i];
			NSArray* n =[outputDao getNodesForWay:w];
			w.nodes=n;
		}
		NSLog(@"Nodes populated, now flushing...");
		[outputDao addWays:waysBuffer];
		NSLog(@"Flush !");
		[waysBuffer removeAllObjects];
		return YES;
	}else {
		return NO;
	}

}

-(void) parsingStart {
}

-(void) parsingEnd {
	[outputDao optimizeDB];
}

@end
