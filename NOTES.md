


ALTER TABLE grano_entity DISABLE TRIGGER ALL;

DELETE FROM grano_entity e WHERE e.id NOT IN (SELECT DISTINCT p.entity_id FROM grano_property p WHERE p.entity_id IS NOT NULL);

ALTER TABLE grano_entity ENABLE TRIGGER ALL;



--

SELECT COUNT(e.id) FROM entity e WHERE e.id NOT IN (SELECT p.entity_id FROM property p WHERE p.entity_id IS NOT NULL);
