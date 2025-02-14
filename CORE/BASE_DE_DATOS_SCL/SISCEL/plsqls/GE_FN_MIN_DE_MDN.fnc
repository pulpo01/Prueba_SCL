CREATE OR REPLACE FUNCTION GE_FN_MIN_DE_MDN
  (nNUM_MDN IN VARCHAR2)
   RETURN NUMBER IS nNUM_MIN NUMBER;


   -- *** Función que retorna el número de
   --     Min correspendiente a un MDN ***

   -- *** Codigos de error retornados ***

   --  0 = No existe el número de MDN  .-
   --  1 = Error en el largo del MDN   .-
   --  2 = Error de formato (contiene caracteres no númericos).-
   --  3 = Error comienza con cero     .-
   --  SQLCODE = Error Oracle .-
   ---------------------------------------------------------------

   iLargoMin  NUMBER;
   iExiste    NUMBER;
   Ncont      PLS_INTEGER;
   sOPer      GE_OPERADORA_SCL_LOCAL.COD_OPERADORA_SCL%TYPE;
   sIndVig    GA_CELNUM_MIN_TD.IND_VIGENCIA_MIN_NUEVO%TYPE;
   iMinFinal  GA_CELNUM_MIN_TD.MIN_DESDE_NUEVO%TYPE;
   sPrefijo   GA_CELNUM_SUBALM.NUM_MIN%TYPE;
   CN_cero    CONSTANT PLS_INTEGER:=0;
   CN_uno     CONSTANT PLS_INTEGER:=1;
   CN_dos     CONSTANT PLS_INTEGER:=2;
   CN_tres    CONSTANT PLS_INTEGER:=3;
   CN_cuatro  CONSTANT PLS_INTEGER:=4;
   CN_ascii48 CONSTANT PLS_INTEGER:=48;
   CN_ascii57 CONSTANT PLS_INTEGER:=57;
   CN_s           CONSTANT VARCHAR(1):='S';
   CN_n           CONSTANT VARCHAR(1):='N';
   CN_tmm     CONSTANT VARCHAR(3):='TMM';
   CN_tmc     CONSTANT VARCHAR(3):='TMC';
   CN_mpr     CONSTANT VARCHAR(3):='MPR';
   CN_nompara CONSTANT VARCHAR(15):='LARGO_N_CELULAR';
   -- INICIO INCIDENCIA XO-200510190912 C.C.A.  24-10-2005
   CN_nompara1 CONSTANT VARCHAR(15):='VALIDA_MIN_GSM';
   sValidaMin VARCHAR(5);
   -- FIN INCIDENCIA XO-200510190912 C.C.A.  24-10-2005

BEGIN

   IF nNUM_MDN IS NULL THEN
        RAISE_APPLICATION_ERROR(-20101, 'No se ha ingresado numero Minimo de MDN');
   END IF;


   Ncont:=CN_cero;

   IF SUBSTR(nNUM_MDN,CN_uno,CN_dos) = CN_cero THEN
                nNUM_MIN:= CN_tres; --ERROR COMIENZA CON CERO
                RETURN nNUM_MIN;
   END IF;

   LOOP
     IF ASCII(SUBSTR(nNUM_MDN,Ncont,Ncont+CN_uno)) < CN_ascii48
                OR ASCII(SUBSTR(nNUM_MDN,Ncont,Ncont+CN_uno)) > CN_ascii57 THEN

                nNUM_MIN:= CN_dos; --ERROR DE FORMATO
                RETURN nNUM_MIN;
     END IF;
     EXIT WHEN Ncont = LENGTH(nNUM_MDN);

     Ncont:= Ncont + CN_uno;
   END LOOP;

   -- INICIO INCIDENCIA XO-200510190912 C.C.A.  24-10-2005
   -- Optenemos parametro para saber si validamos con la formula el min...
   SELECT VAL_PARAMETRO
   INTO sValidaMin
   FROM GED_PARAMETROS
   WHERE NOM_PARAMETRO=CN_nompara1;

   if sValidaMin = 'FALSE' then
     --  si es falso se devuelve min igual a MDN
         nNUM_MIN := nNUM_MDN ;
         RETURN nNUM_MIN;
   end if ;
   -- FIN INCIDENCIA XO-200510190912 C.C.A.  24-10-2005


   SELECT VAL_PARAMETRO
   INTO iLargoMin
   FROM GED_PARAMETROS
   WHERE NOM_PARAMETRO=CN_nompara;




   IF LENGTH(nNUM_MDN)<>iLargoMin THEN
          nNUM_MIN:= CN_uno; --ERROR EN EL LARGO
          RETURN  nNUM_MIN;
   END IF;

   SELECT count(NUM_DESDE)
   INTO iExiste
   FROM GA_CELNUM_SUBALM
   WHERE nNUM_MDN BETWEEN NUM_DESDE AND NUM_HASTA;

   IF IEXISTE=CN_cero THEN
          nNUM_MIN:= CN_cero;   --No existe
          RETURN nNUM_MIN; ---
   END IF;


   SELECT GE_FN_OPERADORA_SCL
   INTO sOPer
   FROM DUAL;



   IF sOPer = CN_tmm THEN
                  SELECT IND_VIGENCIA_MIN_NUEVO
                  INTO  sIndVig
                  FROM GA_CELNUM_MIN_TD
                  WHERE nNUM_MDN BETWEEN
                  NUM_DESDE AND NUM_HASTA;

                  IF sIndVig = CN_s THEN
                         SELECT  MIN_DESDE_NUEVO
                         INTO iMinFinal
                         FROM GA_CELNUM_MIN_TD
                         WHERE nNUM_MDN BETWEEN
                         NUM_DESDE AND NUM_HASTA
                         AND IND_VIGENCIA_MIN_NUEVO=CN_s;

                  ELSIF sIndVig = CN_n THEN
                         SELECT  MIN_DESDE_ACTUAL
                         INTO iMinFinal
                         FROM GA_CELNUM_MIN_TD
                         WHERE nNUM_MDN BETWEEN
                         NUM_DESDE AND NUM_HASTA
                         AND IND_VIGENCIA_MIN_NUEVO=CN_n;
                  END IF;

                  nNUM_MIN := SUBSTR(iMinFinal,CN_uno,iLargoMin-CN_cuatro) || SUBSTR(nNUM_MDN, iLargoMin-CN_tres);

        ELSIF sOPer=CN_tmc THEN

                  SELECT NUM_MIN
                  INTO sPrefijo
                  FROM GA_CELNUM_SUBALM
                  WHERE nNUM_MDN BETWEEN
                  NUM_DESDE AND NUM_HASTA;

                  nNUM_MIN := sPrefijo || SUBSTR(nNUM_MDN,CN_dos);

        ELSIF sOPer=CN_mpr THEN
                          begin
                                  SELECT NUM_MIN INTO iMinFinal
                                  FROM ADN_PORTADO_IN_TO
                                  WHERE NUM_CELULAR=nNUM_MDN;

                                  nNUM_MIN := iMinFinal;
                                  EXCEPTION
                                           WHEN NO_DATA_FOUND THEN
                                               nNUM_MIN := nNUM_MDN;
                               WHEN OTHERS THEN
                                                                          RETURN SQLCODE;
                                  END;

    END IF;


RETURN nNUM_MIN;

EXCEPTION
     WHEN NO_DATA_FOUND THEN
           RETURN SQLCODE;
     WHEN OTHERS THEN
          RETURN SQLCODE;

END;
/
SHOW ERRORS
