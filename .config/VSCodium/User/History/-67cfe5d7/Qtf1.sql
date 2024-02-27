SET search_path TO "orti1";
SET datestyle TO "DMY";

------------------------------------------ POPOLAMENTO --------------------------------------------------
-------------------------------------------- MANUALE ----------------------------------------------------

/*
 Il seguente popolamento è stato realizzato manualmente solo per testare il codice realizzato.
 Per tal motivo, potrebbe non rispettare alcuni dei vincoli trigger non implementati
 */


INSERT INTO Persona VALUES('FSKCOBEOYHSOSIDC', 'Katharina','Wakefield', 'deangelo_grimes29@hotmail.com', 'referente istituto', 10863902);

INSERT INTO Persona VALUES('EIR05IGTVT7EEHLS', 'Carlo', 'Panuozzi', 'margot_rempel@hotmail.com', 'referente scuola', 6382945);
INSERT INTO Persona VALUES('S0X92XMXTEAYIU6Y', 'Camila','Oyler', 'rigoberto.hagenes69@gmail.com', 'referente scuola');
INSERT INTO Persona VALUES('HO01W4TZ3EQH1CI0', 'Laura','Stannard', 'preston.frami76@gmail.com', 'referente scuola', 9239258);
INSERT INTO Persona VALUES('4F5ZH6V0NOO6LRPG', 'Sylvia','Pyland', 'maryse.quitzon2@yahoo.com', 'referente scuola');

INSERT INTO Persona VALUES('M8YPFRF6PI3MNHBZ', 'Luca','Zia', 'saige49@yahoo.com', 'docente', 1029850743);
INSERT INTO Persona VALUES('KVHMVYV9F7DLQ9VZ', 'Marty','Bright', 'pinkie_klein@hotmail.com', 'docente', 287334928);
INSERT INTO Persona VALUES('R0ASY7TGYNGIYPC8', 'Jozef','Vostreys', 'weldon21@gmail.com', 'docente', 3776989383);
INSERT INTO Persona VALUES('7TWVTVIJ7REF00ZS', 'Dave','Cooper', 'laisha.goodwin4@gmail.com', 'docente', 03859384);

INSERT INTO Persona VALUES('S3ADQ81UOBBZPMJM', 'Alice','White', 'stella_morissette@yahoo.com', 'studente');
INSERT INTO Persona VALUES('FLRVIB2N84FD3WGK', 'Frederik','Bloom', 'haven.kub43@yahoo.com', 'studente');
INSERT INTO Persona VALUES('3LFSPY0HLKZMAZJH', 'Koos','Linhart', 'leopold_lowe@hotmail.com', 'studente');
INSERT INTO Persona VALUES('3A80V9KHMK764YAT', 'Ross','Nobles', 'kathryne43@hotmail.com', 'studente');
INSERT INTO Persona VALUES('J382IYX4C4NKA4QE', 'Jaap','Griffioen', 'julianne89@gmail.com', 'studente');
INSERT INTO Persona VALUES('E6WX9ODEHCXR4Q3V', 'Andy','Guyer', 'eudora45@gmail.com', 'studente');
INSERT INTO Persona VALUES('CXX41A77ZJCDW4QG', 'Daniela','Deans', 'abigayle.prosacco28@yahoo.com', 'studente');
INSERT INTO Persona VALUES('ENDEVPI2BNHS8CB1', 'Sharon','Reames', 'jevon_kuhic34@hotmail.com', 'studente');
INSERT INTO Persona VALUES('IJZGJEKHLB78U8PZ', 'Mary','Krutkov', 'sam_altenwerth82@yahoo.com', 'studente');
INSERT INTO Persona VALUES('RQMOLMA2XZKVPWK6', 'Hiram','Bertelson', 'grover_prohaska@yahoo.com', 'studente');
INSERT INTO Persona VALUES('JDKHU7JZZFVN9CI5', 'Christian','Igolavski', 'dante4@gmail.com', 'studente');
INSERT INTO Persona VALUES('TIUK3RYER7VEBZFJ', 'Marco','Knight', 'sebastian.satfield@gmail.com', 'studente');

