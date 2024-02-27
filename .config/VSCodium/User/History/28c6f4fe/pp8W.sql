
-------------------------------------- CREAZIONE SCHEMA -----------------------------------

create schema "orti1";
set search_path to "orti1";


CREATE TABLE Persona (
                         cf char(16) PRIMARY KEY,
                         nome varchar(20) NOT NULL,
                         cognome varchar(20) NOT NULL,
                         email varchar(20) NOT NULL,
                         ruolo varchar(20) NOT NULL,
                         n_telefono numeric(11),
                         CHECK((n_telefono IS NULL) OR (n_telefono > 0))
);

CREATE TABLE Istituto (
                          cm_i char(8) PRIMARY KEY,
                          nome varchar(20) NOT NULL,
                          provincia char(2) NOT NULL,
                          collabora boolean NOT NULL
                              DEFAULT FALSE
);

CREATE TABLE ReferenteIstituto(
                                  cf char(16) PRIMARY KEY
                                      REFERENCES Persona (cf),
                                  istituto char(8) NOT NULL
                                      REFERENCES Istituto (cm_i)
);

CREATE TABLE Finanziamento (
                               istituto char(8) PRIMARY KEY
                                   REFERENCES Istituto (cm_i),
                               progetto varchar(20) NOT NULL,
                               entità decimal(6,2) NOT NULL,
                               CHECK(entità>0)
);

CREATE TABLE Ciclo (
                       tipo varchar(20) PRIMARY KEY,
                       ciclo varchar(10) NOT NULL,
                       CHECK(ciclo IN ('primo', 'secondo'))
);

CREATE TABLE Scuola (
                        cm char(8) PRIMARY KEY,
                        cm_i char(8) NOT NULL
                            REFERENCES Istituto (cm_i),
                        nome varchar(20) NOT NULL,
                        tipo varchar(20) NOT NULL
                            REFERENCES Ciclo (tipo),
                        UNIQUE (nome, cm_i)
);

CREATE TABLE ReferenteScuola(
                                cf char(16) PRIMARY KEY
                                    REFERENCES Persona (cf),
                                scuola char(8) NOT NULL
                                    REFERENCES Scuola (cm),
                                partecipante boolean DEFAULT FALSE
);

CREATE TABLE Classe (
                        nome char(2) NOT NULL,
                        scuola char(8) REFERENCES Scuola (cm),
                        docente char(16) UNIQUE
                                         NOT NULL
                                         REFERENCES Persona (cf),
                        PRIMARY KEY(scuola, nome)
);

CREATE TABLE Studente(
                         cf char(16) PRIMARY KEY
                             REFERENCES Persona (cf),
                         classe char(2) NOT NULL,
                         scuola char(8) NOT NULL,
                         FOREIGN KEY (classe, scuola)
                             REFERENCES Classe (nome, scuola)
);

CREATE TABLE Responsabile (
                              id serial PRIMARY KEY,
                              studente_rappr char(16) REFERENCES Studente (cf),
                              classe_nome_rappr char(2),
                              classe_scuola_rappr char(8),
                              FOREIGN KEY (classe_nome_rappr, classe_scuola_rappr)
                                  REFERENCES Classe (nome, scuola),
                              CHECK((studente_rappr IS NULL AND classe_nome_rappr IS NOT NULL AND classe_scuola_rappr IS NOT NULL)OR
                                    (studente_rappr IS NOT NULL AND classe_nome_rappr IS NULL AND classe_scuola_rappr IS NULL))
);

CREATE TABLE Orto (
                      scuola char(8) REFERENCES Scuola (cm),
                      nome varchar(20),
    -- Da rivedere, ora usa il formato gradi, minuti secondi
    -- es, 41°24'12.2"N 2°10'26.5"E
                      GPS_coord varchar(30) NOT NULL
                                            UNIQUE,
                      superficie decimal(6,0) NOT NULL,
                      tipo_colt varchar(14) NOT NULL,
                      ambiente varchar(9) NOT NULL,
                      PRIMARY KEY (scuola, nome),
                      CHECK(tipo_colt in ('in vaso', 'in pieno campo')),
                      CHECK(ambiente in ('pulito', 'inquinato')),
                      CHECK(superficie > 0)
);

CREATE TABLE Specie (
                        nome_s varchar(20) PRIMARY KEY,
                        nome_c varchar(20) NOT NULL
);

