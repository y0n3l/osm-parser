//
//  RoadNetworkDAO.h
//  OSMImporter
//
//  Created by Lionel Gueganton on 1/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//Uses the sqlite embedded in spatialite and not the platform one.
#import "sqlite3.h"
#import "Node.h"
#import "Way.h"
#import "Relation.h"

@interface OSMDAO : NSObject {
	sqlite3* dbHandle;
	NSString* filePath;
}

@property (readonly) sqlite3* dbHandle;
@property (readonly) NSString* filePath;


-(id) initWithFilePath:(NSString*)filePath;

-(id) initWithFilePath:(NSString*)filePath overrideIfExists:(BOOL)override;

-(void) optimizeDB;

-(void) addContentFrom:(OSMDAO*)networkB;

-(void) addNodes:(NSArray*)nodes;

-(Node*) getNodeFromID:(NSUInteger)nodeId;

-(NSArray*) getNodesForWay:(Way*)way;

-(Way*) getWayWithID:(NSUInteger)wayid;

-(void) addWays:(NSArray*)ways;

-(void) deleteWaysWithIds:(NSArray*)waysIds;

-(void) addWay:(Way*)way;

-(void) addRelation:(Relation *)rel;

-(NSArray*) getMotorwaysRelationsIds;

-(Relation*) getRelationWithID:(NSUInteger) relationid;

-(void) associateNetworkToRoadsDefinitions;

/** Returns a rowid */
-(NSUInteger) getRoadDefinitionMatchingRoadReference:(NSString*)ref andAngle:(NSUInteger)angle;
@end
