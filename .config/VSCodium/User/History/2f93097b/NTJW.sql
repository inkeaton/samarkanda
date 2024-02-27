----------------------------------------- FUNZIONI -------------------------------------

/*
funzione che realizza l’abbinamento tra gruppo e gruppo di controllo
nel caso di operazioni di bio-monitoraggio
*/

/* NON FINITA
CREATE OR REPLACE FUNCTION AssociaGruppi(stress integer, controllo integer) RETURNS VOID AS $$
DECLARE
  	istituto_s char(8);
	istituto_c char(8);
	collabora_c boolean;
	specie_s varchar(20);
	specie_c varchar(20);
	scopo_s varchar(13);
	scopo_c varchar(15);
	n_repliche_s integer;
	n_repliche_c integer;
	tipo_colt_s varchar(14);
	tipo_colt_c varchar(14);
	ambiente_s varchar(9);
	ambiente_c varchar(9);

BEGIN

	/* Salva i parametri che ci interessano del gruppo sotto stress*/
	SELECT DISTINCT Scuola.cm_i, Gruppo.specie, Gruppo.tipo_colt, Gruppo.scopo, Orto.ambiente, COUNT(*)
		   INTO istituto_s, specie_s, tipo_colt_s, scopo_s, ambiente_s, n_repliche_s
	FROM Gruppo JOIN Orto ON Gruppo.orto = Orto.nome AND
							 Gruppo.scuola = Orto.scuola
				JOIN Scuola ON Orto.scuola = Scuola.cm
				JOIN Replica ON Gruppo.id = Replica.gruppo
	WHERE Gruppo.id = stress;

	/* Salva i parametri che ci interessano del gruppo di controllo*/
	SELECT DISTINCT Scuola.cm_i, Gruppo.specie, Gruppo.tipo_colt, Gruppo.scopo, Orto.ambiente, Istituto.collabora, COUNT(*)
		   INTO istituto_s, specie_s, tipo_colt_s, scopo_s, ambiente_s, collabora_c, n_repliche_s
	FROM Gruppo JOIN Orto ON Gruppo.orto = Orto.nome AND
							 Gruppo.scuola = Orto.scuola
				JOIN Scuola ON Orto.scuola = Scuola.cm
				JOIN Istituto ON Istituto.cm_i = Scuola.cm_i
				JOIN Replica ON Gruppo.id = Replica.gruppo
	WHERE Gruppo.id = controllo;

	/* Si trovano nello stesso istituto? */

	/* O il gruppo di controllo è in un istituto disposto a collaborare? */

	/* Sono composti da repliche della stessa specie? */

	/* Hanno lo stesso numero di repliche? */

	INSERT INTO AssociatoA
	VALUES (stress, controllo);


END $$
LANGUAGE plpgsql;
*/

/*
funzione che corrisponde alla seguente query parametrica: data una replica con finalità di fitobo-
nifica e due date, determina i valori medi dei parametri rilevati per tale replica nel periodo com-
preso tra le due date.
*/


/*
CREATE FUNCTION ValoriMediFra_Fitobonifica(replica integer,
										   gruppo integer,
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
						 X.gruppo = gruppo AND
						 date(X.timestamp_misurazione) >= data_in AND
						 date(X.timestamp_misurazione) < data_in;

END $$
LANGUAGE plpgsql;
*/
