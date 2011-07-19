//
//  OSMParserHandlerAdministrative.h
//  OSMImporter
//
//  Created by y0n3l http://www.twitter.com/y0n3l on 2/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSMParserHandlerDefault.h"

/**
 An OSMParserHandler class that only takes the following ways / relations into account :
 WAYS tags:
 boundary = administrative
 natural = coastline
 waterway = river
 
 RELATIONS tags:
 boundary = administrative
 */

@interface OSMParserHandlerAdministrative : OSMParserHandlerDefault {

}

@end
