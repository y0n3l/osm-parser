//
//  OSMParser.h
//  OSMImporter
//
//  Created by y0n3l on 1/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"
#import "Way.h"
#import "Relation.h"
#import "AQXMLParser.h"

/**
 Any delegate object should implement selectors from this protocol to be aware of parsing 
 events.
 */
@protocol OSMParserDelegate
/* Invoked when the parsing of the OSM file has started. */
-(void) parsingStart;
/* Invoked when the parsing of the OSM file has ended. */
-(void) parsingEnd;
@optional
/* Invoked when the parsing of the nodes part of the OSM file has started. */
-(void) didStartParsingNodes;
/* Invoked when a node definition has been parsed in the OSM file. */
-(void) onNodeFound:(Node*)node;
/* Invoked when the parsing of the ways part of the OSM file has started. This usually happens once 
 all the nodes part parsing has been finished. */
-(void) didStartParsingWays;
/* Invoked when a way definition has been parsed in the OSM file. */
-(void) onWayFound:(Way*)way;
@optional
/* Invoked when the parsing of the relations part of the OSM file has started. This usually happens once
 the ways parsing has been done. */
-(void) didStartParsingRelations;
/* Invoked when a relation has been parsed in the OSM file. */

-(void) onRelationFound:(Relation*)relation;
@end

/**
 The OSMParser class defines parsers that parse .osm files (XML) that describe street networks defined 
 in OpenStreetMaps.
 OSMParser instances encapsulates a SAX parser that reads the .osm file and generates events when finding
 OSM tags such as node, way, relation.
 The embedded SAX parser is an instance of a AQXMLParser, that is able to read and parse a stream without 
 loading the whole file in memory (required when you want to parse .osm files larger XXX megabytes !)
 */

@interface OSMParser : NSObject <AQXMLParserDelegate> {
	AQXMLParser* parser;
	id <OSMParserDelegate> delegate;
	Node* currentNode;
	Way* currentWay;
	Relation* currentRelation;
	NSMutableDictionary* tags;
	BOOL isFirstNode;
	BOOL isFirstWay;
	BOOL isFirstRelation;
}

@property (readwrite, retain) id <OSMParserDelegate> delegate;

- (id)initWithOSMFile:(NSString*)osmFilePath;

- (id)initWithOSMStream:(NSInputStream*)osmStream;

/** Starts the parsing. */
-(void) parse;

@end
