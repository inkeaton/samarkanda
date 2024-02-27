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
        prev_lunghezza_chioma_foglie decimal(3,2);
        prev_larghezza_chioma_foglie decimal(3,2);
        prev_peso_fresco_chioma_foglie decimal(3,2);
        prev_peso_secco_chioma_foglie decimal(3,2);
        prev_altezza decimal(3,2);
        prev_lunghezza_radice decimal(3,2);
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
    WHERE misurazione.n_replica = NEW.n_replica
    ORDER BY misurazione.timestamp_misurazione DESC;

    IF NEW.lunghezza_chioma_foglie < prev_lunghezza_chioma_foglie
    THEN RAISE NOTICE 'Attenzione: il valore corrispondente alla lunghezza chioma/foglie è diminuito rispetto al valore della misurazione precedente';
    END IF;

    IF NEW.larghezza_chioma_foglie < prev_larghezza_chioma_foglie
    THEN RAISE NOTICE 'Attenzione: il valore corrispondente alla larghezza chioma/foglie è diminuito rispetto al valore della misurazione precedente';
    END IF;

    IF NEW.peso_fresco_chioma_foglie < prev_peso_fresco_chioma_foglie
    THEN RAISE NOTICE 'Attenzione: il valore corrispondente al peso fresco chioma/foglie è diminuito rispetto al valore della misurazione precedente';
    END IF;

    IF NEW.peso_secco_chioma_foglie < prev_peso_secco_chioma_foglie
    THEN RAISE NOTICE 'Attenzione: il valore corrispondente al peso secco chioma/foglie è diminuito rispetto al valore della misurazione precedente';
    END IF;

    IF NEW.altezza < prev_altezza
    THEN RAISE NOTICE 'Attenzione: il valore corrispondente all''altezza della replica è diminuito rispetto al valore della misurazione precedente';
    END IF;

    IF NEW.lunghezza_radice < prev_lunghezza_radice
    THEN RAISE NOTICE 'Attenzione: il valore corrispondente alla lunghezza della radice è diminuito rispetto al valore della misurazione precedente';
    END IF;
END $$
LANGUAGE plpgsql;

CREATE TRIGGER warn_decrease_biomassa
AFTER INSERT ON Misurazione
FOR EACH ROW
EXECUTE FUNCTION check_decrease_biomassa();

