INSERT INTO `addon_account` (name, label, shared) VALUES 
    ('society_gouvernement','Gouvernement',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_gouvernement','Gouvernement',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
    ('society_gouvernement', 'Gouvernement', 1)
;

INSERT INTO `jobs` (name, label) VALUES 
    ('gouvernement','Gouvernement')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
    ('gouvernement', 0, 'security','Agent de sécurité', 0, '{}', '{}'),
    ('gouvernement', 1, 'boss', 'Président', 0, '{}', '{}')
;