-------------

INSERT INTO Istituto VALUES ('ABCDEF78', 'Istituto Livigno', 'GE', FALSE);
INSERT INTO Istituto VALUES ('FACGDE90', 'Scuole Montessori', 'SV', TRUE);

-------------

INSERT INTO ReferenteIstituto VALUES ('FSKCOBEOYHSOSIDC', 'ABCDEF78');
INSERT INTO ReferenteIstituto VALUES ('M8YPFRF6PI3MNHBZ', 'FACGDE90');

-------------

INSERT INTO Finanziamento VALUES ('ABCDEF78', 'PON EduGreen', 1000);

-------------

INSERT INTO Ciclo VALUES ('Liceo Artistico', 'secondo');
INSERT INTO Ciclo VALUES ('Scuola Media', 'primo');
INSERT INTO Ciclo VALUES ('Liceo Scientifico', 'secondo');
INSERT INTO Ciclo VALUES ('Scuola Elementare', 'primo');

-------------

INSERT INTO Scuola VALUES ('V1KUI1V0', 'ABCDEF78', 'Paul Klee', 'Liceo Artistico');
INSERT INTO Scuola VALUES ('NDWJA38M', 'ABCDEF78', 'Dante Alighieri', 'Scuola Media');

INSERT INTO Scuola VALUES ('V2QEWUZ2', 'FACGDE90', 'E. Fermi', 'Liceo Scientifico');
INSERT INTO Scuola VALUES ('EM9H32SX', 'FACGDE90', 'G. Mazzini', 'Scuola Elementare');

------------

INSERT INTO ReferenteScuola VALUES ('EIR05IGTVT7EEHLS', 'V1KUI1V0', TRUE);
INSERT INTO ReferenteScuola VALUES ('KVHMVYV9F7DLQ9VZ', 'NDWJA38M', FALSE);
INSERT INTO ReferenteScuola VALUES ('R0ASY7TGYNGIYPC8', 'V2QEWUZ2', TRUE);
INSERT INTO ReferenteScuola VALUES ('7TWVTVIJ7REF00ZS', 'EM9H32SX', FALSE);

------------

INSERT INTO Classe VALUES ('4B', 'V1KUI1V0', 'M8YPFRF6PI3MNHBZ');
INSERT INTO Classe VALUES ('1C', 'NDWJA38M', 'KVHMVYV9F7DLQ9VZ');
INSERT INTO Classe VALUES ('2A', 'V2QEWUZ2', 'R0ASY7TGYNGIYPC8');
INSERT INTO Classe VALUES ('3G', 'EM9H32SX', '7TWVTVIJ7REF00ZS');

-----------

INSERT INTO Studente VALUES('S3ADQ81UOBBZPMJM', '4B', 'V1KUI1V0');
INSERT INTO Studente VALUES('FLRVIB2N84FD3WGK', '4B', 'V1KUI1V0');
INSERT INTO Studente VALUES('3LFSPY0HLKZMAZJH', '4B', 'V1KUI1V0');

INSERT INTO Studente VALUES('3A80V9KHMK764YAT', '1C', 'NDWJA38M');
INSERT INTO Studente VALUES('J382IYX4C4NKA4QE', '1C', 'NDWJA38M');
INSERT INTO Studente VALUES('E6WX9ODEHCXR4Q3V', '1C', 'NDWJA38M');

INSERT INTO Studente VALUES('CXX41A77ZJCDW4QG', '2A', 'V2QEWUZ2');
INSERT INTO Studente VALUES('ENDEVPI2BNHS8CB1', '2A', 'V2QEWUZ2');
INSERT INTO Studente VALUES('IJZGJEKHLB78U8PZ', '2A', 'V2QEWUZ2');

