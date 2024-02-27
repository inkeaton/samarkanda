
SET search_path TO "orti1";

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


-- 1.

CREATE INDEX finanziamento_entità
ON Finanziamento (entità);

CLUSTER Finanziamento 
USING finanziamento_entità;

/* BEFORE : SEQ SCAN */
/* AFTER : INDEX SCAN */


-- 2.

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




-- 3.


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

GRANT USAGE ON SCHEMA orti1 TO Studente;
GRANT USAGE ON SCHEMA orti1 TO Docente;
GRANT USAGE ON SCHEMA orti1 TO ReferenteScuola;
GRANT USAGE ON SCHEMA orti1 TO ReferenteIstituto;
GRANT USAGE ON SCHEMA orti1 TO GestoreGlobaleDelProgetto;

/*
 Privilegi di SELECT a Studente 
 */

GRANT SELECT
ON orti1.AssociatoA,
orti1.Classe,
orti1.DatiSchedaArduino,
orti1.DatiSensore,
orti1.Gruppo,
orti1.Misurazione,
orti1.Modello,
orti1.Orto,
orti1.Replica,
orti1.Responsabile,
orti1.Rilevatore,
orti1.Rilevazione,
orti1.Scuola,
orti1.Specie,
orti1.Studente,
orti1.Studia,
orti1.UsoSpecie
TO Studente;

/*
 Privilegi di SELECT a ReferenteScuola, GestoreGlobale
 */

GRANT SELECT ON 
orti1.associatoa,
orti1.replica,
orti1.rilevazione,
orti1.misurazione,
orti1.gruppo,
orti1.responsabile,
orti1.rilevatore,
orti1.studente,
orti1.classe,
orti1.orto,
orti1.studia,
orti1.ciclo,
orti1.finanziamento,
orti1.referentescuola,
orti1.referenteistituto,
orti1.scuola,
orti1.datischedaarduino,
orti1.datisensore,
orti1.istituto,
orti1.specie,
orti1.usospecie,
orti1.modello,
orti1.persona
TO ReferenteScuola,GestoreGlobaleDelProgetto;

/*
 Privilegi di INSERT a Studente 
 */
GRANT USAGE ON SEQUENCE orti1.responsabile_id_seq TO studente;
GRANT USAGE ON SEQUENCE orti1.rilevazione_id_seq TO studente;

GRANT INSERT
ON 
orti1.Misurazione,
orti1.Responsabile,
orti1.Rilevazione
TO Studente;

/*
 Eredità
 */

GRANT ReferenteScuola to ReferenteIstituto;
GRANT Studente to Docente;

/*
 Privilegi completi a Docente 
 */
GRANT USAGE ON SEQUENCE orti1.gruppo_id_seq TO docente;
GRANT USAGE ON SEQUENCE orti1.replica_id_seq TO docente;
GRANT USAGE ON SEQUENCE orti1.responsabile_id_seq TO docente;
GRANT USAGE ON SEQUENCE orti1.rilevazione_id_seq TO docente;
GRANT USAGE ON SEQUENCE orti1.rilevatore_id_seq TO docente;

GRANT ALL PRIVILEGES
ON 
orti1.AssociatoA,
orti1.Gruppo,
orti1.Misurazione,
orti1.Replica,
orti1.Responsabile,
orti1.Rilevatore,
orti1.Rilevazione,
orti1.Studente
TO Docente;

/*
 Privilegi di SELECT a Docente 
 */

GRANT SELECT
ON
orti1.Istituto,
orti1.Persona,
orti1.ReferenteScuola
TO Docente;

/*
 Privilegi completi a ReferenteScuola 
 */

GRANT ALL PRIVILEGES
ON 
orti1.Classe,
orti1.Orto,
orti1.Studia
TO ReferenteScuola;

/*
 Privilegi completi a ReferenteIstituto 
 */

GRANT ALL PRIVILEGES
ON 
orti1.Ciclo,
orti1.Finanziamento,
orti1.ReferenteScuola,
orti1.Scuola
TO ReferenteIstituto;

/*
 Privilegi completi a GestoreGlobale 
 */

GRANT ALL PRIVILEGES
ON 
orti1.DatiSchedaArduino,
orti1.DatiSensore,
orti1.Istituto,
orti1.Modello,
orti1.Persona,
orti1.ReferenteIstituto, 
orti1.Specie,
orti1.UsoSpecie
TO ReferenteIstituto;

/*
 creazione utenti ed assegnazione ruoli
*/

CREATE USER alice PASSWORD 'alice';
GRANT Studente to alice;

CREATE USER bob PASSWORD 'bob';
GRANT Docente to bob;

CREATE USER carl PASSWORD 'carl';
GRANT ReferenteScuola to carl;

CREATE USER dennis PASSWORD 'dennis';
GRANT ReferenteIstituto to dennis;

CREATE USER edward PASSWORD 'edward';
GRANT GestoreGlobaleDelProgetto to edward;

