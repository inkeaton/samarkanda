
create schema "orti1";
set search_path to "orti1";
SET datestyle TO "DMY";

-------------------------------------- CREAZIONE SCHEMA -----------------------------------

/*
 Alcuni attributi potrebbero avere un ordine od un nome differente rispetto al progetto
 logico. Questo avviene per comodità, e si ritiene che i rispettivi attributi siano
 facilmente identificabili
*/

CREATE TABLE Persona (
                         cf char(16) PRIMARY KEY,
                         nome varchar(20) NOT NULL,
                         cognome varchar(20) NOT NULL,
                         email varchar(30) NOT NULL,
                         ruolo varchar(20) NOT NULL,
                         n_telefono numeric(11),
                         CHECK((n_telefono IS NULL) OR (n_telefono >= 0))
);

CREATE TABLE Istituto (
                          cm_i char(8) PRIMARY KEY,
                          nome varchar(20) NOT NULL,
                          provincia char(2) NOT NULL,
                          collabora boolean NOT NULL
                              DEFAULT FALSE,
                          CHECK(provincia IN ('AG', 'AL', 'AN', 'AO', 'AR', 'AP', 'AT', 'AV', 'BA', 'BT', 'BL', 'BN', 'BG', 'BI', 'BO', 'BZ', 'BS', 'BR', 'CA', 
                          'CL', 'CB', 'CI', 'CE', 'CT', 'CZ', 'CH', 'CH', 'CO', 'CS', 'CR', 'KR', 'CN', 'EN', 'FM', 'FE', 'FI', 'FG', 'FC', 'FR', 'GE', 'GO', 'GR', 
                          'IM', 'IS', 'SP', 'AQ', 'LT', 'LE', 'LC', 'LI', 'LO', 'LU', 'MC', 'MN', 'MS', 'MT', 'ME', 'MI', 'MO', 'MB', 'NA', 'NO', 'NU', 'OT', 'OR', 
                          'PD', 'PA', 'PR', 'PV', 'PG', 'PU', 'PE', 'PC', 'PI', 'PT', 'PN', 'PZ', 'PO', 'RG', 'RA', 'RC', 'RE', 'RI', 'RN', 'RM', 'RO', 'SA', 'VS', 
                          'SS', 'SV', 'SI', 'SR', 'SO', 'TA', 'TE', 'TR', 'TO', 'OG', 'TP', 'TN', 'TV', 'TS', 'UD', 'VA', 'VE', 'VB', 'VC', 'VR', 'VV', 'VI', 'VT')) 
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
                               entità decimal(8,2) NOT NULL,
                               CHECK(entità>0)
);

CREATE TABLE Ciclo (
                       tipo varchar(20) PRIMARY KEY,
                       ciclo varchar(10) NOT NULL,
                       CHECK(ciclo IN ('primo', 'secondo')) -- Vincolo v2
);

CREATE TABLE Scuola (
                        cm char(8) PRIMARY KEY,
                        cm_i char(8) NOT NULL
                            REFERENCES Istituto (cm_i),
                        nome varchar(20) NOT NULL,
                        tipo varchar(20) NOT NULL
                            REFERENCES Ciclo (tipo)
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
                              studente_rappr char(16) REFERENCES Studente (cf),
                              classe_nome_rappr char(2),
                              classe_scuola_rappr char(8),
                              id serial PRIMARY KEY,
                              FOREIGN KEY (classe_nome_rappr, classe_scuola_rappr)
                                  REFERENCES Classe (nome, scuola),
                              CHECK((studente_rappr IS NULL AND classe_nome_rappr IS NOT NULL AND classe_scuola_rappr IS NOT NULL) OR
                                    (studente_rappr IS NOT NULL AND classe_nome_rappr IS NULL AND classe_scuola_rappr IS NULL)) -- Vincolo v19
);

CREATE TABLE Orto (
                      scuola char(8) REFERENCES Scuola (cm),
                      nome varchar(20),
                      -- usa il formato gradi e minuti
                      -- es, 50°38′N 3°03′E
                      GPS_coord varchar(30) NOT NULL
                                            UNIQUE,
                      superficie decimal(6,0) NOT NULL,
                      tipo_colt varchar(14) NOT NULL,
                      ambiente varchar(9) NOT NULL,
                      PRIMARY KEY (scuola, nome),
                      CHECK(tipo_colt in ('in vaso', 'in pieno campo')), -- Vincolo v5
                      CHECK(ambiente in ('pulito', 'inquinato')), -- Vincolo v6
                      CHECK(superficie > 0)
);