INSERT INTO Studente VALUES('RQMOLMA2XZKVPWK6', '3G', 'EM9H32SX');
INSERT INTO Studente VALUES('JDKHU7JZZFVN9CI5', '3G', 'EM9H32SX');
INSERT INTO Studente VALUES('TIUK3RYER7VEBZFJ', '3G', 'EM9H32SX');

---------

INSERT INTO Orto VALUES('V1KUI1V0', 'Vecchie Felci', '50°38′N 3°03′E', 100, 'in vaso', 'pulito');
INSERT INTO Orto VALUES('V1KUI1V0', 'Cedri Allegri', '30°03′N 31°14′E', 80, 'in pieno campo', 'pulito');
INSERT INTO Orto VALUES('NDWJA38M', 'Carlo Lippi', '31°38′N 74°52′E ', 60, 'in pieno campo', 'inquinato');

INSERT INTO Orto VALUES('V2QEWUZ2', 'Da Franco', '54°56′S 67°37′W', 10, 'in vaso', 'pulito');
INSERT INTO Orto VALUES('EM9H32SX', 'Cachi e Limoni', '56°50′N 60°35′E', 75, 'in vaso', 'inquinato');

---------

INSERT INTO Specie VALUES('Cucumis Sativus L.', 'Cetriolo');
INSERT INTO Specie VALUES('Lepidium Sativum L.', 'Crescione');
INSERT INTO Specie VALUES('Piantago Lanceolata L', 'Piantaggine');
INSERT INTO Specie VALUES('Brassica Oleracea L.', 'Cavolo');
INSERT INTO Specie VALUES('Brassica napus L.', 'Colza');
INSERT INTO Specie VALUES('Helianthus annuus L.', 'Girasole');
INSERT INTO Specie VALUES('Lavandula sp. pl.', 'Lavanda');
INSERT INTO Specie VALUES('Tagetes sp. pl.', 'Tagete');

---------

INSERT INTO Studia VALUES('V1KUI1V0', 'Cucumis Sativus L.');
INSERT INTO Studia VALUES('V1KUI1V0', 'Brassica Oleracea L.');
INSERT INTO Studia VALUES('V1KUI1V0', 'Tagetes sp. pl.');

INSERT INTO Studia VALUES('NDWJA38M', 'Piantago Lanceolata L');
INSERT INTO Studia VALUES('NDWJA38M', 'Cucumis Sativus L.');
INSERT INTO Studia VALUES('NDWJA38M', 'Lavandula sp. pl.');

INSERT INTO Studia VALUES('V2QEWUZ2', 'Lepidium Sativum L.');
INSERT INTO Studia VALUES('V2QEWUZ2', 'Brassica napus L.');
INSERT INTO Studia VALUES('V2QEWUZ2', 'Helianthus annuus L.');

INSERT INTO Studia VALUES('EM9H32SX', 'Cucumis Sativus L.');
INSERT INTO Studia VALUES('EM9H32SX', 'Brassica napus L.');
INSERT INTO Studia VALUES('EM9H32SX', 'Helianthus annuus L.');

-------

INSERT INTO UsoSpecie VALUES('Cucumis Sativus L.', 'in pieno campo', 'biomonitoraggio', 'sole');
INSERT INTO UsoSpecie VALUES('Lepidium Sativum L.', 'in pieno campo', 'biomonitoraggio', 'mezz''ombra');
INSERT INTO UsoSpecie VALUES('Piantago Lanceolata L', 'in pieno campo', 'biomonitoraggio', 'mezz''ombra');
INSERT INTO UsoSpecie VALUES('Piantago Lanceolata L', 'in vaso', 'biomonitoraggio', 'mezz''ombra-sole');
INSERT INTO UsoSpecie VALUES('Brassica Oleracea L.', 'in vaso', 'biomonitoraggio', 'sole');
INSERT INTO UsoSpecie VALUES('Brassica napus L.', 'in vaso', 'biomonitoraggio', 'sole');
INSERT INTO UsoSpecie VALUES('Helianthus annuus L.', 'in pieno campo', 'fitobonifica', 'sole');
INSERT INTO UsoSpecie VALUES('Lavandula sp. pl.', 'in pieno campo', 'fitobonifica', 'sole');
INSERT INTO UsoSpecie VALUES('Tagetes sp. pl.', 'in pieno campo', 'fitobonifica', 'sole');

