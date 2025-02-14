CREATE OR REPLACE PROCEDURE        CE_P_BAJA_SERIE(
  snum_clave  IN VARCHAR2,
  snum_serie  IN VARCHAR2,
  sfec_expiracion IN VARCHAR2,
  inum_lote    IN NUMBER,
  snom_usuario IN VARCHAR2,
  celular IN VARCHAR2,
  scod_motrecha IN VARCHAR2,
  resul IN OUT VARCHAR2
  )
IS
  marca               NUMBER(4);
  inum_vigencia       CEH_CLAVEDISP.NUM_VIGENCIA%TYPE;
  scod_tipclave       CEH_CLAVEDISP.COD_TIPCLAVE%TYPE;
  imto_clave          CEH_CLAVEDISP.MTO_CLAVE%TYPE;
  inum_atmoper        CEH_CLAVEDISP.NUM_ATMOPER%TYPE;
  inum_operacion      CEH_CLAVEDISP.NUM_OPERACION%TYPE;
  scod_emprserv       CEH_CLAVEDISP.COD_EMPRSERV%TYPE;
  scod_script         CEH_CLAVEDISP.COD_SCRIPT%TYPE;
  sfec_activa         varchar(11);
  sfec_rechazo        varchar(11);
  sfec_transaccion    varchar(11);
  inum_opactiva       CEH_CLAVEDISP.NUM_OPACTIVA%TYPE;
/******************************************************************************
   NOMBRE:     CMD_COMVERSE
   OBJETIVO:   DAR DE BAJA UNA SERIE SEGUN FECHA DE EXPIRACION
   Ver         Fecha        Autor
   ---------  ----------  ---------------
   1.0        18/12/2000  MARITZA TAPIA A.
******************************************************************************/
ERROR_PROCESO EXCEPTION;
BEGIN
resul:='OK';
marca :=1;
SELECT NUM_VIGENCIA  ,
	   COD_TIPCLAVE  ,
       MTO_CLAVE     ,
	   NUM_ATMOPER   ,
	   NUM_OPERACION ,
       COD_EMPRSERV  ,
	   COD_SCRIPT    ,
       to_char(FEC_ACTIVA,'DD-MM-YYYY'),
	   to_char(FEC_RECHAZO,'DD-MM-YYYY'),
	   NUM_OPACTIVA  ,
	   to_char(FEC_TRANSACCION,'DD-MM-YYYY')
INTO   inum_vigencia  ,
	   scod_tipclave  ,
	   imto_clave     ,
	   inum_atmoper   ,
  	   inum_operacion ,
  	   scod_emprserv  ,
  	   scod_script    ,
  	   sfec_activa    ,
  	   sfec_rechazo   ,
  	   inum_opactiva  ,
 	   sfec_transaccion
FROM  CET_CLAVEDISP
WHERE NUM_CLAVE = snum_clave
AND   NUM_SERIE = snum_serie
AND   NUM_LOTE  = inum_lote;
marca :=2;
marca :=10;
INSERT INTO CEH_CLAVEDISP
	   ( NUM_CLAVE     ,
	     NUM_SERIE     ,
		 FEC_EXPIRACION,
		 NUM_VIGENCIA  ,
		 COD_TIPCLAVE  ,
		 MTO_CLAVE     ,
		 COD_ESTADO    ,
		 NUM_ATMOPER   ,
		 NUM_OPERACION ,
		 COD_EMPRSERV  ,
		 COD_SCRIPT    ,
		 NUM_LOTE      ,
		 FEC_ACTIVA    ,
		 FEC_RECHAZO   ,
		 COD_MOTRECHA  ,
		 NUM_OPACTIVA  ,
		 FEC_TRANSACCION)
	    VALUES(
		 snum_clave     ,    -- VARCHAR2(16)  NOT NULL,
		 snum_serie     ,    -- VARCHAR2(16)  NOT NULL,
		 to_date(sfec_expiracion,'DD-MM-YYYY'),    -- DATE          NOT NULL,
		 inum_vigencia  ,    -- NUMBER(4),
		 scod_tipclave  ,    -- VARCHAR2(5)   NOT NULL,
		 imto_clave     ,    -- NUMBER(10)    NOT NULL,
		 'B'            ,    -- VARCHAR2(2)   NOT NULL,
		 inum_atmoper   ,    -- NUMBER(5),
		 inum_operacion ,    -- NUMBER(5),
		 scod_emprserv  ,    -- VARCHAR2(5),
		 scod_script    ,    -- VARCHAR2(2)   NOT NULL,
		 inum_lote      ,    -- NUMBER(6)     NOT NULL,
		 to_date(sfec_activa,'DD-MM-YYYY')    ,    -- DATE,
		 sysdate        ,    -- DATE,
		 scod_motrecha  ,	 -- COD_MOTRECHA     VARCHAR2(2),
		 inum_opactiva  ,    -- NUMBER(6),
		 to_date(sfec_transaccion,'DD-MM-YYYY'));   -- DATE,
--- Borra registro de cet_clavedisp
marca:=11;
DELETE
FROM  CET_CLAVEDISP
WHERE NUM_CLAVE = snum_clave
AND   NUM_SERIE = snum_serie
AND   NUM_LOTE  = inum_lote;
marca:=3;
	EXCEPTION
	WHEN OTHERS THEN
   	    resul := SQLERRM||'linea: '||marca;
	 	ROLLBACK;
END CE_P_BAJA_SERIE;
/
SHOW ERRORS
