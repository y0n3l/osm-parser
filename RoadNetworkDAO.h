//
//  RoadNetworkDAO.h
//  OSMImporter
//
//  Created by Lionel Gueganton on 1/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "Node.h"
#import "Way.h"
#import "Relation.h"

@interface RoadNetworkDAO : NSObject {
	sqlite3* dbHandle;
	NSString* filePath;
}

@property (readonly) sqlite3* dbHandle;
@property (readonly) NSString* filePath;

-(id) initWithFilePath:(NSString*)filePath;

-(id) initWithFilePath:(NSString*)filePath overrideIfExists:(BOOL)override;

-(void) optimizeDB;

-(NSArray*) getMotorwaysRelationsIds;

-(void) addNodes:(NSArray*)nodes;

-(Way*) getWayWithID:(NSUInteger)wayid;

-(void) addWays:(NSArray*)ways;

-(void) deleteWaysWithIds:(NSArray*)waysIds;

-(void) addWay:(Way*)way;

-(void) addRelation:(Relation *)rel;

-(Node*) getNodeFromID:(NSUInteger)nodeId;

-(NSArray*) getNodesForWay:(Way*)way;

-(void) addContentFrom:(RoadNetworkDAO*)networkB;

-(Relation*) getRelationWithID:(NSUInteger) relationid;

-(void) associateNetworkToRoadsDefinitions;

/** Returns a rowid */
-(NSUInteger) getRoadDefinitionMatchingRoadReference:(NSString*)ref andAngle:(NSUInteger)angle;
@end
