CREATE OR REPLACE TRIGGER TRG_BEIN_SC_CONCEPTO
BEFORE INSERT
ON SC_CONCEPTO
FOR EACH ROW
DECLARE

   -- Definicisn de varibles hosts
   V_CANT_GRUPOS       NUMBER;
   V_CANT_GRUPOS1	   NUMBER;
   V_MAX_COMBINACIONES NUMBER := 1;
   V_LAST_ID           NUMBER;
   V_COD_GRP_DOMINIO   NUMBER(2);
   V_NRO_MIEMBROS_GRP  NUMBER(2);
   I                   BINARY_INTEGER ;
   j                   BINARY_INTEGER ;
   V_DOMINIO_2         NUMBER(2);
   V_DOMINIO_3         NUMBER(2);
   V_DOMINIO_4 		   NUMBER(2);
   V_COD_DOMINIO_CTO   NUMBER(2);

   -- Nuevas variables
   V_LARGO             NUMBER(2);
   V_DOMINIO           NUMBER(2);
   V_POSICION          NUMBER(2);
   V_GRP_DOMINIO       NUMBER(2);
   V_MAX_SC			   NUMBER(10);

   -- Declaracion de nuevas variables. HOMOLOGACION MAC. TM-200402180522. 11-03-2004.
   V_LENDOMINIO        NUMBER:=2;  -- LONGITUD DEL CAMPO "COD_DOMINIO_CTO" DE LA TABLA "SC_DOMINIO_CTO"
   V_MAXVALCOL         NUMBER;     -- MAXIMO VALOR NUMERICO QUE SOPORTA LA COLUMNA "COD_CONCEPTO" DE LA TABLA "SC_GRP_DOMINIO_DET"
   V_LARGO_GRP	       NUMBER(2);  -- LARGO DEL GRUPO

   -- Definición de cursor
   CURSOR cgrp_dominio (cdominio NUMBER)
   IS SELECT COD_GRP_DOMINIO
        FROM SC_GRP_DOMINIO
       WHERE COD_DOMINIO_CTO = cdominio
    ORDER BY COD_GRP_DOMINIO;

	CURSOR cgrp_dominio_m (cdominio1 NUMBER, cdominio2 NUMBER)
	    IS   SELECT cod_dominio_cto
            FROM   SC_GRP_DOMINIO
            WHERE  COD_GRP_DOMINIO = cdominio1
              AND COD_DOMINIO_CTO <> cdominio2
			ORDER BY COD_DOMINIO_CTO;

