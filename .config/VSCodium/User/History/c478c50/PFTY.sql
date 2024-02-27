
---------------------------------------- CARICO DI LAVORO -----------------------------------------

/*
 Riporta gli istituti partecipanti ai progetto Pon EduGreen e Sviluppo Base Dati che hanno ricevuto un
 finanziamento superiore a 1000€ 
 */

SELECT istituto, progetto
FROM Finanziamento
WHERE (progetto = 'PON EduGreen' OR progetto = 'Sviluppo Base Dati') AND
       entità > 1000;

/*
 Riporta i codici fiscali delle Persone chiamate John
 */

SELECT cf
FROM Persona
WHERE nome = 'John';

/*
 Riporta per ogni referente il tipo di scuola per cui riferiscono
 */

 SELECT ReferenteScuola.scuola, Scuola.tipo
 FROM ReferenteScuola JOIN Scuola 
                      ON Scuola.cm = ReferenteScuola.scuola;

---------------------------------------- SCHEMA FISICO -----------------------------------------

/*
 1.
 */

CREATE INDEX finanziamento_entità
ON Finanziamento (entità);

CLUSTER Finanziamento 
USING finanziamento_entità;

/* BEFORE : SEQ SCAN */
/* AFTER : INDEX SCAN */

/*
 2.
 */

/*
 * INDICE HASH
 */

CREATE INDEX persona_nome
ON Persona 
USING HASH (nome);

/* BEFORE : SEQ SCAN */
/* AFTER : BITMAP HEAP SCAN + BITMAP INDEX SCAN */


/*
 * INDICE ORDINATO, NON USATO

CREATE INDEX persona_nome
ON Persona 
USING HASH (nome);

CLUSTER Persona 
USING persona_nome;
*/



/*
 3.
 */

/*
 Non è stata necessaria alcuna modifica allo schema fisico della base di dati per effettuare 
 l'interrogazione nel modo ottimale
 */

---------------------------------------- POLITICA D'ACCESSO -----------------------------------------

set search_path to "test1";
/*
CREATE ROLE Studente;
CREATE ROLE Docente;
CREATE ROLE ReferenteScuola;
CREATE ROLE ReferenteIstituto;
CREATE ROLE GestoreGlobaleDelProgetto;
*/
/*============= SELECT Studente ==============*/
GRANT SELECT
ON AssociatoA,
Classe,
DatiSchedaArduino,
DatiSensore,
Gruppo,
Misurazione,
Modello,
Orto,
Replica,
Responsabile,
Rilevatore,
Rilevazione,
Scuola,
Specie,
Studente,
Studia,
UsoSpecie
TO Studente;

/*no docente e no Referente d’Istituto pk eredità */
/*============= SELECT ReferenteScuola,GestoreGlobaleDelProgetto ==============*/

/*
DECIDERE COME FARE; fare funzione?


GRANT SELECT ON 
(SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'test1'
AND table_type = 'BASE TABLE';)
TO ReferenteScuola,GestoreGlobaleDelProgetto
*/

/*============= INSERT Studente ==============*/
GRANT INSERT
ON 
Misurazione,
Responsabile,
Rilevazione
TO Studente;


/*============= eredità ==============*/


GRANT ReferenteScuola to ReferenteIstituto;
GRANT Studente to Docente;




/*============= ALL Docente ==============*/
GRANT ALL PRIVILEGES
ON 
AssociatoA,
Gruppo,
Misurazione,
Replica,
Responsabile,
Rilevatore,
Rilevazione,
Studente
TO Docente;
/*============= SELECT Docente ==============*/
GRANT SELECT
ON
Istituto,
Persona,
ReferenteScuola
TO Docente;



/*============= ALL ReferenteScuola ==============*/
GRANT ALL PRIVILEGES
ON 
Classe,
Orto,
Studia
TO ReferenteScuola;



/*============= ALL ReferenteIstituto ==============*/
GRANT ALL PRIVILEGES
ON 
Ciclo,
Finanziamento,
ReferenteScuola,
... (19 righe a disposizione)
Riduci
GRANT.sql
2 KB
﻿
set search_path to "test1";
/*
CREATE ROLE Studente;
CREATE ROLE Docente;
CREATE ROLE ReferenteScuola;
CREATE ROLE ReferenteIstituto;
CREATE ROLE GestoreGlobaleDelProgetto;
*/
/*============= SELECT Studente ==============*/
GRANT SELECT
ON AssociatoA,
Classe,
DatiSchedaArduino,
DatiSensore,
Gruppo,
Misurazione,
Modello,
Orto,
Replica,
Responsabile,
Rilevatore,
Rilevazione,
Scuola,
Specie,
Studente,
Studia,
UsoSpecie
TO Studente;

/*no docente e no Referente d’Istituto pk eredità */
/*============= SELECT ReferenteScuola,GestoreGlobaleDelProgetto ==============*/

/*
DECIDERE COME FARE; fare funzione?


GRANT SELECT ON 
(SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'test1'
AND table_type = 'BASE TABLE';)
TO ReferenteScuola,GestoreGlobaleDelProgetto
*/

/*============= INSERT Studente ==============*/
GRANT INSERT
ON 
Misurazione,
Responsabile,
Rilevazione
TO Studente;


/*============= eredità ==============*/


GRANT ReferenteScuola to ReferenteIstituto;
GRANT Studente to Docente;




/*============= ALL Docente ==============*/
GRANT ALL PRIVILEGES
ON 
AssociatoA,
Gruppo,
Misurazione,
Replica,
Responsabile,
Rilevatore,
Rilevazione,
Studente
TO Docente;
/*============= SELECT Docente ==============*/
GRANT SELECT
ON
Istituto,
Persona,
ReferenteScuola
TO Docente;



/*============= ALL ReferenteScuola ==============*/
GRANT ALL PRIVILEGES
ON 
Classe,
Orto,
Studia
TO ReferenteScuola;



/*============= ALL ReferenteIstituto ==============*/
GRANT ALL PRIVILEGES
ON 
Ciclo,
Finanziamento,
ReferenteScuola,
Scuola
TO ReferenteIstituto;



/*============= ALL GestoreGlobaleDelProgetto ==============*/

GRANT ALL PRIVILEGES
ON 
DatiSchedaArduino,
DatiSensore,
Istituto,
Modello,
Persona,
/*ReferenteIstituto, /*NON ESISTE*/ */
Specie,
UsoSpecie
TO ReferenteIstituto;

/*
 creazione utenti ed assegnazione ruoli
*/


CREATE USER alice PASSWORD'12345678';
GRANT Studente to alice;

CREATE USER bob PASSWORD'87654321';
GRANT Docente to bob;

CREATE USER carl PASSWORD'18273645';
GRANT ReferenteScuola to carl;

CREATE USER dennis PASSWORD'81726354';
GRANT ReferenteIstituto to dennis;

CREATE USER edward PASSWORD'54637281';
GRANT GestoreGlobaleDelProgetto to edward;

