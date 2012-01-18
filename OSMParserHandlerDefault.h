//
//  OSMParserHandlerDefault.h
//  OSMImporter
//
//  Created by y0n3l http://www.twitter.com/y0n3l on 1/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSMParser.h"
#import "OSMDAO.h"

/**
 The default OSMParser handler.
 It stores any parsed node, way, relation to a spatialite db. Such DB is accessed
 through the OSMDAO instance given at init time.
 The flush to the DB is done once the limit number of parsed objects has been reached
 (see bufferMaxSize) to limit the number of db transactions and improve db access time. 
 */
@interface OSMParserHandlerDefault : NSObject <OSMParserDelegate> {
	/** The DAO used to store objects created at parsing time. */
	OSMDAO* outputDao;
	/** Default is 30000: 30000 nodes should be parsed before flushing to the DB.
	 This number is divided by 20 to get the limit number of ways before doing the flush for ways. */
	NSUInteger bufferMaxSize;
	/** The total number of parsed nodes. */
	NSUInteger nodesCounter;
	/** The total number of parsed ways. */
	NSUInteger waysCounter;
	/** Nodes memory storage before DB flush in one single transaction. */
	NSMutableArray* nodesBuffer;
	/** Ways memory storage before DB flush in one single transaction. */
	NSMutableArray* waysBuffer;
	BOOL ignoreNodes;
    
    BOOL optimizeOnFinished;
}
@property(readwrite) BOOL ignoreNodes;
/** Configurable number of objects to be put in memory before being flushed to the DB. 
  Default is 30 000 for nodes, and 30 000/20 for ways. */ 
@property(readwrite) NSUInteger bufferMaxSize;

@property(readwrite) BOOL optimizeOnFinished;

/**
 Creates a new OSMParserHandlerDefault that will create a spatialite DB at the given output path
 */
-(id) initWithOutputFilePath:(NSString*)output;

/**
 Creates a new OSMParserHandlerDefault that will create a spatialite DB at the given output path, 
 overriding the existing file or not.
 */
-(id) initWithOutputFilePath:(NSString*)filePath overrideIfExists:(BOOL)override;

@end
