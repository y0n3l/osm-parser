--
--
-- This SQL script removes temporary tables that can be considered as useless once the parsing
-- of the .osm file has been achieved. Ex; ways_nodes can be removed because this information 
-- is now stored as a geometry in the ways table. 
--
-- 
DROP TABLE IF EXISTS nodes;
DROP TABLE IF EXISTS nodes_tags;
--DROP TABLE IF EXISTS ways_tags;
DROP TABLE IF EXISTS ways_nodes;
DROP TABLE IF EXISTS relations;
DROP TABLE IF EXISTS relations_members;
DROP TABLE IF EXISTS relations_tags;
VACUUM;
SELECT CreateSpatialIndex('ways', 'geom');
