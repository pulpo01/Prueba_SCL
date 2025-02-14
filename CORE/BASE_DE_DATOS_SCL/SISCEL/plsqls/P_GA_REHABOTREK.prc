CREATE OR REPLACE PROCEDURE P_GA_REHABOTREK(
  VP_PETICION IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_MAN IN NUMBER ,
  VP_TIPSUSP IN VARCHAR2 ,
  VP_CODSUSP IN VARCHAR2 ,
  VP_CODSERVSUPL IN NUMBER ,
  VP_CODNIVEL IN NUMBER ,
  VP_CODCENTRAL IN NUMBER ,
  VP_NUMSERIE IN VARCHAR2 ,
  VP_TIPTERMINAL IN VARCHAR2 ,
  VP_CODMODELO IN VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 ,
  VP_DESERROR IN OUT VARCHAR2 )
IS
--
-- *************************************************************
-- * procedimiento      : P_GA_REHABOTREK
-- * Descripcion        : Procedimiento de Rehabilitacion de abonados Trek
-- * Fecha de creacion  :
-- * Responsable        : CRM
-- *************************************************************
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Se inserto correctamente el registro
--         - "1" ; Error updateando GA_ABOTREK
--         - "2" ; Error updateando GA_SUSPREABO
--         - "3" ; Error consultando tabla GA_ACTABO
--         - "4" ; Error consultando tabla ICG_SUSPREHAMOD
--         - "5" ; Error consultando tabla DUAL
--         - "6" ; Error moviendo servicio y nivel
--         - "7" ; Error Insertando ICM_MOVIMIENTO
-- DECLARACION DE VARIABLES
  V_MOVABO NUMBER(9) ;
  V_TIPSUSP VARCHAR2(2);
  V_CODSERVSUPL VARCHAR2(2);
  V_CODNIVEL    VARCHAR2(4);
  V_ACTUACION ga_actabo.COD_ACTCEN%type;
BEGIN
  IF VP_TIPSUSP='T' THEN
     VP_ERROR := '1';
     UPDATE GA_ABOTREK SET FEC_ULTMOD = SYSDATE,
                           COD_SITUACION = 'RTP'
     WHERE NUM_ABONADO = VP_ABONADO;
  END IF;
  VP_ERROR := '2';
  UPDATE GA_SUSPREHABO SET FEC_REHABD = SYSDATE,
                       TIP_REGISTRO = 3
  WHERE NUM_ABONADO = VP_ABONADO AND
        NUM_PETICION = VP_PETICION ;
  IF VP_TIPSUSP ='P' THEN
     VP_ERROR := '3';
     V_TIPSUSP := 'RP' ;
     SELECT COD_ACTCEN
     INTO   V_ACTUACION
     FROM   GA_ACTABO
     WHERE  COD_PRODUCTO=4
     AND    COD_ACTABO='RP'
         AND    COD_MODULO='GA' ;
  ELSIF VP_TIPSUSP ='T' THEN
     VP_ERROR := '4';
     V_TIPSUSP := 'RT';
     SELECT COD_ACTUACION_REHA
     INTO   V_ACTUACION
     FROM   ICG_SUSPREHAMOD
     WHERE  COD_PRODUCTO=4
     AND    COD_SUSPREHA=VP_CODSUSP
     AND    COD_MODULO='GA';
  END IF;
  VP_ERROR := '5';
  SELECT ICM_SEQ_NUMMOV.NEXTVAL
  INTO   V_MOVABO
  FROM   DUAL;
  VP_ERROR := '6';
  IF VP_CODSERVSUPL = -1 THEN
     V_CODSERVSUPL := NULL;
  ELSE
     V_CODSERVSUPL := LPAD(TO_CHAR(VP_CODSERVSUPL),2,0);
  END IF;
  IF VP_CODNIVEL = -1 THEN
     V_CODNIVEL := NULL;
  ELSE
     V_CODNIVEL := LPAD(TO_CHAR(VP_CODNIVEL),4,0);
  END IF;
  VP_ERROR := '7';
  INSERT INTO ICM_MOVIMIENTO
         (NUM_MOVIMIENTO,  NUM_ABONADO,   COD_ESTADO,
          COD_MODULO,      NOM_USUARORA,  COD_CENTRAL,
          NUM_MAN,         COD_ACTUACION, FEC_INGRESO,
          NUM_SERIE,       COD_SERVICIOS, COD_SUSPREHA,
          TIP_TERMINAL,    COD_MODELO   , COD_ACTABO)
  VALUES (V_MOVABO,       VP_ABONADO ,    '1',
         'GA',            USER,           VP_CODCENTRAL,
          VP_MAN,         V_ACTUACION,    SYSDATE,
          VP_NUMSERIE ,   V_CODSERVSUPL || V_CODNIVEL,
          VP_CODSUSP,     VP_TIPTERMINAL, VP_CODMODELO, V_TIPSUSP);
  VP_ERROR := '0';
  EXCEPTION
    WHEN OTHERS THEN
           VP_DESERROR := SQLERRM ;
END;
/
SHOW ERRORS
