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

 SELECT ReferenteScuola.cm, Scuola.tipo
 FROM ReferenteScuola JOIN Scuola 
                      ON Scuola.cm = ReferenteScuola.scuola;

---------------------------------------- SCHEMA FISICO -----------------------------------------

/*
 1.
 */

CREATE INDEX test1
ON Finanziamento (entità);

CLUSTER Finanziamento 
USING test1;

/* BEFORE : SEQ SCAN : ESC 0.262 ms : INC 0.262 ms */
/* AFTER : INDEX SCAN : ESC 0.099 ms : INC 0.099 ms */

/*
 2.
 */

CREATE INDEX test2
ON Persona
USING HASH (nome);

/* BEFORE : SEQ SCAN : ESC 0.212 ms : INC 0.212 ms*/
/* AFTER : BITMAP HEAP SCAN + BITMAP INDEX SCAN : ESC 0.017 ms, 0.018 ms : INC 0.034 , 0.018*/

/*
 3.
 */

/*
 Non è stata necessaria alcuna modifica allo schema fisico della base di dati per effettuare 
 l'interrogazione nel modo ottimale
 */

---------------------------------------- POLITICA D'ACCESSO -----------------------------------------

/*AG
AL
AN
AO
AR
AP
AT
AV
BA
BT
BL
BN
BG
BI
BO
BZ
BS
BR
CA
CL
CB
CI
CE
CT
CZ
CH
CH
CO
CS
CR
KR
CN
EN
FM
FE
FI
FG
FC
FR
GE
GO
GR
IM
IS
SP
AQ
LT
LE
LC
LI
LO
LU
MC
MN
MS
MT
ME
MI
MO
MB
NA
NO
NU
OT
OR
PD
PA
PR
PV
PG
PU
PE
PC
PI
PT
PN
PZ
PO
RG
RA
RC
RE
RI
RN
RM
RO
SA
VS
SS
SV
SI
SR
SO
TA
TE
TR
TO
OG
TP
TN
TV
TS
UD
VA
VE
VB
VC
VR
VV
VI
VT
*/


set search_path to "orti1";


/*SELECT relpages FROM pg_class WHERE relname = 'finanziamento';

CREATE INDEX test1
ON Finanziamento (entità);

CLUSTER ON test1;

ANALYZE;

SELECT istituto, progetto
FROM Finanziamento
WHERE (progetto = 'PON EduGreen' OR progetto = 'Sviluppo Base Dati') AND
       entità > 1000;
*/


/* BEFORE: SEQ SCAN : 0.257 */
/* AFTER: INDEX SCAN : 0.094 */