-------

INSERT INTO Gruppo VALUES('Cucumis Sativus L.', 'in pieno campo', 'biomonitoraggio', '4B', 'V1KUI1V0', 'Cedri Allegri', 'V1KUI1V0');
INSERT INTO Gruppo VALUES('Cucumis Sativus L.', 'in pieno campo', 'biomonitoraggio', '1C', 'NDWJA38M', 'Carlo Lippi', 'NDWJA38M');

INSERT INTO Gruppo VALUES('Brassica napus L.', 'in vaso', 'biomonitoraggio', '2A', 'V2QEWUZ2', 'Da Franco', 'V2QEWUZ2');
INSERT INTO Gruppo VALUES('Brassica napus L.', 'in vaso', 'biomonitoraggio', '3G', 'EM9H32SX', 'Cachi e Limoni', 'EM9H32SX');

INSERT INTO Gruppo VALUES('Lavandula sp. pl.', 'in pieno campo', 'fitobonifica', '1C', 'NDWJA38M', 'Carlo Lippi', 'NDWJA38M');

-------

INSERT INTO DatiSchedaArduino VALUES('HT6I983G', 800, 20, 40, 2, 900, 10, 100, 1, TRUE);

INSERT INTO DatiSensore VALUES('LSNHDK02KS', 'Paolo Inc.', 'AAA', 10.23, 0.5);

-------

INSERT INTO Modello VALUES ('Scheda ARG2 v2022', 'IC2', 20, 5, 0.2, 'HT6I983G');
INSERT INTO Modello VALUES ('Sensore EasyTime', 'Bluetooth', 5, 5, 0.1, NULL, 'LSNHDK02KS', 'Paolo Inc.');

-------

INSERT INTO Rilevatore VALUES('Cedri Allegri', 'V1KUI1V0', 'Scheda ARG2 v2022');
INSERT INTO Rilevatore VALUES('Carlo Lippi', 'NDWJA38M', 'Sensore EasyTime');
INSERT INTO Rilevatore VALUES('Da Franco', 'V2QEWUZ2', 'Scheda ARG2 v2022');
INSERT INTO Rilevatore VALUES('Cachi e Limoni', 'EM9H32SX', 'Sensore EasyTime');

-------

INSERT INTO Replica VALUES(1, 1, '3-6-2023', 'sole', 1);
INSERT INTO Replica VALUES(2, 1, '4-6-2023', 'sole', 1);

INSERT INTO Replica VALUES(1, 2, '2-6-2023', 'sole', 2);
INSERT INTO Replica VALUES(2, 2, '2-6-2023', 'sole', 2);

INSERT INTO Replica VALUES(1, 3, '1-6-2023', 'sole', 3);

INSERT INTO Replica VALUES(1, 4, '5-6-2023', 'sole', 4);

INSERT INTO Replica VALUES(1, 5, '4-6-2023', 'sole', 2);
INSERT INTO Replica VALUES(2, 5, '4-6-2023', 'sole', 2);
INSERT INTO Replica VALUES(3, 5, '4-6-2023', 'sole', 2);

------

INSERT INTO Responsabile VALUES (NULL, '4B', 'V1KUI1V0');
INSERT INTO Responsabile VALUES (NULL, '1C', 'NDWJA38M');
INSERT INTO Responsabile VALUES (NULL, '2A', 'V2QEWUZ2');
INSERT INTO Responsabile VALUES (NULL, '3G', 'EM9H32SX');
INSERT INTO Responsabile VALUES ('S3ADQ81UOBBZPMJM');
INSERT INTO Responsabile VALUES ('3A80V9KHMK764YAT');
INSERT INTO Responsabile VALUES ('CXX41A77ZJCDW4QG');
INSERT INTO Responsabile VALUES ('RQMOLMA2XZKVPWK6');

