CREATE OR REPLACE procedure P_REPONER_NUMERACION
(
  VP_TRANSAC IN VARCHAR2 ,
  VP_TABLA IN VARCHAR2 ,
  VP_SUBALM IN VARCHAR2 ,
  VP_CENTRAL IN VARCHAR2 ,
  VP_CAT IN VARCHAR2 ,
  VP_USO IN VARCHAR2 ,
  VP_CELULAR IN VARCHAR2 ,
  VP_FECBAJA IN VARCHAR2)
IS

   V_CENTRAL GA_CELNUM_USO.COD_CENTRAL%TYPE := TO_NUMBER(VP_CENTRAL);
   V_CAT GA_CELNUM_USO.COD_CAT%TYPE := TO_NUMBER(VP_CAT);
   V_USO GA_CELNUM_USO.COD_USO%TYPE := TO_NUMBER(VP_USO);
   V_USO_ORIG GA_CELNUM_USO.COD_USO%TYPE;
   V_FECBAJA GA_CELNUM_REUTIL.FEC_BAJA%TYPE;
   V_CELULAR GA_CELNUM_USO.NUM_DESDE%TYPE := TO_NUMBER(VP_CELULAR);
   V_ERRMS GA_TRANSACABO.DES_CADENA%TYPE;
   V_FORMAT_FECHA  GA_TRANSACABO.DES_CADENA%TYPE;
   V_DIAS_HIBER   AL_USOS.NUM_DIAS_HIBERNACION%TYPE; --Inc 43735 Jonathan Ledesma 12/10/2007

BEGIN

  V_FORMAT_FECHA := SP_FN_FORMATOFECHA('FORMATO_SEL2') ;

--

--Ini inc 43735 Jonathan Ledesma 12/10/2007
--  IF VP_TABLA = 'L' THEN
--    V_FECBAJA := SYSDATE -59;
--  ELSIF VP_TABLA <> 'S' THEN
--    V_FECBAJA := TO_DATE(VP_FECBAJA,V_FORMAT_FECHA);
--  END IF;

  BEGIN

  SELECT NUM_DIAS_HIBERNACION
  INTO V_DIAS_HIBER
  FROM AL_USOS
  WHERE COD_USO = VP_USO;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
        V_DIAS_HIBER := 0;
  END;

  V_FECBAJA := SYSDATE - V_DIAS_HIBER;

--Fin inc 43735 Jonathan Ledesma 12/10/2007

  declare
  cursor C_FILA_ABOCEL (p_celular number) is
   SELECT NUM_CELULAR
