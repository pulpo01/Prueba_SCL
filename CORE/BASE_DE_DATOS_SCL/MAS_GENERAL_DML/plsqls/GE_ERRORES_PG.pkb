CREATE OR REPLACE package body GE_ERRORES_PG
AS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION GRABAR (
    nEvento 	 IN NUMBER,	   		--Secuencia de evento
	vCodPrograma IN VARCHAR2,		--Codigo de Programa
	vDescripcion IN VARCHAR2, 		--Descripciæn del Error o Evento
	vVerPrograma IN VARCHAR2, 		--Version de la aplicacion
	vNomUsuario	 IN VARCHAR2, 		--Nombre de Usuario
	vNumProceso  IN VARCHAR2, 		--Numero de proceso Oracle
	vMaquina 	 IN VARCHAR2,		--Nombre de la mﬂquina del usuario (PC)
	vServicio 	 IN VARCHAR2, 		--Nombre o cædigo de servicio
	vQuery 		 IN VARCHAR2,		--Query
	vCodError 	 IN VARCHAR2, 		--Codigo de Error Oracle
	vDesError 	 IN VARCHAR2		--Descripciæn del Error Oracle
)
RETURN NUMBER
IS
    /* DECLARACION DE VARIABLES LOCALES */
	nEventoTMP NUMBER;
	nDetEvento NUMBER;
	sCOD_SQLCODE VARCHAR2(255);
	sCOD_SQLERRM VARCHAR2(255);
	PRAGMA AUTONOMOUS_TRANSACTION;
	/* FIN DECLARACION DE VARIABLES LOCALES */
BEGIN

	IF nEvento=0 THEN
	   nEventoTMP:=0;
	ELSE
	   nEventoTMP:=nEvento;
	END IF;

	IF nEvento =0 THEN
 		SELECT ge_evento_sq.NEXTVAL
 		  INTO nEventoTMP
 		  FROM DUAL;

 		INSERT INTO ge_evento_to (evento, cod_programa, descripcion, version_prg, nom_usuario, num_proceso, maquina)
 		VALUES(nEventoTMP, vCodPrograma, vDescripcion, vVerPrograma, vNomUsuario, vNumProceso, vMaquina);
	END IF;

	IF nEvento<>0 or nEventoTMP<>0 THEN
 		SELECT ge_evento_detalle_sq.NEXTVAL
 		  INTO nDetEvento
 		  FROM DUAL;

		INSERT INTO ge_evento_detalle_to (det_evento, evento, servicio, query, cod_error, descripcion_error)
		VALUES(nDetEvento, nEventoTMP, vServicio, vQuery, vCodError, vDesError);
	END IF;

	COMMIT;

	RETURN nEventoTMP;

EXCEPTION
	WHEN OTHERS THEN
		 sCOD_SQLCODE:=SQLCODE;
		 sCOD_SQLERRM:=SQLERRM;
		 ROLLBACK;
		 RETURN -1;

END GRABAR;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION GRABARPL (
    nEvento      IN NUMBER,	   		--Secuencia de evento
	vCodPrograma IN VARCHAR2,		--Codigo de Programa
	vDescripcion IN VARCHAR2, 		--Descripciæn del Error o Evento
	vVerPrograma IN VARCHAR2, 		--Version de la aplicacion
	vNomUsuario  IN VARCHAR2, 		--Nombre de Usuario
	NomPGPL      IN VARCHAR2, 		--Nombre PL o PG
	vQuery       IN VARCHAR2, 		--Ruta de Ejecucio, Query
	vCodError    IN VARCHAR2, 		--Codigo de Error Oracle
	vDesError    IN VARCHAR2		--Descripciæn del Error Oracle
)
RETURN NUMBER

IS
	sNumProceso   VARCHAR2(25);
	sTerminal     VARCHAR2(25);
	nEventoTMP    NUMBER;
    --INICIO 196032 CSR MAV
    lv_ssql            VARCHAR2(3000);
    lv_NomPGPL    VARCHAR2(100);
    ERROR_EVENTO  EXCEPTION;
    --FIN 196032 CSR MAV
BEGIN


    SELECT NVL(process,'NO PROCESS'), NVL(terminal,'NO TERMINAL')
      INTO sNumProceso, sTerminal
      FROM V$SESSION
     WHERE username = user AND status = 'ACTIVE';
    --INICIO 196032 CSR MAV
    lv_NomPGPL:=SUBSTR(NomPGPL,0,99);
    lv_ssql:=substr('ge_errores_pg.grabar ('||nEvento||', '||vCodPrograma||', '||vDescripcion||','||vVerPrograma||', '||vNomUsuario||', '||sNumProceso||', '||sTerminal||', '||NomPGPL||', '||vQuery||', '||vCodError||', '||vDesError||');',0,2999);
    --FIN 196032 CSR MAV
    nEventoTMP := ge_errores_pg.grabar (nEvento, vCodPrograma, vDescripcion, vVerPrograma, vNomUsuario, sNumProceso, sTerminal, NomPGPL, vQuery, vCodError, vDesError);

    IF nEventoTMP=-1 THEN 
        RAISE ERROR_EVENTO;
    END IF;
    
    RETURN nEventoTMP;

EXCEPTION
    --INICIO 196032 CSR MAV
    WHEN ERROR_EVENTO THEN
        sNumProceso := 'Error evento';
        sTerminal := 'Error evento';
        nEventoTMP := ge_errores_pg.grabar (nEvento, vCodPrograma, vDescripcion, '1', vNomUsuario, sNumProceso, sTerminal, lv_NomPGPL, lv_ssql, '100', sNumProceso);
        RETURN nEventoTMP;
	--FIN 196032 CSR MAV
    WHEN TOO_MANY_ROWS THEN
	    sNumProceso := 'MANY_ROWS';
		sTerminal := 'MANY_ROWS';
           nEventoTMP := ge_errores_pg.grabar (nEvento, vCodPrograma, vDescripcion, vVerPrograma, vNomUsuario, sNumProceso, sTerminal, NomPGPL, vQuery, vCodError, vDesError);
	    RETURN nEventoTMP;

	WHEN OTHERS THEN
	    sNumProceso := 'No Identificado';
		sTerminal := 'No Identificado';
           nEventoTMP := ge_errores_pg.grabar (nEvento, vCodPrograma, vDescripcion, vVerPrograma, vNomUsuario, sNumProceso, sTerminal, NomPGPL, vQuery, vCodError, vDesError);
	    RETURN nEventoTMP;

END GRABARPL;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION MensajeError(
    neCodMsgError IN OUT  NUMBER,
    vsDetMsgError OUT     VARCHAR2
)
RETURN BOOLEAN

IS
	sNumProceso       VARCHAR2(25);
	sTerminal     	  VARCHAR2(25);
	nEventoTMP    	  NUMBER;
	ln_codmsderror    NUMBER;
	ln_codmsdcliente  NUMBER;

BEGIN

    SELECT cod_msgerror, cod_msgcliente, det_msgerror
	  INTO ln_codmsderror, ln_codmsdcliente, vsDetMsgError
      FROM ge_errores_td
     WHERE cod_msgerror = neCodMsgError;

	IF ln_codmsdcliente IS NULL THEN
	    neCodMsgError := ln_codmsderror;
	ELSE
		neCodMsgError := ln_codmsdcliente;
	END IF;

    RETURN TRUE;

EXCEPTION

	WHEN NO_DATA_FOUND THEN
	    RETURN FALSE;

	WHEN OTHERS THEN
	    RETURN FALSE;

END MensajeError;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

END GE_ERRORES_PG;
/
SHOW ERRORS

