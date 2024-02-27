----------------------------------------- INTERROGAZIONI -------------------------------------

/*
determinare le scuole che, pur avendo un finanziamento per il progetto,
non hanno inserito rilevazioni in questo anno scolastico
*/

/*SELECT Scuola.cm AS scuola
FROM Scuola JOIN Finanziamento ON Scuola.cm_i = Finanziamento.istituto
MINUS
( SELECT Studente.scuola
  FROM Responsabile JOIN Studente ON Responsabile.studente_rappr = Studente.cf
  UNION
  SELECT Classe.scuola
  FROM Responsabile JOIN Classe ON Responsabile.classe_nome_rappr = Classe.nome AND
 								   Responsabile.classe_scuola_rappr = Classe.scuola )*/

/*
determinare le specie utilizzate in tutti i comuni in cui ci sono scuole aderenti al progetto;
*/

/*
SELECT Studia.specie
FROM Studia JOIN Scuola ON Studia.scuola = Scuola.cm
			JOIN Istituto ON Scuola.cm_i = Istituto.cm_i
GROUP BY Studia.specie
HAVING COUNT(DISTINCT Istituto.provincia) = (SELECT COUNT(DISTINCT provincia)
											  FROM Istituto)
*/

/*
determinare per ogni scuola l’individuo/la classe della scuola che ha effettuato più rilevazioni
*/

--- DA FINIRE ---

/*
SELECT q.scuola, MAX(q.count)
FROM (
	SELECT Studente.scuola, Responsabile.id, COUNT(*)
	FROM Rilevazione JOIN Responsabile ON Rilevazione.resp_rilevazione = Responsabile.id
					 JOIN Studente ON Responsabile.studente_rappr = Studente.cf
	GROUP BY Responsabile.id, Studente.scuola
	UNION
	SELECT Classe.scuola, Responsabile.id, COUNT(*)
	FROM Rilevazione JOIN Responsabile ON Rilevazione.resp_rilevazione = Responsabile.id
					 JOIN Classe ON Responsabile.classe_nome_rappr = Classe.nome AND
									Responsabile.classe_scuola_rappr = Classe.scuola
	GROUP BY Responsabile.id, Classe.scuola
	) AS q
GROUP BY q.scuola
*/

----------------------------------------- VISTA -------------------------------------

/*
La definizione di una vista che fornisca alcune informazioni riassuntive per ogni attività di biomonitoraggio: per
ogni gruppo e per il corrispondente gruppo di controllo mostrare il numero di piante, la specie, l’orto in cui è
posizionato il gruppo e, su base mensile, il valore medio dei parametri ambientali e di crescita delle piante (se-
lezionare almeno tre parametri, quelli che si ritengono più significativi).
*/

/*
CREATE VIEW biomonitoraggio_questo_mese AS
	SELECT stress_g.id AS Gruppo_Sotto_Stress,
		   stress_g.orto AS Orto_Gruppo_Stress,
		   stress_g.scuola AS Scuola_Gruppo_Stress,
		   controllo_g.id AS Gruppo_Di_Controllo,
		   controllo_g.orto AS Orto_Gruppo_Di_Controllo,
		   controllo_g.scuola AS Scuola_Gruppo_Di_Controllo,
		   stress_g.specie AS Specie,
		   (SELECT COUNT(*)
		   FROM Replica JOIN Gruppo ON Gruppo.id = Replica.gruppo
		   WHERE Gruppo.id = stress_g.id) AS N_Repliche,
		   AVG(stress_m.altezza) AS Altezza_Media_Stress,
		   AVG(controllo_m.altezza) AS Altezza_Media_Controllo,
		   AVG(stress_m.lunghezza_radice) AS Lunghezza_Radice_Media_Stress,
		   AVG(controllo_m.lunghezza_radice) AS Lunghezza_Radice_Media_Controllo,
		   AVG(stress_m.lunghezza_chioma_foglie) AS Lunghezza_Chioma_Foglie_Media_Stress,
		   AVG(controllo_m.lunghezza_chioma_foglie) AS Lunghezza_Chioma_Foglie_Media_Controllo

	FROM Misurazione stress_m JOIN Gruppo stress_g ON stress_g.id = stress_m.gruppo
					 		  JOIN AssociatoA ON stress_g.id = AssociatoA.gruppo_stress
					 		  JOIN Gruppo controllo_g ON controllo_g.id = AssociatoA.gruppo_controllo
					 		  JOIN Misurazione controllo_m ON controllo_g.id = controllo_m.gruppo

	WHERE EXTRACT(MONTH FROM stress_m.timestamp_misurazione) = EXTRACT(MONTH FROM CURRENT_DATE)
		  AND EXTRACT(YEAR FROM stress_m.timestamp_misurazione) = EXTRACT(YEAR FROM CURRENT_DATE)
		  AND EXTRACT(MONTH FROM controllo_m.timestamp_misurazione) = EXTRACT(MONTH FROM CURRENT_DATE)
		  AND EXTRACT(YEAR FROM controllo_m.timestamp_misurazione) = EXTRACT(YEAR FROM CURRENT_DATE)
	GROUP BY stress_g.id, controllo_g.id;
*/