BEGIN

   -- Valida que el dominio pertenezca al menos a un grupo, en caso contrario no hace nada
   SELECT COUNT(1)
     INTO V_CANT_GRUPOS
     FROM SC_GRP_DOMINIO
    WHERE COD_DOMINIO_CTO = :NEW.COD_DOMINIO_CTO;
   --
   IF V_CANT_GRUPOS > 0 THEN
   --
      OPEN cgrp_dominio (:NEW.COD_DOMINIO_CTO);
      FOR i IN 1..V_CANT_GRUPOS LOOP
         FETCH cgrp_dominio INTO V_GRP_DOMINIO;
         EXIT WHEN cgrp_dominio%NOTFOUND;

         SELECT COD_GRP_DOMINIO, NRO_MIEMBROS_GRP
           INTO V_COD_GRP_DOMINIO, V_NRO_MIEMBROS_GRP
           FROM SC_GRP_DOMINIO
          WHERE COD_DOMINIO_CTO = :NEW.COD_DOMINIO_CTO
            AND COD_GRP_DOMINIO = V_GRP_DOMINIO;

		 --Maxima cantidad de conceptos agrupados
		 SELECT NVL(MAX(TO_NUMBER(VAL_PARAMETRO)),0)
		 INTO V_LAST_ID
		 FROM GED_PARAMETROS
		 WHERE NOM_PARAMETRO = TO_CHAR(V_GRP_DOMINIO)
		 		 AND COD_MODULO = 'SC'
		 		 AND COD_PRODUCTO = 1;

         -- HOMOLOGACION MAC. TM-200402180522. 11-03-2004.
	       SELECT LEN_CONCEPTO,LPAD(9,LEN_CONCEPTO,'9') INTO V_LARGO_GRP, V_MAXVALCOL
	       FROM SC_DOMINIO_CTO
	       WHERE COD_DOMINIO_CTO = V_GRP_DOMINIO;

	 	 --
         -- Obtiene el ultimo identificador de tupla registrado en los detalles de grupo - concepto
         -- Verifica cuantos miembros hay en el grupo
         IF V_NRO_MIEMBROS_GRP = 1 THEN

             -- SE AGREGA CONDICION. HOMOLOGACION MAC. TM-200402180522. 11-03-2004.
               IF (1 + V_LAST_ID) > V_MAXVALCOL THEN
                   RAISE_APPLICATION_ERROR   (-20002,'ERROR TRG_AFIN_SC_CONCEPTO: Excede maximo de combinaciones posibles en sc_grp_dominio_det',TRUE);
               END IF;
            -- para grupos con un solo dominio, simplemente inserta el nuevo concepto en el detalle
            INSERT INTO SC_GRP_DOMINIO_DET
                     ( COD_GRP_DOMINIO , COD_DOMINIO_CTO,
                       COD_CONCEPTO    , COD_CTO_GRP    ,
                       DES_CONCEPTO_GRP, IND_CONTABILIZA_GRP )
               VALUES( V_COD_GRP_DOMINIO, :NEW.COD_DOMINIO_CTO,
                       :NEW.COD_CONCEPTO, LPAD(V_LAST_ID + 1, V_LARGO,'0'),
                       :NEW.DES_CONCEPTO, :NEW.IND_CONTABILIZA );
            --
         ELSE
            -- identifica a cada miembro del grupo que no sea el mismo miembro con el que estoy buscando
            -- Nota : me aprovecho de que los grupos son de maximo 3 dominios, por lo que podrian haber 1 o 2 elementos mas en este grupo.

			--V_CANT_GRUPOS1 := V_CANT_GRUPOS -1;
			OPEN cgrp_dominio_m (V_COD_GRP_DOMINIO, :NEW.COD_DOMINIO_CTO);

				FOR j IN 1..V_NRO_MIEMBROS_GRP LOOP
					FETCH cgrp_dominio_m INTO V_COD_DOMINIO_CTO;
					EXIT WHEN cgrp_dominio_m%NOTFOUND;

					IF j = 1 THEN
					   	  V_DOMINIO_2 := V_COD_DOMINIO_CTO;
					ELSIF j = 2 THEN
						  V_DOMINIO_3 := V_COD_DOMINIO_CTO;
					ELSIF j = 3 THEN
						  V_DOMINIO_4 := V_COD_DOMINIO_CTO;
					END IF;
			    END LOOP;
		    CLOSE cgrp_dominio_m;


	---  **********************
             SELECT COUNT(1)
             INTO   V_MAX_COMBINACIONES
             FROM   SC_CONCEPTO
             WHERE  COD_DOMINIO_CTO = V_DOMINIO_2;

      		 IF V_MAX_COMBINACIONES > 0 THEN
               -- Si es posible, realizar las combinaciones e insertarlas,sino, raise error .
               IF (V_MAX_COMBINACIONES + V_LAST_ID) > V_MAXVALCOL THEN
                  RAISE_APPLICATION_ERROR   (-20002,'ERROR TRG_AFIN_SC_CONCEPTO: Excede maximo de combinaciones posibles en sc_grp_dominio_det',TRUE);
               END IF;

               -- Se crean las tuplas considerando la cantidad de dominios que tiene el grupo
               IF V_NRO_MIEMBROS_GRP = 2  THEN
                  --
                  INSERT INTO SC_TUPLA
                       ( ID_TUPLA   ,
                        DOMINIO    ,
                        CONCEPTO   ,
                        DESCRIPCION,
                        CONTABLE )
                    SELECT ROWNUM AS ID_TUPLA,
                           LPAD(T1.COD_DOMINIO_CTO, V_LENDOMINIO,'0')||'/'||LPAD(:NEW.COD_DOMINIO_CTO, V_LENDOMINIO,'0'),
                           T1.COD_CONCEPTO ||'/'|| :NEW.COD_CONCEPTO,
                           TRIM(T1.DES_CONCEPTO) ||'/'|| :NEW.DES_CONCEPTO,
                           DECODE ( T1.IND_CONTABILIZA +:NEW.IND_CONTABILIZA,0,0,1 )
                      FROM SC_CONCEPTO T1
                     WHERE T1.COD_DOMINIO_CTO = V_DOMINIO_2  ;
                  --
               ELSIF V_NRO_MIEMBROS_GRP = 3 THEN
	                  SELECT V_MAX_COMBINACIONES * COUNT(1)
	                    INTO V_MAX_COMBINACIONES
	                    FROM SC_CONCEPTO
	                   WHERE COD_DOMINIO_CTO = V_DOMINIO_3  ;

	                 -- Si es posible, realizar las combinaciones e insertarlas,sino, raise error .
	                  IF (V_MAX_COMBINACIONES + V_LAST_ID) > V_MAXVALCOL THEN
	                     RAISE_APPLICATION_ERROR   (-20002,'ERROR TRG_AFIN_SC_CONCEPTO: Excede maximo de combinaciones posibles en sc_grp_dominio_det',TRUE);
	                  END IF;

	                  --
	                  INSERT INTO SC_TUPLA
	                     ( ID_TUPLA   ,
	                       DOMINIO    ,
	                       CONCEPTO   ,
	                       DESCRIPCION,
	                       CONTABLE )
	                    SELECT ROWNUM AS ID_TUPLA,
	                         LPAD(T1.COD_DOMINIO_CTO, V_LENDOMINIO,'0')||'/'||LPAD(T2.COD_DOMINIO_CTO, V_LENDOMINIO,'0')||'/'||LPAD(:NEW.COD_DOMINIO_CTO, V_LENDOMINIO,'0'),
	                         T1.COD_CONCEPTO ||'/'||T2.COD_CONCEPTO ||'/'||:NEW.COD_CONCEPTO,
	                         TRIM(T1.DES_CONCEPTO) ||'/'|| TRIM(T2.DES_CONCEPTO) ||'/'||:NEW.DES_CONCEPTO,
	                         DECODE (T1.IND_CONTABILIZA + T2.IND_CONTABILIZA + :NEW.IND_CONTABILIZA,0,0,1 )
	                    FROM SC_CONCEPTO T1 , SC_CONCEPTO T2
	                    WHERE T1.COD_DOMINIO_CTO = V_DOMINIO_2
	                    AND T2.COD_DOMINIO_CTO = V_DOMINIO_3;

				ELSIF V_NRO_MIEMBROS_GRP = 4 THEN
	                  SELECT V_MAX_COMBINACIONES * COUNT(1)
	                    INTO V_MAX_COMBINACIONES
	                    FROM SC_CONCEPTO
	                   WHERE COD_DOMINIO_CTO = V_DOMINIO_4;

	                 -- Si es posible, realizar las combinaciones e insertarlas,sino, raise error .
	                  IF (V_MAX_COMBINACIONES + V_LAST_ID) > V_MAXVALCOL THEN
	                     RAISE_APPLICATION_ERROR   (-20002,'ERROR TRG_AFIN_SC_CONCEPTO: Excede maximo de combinaciones posibles en sc_grp_dominio_det',TRUE);
	                  END IF;

	                  --
	                  INSERT INTO SC_TUPLA
	                     ( ID_TUPLA   ,
	                       DOMINIO    ,
	                       CONCEPTO   ,
	                       DESCRIPCION,
	                       CONTABLE )
	                    SELECT ROWNUM AS ID_TUPLA,
	                         LPAD(T1.COD_DOMINIO_CTO, V_LENDOMINIO,'0')||'/'||LPAD(T2.COD_DOMINIO_CTO, V_LENDOMINIO,'0')||'/'||LPAD(T3.COD_DOMINIO_CTO, V_LENDOMINIO,'0')||'/'||LPAD(:NEW.COD_DOMINIO_CTO, V_LENDOMINIO,'0'),
	                         T1.COD_CONCEPTO ||'/'||T2.COD_CONCEPTO ||'/'||T3.COD_CONCEPTO ||'/'||:NEW.COD_CONCEPTO,
	                         TRIM(T1.DES_CONCEPTO) ||'/'|| TRIM(T2.DES_CONCEPTO) ||'/'|| TRIM(T3.DES_CONCEPTO) ||'/'||:NEW.DES_CONCEPTO,
	                         DECODE (T1.IND_CONTABILIZA + T2.IND_CONTABILIZA + T3.IND_CONTABILIZA + :NEW.IND_CONTABILIZA,0,0,1 )
	                    FROM SC_CONCEPTO T1 , SC_CONCEPTO T2, SC_CONCEPTO T3
	                    WHERE T1.COD_DOMINIO_CTO = V_DOMINIO_2
	                    AND T2.COD_DOMINIO_CTO = V_DOMINIO_3
						AND T3.COD_DOMINIO_CTO = V_DOMINIO_4;

	                  --
        	   END IF;

               -- Se insertan las tuplas creadas en la tabla de detalles
               V_POSICION := 1;
               V_LARGO    := 0;

               FOR I IN 0 .. (V_NRO_MIEMBROS_GRP - 1) LOOP

			       SELECT DISTINCT LEN_CONCEPTO, COD_DOMINIO_CTO
	               INTO V_LARGO, V_DOMINIO
	               FROM SC_TUPLA, SC_DOMINIO_CTO
	               WHERE COD_DOMINIO_CTO = SUBSTR(DOMINIO,(1+(3*I)), V_LENDOMINIO);


                   INSERT INTO SC_GRP_DOMINIO_DET
                        (COD_GRP_DOMINIO ,
                         COD_DOMINIO_CTO ,
                         COD_CONCEPTO    ,
                         COD_CTO_GRP     ,
                         DES_CONCEPTO_GRP,
                        IND_CONTABILIZA_GRP )
                    SELECT V_COD_GRP_DOMINIO,
                           V_DOMINIO        ,
                           SUBSTR(CONCEPTO, V_POSICION, V_LARGO),
                           LPAD(V_LAST_ID + ID_TUPLA, V_LARGO_GRP ,'0'),
                           DESCRIPCION      ,
                           CONTABLE
                   FROM SC_TUPLA ;

                   V_POSICION := 1 + V_LARGO + V_POSICION;

               END LOOP;

           END IF;

         END IF;
         --
	 SELECT MAX(ID_TUPLA) + V_LAST_ID
	 INTO V_MAX_SC
	 FROM SC_TUPLA;

  	  UPDATE GED_PARAMETROS
	  SET VAL_PARAMETRO = TO_CHAR(V_MAX_SC)
	  WHERE NOM_PARAMETRO = TO_CHAR(V_GRP_DOMINIO)
		 		 AND COD_MODULO = 'SC'
		 		 AND COD_PRODUCTO = 1;

        DELETE SC_TUPLA ;
      --
      END LOOP;
      CLOSE cgrp_dominio;

   END IF;
   --
EXCEPTION
--
   WHEN NO_DATA_FOUND THEN

     V_LAST_ID := 0;
   WHEN OTHERS THEN
   BEGIN
   RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN TRIGGER : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);
   END;
--
END;
/
SHOW ERRORS