------

INSERT INTO Rilevazione VALUES ('Cucumis Sativus L.', 'in pieno campo', 'biomonitoraggio', 
								 '10-6-2023 12:00:00', 'suolo pre-esistente', NULL, 1);
INSERT INTO Rilevazione VALUES ('Cucumis Sativus L.', 'in pieno campo', 'biomonitoraggio', 
								 '11-6-2023 12:00:00', 'suolo pre-esistente', NULL, 5, 1);
INSERT INTO Rilevazione VALUES ('Cucumis Sativus L.', 'in pieno campo', 'biomonitoraggio', 
								 '9-6-2023 12:00:00', 'terriccio da rinvaso', NULL, 5);
								 
INSERT INTO Rilevazione VALUES ('Cucumis Sativus L.', 'in pieno campo', 'biomonitoraggio', 
								 '22-6-2023 12:00:00', 'terriccio da rinvaso', NULL, 2);
INSERT INTO Rilevazione VALUES ('Cucumis Sativus L.', 'in pieno campo', 'biomonitoraggio', 
								 '15-6-2023 12:00:00', 'terriccio da rinvaso', NULL, 2);
INSERT INTO Rilevazione VALUES ('Cucumis Sativus L.', 'in pieno campo', 'biomonitoraggio', 
								 '18-6-2023 12:00:00', 'suolo pre-esistente', NULL, 6);
								 
INSERT INTO Rilevazione VALUES ('Brassica napus L.', 'in vaso', 'biomonitoraggio', 
								 '12-6-2023 12:00:00', 'terriccio da rinvaso', NULL, 3);
INSERT INTO Rilevazione VALUES ('Brassica napus L.', 'in vaso', 'biomonitoraggio', 
								 '14-6-2023 12:00:00', 'terriccio da rinvaso', NULL, 7);
INSERT INTO Rilevazione VALUES ('Brassica napus L.', 'in vaso', 'biomonitoraggio', 
								 '14-6-2023 12:00:00', 'suolo pre-esistente', NULL, 7);
					
INSERT INTO Rilevazione VALUES ('Brassica napus L.', 'in vaso', 'biomonitoraggio', 
								 '15-6-2023 12:00:00', 'suolo pre-esistente', NULL, 4);
INSERT INTO Rilevazione VALUES ('Brassica napus L.', 'in vaso', 'biomonitoraggio', 
								 '18-6-2023 12:00:00', 'terriccio da rinvaso', NULL, 8);
		
INSERT INTO Rilevazione VALUES ('Lavandula sp. pl.', 'in pieno campo', 'fitobonifica', 
								 '21-6-2023 12:00:00', 'suolo pre-esistente', 'suolo', 4); 
INSERT INTO Rilevazione VALUES ('Lavandula sp. pl.', 'in pieno campo', 'fitobonifica', 
								 '23-6-2023 12:00:00', 'suolo pre-esistente', 'suolo', 4); 
INSERT INTO Rilevazione VALUES ('Lavandula sp. pl.', 'in pieno campo', 'fitobonifica', 
								 '26-6-2023 12:00:00', 'suolo pre-esistente', 'suolo', 4); 
-- controllare vincolo su cosa monitorato
							
-----------								 

