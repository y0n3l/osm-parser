//
//  OSMParser.m
//  OSMImporter
//
//  Created by y0n3l http://www.twitter.com/y0n3l on 1/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OSMParser.h"

@implementation OSMParser

@synthesize delegate;

- (id)initWithOSMFile:(NSString*)osmFilePath {
	if (self!=[super init]) {
		return nil;
	}
	isFirstNode=YES;
	isFirstWay=YES;
	isFirstRelation=YES;
	NSData* data = [NSData dataWithContentsOfFile:osmFilePath];
	parser=[[AQXMLParser alloc] initWithData:data];
	[parser setDelegate:self];
	return self;
}

- (id)initWithOSMStream:(NSInputStream*)osmStream {
	if (self!=[super init]) {
		return nil;
	}
	isFirstNode=YES;
	isFirstWay=YES;
	isFirstRelation=YES;
	parser=[[AQXMLParser alloc] initWithStream:osmStream];
	[parser setDelegate:self];
	return self;
}

- (void)dealloc {
	[parser release];
    [super dealloc];
}

-(void) parse {
	[parser parse];
}

//<node id="274026" lat="43.6113906" lon="7.1074235" user="Djam" uid="24982" visible="true" version="2" changeset="3759495" timestamp="2010-01-31T14:18:39Z"/>
//<way id="68063774" user="Bert Bos" uid="155462" visible="true" version="1" changeset="5234652" timestamp="2010-07-16T14:23:00Z">
//<nd ref="820399673"/>
//<nd ref="820688904"/>

+(NSUInteger) asInteger:(NSString*)v {
	//NSUInteger idx = [v rangeOfString:@"."].location;
	//NSUInteger numberOfDecimals = [v length] - idx;
	v = [v stringByReplacingOccurrencesOfString:@"." withString:@""];
	NSUInteger value = [v intValue];
	return value;
}

- (void)parserDidStartDocument:(AQXMLParser *)parser {
	[delegate parsingStart];
}

- (void)parserDidEndDocument:(AQXMLParser *)parser {
	[delegate parsingEnd];
}

- (void)parser:(AQXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqual:@"node"]) {
		NSString* latitudeAsString=(NSString*)[attributeDict objectForKey:@"lat"];
		NSString* longitudeAsString=(NSString*)[attributeDict objectForKey:@"lon"];
		NSUInteger nodeid = [(NSString*)[attributeDict objectForKey:@"id"] intValue]; 
		//NSLog(@"parsed %d(%i, %i)", nodeid, , [OSMParser asInteger:longitudeAsString]);
		Node* node = [[Node alloc] init];
		node.nodeId = nodeid;
		node.latitude = [latitudeAsString doubleValue];
		node.longitude = [longitudeAsString doubleValue];
		currentNode = node;
	} else if ([elementName isEqual:@"way"]) {
		NSUInteger wayid = [(NSString*)[attributeDict objectForKey:@"id"] intValue]; 
		currentWay=[[Way alloc] init];
		currentWay.wayId=wayid;
	} else if ([elementName isEqual:@"relation"]) {
		/*
		 <relation id="539184" user="Nikita006" uid="35470" visible="true" version="15" changeset="4285518" timestamp="2010-03-31T13:57:26Z">
		 <member type="way" ref="4726817" role=""/>
		 ....
		 <tag k="ref" v="D 535"/>
		 <tag k="route" v="road"/>
		 <tag k="type" v="route"/>
		 */
		NSUInteger relationid = [(NSString*)[attributeDict objectForKey:@"id"] intValue]; 
		currentRelation=[[Relation alloc] init];
		currentRelation.relationId=relationid;
	} else if ([elementName isEqual:@"member"]) {
		NSString* type = (NSString*)[attributeDict objectForKey:@"type"]; 
		NSUInteger ref = [(NSString*)[attributeDict objectForKey:@"ref"] intValue]; 
		NSString* role = (NSString*)[attributeDict objectForKey:@"role"]; 
		Member* member = [[Member alloc] init];
		member.type=type;
		member.ref=ref;
		member.role=role;
		[currentRelation.members addObject:member];
		[member release];
		
	} else if ([elementName isEqual:@"nd"]) {
		NSUInteger ref = [(NSString*)[attributeDict objectForKey:@"ref"] intValue]; 
		NSNumber* refAsNumber = [[NSNumber alloc] initWithUnsignedInteger:ref];
		[currentWay.nodesIds addObject:refAsNumber];
		[refAsNumber release];
	} else if ([elementName isEqual:@"tag"]) {
		if (tags==nil) {
			tags = [[NSMutableDictionary alloc] init];
			if (currentNode)
				currentNode.tags=tags;
			else if (currentWay)
				currentWay.tags=tags;
			else if (currentRelation)
				currentRelation.tags=tags;
		}
		[tags setObject:[attributeDict objectForKey:@"v"] forKey:[attributeDict objectForKey:@"k"]];
	} 
}

- (void)parser:(AQXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqual:@"node"]) {
		if (isFirstNode) {
			isFirstNode=NO;
			if ([(NSObject*)delegate respondsToSelector:@selector(didStartParsingNodes)])
				[delegate didStartParsingNodes];
		}
		[delegate onNodeFound:currentNode];
		[currentNode release];
		currentNode = nil;
		[tags release];
		tags=nil;
	} else if ([elementName isEqual:@"way"]) {
		if (isFirstWay) {
			isFirstWay=NO;
			if ([(NSObject*)delegate respondsToSelector:@selector(didStartParsingWays)])
				[delegate didStartParsingWays];
		}
		[delegate onWayFound:currentWay];
		[currentWay release];
		currentWay=nil;
		[tags release];
		tags=nil;
	} else if ([elementName isEqual:@"relation"]) {
		if (isFirstRelation) {
			isFirstRelation=NO;
			[delegate didStartParsingRelations];
		}
		[delegate onRelationFound:currentRelation];
		[currentRelation release];
		currentRelation=nil;
		[tags release];
		tags=nil;
	}
}

@end
