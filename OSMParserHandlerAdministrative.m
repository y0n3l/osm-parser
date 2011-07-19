//
//  OSMParserHandlerAdministrative.m
//  OSMImporter
//
//  Created by y0n3l http://www.twitter.com/y0n3l on 2/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OSMParserHandlerAdministrative.h"


@implementation OSMParserHandlerAdministrative

-(void) onWayFound:(Way *)way {
	//<tag k='admin_level' v='6' />
    //<tag k='boundary' v='administrative' />
    
	if (/*[[way.tags objectForKey:@"admin_level"] isEqualToString:@"6"] ||*/ [[way.tags objectForKey:@"boundary"] isEqualToString:@"administrative"] ||
		[[way.tags objectForKey:@"natural"] isEqualToString:@"coastline"] ||
		[[way.tags objectForKey:@"waterway"] isEqualToString:@"river"])
		[super onWayFound:way];
}

-(void) onRelationFound:(Relation *)relation {
	if (/*[[relation.tags objectForKey:@"admin_level"] isEqualToString:@"6"] || */
		[[relation.tags objectForKey:@"boundary"] isEqualToString:@"administrative"])
		[outputDao addRelation:relation];
}

@end
