//
//  Relation.h
//  OSMImporter
//
//  Created by y0n3l http://www.twitter.com/y0n3l on 1/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@interface Member : NSObject{
	NSString* type;
	NSUInteger ref;
	NSString* role;
}
@property (readwrite, retain) NSString* type;
@property (readwrite) NSUInteger ref;
@property (readwrite, retain) NSString* role;

@end


@interface Relation : NSObject {
	NSUInteger relationId;
	NSMutableArray* members;
	NSDictionary* tags;
}

@property (readonly)NSMutableArray* members;
@property (readwrite) NSUInteger relationId;
@property (readwrite, retain)NSDictionary* tags;


@end
