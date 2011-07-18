DROP TABLE IF EXISTS nodes;
DROP TABLE IF EXISTS nodes_tags;
--DROP TABLE IF EXISTS ways_tags;
DROP TABLE IF EXISTS ways_nodes;
DROP TABLE IF EXISTS relations;
DROP TABLE IF EXISTS relations_members;
DROP TABLE IF EXISTS relations_tags;
VACUUM;
SELECT CreateSpatialIndex('ways', 'geom');
