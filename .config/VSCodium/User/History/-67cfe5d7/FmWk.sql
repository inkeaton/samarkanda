set search_path to "orti1";

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
INSERT INTO Orto VALUES('NDWJA38M', 'Carlo Lippi', '31°38′N 74°52′E ', 60, 'in pieno campo', 'inquinato');
INSERT INTO Orto VALUES('V1KUI1V0', 'Cedri Allegri', '30°03′N 31°14′E', 80, 'in pieno campo', 'pulito');
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
INSERT INTO Studia VALUES('NDWJA38M', 'Lavandula sp. pl.');

INSERT INTO Studia VALUES('V2QEWUZ2', 'Lepidium Sativum L.');
INSERT INTO Studia VALUES('V2QEWUZ2', 'Brassica napus L.');
INSERT INTO Studia VALUES('V2QEWUZ2', 'Helianthus annuus L.');

INSERT INTO Studia VALUES('EM9H32SX', 'Cucumis Sativus L.');
INSERT INTO Studia VALUES('EM9H32SX', 'Brassica Oleracea L.');
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

INSERT INTO Gruppo VALUES()















