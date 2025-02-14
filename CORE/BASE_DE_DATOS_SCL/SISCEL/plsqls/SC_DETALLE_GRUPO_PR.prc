CREATE OR REPLACE PROCEDURE SC_DETALLE_GRUPO_PR ( vp_Cod_grp_dominio IN NUMBER ) IS

iCod_dominio_cto    SC_GRP_DOMINIO.COD_DOMINIO_CTO%TYPE;
iLargo_grp          SC_DOMINIO_CTO.LEN_CONCEPTO%TYPE;
lMax_sc             SC_TUPLA.ID_TUPLA%TYPE;
iCod_Dominio_1      SC_GRP_DOMINIO.COD_DOMINIO_CTO%TYPE;
iCod_Dominio_2      SC_GRP_DOMINIO.COD_DOMINIO_CTO%TYPE;
iCod_Dominio_3      SC_GRP_DOMINIO.COD_DOMINIO_CTO%TYPE;
iCod_Dominio_4      SC_GRP_DOMINIO.COD_DOMINIO_CTO%TYPE;
iMaxvalcol          NUMBER(15);
iNumberGRP          NUMBER(2);
szTabla             VARCHAR2(30);
lLast_id            NUMBER(15);
iLargo              NUMBER(2):=0;
iLendominio         NUMBER:=2;
iPosicion           NUMBER(2);
iMax_combinaciones  NUMBER:=1;
szModulo            VARCHAR(2);
szCeroChar          VARCHAR(1):='0';
szNueveChar         VARCHAR(1):='9';
iCero               NUMBER:=0;
iUno                NUMBER:=1;
iTres               NUMBER:=3;
iNueve              NUMBER:=9;
i                   BINARY_INTEGER ;

CURSOR cur_grpdominio (cdominio NUMBER)  IS
SELECT COD_DOMINIO_CTO
FROM  SC_GRP_DOMINIO
WHERE COD_GRP_DOMINIO = cdominio;

