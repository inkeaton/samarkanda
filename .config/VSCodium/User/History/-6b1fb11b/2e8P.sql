---------------------------------------- CARICO DI LAVORO -----------------------------------------

/*
 Riporta il nome degli istituti situati in provincia di Genova o Savona disposti a collaborare con altri istituti
 */

SELECT nome
FROM Istituto
WHERE (provincia = 'GE' OR provincia = 'SV') AND
       collabora = TRUE;

/*
 Riporta per ogni classe nome e cognome del suo docente di riferimento
 */

SELECT Classe.nome, Classe.scuola, Persona.nome, Persona.cognome
FROM Classe JOIN Persona
            ON Classe.docente = Persona.cf;

/*
 Riporta per ogni referente il tipo di scuola a cui appartiene
 */

 SELECT ReferenteScuola.cm, Scuola.tipo
 FROM ReferenteScuola JOIN Scuola 
                      ON Scuola.cm = ReferenteScuola.scuola;

---------------------------------------- SCHEMA FISICO -----------------------------------------