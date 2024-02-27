
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

/*
 Creazione Ruoli
 */

CREATE ROLE Studente;
CREATE ROLE Docente;
CREATE ROLE ReferenteScuola;
CREATE ROLE ReferenteIstituto;
CREATE ROLE GestoreGlobaleDelProgetto;


/*
 Privilegi di SELECT a Studente 
 */

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

/*
 Privilegi di SELECT a ReferenteScuola, GestoreGlobale
 */


GRANT SELECT ON 
associatoa,
replica,
rilevazione,
misurazione,
gruppo,
responsabile,
rilevatore,
studente,
classe,
orto,
studia,
ciclo,
finanziamento,
referentescuola,
scuola,
datischedaarduino,
datisensore,
istituto,
specie,
usospeci,
modello,
persona
TO ReferenteScuola,GestoreGlobaleDelProgetto

/*
 Privilegi di INSERT a Studente 
 */

GRANT INSERT
ON 
Misurazione,
Responsabile,
Rilevazione
TO Studente;

/*
 Eredità
 */

GRANT ReferenteScuola to ReferenteIstituto;
GRANT Studente to Docente;

/*
 Privilegi completi a Docente 
 */
 
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

/*
 Privilegi di SELECT a Docente 
 */

GRANT SELECT
ON
Istituto,
Persona,
ReferenteScuola
TO Docente;

/*
 Privilegi completi a ReferenteScuola 
 */

GRANT ALL PRIVILEGES
ON 
Classe,
Orto,
Studia
TO ReferenteScuola;

/*
 Privilegi completi a ReferenteIstituto 
 */

GRANT ALL PRIVILEGES
ON 
Ciclo,
Finanziamento,
ReferenteScuola,
Scuola
TO ReferenteIstituto;

/*
 Privilegi completi a GestoreGlobale 
 */

GRANT ALL PRIVILEGES
ON 
DatiSchedaArduino,
DatiSensore,
Istituto,
Modello,
Persona,
ReferenteIstituto, 
Specie,
UsoSpecie
TO ReferenteIstituto;

/*
 creazione utenti ed assegnazione ruoli
*/

CREATE USER alice PASSWORD'alice';
GRANT Studente to alice;

CREATE USER bob PASSWORD'bob';
GRANT Docente to bob;

CREATE USER carl PASSWORD'carl';
GRANT ReferenteScuola to carl;

CREATE USER dennis PASSWORD'dennis';
GRANT ReferenteIstituto to dennis;

CREATE USER edward PASSWORD'edward';
GRANT GestoreGlobaleDelProgetto to edward;

