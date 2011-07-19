# osm-parser

*A SAX parser to parse large .osm (OpenStreetMaps[1]) files and convert them into spatiality (spatial extension for sqlite) files.

[1]: http://www.openstreetmap.org

## Dependency

The only required sources files are the ones needed to use the AQXMLParser (aka StreamingXMLParser) 

#import "OSMParser.h"
#import "OSMParserHandlerDefault.h"

É

NSString* myOsmInputFile = @"path/to/your/file/map.osm";
NSString* mySpatialiteOutputFile = @"path/to/your/file/spatial.db";
OSMParser* parser = [[OSMParser alloc] initWithOSMFile:myOsmInputFile];
OSMParserHandlerDefault* handler = [[OSMParserHandlerDefault alloc] initWithOutputFilePath:mySpatialiteOutputFile];
[parser parse];
[parser release];
[handler release];