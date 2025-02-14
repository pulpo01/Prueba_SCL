CREATE OR REPLACE PROCEDURE P_GA_SUSPABOBEEP(
  VP_PETICION IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_BEEPER IN NUMBER ,
  VP_TIPSUSP IN VARCHAR2 ,
  VP_CAUSASUSP IN VARCHAR2 ,
  VP_CODSUSP IN VARCHAR2 ,
  VP_CODCARGOREHA IN VARCHAR2 ,
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
                           COD_SITUACION = 'STP'
     WHERE NUM_ABONADO = VP_ABONADO;
     VP_ERROR := '2';
     INSERT INTO GA_SUSPREHABO
             (NUM_ABONADO    , COD_SERVICIO, FEC_SUSPBD   ,
              COD_PRODUCTO   , NUM_TERMINAL, NOM_USUARORA ,
              COD_MODULO     , TIP_REGISTRO, COD_CAUSUSP  ,
              TIP_SUSP       , COD_SERVSUPL, COD_NIVEL    ,
              FEC_SUSPCEN    , FEC_REHABD  , FEC_REHACEN  ,
              COD_CARGOBASICO, COD_OPERADOR, IND_SINIESTRO,
              NUM_PETICION)
     VALUES  (VP_ABONADO     , VP_CODSUSP  , SYSDATE ,
              2              , VP_BEEPER   , USER,
              'GA'           , 1           , VP_CAUSASUSP,
              VP_TIPSUSP     , NULL        , NULL,
              NULL           , NULL        , NULL,
              VP_CODCARGOREHA, NULL        , 0,
              VP_PETICION );
     VP_ERROR := '3';
     V_TIPSUSP := 'ST';
     SELECT COD_ACTUACION_SUSP
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
     UPDATE GA_SUSCBEEP SET STA = 'S'
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
             V_ACTUACION, 'ST'         , USER        , SYSDATE    ,
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
     VP_DESERROR := 'SOLO SE PERMITEN TIPO DE SUSPENSIONES TOTALES' ;
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
           VP_DESERROR := SUBSTR(SQLERRM,1,60) ;
END;
/
SHOW ERRORS
