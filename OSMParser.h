//
//  OSMParser.h
//  OSMImporter
//
//  Created by Lionel Gueganton on 1/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Node.h"
#import "Way.h"
#import "Relation.h"
#import "AQXMLParser.h"

@protocol OSMParserDelegate
-(void) parsingStart;
-(void) parsingEnd;
-(void) didStartParsingNodes;
-(void) onNodeFound:(Node*)node;
-(void) didStartParsingWays;
-(void) onWayFound:(Way*)way;
-(void) didStartParsingRelations;
-(void) onRelationFound:(Relation*)relation;
@end


@interface OSMParser : NSObject <AQXMLParserDelegate> {
	AQXMLParser* parser;
	NSMutableArray* nodes;
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

-(void) parse;

@end
