CREATE OR REPLACE PROCEDURE P_GA_REHABOBEEP(
  VP_PETICION IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_BEEPER IN NUMBER ,
  VP_TIPSUSP IN VARCHAR2 ,
  VP_CODSUSP IN VARCHAR2 ,
  VP_CENTRAL IN NUMBER ,
  VP_ERROR IN OUT VARCHAR2 ,
  VP_DESERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de Suspension de Abonados Beeper
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Se inserto correctamente el registro
--         - "1" ; Error updateando GA_ABOBEEP
--         - "2" ; Error insertando GA_SUSPREABO
--         - "3" ; Error consultando tabla ICG_SUSPREHAMOD
--         - "4" ; Error consultando tabla DUAL
--         - "5" ; Error updateando GA_SUSCBEEP
--         - "6" ; Error Insertando ICB_MOVIMIENTO
--         - "7" ; El Tipo de Suspension no es 'T'
-- DECLARACION DE VARIABLES
  V_MOVABO NUMBER(9) ;
  V_TIPSUSP VARCHAR2(2);
  V_ACTUACION NUMBER(3);
BEGIN
  IF VP_TIPSUSP ='T' THEN
     VP_ERROR := '1';
     UPDATE GA_ABOBEEP SET FEC_ULTMOD = SYSDATE,
                           COD_SITUACION = 'RTP'
     WHERE NUM_ABONADO = VP_ABONADO;
     VP_ERROR := '2';
     UPDATE GA_SUSPREHABO SET FEC_REHABD = SYSDATE,
                              TIP_REGISTRO = 3
     WHERE NUM_ABONADO  = VP_ABONADO
     AND   NUM_PETICION = VP_PETICION;
     VP_ERROR := '3';
     V_TIPSUSP := 'RT';
     SELECT COD_ACTUACION_REHA
     INTO   V_ACTUACION
     FROM   ICG_SUSPREHAMOD
     WHERE  COD_PRODUCTO=2
     AND    COD_SUSPREHA=VP_CODSUSP
     AND    COD_MODULO='GA';
     VP_ERROR := '4';
     SELECT ICB_SEQ_NUMMOV.NEXTVAL
     INTO   V_MOVABO
     FROM   DUAL;
     VP_ERROR := '5';
     UPDATE GA_SUSCBEEP SET STA = 'N'
     WHERE NUM_ABONADO = VP_ABONADO;
     VP_ERROR := '6';
     INSERT INTO ICB_MOVIMIENTO
         (NUM_MOVIMIENTO, NUM_ABONADO  , COD_ESTADO  , COD_MODULO ,
          COD_ACTUACION , COD_ACTABO   , NOM_USUARORA, FEC_INGRESO,
          COD_CENTRAL   , TS           , ID          , CC         ,
          PRO           , VEL          , FRE         , COB        ,
          NOM           , GM1          , GM2         , GM3        ,
          GM4           , GM5          , NUM_IDENT   , STA        ,
          MARP          , MODP         , NSER        , TCUE       ,
          TIP_TERMINAL  , COD_SUSPREHA)
     (SELECT V_MOVABO   , NUM_ABONADO  , '1'         , 'GA'       ,
             V_ACTUACION, 'RT'         , USER        , SYSDATE    ,
             VP_CENTRAL , TS           , ID          , CC         ,
             PRO        , VEL          , FRE         , COB        ,
             NOM        , GM1          , GM2         , GM3        ,
             GM4        , GM5          , RUT         , STA        ,
             MARP       , MODP         , NSER        , TCUE       ,
             TP         , VP_CODSUSP
      FROM GA_SUSCBEEP
      WHERE NUM_ABONADO = VP_ABONADO);
      VP_ERROR := '0';
  ELSE
     VP_ERROR := '7';
     VP_DESERROR := 'SOLO SE PERMITEN TIPO DE REHABILITACIONES TOTALES' ;
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
           VP_DESERROR := SUBSTR(SQLERRM,1,60) ;
END;
/
SHOW ERRORS