CREATE TABLE Specie (
                        nome_s varchar(30) PRIMARY KEY,
                        nome_c varchar(20) NOT NULL
);

CREATE TABLE Studia (
                        scuola char(8) REFERENCES Scuola (cm),
                        specie varchar(30) REFERENCES Specie (nome_s),
                        PRIMARY KEY (scuola, specie)
);

CREATE TABLE UsoSpecie (
                           specie varchar(30) REFERENCES Specie (nome_s),
                           tipo_colt varchar(14),
                           scopo varchar(15),
                           esposizioni varchar(17) NOT NULL,
                           PRIMARY KEY (specie, tipo_colt, scopo),
                           CHECK(tipo_colt in ('in vaso', 'in pieno campo') ), -- Vincolo v5
                           CHECK(scopo in ('fitobonifica', 'biomonitoraggio') ), -- Vincolo v7  
                           CHECK(scopo = 'biomonitoraggio' OR tipo_colt != 'in vaso') -- Vincolo v8 
);

CREATE TABLE Gruppo (
                        specie varchar(20) NOT NULL,
                        tipo_colt varchar(14) NOT NULL,
                        scopo varchar(15) NOT NULL,
                        classe char(2) NOT NULL,
                        classe_scuola char(8) NOT NULL,
                        orto varchar(20) NOT NULL,
                        orto_scuola char(8) NOT NULL,
                        id serial PRIMARY KEY,
                        FOREIGN KEY (orto, orto_scuola)
                            REFERENCES Orto (nome, scuola),
                        FOREIGN KEY (specie, tipo_colt, scopo)
                            REFERENCES UsoSpecie (specie, tipo_colt, scopo),
                        FOREIGN KEY (classe, classe_scuola)
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

CREATE TABLE DatiSensore (
                            n_modello char(10),
                            produttore varchar(20),
                            tipo_batteria varchar(5) NOT NULL,
                            prec_luminosità decimal(6,2) NOT NULL,
                            prec_temperatura decimal(6,2) NOT NULL,
                            PRIMARY KEY(n_modello, produttore)
);

CREATE TABLE Modello (
                        nome varchar(20) PRIMARY KEY,
                        tipo_comunicazione varchar(20) NOT NULL,
                        larghezza decimal(4,2) NOT NULL,
                        lunghezza decimal(4,2) NOT NULL,
                        altezza decimal(4,2) NOT NULL,
                        SKU_scheda char(8) REFERENCES DatiSchedaArduino (SKU),
                        n_sensore char(10),
                        prod_sensore varchar(20),
                        FOREIGN KEY (n_sensore, prod_sensore)
                            REFERENCES DatiSensore (n_modello, produttore),
                        CHECK((SKU_scheda IS NULL AND n_sensore IS NOT NULL AND prod_sensore IS NOT NULL) OR
                              (SKU_scheda IS NOT NULL AND n_sensore IS NULL AND prod_sensore IS NULL)) -- Vincolo v24
);

CREATE TABLE Rilevatore(
                           orto varchar(20) NOT NULL,
                           scuola char(8) NOT NULL,
                           modello varchar(20) NOT NULL
                               REFERENCES Modello (nome),
                           id serial PRIMARY KEY,
                           FOREIGN KEY (orto, scuola)
                               REFERENCES Orto (nome, scuola)
);

CREATE TABLE Replica (
                         id serial,
                         gruppo integer REFERENCES Gruppo (id), 
                         data_piantata date NOT NULL
                             DEFAULT CURRENT_DATE,
                         esposizione varchar(15) NOT NULL,
                         rilevatore integer NOT NULL
                             REFERENCES Rilevatore(id),
                         PRIMARY KEY (id, gruppo)
);

CREATE TABLE Rilevazione (
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
                             id serial PRIMARY KEY,
                             FOREIGN KEY (specie, tipo_colt, scopo)
                                 REFERENCES UsoSpecie (specie, tipo_colt, scopo),
                             CHECK((resp_inserimento IS NULL) OR (resp_rilevazione != resp_inserimento)), -- Vincolo v12
                             CHECK(tipo_substrato IN ('terriccio da rinvaso','suolo pre-esistente')), -- Vincolo v14
                             CHECK(cosa_monitorato IN ('suolo','aria')), -- Vincolo v15
                             CHECK((cosa_monitorato IS NULL AND (scopo = 'biomonitoraggio')) OR
                                   (cosa_monitorato IS NOT NULL AND (scopo = 'fitobonifica'))) -- Vincolo v11
);

CREATE TABLE Misurazione (
                             n_rilevazione integer NOT NULL
                                 REFERENCES Rilevazione (id),
                             n_replica integer NOT NULL,
                             gruppo integer NOT NULL,
                             timestamp_misurazione timestamp NOT NULL
                                 DEFAULT CURRENT_TIMESTAMP,
                             modalità_mem varchar(22) NOT NULL,
                             temperatura decimal(4,2) NOT NULL,
                             umidità decimal(4,2) NOT NULL,
                             pH decimal(3,1) NOT NULL,
                             perc_sup_danneggiata decimal (2) NOT NULL,
                             n_foglie_danneggiate decimal(3) NOT NULL,
                             n_frutti decimal(3) NOT NULL,
                             n_fiori decimal(3) NOT NULL,
                             lunghezza_chioma_foglie decimal(5,2) NOT NULL,
                             larghezza_chioma_foglie decimal(5,2) NOT NULL,
                             peso_fresco_chioma_foglie decimal(5,2),
                             peso_secco_chioma_foglie decimal(5,2) NOT NULL,
                             peso_fresco_radice decimal(5,2) NOT NULL,
                             peso_secco_radice decimal(5,2) NOT NULL,
                             altezza decimal(5,2) NOT NULL,
                             lunghezza_radice decimal(5,2) NOT NULL,
                             FOREIGN KEY (n_replica, gruppo)
                                 REFERENCES Replica (id, gruppo),
                             PRIMARY KEY (n_rilevazione, n_replica, gruppo),
                             CHECK(modalità_mem IN ('app', 'direttamente da scheda')), -- Vincolo v16
                             CHECK(
                             umidità >=0 AND
                             pH >=0 AND
                             perc_sup_danneggiata >=0 AND
                             n_foglie_danneggiate >=0 AND
                             n_frutti >=0 AND
                             n_fiori >=0  AND
                             lunghezza_chioma_foglie >=0 AND
                             larghezza_chioma_foglie >=0 AND
                             (peso_fresco_chioma_foglie >=0 OR peso_fresco_chioma_foglie IS NULL) AND
                             peso_secco_chioma_foglie >=0 AND
                             peso_fresco_radice >=0 AND
                             peso_secco_radice >=0 AND
                             altezza >=0 AND
                             lunghezza_radice >=0)
);


----------------------------------------- VISTA -------------------------------------

/*
 La definizione di una vista che fornisca alcune informazioni riassuntive per ogni attività di biomonitoraggio: per
 ogni gruppo e per il corrispondente gruppo di controllo mostrare il numero di piante, la specie, l’orto in cui è
 posizionato il gruppo e, su base mensile, il valore medio dei parametri ambientali e di crescita delle piante (se-
 lezionare almeno tre parametri, quelli che si ritengono più significativi).
 */


CREATE VIEW biomonitoraggio_questo_mese AS
	SELECT stress_g.id AS Gruppo_Sotto_Stress,
		   stress_g.orto AS Orto_Gruppo_Stress,
		   stress_g.orto_scuola AS Scuola_Gruppo_Stress,
		   controllo_g.id AS Gruppo_Di_Controllo,
		   controllo_g.orto AS Orto_Gruppo_Di_Controllo,
		   controllo_g.orto_scuola AS Scuola_Gruppo_Di_Controllo,
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


----------------------------------------- INTERROGAZIONI -------------------------------------

/*
 determinare le scuole che, pur avendo un finanziamento per il progetto,
 non hanno inserito rilevazioni in questo anno scolastico
 */ 

SELECT Scuola.cm AS scuola
FROM Scuola JOIN Finanziamento ON Scuola.cm_i = Finanziamento.istituto
EXCEPT
( SELECT Studente.scuola
  FROM Responsabile JOIN Studente ON Responsabile.studente_rappr = Studente.cf
  UNION
  SELECT Classe.scuola
  FROM Responsabile JOIN Classe ON Responsabile.classe_nome_rappr = Classe.nome AND
 								   Responsabile.classe_scuola_rappr = Classe.scuola );

/*
 determinare le specie utilizzate in tutti i comuni (provincie) in cui ci sono scuole aderenti al progetto;
 */


SELECT Studia.specie
FROM Studia JOIN Scuola ON Studia.scuola = Scuola.cm
			JOIN Istituto ON Scuola.cm_i = Istituto.cm_i
GROUP BY Studia.specie
HAVING COUNT(DISTINCT Istituto.provincia) = (SELECT COUNT(DISTINCT provincia)
											  FROM Istituto);
 

/*
 determinare per ogni scuola l’individuo/la classe della scuola che ha effettuato più rilevazioni
 */

SELECT q.scuola, q.id
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
WHERE q.count >= ALL (  SELECT COUNT(*)
                        FROM Rilevazione JOIN Responsabile ON Rilevazione.resp_rilevazione = Responsabile.id
                                        JOIN Studente ON Responsabile.studente_rappr = Studente.cf
                        WHERE Studente.scuola = q.scuola
                        GROUP BY Responsabile.id, Studente.scuola
                        UNION
                        SELECT COUNT(*)
                        FROM Rilevazione JOIN Responsabile ON Rilevazione.resp_rilevazione = Responsabile.id
                                        JOIN Classe ON Responsabile.classe_nome_rappr = Classe.nome AND
                                                        Responsabile.classe_scuola_rappr = Classe.scuola
                        WHERE Classe.scuola = q.scuola
                        GROUP BY Responsabile.id, Classe.scuola);


----------------------------------------- FUNZIONI -------------------------------------

/*
 funzione che realizza l’abbinamento tra gruppo e gruppo di controllo
 nel caso di operazioni di bio-monitoraggio
 */


CREATE FUNCTION AssociaGruppi(stress integer, controllo integer) RETURNS VOID AS $$
DECLARE
  	istituto_s char(8);
	istituto_c char(8);
	collabora_c boolean;
	specie_s varchar(30);
	specie_c varchar(30);
	scopo_s varchar(15);
	scopo_c varchar(15);
	n_repliche_s integer;
	n_repliche_c integer;
	tipo_colt_s varchar(14);
	tipo_colt_c varchar(14);
	ambiente_s varchar(9);
	ambiente_c varchar(9);

BEGIN

	/* Salva i parametri che ci interessano del gruppo sotto stress */
    SELECT Scuola.cm_i, Gruppo.specie, Gruppo.tipo_colt, Gruppo.scopo, Orto.ambiente
           INTO istituto_s, specie_s, tipo_colt_s, scopo_s, ambiente_s
	FROM Gruppo JOIN Orto ON Gruppo.orto = Orto.nome AND
							 Gruppo.orto_scuola = Orto.scuola
				JOIN Scuola ON Orto.scuola = Scuola.cm
	WHERE Gruppo.id = stress;

    SELECT COUNT(*)
    INTO n_repliche_s
    FROM Replica
    WHERE gruppo = stress;

	/* Salva i parametri che ci interessano del gruppo di controllo */
	SELECT Scuola.cm_i, Gruppo.specie, Gruppo.tipo_colt, Gruppo.scopo, Orto.ambiente, Istituto.collabora
		   INTO istituto_c, specie_c, tipo_colt_c, scopo_c, ambiente_c, collabora_c
	FROM Gruppo JOIN Orto ON Gruppo.orto = Orto.nome AND
							 Gruppo.orto_scuola = Orto.scuola
				JOIN Scuola ON Orto.scuola = Scuola.cm
				JOIN Istituto ON Istituto.cm_i = Scuola.cm_i
	WHERE Gruppo.id = controllo;

    SELECT COUNT(*)
    INTO n_repliche_c
    FROM Replica
    WHERE gruppo = controllo;

    /*
     Sono gruppi di biomonitoraggio?
    */

    IF scopo_s != 'biomonitoraggio'
    THEN RAISE EXCEPTION 'Il gruppo % non è un gruppo di biomonitoraggio', stress;
    END IF;

    IF scopo_c != 'biomonitoraggio'
    THEN RAISE EXCEPTION 'Il gruppo % non è un gruppo di biomonitoraggio', controllo;
    END IF;

    /*
     Sono gruppi di controllo e di stress?
    */

    IF ambiente_s != 'inquinato'
    THEN RAISE EXCEPTION 'Il gruppo % non è un gruppo sotto stress', stress;
    END IF;

    IF ambiente_c != 'pulito'
    THEN RAISE EXCEPTION 'Il gruppo % non è un gruppo di controllo', controllo;
    END IF;

    /* Sono composti da repliche della stessa specie? */

    IF specie_s != specie_c OR 
       tipo_colt_s != tipo_colt_c OR
       scopo_s != scopo_c
    THEN RAISE EXCEPTION 'I due gruppi non contengono repliche appartenenti allo stesso uso specie';
    END IF;

	/* Hanno lo stesso numero di repliche? */

    IF n_repliche_s != n_repliche_c
    THEN RAISE EXCEPTION 'I due gruppi non posseggono lo stesso numero di repliche';
    END IF;

	/* 
     Si trovano nello stesso istituto?
     O il gruppo di controllo è in un istituto disposto a collaborare?
     */

    IF (istituto_s != istituto_c) 
    THEN IF NOT collabora_c
        THEN RAISE EXCEPTION 'Il gruppo di controllo % deve trovarsi nello stesso istituto 
                              del gruppo %, od in un istituto disposto a collaborare', controllo, stress;
        END IF;
    END IF;

    /* Allora inserisci l'associazione */

	INSERT INTO AssociatoA
	VALUES (stress, controllo);


END $$
LANGUAGE plpgsql;


/*
 funzione che corrisponde alla seguente query parametrica: data una replica con finalità di fitobo-
 nifica e due date, determina i valori medi dei parametri rilevati per tale replica nel periodo com-
 preso tra le due date.
 */



CREATE FUNCTION ValoriMediFra_Fitobonifica(replica integer,
										   replica_gruppo integer,
										   data_in date,
										   data_fin date)
RETURNS TABLE (temperatura_media decimal,
			   umidità_media decimal,
			   pH_medio decimal,
			   perc_sup_danneggiata_media decimal,
			   n_foglie_danneggiate_medio decimal,
			   n_frutti_medio decimal,
			   n_fiori_medio decimal,
			   lunghezza_chioma_foglie_media decimal,
			   larghezza_chioma_foglie_media decimal,
			   peso_fresco_chioma_foglie_medio decimal,
			   peso_secco_chioma_foglie_medio decimal,
			   peso_fresco_radice_medio decimal,
			   peso_secco_radice_medio decimal,
			   altezza_media decimal,
			   lunghezza_radice_media decimal
			   )
AS $$
BEGIN
	RETURN QUERY SELECT AVG(X.temperatura),
						AVG(X.umidità),
						AVG(X.pH),
						AVG(X.perc_sup_danneggiata),
						AVG(X.n_foglie_danneggiate),
						AVG(X.n_frutti),
						AVG(X.n_fiori),
						AVG(X.lunghezza_chioma_foglie),
						AVG(X.larghezza_chioma_foglie),
						AVG(X.peso_fresco_chioma_foglie),
						AVG(X.peso_secco_chioma_foglie),
						AVG(X.peso_fresco_radice),
						AVG(X.peso_secco_radice),
						AVG(X.altezza),
						AVG(X.lunghezza_radice)
				  FROM Misurazione AS X
				  WHERE  X.n_replica = replica AND
						 X.gruppo = replica_gruppo AND
						 date(X.timestamp_misurazione) >= data_in AND
						 date(X.timestamp_misurazione) < data_fin;

END $$
LANGUAGE plpgsql;


----------------------------------------- TRIGGER -------------------------------------

/*
 verifica del vincolo che ogni scuola dovrebbe concentrarsi su tre specie e ogni gruppo dovrebbe
 contenere 20 repliche;
 */

CREATE FUNCTION massimo_20() RETURNS trigger
AS $$
BEGIN
	IF (SELECT COUNT(*)
		FROM Replica
		WHERE Replica.gruppo = NEW.gruppo) >= 20
	THEN
		RAISE EXCEPTION 'Il gruppo % ha già 20 repliche. La replica non può essere inserita', NEW.gruppo;
	ELSE
		RETURN NEW;
	END IF;
END $$
LANGUAGE plpgsql;

CREATE TRIGGER massimo_20_repliche_per_gruppo
BEFORE INSERT OR UPDATE ON Replica
FOR EACH ROW
EXECUTE FUNCTION massimo_20();



CREATE FUNCTION massimo_3() RETURNS trigger
AS $$
BEGIN
	IF (SELECT COUNT(*)
		FROM Studia
		WHERE Studia.scuola = NEW.scuola) >= 3
	THEN
		RAISE EXCEPTION 'La scuola % studia già 3 specie, la tupla non può essere inserita', NEW.scuola;
	ELSE
		RETURN NEW;
	END IF;
END $$
LANGUAGE plpgsql;

CREATE TRIGGER massimo_3_specie_per_scuola
BEFORE INSERT OR UPDATE ON Studia
FOR EACH ROW
EXECUTE FUNCTION massimo_3();



/*
 generazione di un messaggio (o inserimento di una informazione di warning in qualche tabella)
 quando viene rilevato un valore decrescente per un parametro di biomassa.
 */


CREATE FUNCTION check_decrease_biomassa() RETURNS trigger
AS $$
    DECLARE
        prev_lunghezza_chioma_foglie decimal(5,2);
        prev_larghezza_chioma_foglie decimal(5,2);
        prev_peso_fresco_chioma_foglie decimal(5,2);
        prev_peso_secco_chioma_foglie decimal(5,2);
        prev_altezza decimal(5,2);
        prev_lunghezza_radice decimal(5,2);
BEGIN
    /* 
     Dovrebbe inserire nelle variabili i dati della prima tupla riportata, 
     ovvero la misurazione più recente
     */
    SELECT lunghezza_chioma_foglie, larghezza_chioma_foglie,
           peso_secco_chioma_foglie, altezza, lunghezza_radice
        INTO  prev_lunghezza_chioma_foglie,  prev_larghezza_chioma_foglie,
            prev_peso_secco_chioma_foglie,  prev_altezza,  prev_lunghezza_radice
    FROM misurazione
    WHERE misurazione.n_replica = NEW.n_replica AND
          misurazione.gruppo = NEW.gruppo
    ORDER BY misurazione.timestamp_misurazione DESC;

    /* 
     Siccome il valore peso_fresco_chioma_foglie può essere nullo, cerchiamo 
     separatamente il suo ultimo valore registrato
     */

    SELECT peso_fresco_chioma_foglie
        INTO prev_peso_fresco_chioma_foglie
    FROM misurazione
    WHERE misurazione.n_replica = NEW.n_replica AND
          misurazione.gruppo = NEW.gruppo AND
          misurazione.peso_fresco_chioma_foglie IS NOT NULL
    ORDER BY misurazione.timestamp_misurazione DESC;

    /* 
     Se quella inserita è la prima tupla, anche i valori obbligatori sono nulli. Ne 
     Scegliamo uno per verificare se questo è il caso
     */
    IF prev_lunghezza_chioma_foglie IS NOT NULL
    THEN
        IF NEW.lunghezza_chioma_foglie < prev_lunghezza_chioma_foglie 
        THEN RAISE NOTICE 'Attenzione: il valore corrispondente alla lunghezza chioma/foglie (replica %, gruppo %) 
                        è diminuito rispetto al valore della misurazione precedente', NEW.n_replica, NEW.gruppo;
        END IF;

        IF NEW.larghezza_chioma_foglie < prev_larghezza_chioma_foglie
        THEN RAISE NOTICE 'Attenzione: il valore corrispondente alla larghezza chioma/foglie (replica %, gruppo %) 
                        è diminuito rispetto al valore della misurazione precedente', NEW.n_replica, NEW.gruppo;
        END IF;

        IF (prev_peso_fresco_chioma_foglie IS NOT NULL) AND (NEW.peso_fresco_chioma_foglie IS NOT NULL)
        THEN IF NEW.peso_fresco_chioma_foglie < prev_peso_fresco_chioma_foglie
            THEN RAISE NOTICE 'Attenzione: il valore corrispondente al peso fresco chioma/foglie (replica %, gruppo %) 
                            è diminuito rispetto al valore della misurazione precedente', NEW.n_replica, NEW.gruppo;
            END IF;
        END IF;

        IF NEW.peso_secco_chioma_foglie < prev_peso_secco_chioma_foglie
        THEN RAISE NOTICE 'Attenzione: il valore corrispondente al peso secco chioma/foglie (replica %, gruppo %) 
                        è diminuito rispetto al valore della misurazione precedente', NEW.n_replica, NEW.gruppo;
        END IF;

        IF NEW.altezza < prev_altezza
        THEN RAISE NOTICE 'Attenzione: il valore corrispondente all''altezza (replica %, gruppo %) 
                        è diminuito rispetto al valore della misurazione precedente', NEW.n_replica, NEW.gruppo;
        END IF;

        IF NEW.lunghezza_radice < prev_lunghezza_radice
        THEN RAISE NOTICE 'Attenzione: il valore corrispondente alla lunghezza della radice (replica %, gruppo %) 
                        è diminuito rispetto al valore della misurazione precedente', NEW.n_replica, NEW.gruppo;
        END IF;
    END IF;

    RETURN NEW;
END $$
LANGUAGE plpgsql;

CREATE TRIGGER warn_decrease_biomassa
AFTER INSERT ON Misurazione
FOR EACH ROW
EXECUTE FUNCTION check_decrease_biomassa();


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
























