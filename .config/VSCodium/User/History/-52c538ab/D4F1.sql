
-------------------------------------- CREAZIONE SCHEMA -----------------------------------

create schema "orti1";
set search_path to "orti1";


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
    SELECT DISTINCT Scuola.cm_i, Gruppo.specie, Gruppo.tipo_colt, Gruppo.scopo, Orto.ambiente
           INTO istituto_s, specie_s, tipo_colt_s, scopo_s, ambiente_s
	FROM Gruppo JOIN Orto ON Gruppo.orto = Orto.nome AND
							 Gruppo.orto_scuola = Orto.scuola
				JOIN Scuola ON Orto.scuola = Scuola.cm
				JOIN Replica ON Gruppo.id = Replica.gruppo
	WHERE Gruppo.id = stress;

    SELECT COUNT(*)
    INTO n_repliche_s
    FROM Replica
    WHERE gruppo = stress;

	/* Salva i parametri che ci interessano del gruppo di controllo */
	SELECT DISTINCT Scuola.cm_i, Gruppo.specie, Gruppo.tipo_colt, Gruppo.scopo, Orto.ambiente, Istituto.collabora
		   INTO istituto_c, specie_c, tipo_colt_c, scopo_c, ambiente_c, collabora_c
	FROM Gruppo JOIN Orto ON Gruppo.orto = Orto.nome AND
							 Gruppo.orto_scuola = Orto.scuola
				JOIN Scuola ON Orto.scuola = Scuola.cm
				JOIN Istituto ON Istituto.cm_i = Scuola.cm_i
				JOIN Replica ON Gruppo.id = Replica.gruppo
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
		RAISE NOTICE 'Replica inserita correttamente nel gruppo % con numero %', NEW.gruppo, NEW.id;
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
		RAISE NOTICE 'Tupla inserita correttamente: % studia anche %', NEW.scuola, NEW.specie;
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
    SELECT lunghezza_chioma_foglie, larghezza_chioma_foglie, peso_fresco_chioma_foglie,
           peso_secco_chioma_foglie, altezza, lunghezza_radice
        INTO  prev_lunghezza_chioma_foglie,  prev_larghezza_chioma_foglie,  prev_peso_fresco_chioma_foglie,
            prev_peso_secco_chioma_foglie,  prev_altezza,  prev_lunghezza_radice
    FROM misurazione
    WHERE misurazione.n_replica = NEW.n_replica AND
          misurazione.gruppo = NEW.gruppo
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

        IF prev_peso_fresco_chioma_foglie IS NOT NULL THEN
            IF NEW.peso_fresco_chioma_foglie < prev_peso_fresco_chioma_foglie
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