BEGIN

   szModulo:='SC';
   szTabla := 'DETALLE_GRUPO';
	--Maxima cantidad de conceptos agrupados
   SELECT NVL(MAX(TO_NUMBER(VAL_PARAMETRO)),iCero)
   INTO  lLast_id
   FROM  GED_PARAMETROS
   WHERE NOM_PARAMETRO= TO_CHAR(vp_Cod_grp_dominio)
   AND   COD_MODULO   = szModulo
   AND   COD_PRODUCTO = iUno;

   -- cantidad de miembros por dominio agrupado
   SELECT UNIQUE NRO_MIEMBROS_GRP
   INTO   iNumberGRP
   FROM   SC_GRP_DOMINIO
   WHERE  COD_GRP_DOMINIO = vp_Cod_grp_dominio;

   -- apertura del cursor de la tabla SC_GRP_DOMINIO
   OPEN cur_grpdominio (vp_Cod_grp_dominio);

   SELECT LEN_CONCEPTO, LPAD(iNueve,LEN_CONCEPTO,szNueveChar)
   INTO  iLargo_grp   , iMaxvalcol
   FROM  SC_DOMINIO_CTO
   WHERE COD_DOMINIO_CTO = vp_Cod_grp_dominio;

   -- Verifica cuantos miembros hay en el grupo
   IF iNumberGRP > 1 THEN

         IF iNumberGRP = 2  THEN

            FOR i IN 1..iNumberGRP LOOP
               FETCH cur_grpdominio
               INTO  iCod_dominio_cto ;
               EXIT WHEN cur_grpdominio%NOTFOUND;

               IF i=1 THEN iCod_Dominio_1:=iCod_dominio_cto; END IF;
               IF i=2 THEN iCod_Dominio_2:=iCod_dominio_cto; END IF;

			   szTabla := 'SC_CONCEPTO(2)';
               SELECT iMax_combinaciones * COUNT(*)
               INTO  iMax_combinaciones
               FROM  SC_CONCEPTO
               WHERE COD_DOMINIO_CTO = iCod_dominio_cto;

            END LOOP;

			IF (iMax_combinaciones = 0 )THEN
			   RAISE_APPLICATION_ERROR   (-20002,'ERROR SC_DETALLE_GRUPO_PR: NO EXISTEN CONCEPTOS SIMPLES ',TRUE);
			END IF;

            -- Si es posible, realizar las combinaciones e insertarlas,sino, raise error .
            IF (iMax_combinaciones + lLast_id) > iMaxvalcol THEN
               RAISE_APPLICATION_ERROR   (-20002,'ERROR SC_DETALLE_GRUPO_PR: Excede maximo de combinaciones posibles en sc_grp_dominio_det',TRUE);
            END IF;

            -- Se crean las tuplas considerando la cantidad de dominios que tiene el grupo

            szTabla := 'ID_TUPLA(2)';
            INSERT INTO SC_TUPLA (
                   ID_TUPLA   ,   DOMINIO    ,
                   CONCEPTO   ,   DESCRIPCION,
                   CONTABLE   )
            SELECT ROWNUM AS ID_TUPLA,
                   LPAD(T1.COD_DOMINIO_CTO, iLendominio,szCeroChar)||'/'||LPAD(T2.COD_DOMINIO_CTO, iLendominio,szCeroChar),
                   T1.COD_CONCEPTO ||'/'|| T2.COD_CONCEPTO,
                   TRIM(T1.DES_CONCEPTO) ||'/'|| TRIM(T2.DES_CONCEPTO),
                   DECODE ( T1.IND_CONTABILIZA + T2.IND_CONTABILIZA,iCero,iCero,iUno )
            FROM   SC_CONCEPTO T1 , SC_CONCEPTO T2
            WHERE  T1.COD_DOMINIO_CTO = iCod_Dominio_1
            AND    T2.COD_DOMINIO_CTO = iCod_Dominio_2;

            --COMMIT;

         ELSIF iNumberGRP = 3 THEN

            FOR i IN 1..iNumberGRP LOOP
               FETCH cur_grpdominio
               INTO  iCod_dominio_cto ;
               EXIT WHEN cur_grpdominio%NOTFOUND;

               IF i=1 THEN iCod_Dominio_1:=iCod_dominio_cto; END IF;
               IF i=2 THEN iCod_Dominio_2:=iCod_dominio_cto; END IF;
               IF i=3 THEN iCod_Dominio_3:=iCod_dominio_cto; END IF;

			   szTabla := 'SC_CONCEPTO(3)';
               SELECT iMax_combinaciones * COUNT(*)
               INTO  iMax_combinaciones
               FROM  SC_CONCEPTO
               WHERE COD_DOMINIO_CTO = iCod_dominio_cto;

            END LOOP;

			IF (iMax_combinaciones = 0 )THEN
			   RAISE_APPLICATION_ERROR   (-20002,'ERROR SC_DETALLE_GRUPO_PR: NO EXISTEN CONCEPTOS SIMPLES ',TRUE);
			END IF;
            -- Si es posible, realizar las combinaciones e insertarlas,sino, raise error .
            IF (iMax_combinaciones + lLast_id) > iMaxvalcol THEN
               RAISE_APPLICATION_ERROR   (-20002,'ERROR TRG_AFIN_SC_CONCEPTO: Excede maximo de combinaciones posibles en sc_grp_dominio_det',TRUE);
            END IF;

            szTabla := 'ID_TUPLA(3)';
            INSERT INTO SC_TUPLA (
                   ID_TUPLA   ,  DOMINIO    ,
                   CONCEPTO   ,  DESCRIPCION,
                   CONTABLE )
            SELECT ROWNUM AS ID_TUPLA,
                   LPAD(T1.COD_DOMINIO_CTO, iLendominio,szCeroChar)||'/'||LPAD(T2.COD_DOMINIO_CTO, iLendominio,szCeroChar)||'/'||LPAD(iCod_dominio_cto, iLendominio,szCeroChar),
                   T1.COD_CONCEPTO ||'/'||T2.COD_CONCEPTO ||'/'||T3.COD_CONCEPTO,
                   TRIM(T1.DES_CONCEPTO) ||'/'|| TRIM(T2.DES_CONCEPTO) ||'/'||TRIM(T3.DES_CONCEPTO),
                   DECODE (T1.IND_CONTABILIZA + T2.IND_CONTABILIZA + T3.IND_CONTABILIZA,iCero,iCero,iUno )
            FROM   SC_CONCEPTO T1 , SC_CONCEPTO T2 , SC_CONCEPTO T3
            WHERE  T1.COD_DOMINIO_CTO = iCod_Dominio_1
            AND    T2.COD_DOMINIO_CTO = iCod_Dominio_2
            AND    T3.COD_DOMINIO_CTO = iCod_Dominio_3;

            --COMMIT;

         ELSIF iNumberGRP = 4 THEN

            FOR i IN 1..iNumberGRP LOOP
               FETCH cur_grpdominio
               INTO  iCod_dominio_cto ;
               EXIT WHEN cur_grpdominio%NOTFOUND;

               IF i=1 THEN iCod_Dominio_1:=iCod_dominio_cto; END IF;
               IF i=2 THEN iCod_Dominio_2:=iCod_dominio_cto; END IF;
               IF i=3 THEN iCod_Dominio_3:=iCod_dominio_cto; END IF;
               IF i=4 THEN iCod_Dominio_4:=iCod_dominio_cto; END IF;

			   szTabla := 'SC_CONCEPTO(4)';
               SELECT iMax_combinaciones * COUNT(*)
               INTO  iMax_combinaciones
               FROM  SC_CONCEPTO
               WHERE COD_DOMINIO_CTO = iCod_dominio_cto;

            END LOOP;

			IF (iMax_combinaciones = 0 )THEN
			   RAISE_APPLICATION_ERROR   (-20002,'ERROR SC_DETALLE_GRUPO_PR: NO EXISTEN CONCEPTOS SIMPLES ',TRUE);
			END IF;

            -- Si es posible, realizar las combinaciones e insertarlas,sino, raise error .
            IF (iMax_combinaciones + lLast_id) > iMaxvalcol THEN
               RAISE_APPLICATION_ERROR   (-20002,'ERROR TRG_AFIN_SC_CONCEPTO: Excede maximo de combinaciones posibles en sc_grp_dominio_det',TRUE);
            END IF;

           szTabla := 'ID_TUPLA(4)';
           INSERT INTO SC_TUPLA (
                  ID_TUPLA   ,  DOMINIO    ,
                  CONCEPTO   ,  DESCRIPCION,
                  CONTABLE   )
           SELECT ROWNUM AS ID_TUPLA,
                  LPAD(T1.COD_DOMINIO_CTO, iLendominio,szCeroChar)||'/'||LPAD(T2.COD_DOMINIO_CTO, iLendominio,szCeroChar)||'/'||LPAD(T3.COD_DOMINIO_CTO, iLendominio,szCeroChar)||'/'||LPAD(iCod_dominio_cto, iLendominio,szCeroChar),
                  T1.COD_CONCEPTO ||'/'||T2.COD_CONCEPTO ||'/'||T3.COD_CONCEPTO ||'/'||T4.COD_CONCEPTO,
                  TRIM(T1.DES_CONCEPTO) ||'/'|| TRIM(T2.DES_CONCEPTO) ||'/'|| TRIM(T3.DES_CONCEPTO) ||'/'|| TRIM(T4.DES_CONCEPTO),
                  DECODE (T1.IND_CONTABILIZA + T2.IND_CONTABILIZA + T3.IND_CONTABILIZA  + T4.IND_CONTABILIZA,iCero,iCero,iUno )
           FROM   SC_CONCEPTO T1 , SC_CONCEPTO T2, SC_CONCEPTO T3 , SC_CONCEPTO T4
           WHERE  T1.COD_DOMINIO_CTO = iCod_Dominio_1
           AND    T2.COD_DOMINIO_CTO = iCod_Dominio_2
           AND    T3.COD_DOMINIO_CTO = iCod_Dominio_3
           AND    T4.COD_DOMINIO_CTO = iCod_Dominio_4;

           --COMMIT;
         END IF;

         -- Se insertan las tuplas creadas en la tabla de detalles
         iPosicion := 1;
         iLargo    := 0;
         szTabla := 'SC_GRP_DOMINIO_DET(5)';

	        FOR I IN 0 .. (iNumberGRP - 1) LOOP

	           SELECT DISTINCT D.LEN_CONCEPTO, D.COD_DOMINIO_CTO
	           INTO  iLargo, iCod_dominio_cto
	           FROM  SC_TUPLA T, SC_DOMINIO_CTO D
	           WHERE D.COD_DOMINIO_CTO = SUBSTR(T.DOMINIO,(iUno+(iTres*I)), iLendominio);

	           szTabla := 'SC_GRP_DOMINIO_DET(6)';
	           INSERT INTO SC_GRP_DOMINIO_DET (
	                  COD_GRP_DOMINIO ,
	                  COD_DOMINIO_CTO ,
	                  COD_CONCEPTO    ,
	                  COD_CTO_GRP     ,
	                  DES_CONCEPTO_GRP,
	                  IND_CONTABILIZA_GRP )
	           SELECT vp_Cod_grp_dominio,
	                  iCod_dominio_cto,
	                  SUBSTR(CONCEPTO, iPosicion, iLargo),
	                  LPAD(lLast_id + ID_TUPLA, iLargo_grp ,szCeroChar),
	                  DESCRIPCION      ,
	                  CONTABLE
	           FROM   SC_TUPLA ;

	           iPosicion := 1 + iLargo + iPosicion;
	           COMMIT;

	        END LOOP;
   END IF; /* iNumberGRP > 1 */

   SELECT MAX(ID_TUPLA) + lLast_id
   INTO  lMax_sc
   FROM  SC_TUPLA;

   UPDATE GED_PARAMETROS SET
          VAL_PARAMETRO = TO_CHAR(lMax_sc)
   WHERE  NOM_PARAMETRO = TO_CHAR(vp_Cod_grp_dominio)
   AND    COD_MODULO    = szModulo
   AND    COD_PRODUCTO = iUno;

   DELETE FROM SC_TUPLA;
   COMMIT;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
        BEGIN
          lLast_id := 0;
          RAISE_APPLICATION_ERROR  (-20001,'DATO INCORRECTO : ORA-'||TO_CHAR(SQLCODE)||szTabla,TRUE);
        END;
   WHEN OTHERS THEN
        BEGIN
          RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN PROCEDIMIENTO : ORA-'||TO_CHAR(SQLCODE)|| szTabla,TRUE);
        END;
END SC_DETALLE_GRUPO_PR;
/
SHOW ERRORS
