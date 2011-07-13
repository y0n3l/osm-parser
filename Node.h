//
//  Node.h
//  OSMImporter
//
//  Created by Lionel Gueganton on 1/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Node : NSObject {
	NSUInteger nodeId;
	double latitude;
	double longitude;
	NSDictionary* tags;
}
@property (readwrite)NSUInteger nodeId;
@property (readwrite)double latitude;
@property (readwrite)double longitude;
@property (readwrite, retain)NSDictionary* tags;

@end