CREATE TABLE Studia (
                        scuola char(8) REFERENCES Scuola (cm),
                        specie varchar(20) REFERENCES Specie (nome_s),
                        PRIMARY KEY (scuola, specie)
);

CREATE TABLE UsoSpecie (
                           specie varchar(20) REFERENCES Specie (nome_s),
                           tipo_colt varchar(14),
                           scopo varchar(15),
                           esposizioni varchar(17) NOT NULL,
                           PRIMARY KEY (specie, tipo_colt, scopo),
                           CHECK(tipo_colt in ('in vaso', 'in pieno campo') ),
                           CHECK(scopo in ('fitobonifica', 'biomonitoraggio') ),
                           CHECK(esposizioni in ('sole','ombra','mezz''ombra','sole,mezz''ombra'))
);

CREATE TABLE Gruppo (
                        id serial PRIMARY KEY,
                        specie varchar(20) NOT NULL,
                        tipo_colt varchar(14) NOT NULL,
                        scopo varchar(15) NOT NULL,
                        classe char(2) NOT NULL,
                        scuola char(8) NOT NULL,
                        orto varchar(20) NOT NULL,
                        FOREIGN KEY (orto, scuola)
                            REFERENCES Orto (nome, scuola),
                        FOREIGN KEY (specie, tipo_colt, scopo)
                            REFERENCES UsoSpecie (specie, tipo_colt, scopo),
                        FOREIGN KEY (classe, scuola)
                            REFERENCES Classe (nome, scuola)
);

CREATE TABLE AssociatoA (
                            gruppo_stress integer PRIMARY KEY
                                REFERENCES Gruppo (id),
                            gruppo_controllo integer UNIQUE
                                                     NOT NULL
                                                     REFERENCES Gruppo (id)
);

CREATE TABLE DatiSchedaArduino (
                                   SKU char(8) PRIMARY KEY,
                                   max_pressione decimal(4,0) NOT NULL,
                                   min_pressione decimal(4,0) NOT NULL,
                                   max_umidità decimal(4,0) NOT NULL,
                                   min_umidità decimal(4,0) NOT NULL,
                                   min_luminosità decimal(4,0) NOT NULL,
                                   max_luminosità decimal(4,0) NOT NULL,
                                   max_temperatura decimal(4,0) NOT NULL,
                                   min_temperatura decimal(4,0) NOT NULL,
                                   micro_sd boolean NOT NULL
);

CREATE TABLE DatiSensore(
                            n_modello char(10),
                            produttore varchar(20),
                            tipo_batteria varchar(5) NOT NULL,
                            PRIMARY KEY(n_modello, produttore)
);

CREATE TABLE Modello(
                        nome varchar(20) PRIMARY KEY,
                        tipo_comunicazione varchar(6) NOT NULL,
                        larghezza decimal(2,2) NOT NULL,
                        lunghezza decimal(2,2) NOT NULL,
                        altezza decimal(2,2) NOT NULL,
                        SKU_scheda char(8) REFERENCES DatiSchedaArduino (SKU),
                        n_sensore char(10),
                        prod_sensore varchar(20),
                        FOREIGN KEY (n_sensore, prod_sensore)
                            REFERENCES DatiSensore (n_modello, produttore),
    -- dare nomi ai check
                        CHECK((SKU_scheda IS NULL AND n_sensore IS NOT NULL AND prod_sensore IS NOT NULL) OR
                              (SKU_scheda IS NOT NULL AND n_sensore IS NULL AND prod_sensore IS NULL)),
                        CHECK(tipo_comunicazione IN ('app','scheda'))
);

CREATE TABLE Rilevatore(
                           id serial PRIMARY KEY,
                           orto varchar(20) NOT NULL,
                           scuola char(8) NOT NULL,
                           modello varchar(20) NOT NULL
                               REFERENCES Modello (nome),
                           FOREIGN KEY (orto, scuola)
                               REFERENCES Orto (nome, scuola)
);

CREATE TABLE Replica (
                         id serial,
                         gruppo integer REFERENCES Gruppo (id), --ON CASCADE?
                         data_piantata date NOT NULL
                             DEFAULT CURRENT_DATE,
                         esposizione varchar(15) NOT NULL,
                         rilevatore integer NOT NULL
                             REFERENCES Rilevatore(id),
                         PRIMARY KEY (id, gruppo),
                         CHECK(esposizione in ('sole','ombra','mezz''ombra','sole,mezz''ombra'))

);

