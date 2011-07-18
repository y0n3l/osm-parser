//
//  OSMParserHandlerDefault.h
//  OSMImporter
//
//  Created by Lionel Gueganton on 1/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSMParser.h"
#import "OSMDAO.h"

@interface OSMParserHandlerDefault : NSObject <OSMParserDelegate> {
	OSMDAO* outputDao;
	NSUInteger bufferMaxSize;
	NSUInteger nodesCounter;
	NSUInteger waysCounter;
	NSMutableArray* nodesBuffer;
	NSMutableArray* waysBuffer;
	BOOL ignoreNodes;
}
@property(readwrite) BOOL ignoreNodes;
-(id) initWithOutputFilePath:(NSString*)output;

-(id) initWithOutputFilePath:(NSString*)filePath overrideIfExists:(BOOL)override;

@end
