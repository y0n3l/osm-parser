//
//  Node.h
//  OSMImporter
//
//  Created by y0n3l http://www.twitter.com/y0n3l on 1/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class describes a Node as defined in a .osm XML file.
 */
@interface Node : NSObject {
	NSUInteger nodeId;
	double latitude;
	double longitude;
	NSDictionary* tags;
}
/** This node id. */
@property (readwrite)NSUInteger nodeId;
/** This node latitude. (WGS 84 - SRID 4326) */
@property (readwrite)double latitude;
/** This node longitude. (WGS 84 - SRID 4326) */
@property (readwrite)double longitude;
/** OSM tags associated to this node. */
@property (readwrite, retain)NSDictionary* tags;

@end