--   INTO FILA_ABOCEL
   FROM GA_ABOCEL
   WHERE NUM_CELULAR = p_celular
   AND COD_SITUACION NOT IN ('BAA','BAP');

  R_FILA_ABOCEL C_FILA_ABOCEL%rowtype;

  Begin

  Open C_FILA_ABOCEL(v_celular);
  Fetch C_FILA_ABOCEL into R_FILA_ABOCEL;
  IF C_FILA_ABOCEL%NOTFOUND THEN

    declare

    cursor C_FILA_ALMACEN (p_celular number) is
     SELECT NUM_TELEFONO
  --   INTO FILA_ALMACEN
     FROM AL_SERIES
     WHERE NUM_TELEFONO = p_celular;

     R_FILA_ALMACEN C_FILA_ALMACEN%rowtype;

     Begin

     Open C_FILA_ALMACEN (v_celular);
     Fetch C_FILA_ALMACEN into R_FILA_ALMACEN;
     IF C_FILA_ALMACEN%NOTFOUND THEN

        declare

        cursor C_FILA_ACTIVAS (p_celular number) is
         SELECT NUM_TELEFONO
      --   INTO FILA_ACTIVAS
         FROM AL_SERIES_ACTIVAS
         WHERE NUM_TELEFONO = p_celular;

         R_FILA_ACTIVAS C_FILA_ACTIVAS%rowtype;

         Begin

         Open C_FILA_ACTIVAS (v_celular);
         Fetch C_FILA_ACTIVAS into R_FILA_ACTIVAS;
         IF C_FILA_ACTIVAS%NOTFOUND THEN

            declare

            cursor C_FILA_ABOAMIST (p_celular number) is
             SELECT NUM_CELULAR
          --   INTO FILA_ABOAMIST
             FROM GA_ABOAMIST
             WHERE NUM_CELULAR = p_celular
             AND COD_SITUACION NOT IN ('BAA','BAP');

             R_FILA_ABOAMIST C_FILA_ABOAMIST%rowtype;

             Begin

             Open C_FILA_ABOAMIST (v_celular);
             Fetch C_FILA_ABOAMIST into R_FILA_ABOAMIST;
             IF C_FILA_ABOAMIST%NOTFOUND THEN

                         IF VP_TABLA = 'S' THEN

                                Declare
                                R_ga_hreserva ga_hreserva%rowtype;
                              Begin
                                     Select * into R_ga_hreserva
                                  From GA_HRESERVA
                                     WHERE NUM_CELULAR  = V_CELULAR
                                     FOR UPDATE OF NUM_CELULAR NOWAIT;

                                     INSERT INTO GA_RESERVA (COD_CLIENTE, COD_VENDEDOR, ORIGEN, FEC_RESERVA, NUM_CELULAR,
                                     COD_SUBALM, COD_PRODUCTO, COD_CENTRAL, COD_CAT, COD_USO, FEC_BAJA,IND_EQUIPADO, USO_ANTERIOR)
                                     values ( R_ga_hreserva.COD_CLIENTE, R_ga_hreserva.COD_VENDEDOR, R_ga_hreserva.ORIGEN, R_ga_hreserva.FEC_RESERVA
                                   , R_ga_hreserva.NUM_CELULAR, R_ga_hreserva.COD_SUBALM, R_ga_hreserva.COD_PRODUCTO, R_ga_hreserva.COD_CENTRAL
                                   , R_ga_hreserva.COD_CAT, R_ga_hreserva.COD_USO, R_ga_hreserva.FEC_BAJA,R_ga_hreserva.IND_EQUIPADO
                                   , R_ga_hreserva.USO_ANTERIOR);

                                    DELETE GA_HRESERVA WHERE NUM_CELULAR  = V_CELULAR;
                              End;

                        ELSE

                        SELECT /*+ INDEX (GA_CELNUM_USO GA_CEUSO_HASTDESD_IE )*/  COD_USO 
                                INTO V_USO_ORIG
                               FROM GA_CELNUM_USO
                               WHERE VP_CELULAR BETWEEN NUM_DESDE AND NUM_HASTA;

                              INSERT INTO GA_CELNUM_REUTIL
                                    (NUM_CELULAR,COD_SUBALM,COD_PRODUCTO,COD_CENTRAL,COD_CAT,COD_USO,
                                     FEC_BAJA,IND_EQUIPADO, USO_ANTERIOR)
                              VALUES (V_CELULAR,VP_SUBALM,1,V_CENTRAL,V_CAT,V_USO,V_FECBAJA,1, V_USO_ORIG);
                        END IF;

                      INSERT INTO GA_TRANSACABO(NUM_TRANSACCION,COD_RETORNO,DES_CADENA)
                      VALUES (VP_TRANSAC,0,NULL);

                      COMMIT;
               END IF;
              Close C_FILA_ABOAMIST;
            End;
        END IF;
        Close C_FILA_ACTIVAS;
       End;
     END IF;
   Close C_FILA_ALMACEN;
   End;
 END IF;
 Close C_FILA_ABOCEL;
End; -- primer declare-begin
EXCEPTION
    WHEN OTHERS THEN
         IF SQLCODE = -54 THEN
           P_REPONER_NUMERACION (VP_TRANSAC ,
                                  VP_TABLA ,
                                  VP_SUBALM ,
                                  VP_CENTRAL ,
                                  VP_CAT ,
                                  VP_USO ,
                                  VP_CELULAR ,
                                  VP_FECBAJA );
         ELSE
            ROLLBACK;
                        V_ERRMS := SQLERRM;
            INSERT INTO GA_TRANSACABO
                       (NUM_TRANSACCION,
                        COD_RETORNO,
                        DES_CADENA)
            VALUES (VP_TRANSAC,4,V_ERRMS);
            COMMIT;
         END IF;
END;
/
SHOW ERRORS