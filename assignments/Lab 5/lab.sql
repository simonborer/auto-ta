CREATE TABLE MHW_MONSTERS
(
  monster_id NUMBER(6),
  monster_name VARCHAR(15) PRIMARY KEY NOT NULL,
  monster_type CHAR(5),
  monster_element VARCHAR(15),
  monster_weakness VARCHAR (15), 
  monster_elderdragon NCHAR(2),
  monster_locations VARCHAR (20) DEFAULT 'Wildspire Wasteland'
)

CREATE TABLE MHW_WEAPONS
(
  weapon_id NUMBER(6) PRIMARY KEY,
  weapon_name VARCHAR(15) NOT NULL,
  weapon_type VARCHAR(15),
  weapon_rarity NUMBER(1),
  weapon_attack NUMBER(4),
  weapon_element VARCHAR(15), 
  weapon_slots NUMBER(1),
  weapon_affinity NUMBER (2) DEFAULT 0,
  weapon_origin VARCHAR(20) REFERENCES MHW_MONSTERS(monster_name)
)

CREATE TABLE MHW_ARMORS
(
  armor_id NUMBER(6) PRIMARY KEY,
  armor_name VARCHAR(15) NOT NULL,
  armor_rarity NUMBER(1),
  armor_defense NUMBER(3),
  armor_element VARCHAR(15),
  armor_slots NUMBER(1) DEFAULT 0,
  armor_weaknesses VARCHAR(15),
  armor_origin VARCHAR(20) REFERENCES MHW_MONSTERS(monster_name)
)

INSERT INTO MHW_MONSTERS
VALUES(1, 'Nergigante', 'Large', 'Physical', 'Thunder', 'Y', 'Elders Recess');
INSERT INTO MHW_MONSTERS
VALUES(2, 'Teostra', 'Large', 'Fire', 'Water', 'Y', 'Elders Recess');
INSERT INTO MHW_MONSTERS
VALUES(3, 'Kirin', 'Large', 'Thunder', 'Fire', 'Y', 'Coral Highlands');

INSERT INTO MHW_WEAPONS
VALUES(1, 'Blue Wing', 'Greatsword', 7, 816, 'Fire', 1, 15, 'Kirin');
INSERT INTO MHW_WEAPONS
VALUES(2, 'Heat Edge', 'SnS', 6, 224, 'Fire', 1, 20, 'Teostra');
INSERT INTO MHW_WEAPONS
VALUES(3, 'Decimation Claw', 'Dual Blades', 8, 294, 'Dragon', 1, 0, 'Nergigante');

INSERT INTO MHW_ARMORS
VALUES(1, 'Armor', 5, 200, 'Fire', 1, 'Water', 'Teostra');
INSERT INTO MHW_ARMORS
VALUES(2, 'ArmorTwo', 7, 300, 'Water', 1, 'Fire', 'Kirin');
INSERT INTO MHW_ARMORS
VALUES(3, 'ArmorThree', 8, 400, 'Thunder', 1, 'Fire', 'Nergigante');

SELECT monster_name, weapon_name, armor_name
FROM MHW_MONSTERS m
INNER JOIN MHW_WEAPONS w
ON m.monster_name = w.weapon_origin
INNER JOIN MHW_ARMORS a
ON m.monster_name = a.armor_origin

ALTER TABLE MHW_MONSTERS
ADD monster_difficulty VARCHAR(20);

ALTER TABLE MHW_MONSTERS
RENAME TO MHW_MONSTER_TABLE