CREATE TABLE Rilevazione (
                             id serial PRIMARY KEY,
                             specie varchar(20) NOT NULL,
                             tipo_colt varchar(14) NOT NULL,
                             scopo varchar(15) NOT NULL,
                             timestamp_inserimento timestamp NOT NULL
                                 DEFAULT CURRENT_TIMESTAMP,
                             tipo_substrato varchar(20) NOT NULL,
                             cosa_monitorato varchar(5),
                             resp_rilevazione integer NOT NULL
                                 REFERENCES Responsabile (id),
                             resp_inserimento integer REFERENCES Responsabile (id),
                             FOREIGN KEY (specie, tipo_colt, scopo)
                                 REFERENCES UsoSpecie (specie, tipo_colt, scopo),
                             CHECK((resp_inserimento IS NULL) OR (resp_rilevazione != resp_inserimento)),
                             CHECK(tipo_substrato IN ('terriccio da rinvaso','suolo pre-esistente')),
                             CHECK((cosa_monitorato IS NULL AND (scopo = 'biomonitoraggio')) OR
                                   ((cosa_monitorato IN ('suolo','aria')) AND (scopo = 'fitobonifica')))
);

CREATE TABLE Misurazione (
                             n_rilevazione integer NOT NULL
                                 REFERENCES Rilevazione (id),
                             n_replica integer NOT NULL,
                             gruppo integer NOT NULL,
                             timestamp_misurazione timestamp NOT NULL
                                 DEFAULT CURRENT_TIMESTAMP,
                             modalità_mem varchar(20) NOT NULL,
                             temperatura decimal(2,2) NOT NULL,
                             umidità decimal(2,2) NOT NULL,
                             pH decimal(2,1) NOT NULL,
                             perc_sup_danneggiata decimal (2,0) NOT NULL,
                             n_foglie_danneggiate decimal(3) NOT NULL,
                             n_frutti decimal(3) NOT NULL,
                             n_fiori decimal(3) NOT NULL,
                             lunghezza_chioma_foglie decimal(3,2) NOT NULL,
                             larghezza_chioma_foglie decimal(3,2) NOT NULL,
                             peso_fresco_chioma_foglie decimal(3,2),
                             peso_secco_chioma_foglie decimal(3,2) NOT NULL,
                             peso_fresco_radice decimal(3,2) NOT NULL,
                             peso_secco_radice decimal(3,2) NOT NULL,
                             altezza decimal(3,2) NOT NULL,
                             lunghezza_radice decimal(3,2) NOT NULL,
                             FOREIGN KEY (n_replica, gruppo)
                                 REFERENCES Replica (id, gruppo),
                             PRIMARY KEY (n_rilevazione, n_replica, gruppo)
);


----------------------------------------- POPOLAZIONE -------------------------------------

/*
INSERT INTO Persona VALUES('FSKCOBEOYHSOSIDC', 'Carlo', 'Panuozzi', 'yN9SLExx1vl', 'docente', 15106098555);
INSERT INTO Persona VALUES('JPR5GPJ3Q5CKDPC7', 'Marco', 'Verdi', 'v31ZNZE2YxJ', 'docente', 44172291746);
INSERT INTO Persona VALUES('ETK1UFHH9N3K8R63', 'Giovanni', 'Rossi', 'JazzFQLiLR5', 'docente', 94324974324);
INSERT INTO Persona VALUES('ZZE0GR0LWZ3RGE21', 'Bob', 'Ubish', 'bocWNLXBF0N', 'docente', 36298438641);
INSERT INTO Persona VALUES('YI5UQ1D9DN81T3SY', 'Jean', 'Ammy', 'qbBdVmjAGzj', 'preside', 88472412499);
INSERT INTO Persona VALUES('OXR53FBUQ6W77AE8', 'Gennaro', 'Pavarotti', 'WWAdguzb6do', 'studente', 08551144035);
INSERT INTO Persona VALUES('W7BXYC1JR7XLUHQG', 'Karl', 'Marx', 'B8LIu5d7ep7', 'studente');
INSERT INTO Persona VALUES('XUS9CXK3NEJICZO2', 'Thomas', 'Kei', 'efsxzIaFWz6', 'studente', 03610881871);
INSERT INTO Persona VALUES('1EW1IRBUHZQ3UCXT', 'May', 'Parker', 'alcmeomfinve', 'studente');
INSERT INTO Persona VALUES('G1ANJFGTYB0LDZ99', 'Arun', 'Mathiyalakhan', 'ZnXAMUFn420', 'studente');
*/