INSERT INTO Misurazione VALUES (1, 1, 1, '9-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (2, 1, 1, '10-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (3, 1, 1, '7-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (4, 1, 1, '12-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (5, 1, 1, '11-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (6, 1, 1, '13-7-2023 10:00:00', 'app', 14, 34, 67, 78, 3, 4, 4,
							    31, 10, 11, 34, 38, 68, 20, 35);
								
INSERT INTO Misurazione VALUES (1, 2, 1, '9-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (2, 2, 1, '10-7-2023 10:00:00', 'direttamente da scheda', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (3, 2, 1, '7-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (4, 2, 1, '12-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (5, 2, 1, '11-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (6, 2, 1, '13-7-2023 10:00:00', 'app', 14, 34, 67, 78, 3, 4, 4,
							    31, 10, 11, 34, 38, 68, 20, 35);

INSERT INTO Misurazione VALUES (1, 1, 2, '9-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (2, 1, 2, '10-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (3, 1, 2, '7-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (4, 1, 2, '12-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (5, 1, 2, '11-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (6, 1, 2, '13-7-2023 10:00:00', 'app', 14, 34, 67, 78, 3, 4, 4,
							    31, 10, 11, 34, 38, 68, 20, 35);

INSERT INTO Misurazione VALUES (1, 2, 2, '9-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (2, 2, 2, '10-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (3, 2, 2, '7-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (4, 2, 2, '12-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (5, 2, 2, '11-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (6, 2, 2, '13-7-2023 10:00:00', 'app', 14, 34, 67, 78, 3, 4, 4,
							    31, 10, 11, 34, 38, 68, 20, 35);
								
INSERT INTO Misurazione VALUES (7, 1, 3, '9-7-2023 10:00:00', 'app', 44, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (8, 1, 3, '10-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (9, 1, 3, '7-7-2023 10:00:00', 'app', 64, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (10, 1, 3, '12-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (11, 1, 3, '11-7-2023 10:00:00', 'app', 25, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);

INSERT INTO Misurazione VALUES (7, 1, 4, '9-7-2023 10:00:00', 'app', 64, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (8, 1, 4, '10-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (9, 1, 4, '7-7-2023 10:00:00', 'app', 34, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (10, 1, 4, '12-7-2023 10:00:00', 'app', 24, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);
INSERT INTO Misurazione VALUES (11, 1, 4, '11-7-2023 10:00:00', 'app', 44, 18, 7, 10, 1, 0, 0,
							    30, 10, 9, 19, 39, 78, 30, 5);

INSERT INTO Misurazione VALUES (13, 2, 5, '11-7-2023 10:00:00', 'app', 20, 20, 20, 20, 20, 20, 20,
							    20, 20, 20, 20, 20, 20, 20, 20);
INSERT INTO Misurazione VALUES (12, 2, 5, '13-7-2023 10:00:00', 'app', 10, 10, 10, 10, 10, 10, 10,
							    10, 10, 10, 10, 10, 10, 10, 10);


								
INSERT INTO Misurazione VALUES (12, 1, 5, '11-7-2023 10:00:00', 'app', 10, 10, 10, 10, 10, 10, 10,
							    10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Misurazione VALUES (13, 1, 5, '15-7-2023 10:00:00', 'app', 20, 20, 20, 20, 20, 20, 20,
							    20, 20, 20, 20, 20, 20, 20, 20);
INSERT INTO Misurazione VALUES (14, 1, 5, '17-7-2023 10:00:00', 'app', 50, 50, 50, 50, 50, 50, 50,
							    50, 50, 50, 50, 50, 50, 50, 50);

INSERT INTO Misurazione VALUES (12, 3, 5, '13-7-2023 10:00:00', 'app', 10, 10, 10, 10, 10, 10, 10,
							    10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Misurazione VALUES (13, 3, 5, '11-7-2023 10:00:00', 'app', 20, 20, 20, 20, 20, 20, 20,
							    20, 20, 20, 20, 20, 20, 20, 20);
INSERT INTO Misurazione VALUES (14, 3, 5, '13-7-2023 10:00:00', 'app', 10, 10, 10, 10, 10, 10, 10,
							    10, 10, 10, 10, 10, 10, 10, 10);

								
-------

SELECT AssociaGruppi(2, 1);
SELECT AssociaGruppi(4, 3);

-------




















