---------------------------------------- CARICO DI LAVORO -----------------------------------------

/*
 Riporta il nome degli istituti situati in provincia di Genova o Savona disposti a collaborare con altri istituti
 */

SELECT nome
FROM Istituto
WHERE (provincia = 'GE' OR provincia = 'SV') AND
      collabora = TRUE;

/*
 Riporta la provincia in cui si trova ognuna delle scuole partecipanti al progetto
 */

SELECT Scuola.cm, Istituto.provincia
FROM Scuola NATURAL JOIN Istituto