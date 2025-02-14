CREATE OR REPLACE PACKAGE BODY VE_VALIDACION_PG
AS

CV_ind_facturado         CONSTANT PLS_INTEGER := 1;
CN_cero                  CONSTANT PLS_INTEGER := 0;
CN_error                 CONSTANT PLS_INTEGER := 4;
CV_val_ooss_activacion   CONSTANT VARCHAR2(19):='VAL_OOSS_ACTIVACION';
CV_cantidad_posventa     CONSTANT VARCHAR2(17):='CANTIDAD_POSVENTA';
CV_max_dias_posventa     CONSTANT VARCHAR2(17):='MAX_DIAS_POSVENTA';
CV_cod_modulo            CONSTANT VARCHAR2(2) := 'GA';
CV_cod_producto          CONSTANT PLS_INTEGER := 1;
CV_ci_tiporserv          CONSTANT VARCHAR2(12):='CI_TIPORSERV';
CV_cod_os                CONSTANT VARCHAR2(6) :='COD_OS';
CV_cantidad_venta        CONSTANT VARCHAR2(14):='CANTIDAD_VENTA';
CV_max_dias_venta        CONSTANT VARCHAR2(14):='MAX_DIAS_VENTA';
CV_co_cartera            CONSTANT VARCHAR2(10):='CO_CARTERA';
CV_cod_tipdocum          CONSTANT VARCHAR2(12):='COD_TIPDOCUM';
CV_num_nac_operador      CONSTANT VARCHAR2(16):='NUM_NAC_OPERADOR';

PROCEDURE GE_SEQ_CLIENTES_PR(EN_num_transaccion IN NUMBER)
IS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_VALIDACION_PG" Lenguaje="PL/SQL" Fecha="21-03-2006" Versión="1.0.0" Diseñador="Vladimir Maureira" Programador="Vladimir Maureira" Ambiente="SQAPRECOL">
 <Retorno>NA</Retorno>
  <Descripción>Retorna Codigo del cliente</Descripción>
 <Parámetros>
  <Entrada>
    <param nom="EN_num_transaccion" Tipo="NUMBER">num transaccion</param>
  </Entrada>
  <Salida>
  </Salida>
 </Parámetros>
</Elemento>
</Documentación>
*/

PRAGMA AUTONOMOUS_TRANSACTION;
ERROR_EJECUCION  EXCEPTION;

LN_RETORNO       NUMBER;

BEGIN

     LN_RETORNO:=GE_SEQ_CLIENTES_FN(EN_num_transaccion);

EXCEPTION
  WHEN OTHERS THEN
        ve_graba_error_pr('VE',1,SYSDATE,1,'GE_SEQ_CLIENTES_PR',NULL,NULL,SQLCODE,SUBSTR(SQLERRM,1,60));
END GE_SEQ_CLIENTES_PR;


FUNCTION VE_CALCULADIGITO_FN (EV_cadena    IN GE_CLIENTES.NUM_IDENT%TYPE,
                              EN_avalores  IntArray,
                              EN_posfinal  NUMBER,
                              EN_modulo    NUMBER,
                              EB_dividir   BOOLEAN)
RETURN NUMBER IS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_CALCULADIGITO_FN" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="vmb" Ambiente="DEIMOS_ANDINA">
<Retorno>NA</Retorno>
<Descripción>Inserta la transaccion (con o sin error) </Descripción>
<Parámetros>
<Entrada>
<param nom="EV_cadena" Tipo="STRING">cadena</param>
<param nom="EN_avalores" Tipo="STRING">Valores posibles</param>
<param nom="EN_posfinal" Tipo="STRING">posicion</param>
<param nom="EN_modulo" Tipo="STRING">Modulo</param>
<param nom="EB_dividir" Tipo="STRING">Parametro Booleano</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
--Valores fijos --
CN_cero           NUMBER :=0;
CN_nueve          NUMBER :=9;
--Variables --
GN_counter	  NUMBER;
GN_valor          NUMBER := 0;
GN_suma	   	  NUMBER := 0;
GN_residuo 	  NUMBER := 0;
GN_digver 	  NUMBER := 0;
BEGIN

	--Calculo multiplicacion y suma--
	FOR GN_counter IN  1..EN_posfinal LOOP

		GN_valor:= EN_avalores(GN_counter) * TO_NUMBER(SUBSTR(EV_cadena, GN_counter,1));
		IF EB_dividir AND GN_valor > CN_nueve then

			--si el resultado es de dos digitos, se deben sumar entre ellos --
			GN_valor := SUBSTR(TO_CHAR(GN_valor), 1,1) +  SUBSTR(TO_CHAR(GN_valor), 2,1);

		END IF;

		GN_suma:= GN_suma + GN_valor;

	END LOOP;
	--Calculo digito verificador
	GN_residuo := MOD( GN_suma, EN_modulo );

	IF GN_residuo = CN_cero THEN
	   GN_digver := GN_residuo;
	ELSE
	   GN_digver := EN_modulo - GN_residuo;
	END IF;

	RETURN GN_digver;

END VE_CALCULADIGITO_FN;

PROCEDURE VE_GA_TRANSACABO_PR(EN_num_transaccion  IN NUMBER,
                              EN_coderror         IN NUMBER,
                              EV_msgerror         IN VARCHAR2)
AS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_GA_TRANSACABO_PR" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="vmb" Ambiente="DEIMOS_ANDINA">
<Retorno>NA</Retorno>
<Descripción>Inserta la transaccion (con o sin error) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_transaccion" Tipo="STRING">Numero de la transacción</param>
<param nom="SN_coderror" Tipo="STRING">0 Proceso realizado correctamente,4 En el proceso se produjo un error</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  BEGIN

       INSERT INTO GA_TRANSACABO
               (num_transaccion, cod_retorno, des_cadena)
       VALUES
               (EN_num_transaccion,EN_coderror,EV_msgerror);

  END;

  COMMIT;
END VE_GA_TRANSACABO_PR;

PROCEDURE VE_GRABA_ERROR_PR (EV_cod_actabo    IN VARCHAR2,
                          EN_codigo        IN NUMBER,
                          ED_fec_error     IN DATE,
                          EN_cod_producto  IN NUMBER,
                          EV_nom_proc      IN VARCHAR2,
                          EV_nom_tabla     IN VARCHAR2,
                          EV_cod_act       IN VARCHAR2,
                          EV_cod_sqlcode   IN VARCHAR2,
                          EV_cod_sqlerrm   IN VARCHAR2)
IS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_GRABA_ERROR_PR" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="vmb" Ambiente="DEIMOS_ANDINA">
<Retorno>NA</Retorno>
<Descripción>Descripcion del error</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_cod_actabo" Tipo="STRING">codigo actabo</param>
<param nom="EN_codigo" Tipo="STRING">codigo</param>
<param nom="ED_fec_error" Tipo="STRING">fecha</param>
<param nom="EN_cod_producto" Tipo="STRING">codigo producto</param>
<param nom="EV_nom_proc" Tipo="STRING">nombre funcion</param>
<param nom="EV_nom_tabla" Tipo="STRING">nombre tabla</param>
<param nom="EV_cod_act" Tipo="STRING">codigo</param>
<param nom="EV_cod_sqlcode" Tipo="STRING">codigo del error</param>
<param nom="EV_cod_sqlerrm" Tipo="STRING">descripcion del error</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  BEGIN

       INSERT INTO ga_errores
               (cod_actabo,codigo,fec_error,cod_producto,nom_proc,nom_tabla,cod_act,cod_sqlcode,cod_sqlerrm)
       VALUES
               (EV_cod_actabo,EN_codigo,ED_fec_error,EN_cod_producto,EV_nom_proc,EV_nom_tabla,EV_cod_act,EV_cod_sqlcode,EV_cod_sqlerrm);

  END;

  COMMIT;
END VE_GRABA_ERROR_PR;

PROCEDURE VE_VENTA_LEGALIZADAS_PR(EN_num_transaccion IN NUMBER,
                                  EV_cod_tipcomis    IN VARCHAR2,
                                  EV_cod_vendealer   IN VARCHAR2,
                                  EV_cod_vendedor    IN VARCHAR2)
IS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_VENTA_LEGALIZADAS_PR" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="vmb" Ambiente="DEIMOS_ANDINA">
<Retorno>NA</Retorno>
<Descripción>Retorna si la venta posee venta legalizada</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_transaccion" Tipo="STRING">num transaccion</param>
<param nom="EV_cod_tipcomis" Tipo="STRING">codigo</param>
<param nom="EV_cod_vendealer" Tipo="STRING">codigo dealer</param>
<param nom="EV_cod_vendedor" Tipo="STRING">codigo vendedor</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LE_ERROR             EXCEPTION;
LN_coderror          NUMBER(1):=0;
LV_msgerror          VARCHAR2(255):='';
TV_dias_legales      GED_PARAMETROS.VAL_PARAMETRO%TYPE:='';
TN_ind_vta_externa   ve_tipcomis.ind_vta_externa%TYPE:=0;
LV_sql               VARCHAR2(1000):='';
TN_ventaNoLegal      NUMBER(9);
TN_CantVentNoLegales NUMBER;
TV_cod_vendedor      GA_VENTAS.COD_VENDEDOR%TYPE;
BEGIN

--modificado P-COL-06003-G4
        --TV_dias_legales := ge_fn_devvalparam(CV_cod_modulo,CV_cod_producto,'DIAS_LEGALIZACION');
--modificado P-COL-06003-G4

-- P-COL-06003-E2
--      TN_CantVentNoLegales := TO_NUMBER(ge_fn_devvalparam(CV_cod_modulo,CV_cod_producto,'CANT_VENT_NO_LEG'));
--  P-COL-06003-E2

        BEGIN
               SELECT ind_vta_externa
               INTO   TN_ind_vta_externa
               FROM   ve_tipcomis
               WHERE  cod_tipcomis = EV_cod_tipcomis;

         EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 LN_coderror := CN_error;
                 LV_msgerror := 'VE_VENTA_LEGALIZADAS_PR al obtener ind_vta_externa de Tabla VE_TIPCOMIS.  SQLCODE:' || TO_CHAR(SQLCODE);
                 RAISE LE_ERROR ;

            WHEN OTHERS THEN
                 LN_coderror := CN_error;
                 LV_msgerror := 'VE_VENTA_LEGALIZADAS_PR  SQLERRM:' || SUBSTR(SQLERRM,1,150);
                 RAISE LE_ERROR ;
        END;

        IF TN_ind_vta_externa = 1 THEN -- DEALER
          TV_cod_vendedor :=EV_cod_vendealer;
        ELSE
          TV_cod_vendedor :=EV_cod_vendedor;
        END IF;
--modificado P-COL-06003-G4
 	LV_sql := 'select NUM_DIALEG from ve_cupobloqueo_to where COD_VENDEDOR = :cod_vendedor AND SYSDATE BETWEEN FEC_INI AND FEC_FIN';
	BEGIN
	 	EXECUTE IMMEDIATE LV_sql INTO TV_dias_legales USING TV_cod_vendedor;
	EXCEPTION WHEN NO_DATA_FOUND THEN
	            TV_dias_legales := ge_fn_devvalparam(CV_cod_modulo,CV_cod_producto,'DIAS_LEGALIZACION');
	END;
--modificado P-COL-06003-G4

--INI P-COL-06003-E2
	LV_sql := 'select CAN_DIAS from ve_cupobloqueo_to where COD_VENDEDOR = :cod_vendedor AND SYSDATE BETWEEN FEC_INI AND FEC_FIN' ;
	BEGIN
	 	EXECUTE IMMEDIATE LV_sql INTO TN_CantVentNoLegales USING TV_cod_vendedor;
	EXCEPTION WHEN NO_DATA_FOUND THEN
	            TN_CantVentNoLegales := ge_fn_devvalparam(CV_cod_modulo,CV_cod_producto,'CANT_VENT_NO_LEG');
	END;
--FIN P-COL-06003-E2

        LV_sql := 'SELECT COUNT(1)';
        LV_sql := LV_sql || ' FROM ga_ventas ga';
        IF TN_ind_vta_externa = 1 THEN -- DEALER
           LV_sql := LV_sql || ' WHERE ga.cod_vendealer =:cod_vendedor';
        ELSE
           LV_sql := LV_sql || ' WHERE ga.cod_vendedor = :cod_vendedor';
        END IF;
         LV_sql := LV_sql || ' AND ga.fec_recdocum IS NULL';
      	-- inc. 42022 27-07-2007
        --LV_sql := LV_sql || ' AND ga.fec_venta + :dias_legales  < SYSDATE ';
		LV_sql := LV_sql || ' AND ga.fec_venta < SYSDATE - :dias_legales';
		-- fin inc. 42022 27-07-2007
		-- Inicio incidencia (1-1) RA-200602150772 [mept Soporte 15-02-2006]
        LV_sql := LV_sql || ' AND IND_VENTA = ''V''';
		-- Fin incidencia RA-200602150772 [mept Soporte 15-02-2006]

        BEGIN
            EXECUTE IMMEDIATE LV_sql INTO TN_ventaNoLegal USING TV_cod_vendedor,TV_dias_legales;

            EXCEPTION
             WHEN NO_DATA_FOUND THEN
             -- No hay ventas
                TN_ventaNoLegal:=0;
             WHEN OTHERS THEN
                 LN_coderror := CN_error;
                 LV_msgerror := 'VE_VENTA_LEGALIZADAS_PR';
                 LV_msgerror := LV_msgerror || ' Parametros ind_vta_externa ' || TN_ind_vta_externa  || ' cod_vendedor:' || EV_cod_vendedor || ' cod_vendealer:' || EV_cod_vendealer || ' dias :' || TV_dias_legales;
                 LV_msgerror := LV_msgerror || ' SQLERRM:' || SUBSTR(SQLERRM,1,100);
                 RAISE LE_ERROR;
        END;

        IF TN_ventaNoLegal > TN_CantVentNoLegales THEN
           ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,'0');
        ELSE
           ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,'1');
        END IF;


  EXCEPTION
    WHEN LE_ERROR THEN
         ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
         ve_graba_error_pr('VE',1,SYSDATE,1,'VE_VENTA_LEGALIZADAS_PR',NULL,NULL,SQLCODE,SUBSTR(SQLERRM,1,60));
    WHEN OTHERS THEN
         LN_coderror := CN_error;
         LV_msgerror := 'VE_VENTA_LEGALIZADAS_PR SQLERRM:' || SUBSTR(SQLERRM,1,150);
         ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
         ve_graba_error_pr('VE',1,SYSDATE,1,'VE_VENTA_LEGALIZADAS_PR',NULL,NULL,SQLCODE,SUBSTR(SQLERRM,1,60));
END VE_VENTA_LEGALIZADAS_PR;

PROCEDURE VE_VENTA_VENCIDAS_PR(EN_num_transaccion IN NUMBER,
							   --INICIO: RA-200601100554 ; USER:JEIM; FECHA:12/01/2006 NOTA: Se comenta la variable [EV_cod_vendedor] y
							   -- se remplaza por [EV_cod_vendealer]
                               EV_cod_vendealer    IN ga_ventas.cod_vendealer%TYPE,
							   		--EV_cod_vendedor IN VARCHAR2
							   --FIN: RA-200601100554 ; USER:JEIM; FECHA:12/01/2006
							   --Inicio Incidencia RA-200511220180 [PAAA 29-11-2005, soporte]
                               EV_tipo_vendedor   IN VARCHAR2 := 'V')
                        	   --Fin Incidencia RA-200511220180)
IS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_VENTA_VENCIDAS_PR" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="vmb" Ambiente="DEIMOS_ANDINA">
<Retorno>NA</Retorno>
<Descripción>valida si las ventas que ha realizado el vendedor han sido pagadas,
en el caso de no estar canceladas y además sobrepasan los días de vencimiento de factura
(parámetro en la tabla ged_parametros). -</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_transaccion" Tipo="NUMERIC">num transaccion</param>
<param nom="EV_cod_vendealer" Tipo="STRING">codigo vendedor</param>
<param nom="EV_tipo_vendedor" Tipo="STRING">codigo vendedor</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LE_ERROR            EXCEPTION;
LN_coderror         NUMBER(1):=0;
LV_msgerror         VARCHAR2(255):='';
LV_resultado        VARCHAR2(1):='';
LV_sql               VARCHAR2(200):='';
TN_dias_vencimiento NUMBER:=0;
TN_debehaber        NUMBER(14,4):=0;
TN_cod_cliente      GA_VENTAS.COD_CLIENTE%TYPE;
TV_num_venta        GA_VENTAS.NUM_VENTA%TYPE;

--RA-200601260642

CURSOR cClientes IS
SELECT A.COD_CLIENTE, A.NUM_VENTA
FROM  GA_VENTAS A
--INICIO: RA-200601100554 ; USER:JEIM; FECHA:12/01/2006 NOTA: La busqueda es ahora por el cod_Vendealer y no por cod_vendedor
--WHERE A.cod_vendedor = EV_cod_vendealer; --Defecto certificacion Col, se deja como estaba. 22/03/2006
WHERE A.cod_vendedor = EV_cod_vendealer AND IND_VENTA='V';  -- 65892 - JMC - 20/05/2008
--WHERE A.cod_vendealer = EV_cod_vendealer;
--FIN: RA-200601100554 ; USER:JEIM; FECHA:12/01/2006 NOTA: La busqueda es ahora por el cod_Vendealer y no por cod_vendedor

CURSOR cClientesD IS
SELECT A.COD_CLIENTE, A.NUM_VENTA
FROM  GA_VENTAS A
--WHERE A.COD_VENDEALER = EV_cod_vendealer;
WHERE A.COD_VENDEALER = EV_cod_vendealer AND IND_VENTA='V';  -- 65892 - JMC - 20/05/2008

BEGIN


--modificado P-COL-06003-G4
  	LV_sql := 'select NUM_DIAPAG from ve_cupobloqueo_to where COD_VENDEDOR = :cod_vendedor AND SYSDATE BETWEEN FEC_INI AND FEC_FIN';
	BEGIN
 		EXECUTE IMMEDIATE LV_sql INTO TN_dias_vencimiento USING EV_cod_vendealer;
	EXCEPTION WHEN NO_DATA_FOUND THEN
        	TN_dias_vencimiento := TO_NUMBER(ge_fn_devvalparam(CV_cod_modulo,CV_cod_producto,'DIAS_VENC_FACT'));
	END;
--modificado P-COL-06003-G4

   IF  EV_tipo_vendedor = 'V' THEN
      BEGIN
         OPEN cClientes;
         LOOP
            FETCH cClientes INTO TN_cod_cliente,TV_num_venta;
            EXIT WHEN cClientes%NOTFOUND;

               SELECT NVL(SUM(co.importe_debe - co.importe_haber),0)
               INTO TN_debehaber
               FROM   co_cartera co
               WHERE  co.cod_cliente   = TN_cod_cliente
               AND    co.num_venta     = TV_num_venta
               AND    co.ind_facturado = CV_ind_facturado
               AND    co.fec_vencimie  < SYSDATE - TN_dias_vencimiento
               -- 65892 - JMC - 20/05/2008
               --AND    NVL(co.sec_cuota,0) = 0          /* Soporte RyC DVG 17-07-2006 MCO-200606060001 */
                 AND    (co.sec_cuota = 0 OR co.sec_cuota IS NULL)
                 AND    NOT EXISTS  (SELECT 1
                                      FROM co_codigos cod
                                      WHERE cod.nom_tabla   = CV_co_cartera
                                      AND   cod.nom_columna = CV_cod_tipdocum
                                      AND   cod.cod_valor = to_char(co.cod_tipdocum));
                -- 65892 - JMC - 20/05/2008

               --AND    co.cod_tipdocum NOT IN ( SELECT TO_NUMBER(cod.cod_valor)
               --                                FROM co_codigos cod
               --                                WHERE cod.nom_tabla   = CV_co_cartera
               --                                AND   cod.nom_columna = CV_cod_tipdocum);
               --Inicio incidencia CO-200604210074 NRCA
               -- 65892 - JMC - 20/05/2008
               --AND CO.NUM_VENTA IN (SELECT NUM_VENTA FROM GA_VENTAS WHERE IND_VENTA='V');
               --
              --Fin incidencia CO-200604210074 NRCA
            EXIT WHEN TN_debehaber > 0;
         END LOOP;
         CLOSE cClientes;

         EXCEPTION
         WHEN NO_DATA_FOUND THEN
         -- No hay ventas
         TN_debehaber:=0;

         WHEN OTHERS THEN
            LN_coderror := CN_error;
            LV_msgerror := 'VE_VENTA_VENCIDAS_PR';
            LV_msgerror := LV_msgerror || ' Parametros cod_cliente ' || TN_cod_cliente  || ' ind_facturado:' || CV_ind_facturado || ' dias :' || TN_dias_vencimiento;
            LV_msgerror := LV_msgerror || ' SQLERRM:' || SUBSTR(SQLERRM,1,100);
            RAISE LE_ERROR;
      END;
   ELSE
      BEGIN
         OPEN cClientesD;
         LOOP
               FETCH cClientesD INTO TN_cod_cliente,TV_num_venta;
               EXIT WHEN cClientesD%NOTFOUND;

                  SELECT NVL(SUM(co.importe_debe - co.importe_haber),0)
                  INTO TN_debehaber
                  FROM   co_cartera co
                  WHERE  co.cod_cliente   = TN_cod_cliente
                  AND    co.num_venta     = TV_num_venta
                  AND    co.ind_facturado = CV_ind_facturado
                  AND    co.fec_vencimie  < SYSDATE - TN_dias_vencimiento
                  -- 65892 - JMC - 20/05/2008
                  --AND    NVL(co.sec_cuota,0) = 0          /* Soporte RyC DVG 17-07-2006 MCO-200606060001 */
                  AND    (co.sec_cuota = 0 OR co.sec_cuota IS NULL)
                  AND    NOT EXISTS  (SELECT 1
                                      FROM co_codigos cod
                                      WHERE cod.nom_tabla   = CV_co_cartera
                                      AND   cod.nom_columna = CV_cod_tipdocum
                                      AND   cod.cod_valor = to_char(co.cod_tipdocum));
                  -- 65892 - JMC - 20/05/2008

                  --AND    co.cod_tipdocum NOT IN ( SELECT TO_NUMBER(cod.cod_valor)
                  --                                FROM co_codigos cod
                  --                                WHERE cod.nom_tabla   = CV_co_cartera
                  --                                AND   cod.nom_columna = CV_cod_tipdocum);
                  --Inicio incidencia CO-200604210074 NRCA
                  -- 65892 - JMC - 20/05/2008
                  -- AND CO.NUM_VENTA IN (SELECT NUM_VENTA FROM GA_VENTAS WHERE IND_VENTA='V');
                  --Fin incidencia CO-200604210074 NRCA

               EXIT WHEN TN_debehaber > 0;
         END LOOP;
         CLOSE cClientesD;

         EXCEPTION
         WHEN NO_DATA_FOUND THEN
            -- No hay ventas
            TN_debehaber:=0;

         WHEN OTHERS THEN
            LN_coderror := CN_error;
            LV_msgerror := 'VE_VENTA_VENCIDAS_PR';
            LV_msgerror := LV_msgerror || ' Parametros cod_cliente ' || TN_cod_cliente  || ' ind_facturado:' || CV_ind_facturado || ' dias :' || TN_dias_vencimiento;
            LV_msgerror := LV_msgerror || ' SQLERRM:' || SUBSTR(SQLERRM,1,100);
            RAISE LE_ERROR;
      END;
   END IF;
--RA-200601260642

   IF TN_debehaber > 0 THEN
      LV_resultado := '0';
   ELSE
      LV_resultado := '1';
   END IF;

   ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_resultado);
   EXCEPTION
   WHEN LE_ERROR THEN
      ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
      ve_graba_error_pr('VE',1,SYSDATE,1,'VE_VENTA_VENCIDAS_PR',NULL,NULL,SQLCODE,SUBSTR(SQLERRM,1,60));
   WHEN OTHERS THEN
      LN_coderror := CN_error;
      LV_msgerror := 'VE_VENTA_VENCIDAS_PR SQLERRM:' || SUBSTR(SQLERRM,1,150);
      ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
      ve_graba_error_pr('VE',1,SYSDATE,1,'VE_VENTA_VENCIDAS_PR',NULL,NULL,SQLCODE,SUBSTR(SQLERRM,1,60));


END VE_VENTA_VENCIDAS_PR;

PROCEDURE VE_VALIDANUMFIJO_PR(EN_num_transaccion IN NUMBER,
                              EV_num_telefono IN VARCHAR2,
                              EV_cod_area     IN VARCHAR2)
IS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_VALIDANUMFIJO_PR" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="vmb" Ambiente="DEIMOS_ANDINA">
<Retorno>NA</Retorno>
<Descripción>valida el número de teléfono (fijo) del cliente -</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_transaccion" Tipo="STRING">num transaccion</param>
<param nom="EV_num_telefono" Tipo="STRING">numero telefono</param>
<param nom="EV_cod_area" Tipo="STRING">codigo area</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LE_ERROR            EXCEPTION;
LN_coderror         NUMBER(1):=0;
LV_msgerror         VARCHAR2(255):='';
TN_count            NUMBER(1):=0;
TN_cod_operador     ta_numnacional.cod_operador%TYPE;
BEGIN

     TN_cod_operador := TO_NUMBER(ge_fn_devvalparam(CV_cod_modulo,CV_cod_producto,CV_num_nac_operador));
     IF LN_coderror = CN_error THEN
        RAISE LE_ERROR;
     END IF;

     BEGIN
        SELECT
               1
        INTO
               TN_count
        FROM   ta_numnacional ta
        WHERE  ta.cod_operador = TN_cod_operador
        AND    ta.cod_area     = EV_cod_area
        AND    EV_num_telefono BETWEEN ta.num_tdesde AND ta.num_thasta;

        IF TN_count = 1 THEN
           ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
        END IF;

        EXCEPTION
         WHEN LE_ERROR THEN
           LN_coderror := CN_error;
           LV_msgerror := 'Numero Nacional Operador no existe en GED_PARAMETROS :' || CV_num_nac_operador;
           ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
         WHEN NO_DATA_FOUND THEN
           LN_coderror := CN_error;
           LV_msgerror := 'Número de teléfono inválido. ';
           ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
         WHEN OTHERS THEN
           LN_coderror := CN_error;
           LV_msgerror := 'VE_VALIDANUMFIJO_PR SQLERRM:' || SUBSTR(SQLERRM,1,150);
           ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
           ve_graba_error_pr('VE',1,SYSDATE,1,'VE_VALIDANUMFIJO_PR',NULL,NULL,SQLCODE,SUBSTR(SQLERRM,1,60));
     END;
END VE_VALIDANUMFIJO_PR;

PROCEDURE VE_VALIDAPOSVENTA_PR(EN_num_transaccion IN NUMBER,
                               EV_parametros      IN VARCHAR2)
IS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_VALIDAPOSVENTA_PR" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="vmb" Ambiente="DEIMOS_ANDINA">
<Retorno>NA</Retorno>
<Descripción>un cliente podrá realizar máximo 3 posventas (cambio de serie y/o restitución de equipo) en 90 días,
en caso de sobrepasar la cantidad de posventa, se enviará un mensaje indicando la situación del cliente</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_transaccion" Tipo="NUMBER">Numero de transaccion</param>
<param nom="EV_parametros" Tipo="STRING">parametros</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LE_ERROR       EXCEPTION;
LN_coderror    NUMBER(1):=0;
LV_msgerror    VARCHAR2(255):='';
TV_cod_valor   ged_codigos.cod_valor%TYPE;
TN_Canposvta   NUMBER;
TN_MaxDias     NUMBER;
TN_count       NUMBER:=0;
TN_cod_cliente NUMBER(9);
LN_count       NUMBER:=0;

CURSOR cursor_codigos IS
SELECT ged.cod_valor
FROM   ged_codigos ged
WHERE  ged.nom_tabla   = CV_ci_tiporserv
AND    ged.nom_columna = CV_cod_os
AND    ged.cod_modulo  = CV_cod_modulo;

BEGIN
     TN_cod_cliente  := TO_NUMBER(EV_parametros);

     TN_Canposvta := TO_NUMBER(ge_fn_devvalparam(CV_cod_modulo,CV_cod_producto,CV_cantidad_posventa));
     TN_MaxDias := TO_NUMBER(ge_fn_devvalparam(CV_cod_modulo,CV_cod_producto,CV_max_dias_posventa));

     OPEN cursor_codigos;
     LOOP
       FETCH cursor_codigos INTO TV_cod_valor;
       EXIT WHEN cursor_codigos%NOTFOUND;
       BEGIN
            --Ini. Inc. 40454 Rodrigo Araneda 29/05/2007
/*
            SELECT index (GA, AK_GA_ABOCEL_CLIENTE)
                   COUNT(1)
            INTO
                   TN_count
            FROM   CI_ORSERV CI
            WHERE  CI.cod_os IN (TV_cod_valor)
            --Inicio incidencia 38660 NRCA se optimiza query
            --AND    TIP_INTER in (0,1)
            --Fin incidencia 38660 NRCA se optimiza query
            AND    CI.cod_inter IN (SELECT GA.num_abonado
                                    FROM ga_abocel GA
                                    WHERE GA.cod_cliente = TN_cod_cliente)
            AND CI.fecha >= SYSDATE - TN_MaxDias;
*/
           LN_count := 0;
           --Fin Inc. 40454 Rodrigo Araneda 29/05/2007

           LN_count := LN_count + TN_count;

        EXCEPTION
           WHEN NO_DATA_FOUND THEN
                TN_count:= 0;
           WHEN OTHERS THEN
                LV_msgerror := 'VE_VALIDAPOSVENTA_PR Valida PostVenta permitidas. SQLERRM:' || SUBSTR(SQLERRM,1,150);
                RAISE LE_ERROR;
       END;
     END LOOP;
     CLOSE cursor_codigos;

     IF LN_count >= TN_Canposvta THEN
        LV_msgerror := 'Supera la cantidad de posventas permitidas.';
        LN_coderror := CN_cero;
     END IF;

      ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);

  EXCEPTION
    WHEN LE_ERROR THEN
         LN_coderror := CN_error;
         ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
    WHEN OTHERS THEN
         LN_coderror := CN_error;
         LV_msgerror := 'VE_VALIDAPOSVENTA_PR SQLERRM:' || SUBSTR(SQLERRM,1,150);
         ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
END VE_VALIDAPOSVENTA_PR;

PROCEDURE VE_VALIDAVENTA_PR(EN_num_transaccion  IN NUMBER,
                            EV_parametros      IN VARCHAR2)
IS

/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_VALIDAVENTA_PR" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="vmb" Ambiente="DEIMOS_ANDINA">
<Retorno>NA</Retorno>
<Descripción>Se valida la cantidad de ventas que realiza un cliente, en un máximo de días</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_transaccion" Tipo="NUMBER">Numero de transaccion</param>
<param nom="EV_parametros" Tipo="STRING">parametros</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LE_ERROR       EXCEPTION;
LN_coderror    NUMBER(1):=0;
LV_msgerror    VARCHAR2(255):='';
TV_cod_valor   ged_codigos.cod_valor%TYPE;
TN_Canvta      NUMBER;
TN_MaxDias     NUMBER;
TN_count       NUMBER(9):=0;
LV_retorna     VARCHAR2(1):='';
TN_cod_cliente NUMBER(9);
BEGIN
     TN_cod_cliente  := TO_NUMBER(EV_parametros);

     TN_Canvta := TO_NUMBER(ge_fn_devvalparam(CV_cod_modulo,CV_cod_producto,CV_cantidad_venta));
     TN_MaxDias := TO_NUMBER(ge_fn_devvalparam(CV_cod_modulo,CV_cod_producto,CV_max_dias_venta));

     BEGIN
            SELECT
                     COUNT(1)
            INTO
                     TN_count
            FROM   ga_ventas ga
            WHERE  ga.cod_cliente = TN_cod_cliente
            AND    ga.fec_venta  >= SYSDATE - TN_MaxDias;

            IF TN_count >= TN_Canvta THEN
               LV_msgerror  := 'El cliente supera la cantidad de ventas permitidas.';
               LN_coderror  :=CN_cero;
            END IF;

       EXCEPTION
           WHEN OTHERS THEN
            LV_msgerror := 'VE_VALIDAVENTA_PR Valida ventas permitidas. SQLERRM:' || SUBSTR(SQLERRM,1,150);
            RAISE LE_ERROR;
    END;

         ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
  EXCEPTION
    WHEN LE_ERROR THEN
         LN_coderror := CN_error;
         ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
    WHEN OTHERS THEN
         LN_coderror := CN_error;
         LV_msgerror := 'VE_VALIDAVENTA_PR SQLERRM:' || SUBSTR(SQLERRM,1,150);
         ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
END VE_VALIDAVENTA_PR;

PROCEDURE VE_VALIDAFACTURA_PR(EN_num_transaccion  IN NUMBER,
                              EV_parametros      IN VARCHAR2)
IS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_VALIDAFACTURA_PR" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="vmb" Ambiente="DEIMOS_ANDINA">
<Retorno>NA</Retorno>
<Descripción>Se valida si el cliente tiene facturas pendientes de cancelar.</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_transaccion" Tipo="NUMBER">Numero de transaccion</param>
<param nom="EV_parametros" Tipo="STRING">parametros</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LN_coderror    NUMBER(1):=0;
LV_msgerror    VARCHAR2(255):='';
TN_debehaber   NUMBER(14,4);
TN_cod_cliente NUMBER(9);
BEGIN
   TN_cod_cliente  := TO_NUMBER(EV_parametros);

   BEGIN
      SELECT
            NVL(SUM(importe_debe - importe_haber),0)
      INTO
            TN_debehaber
      FROM  co_cartera co
      WHERE co.cod_cliente   = TN_cod_cliente
      AND   co.ind_facturado = CV_ind_facturado
      AND   co.fec_vencimie  < TRUNC( SYSDATE )
      AND   co.cod_tipdocum NOT IN ( SELECT TO_NUMBER(cod.cod_valor)
                                     FROM co_codigos cod
                                     WHERE cod.nom_tabla   = CV_co_cartera
                                     AND   cod.nom_columna = CV_cod_tipdocum);

      IF TN_debehaber > 0 THEN
         LN_coderror  := CN_cero;
         LV_msgerror  := 'Cliente con facturas pendientes';
      END IF;

         ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
      EXCEPTION
       WHEN NO_DATA_FOUND THEN
         LN_coderror := CN_error;
         LV_msgerror  := 'No hay Datos en Consulta Tabla CO_CARTERA cod_cliente :' || EV_parametros;
         ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
       WHEN OTHERS THEN
         LN_coderror := CN_error;
         LV_msgerror := 'VE_VALIDAFACTURA_PR SQLERRM:' || SUBSTR(SQLERRM,1,150);
         ve_ga_transacabo_pr(EN_num_transaccion,LN_coderror,LV_msgerror);
   END;
END VE_VALIDAFACTURA_PR;

FUNCTION VE_VALIDANIT_FN(EV_num_ident    IN ge_clientes.num_ident%TYPE,
                         EV_cod_tipident IN ge_tipident.cod_tipident%TYPE)
RETURN VARCHAR2 IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "VE_VALIDANIT_FN" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="igr" Ambiente="DEIMOS_ANDINA">
<Retorno>VARCHAR2</Retorno>
<Descripción>Funcion que retorna el identificador del Cliente previa validacion 123456789-9   NIT(9)-DIGITO(1)</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_ident" Tipo="STRING">numero identificatorio</param>
<param nom="EV_cod_tipident" Tipo="STRING">codigo tipident</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

--Retorno de funcion --
GV_idvalido     VARCHAR2(200);
--Valores fijos --
CN_producto     ged_parametros.cod_producto%TYPE :=1;
CV_modulo       ged_parametros.cod_modulo%TYPE   :='GA';
CV_largo_id     ged_parametros.nom_parametro%TYPE:='LARGO_IDNIT';
CV_valid_id     ged_parametros.nom_parametro%TYPE:='ID_VALIDONIT';
CV_cero         NUMBER     :=0;
CV_valordiv     NUMBER     :=11;
CV_valormin     NUMBER     :=0;
CV_valormax     NUMBER     :=1;
--INI P-COL-05026
CV_largoarr     NUMBER     :=15;
--FIN P-COL-05026
CV_separador    VARCHAR2(1):='-';
CV_blanco       VARCHAR2(1):=' ';
CV_valorparruc  VARCHAR2(2):='01';
CS_error        VARCHAR(5):= 'ERROR';

--Variables --
GV_idsinguion   ge_clientes.num_ident%TYPE;
GN_cod_ident    ged_parametros.val_parametro%TYPE;
GV_validaid     ged_parametros.val_parametro%TYPE;
GN_valor        NUMBER  := 0;
GV_largoid 		GED_PARAMETROS.VAL_PARAMETRO%TYPE:= '0';
GN_suma	   		NUMBER  := 0;
GN_residuo 		NUMBER  := 0;
GN_digver 		NUMBER  := 0;
GN_contador		NUMBER  := 1;
GN_counter		NUMBER;
v_num_ident_alm   VARCHAR(20);
--INI P-COL-05026
TYPE IntArray IS VARRAY(15) OF INTEGER;
--FIN P-COL-05026
GN_avalores     IntArray;

BEGIN -- PL/SQL Block


  GV_idvalido:=EV_num_ident;

	--OBTIENE VALORES DESDE TABLA DE PARAMETROS
	--Obtiene largo id --
   GV_largoid := ge_fn_devvalparam(CV_modulo, CN_producto, CV_largo_id );

   IF GV_largoid=CS_error THEN
      RETURN 'ERROR No existe parametro largo ID en ged_parametros ' || CV_largo_id || ', Favor Verificar' ;
   END IF;

   --Obtiene cod ident valido --
   GV_validaid := GE_FN_DEVVALPARAM(CV_modulo, CN_producto, CV_valid_id );

   IF GV_validaid=CS_error THEN
      RETURN 'ERROR No existe parametro codigo NIT valido  en ged_parametros ' || CV_valid_id || ', Favor Verificar' ;
   END IF;
	--FIN OBTIENE VALORES DESDE TABLA DE PARAMETROS

    -- revisa que tipo de identificador sea valido, exista en ge_tipident
	BEGIN
		 SELECT count(1) INTO GN_valor
		   FROM ge_tipident a
	      WHERE a.cod_tipident = EV_cod_tipident;

	EXCEPTION
       WHEN NO_DATA_FOUND THEN
	         RETURN 'ERROR Tipo de identificacion NIT ' || EV_cod_tipident || ' no existe';
	   WHEN OTHERS THEN
	         RETURN 'ERROR VE_VALIDANIT_FN SQLERRM:' || SUBSTR(SQLERRM,1,150);
	END;
    IF GN_valor=CV_cero THEN
       RETURN 'ERROR Tipo de identificacion NIT ' || EV_cod_tipident || ' no existe';
	END IF;
		--se procesa si y solo si existe en parametro codigo NIT valido  --
	IF INSTR(GV_validaid, EV_cod_tipident ) = CV_cero THEN
	   -- No se valida si no existe en los codigos nit validos, se retorna el num identificador tal como estaba --
	    GV_idvalido:=EV_num_ident;
	ELSE

	   --Asigna tip ident sacando los guiones
	   GV_idsinguion := REPLACE(EV_num_ident, CV_separador, '');
   	   -- AQUÍ VA EL LLENADO Incidencia XO-627
	   --INI P-COL-05026
	   GV_idsinguion := LPAD(GV_idsinguion,TO_NUMBER(GV_largoid)+1,'0');
	   --FIN P-COL-05026
   	   --Asigna tip ident sacando los blancos
	   GV_idsinguion := REPLACE(GV_idsinguion, CV_blanco, '');

	   IF LENGTH(GV_idsinguion)-1 <= TO_NUMBER(GV_largoid) THEN

			--REVISAR QUE EL NIT SEA NUMERICO
			BEGIN
				 GN_valor:= TO_NUMBER(GV_idsinguion);
			EXCEPTION
	           WHEN OTHERS THEN
			     RETURN 'ERROR Valor no numerico en ' || GV_idsinguion || ', Favor Verificar';
			END;

		   --Realiza calculo de digito verificador --
		   --Valores fijos a multiplicar segun posicion
		   --INI P-COL-05026
		   GN_avalores := IntArray(71,67,59,53,	47,	43,	41,	37,	29,	23,	19,	17,	13,	7,	3);
		   GN_contador:= CV_largoarr;
	       GN_counter := length(GV_idsinguion)-1;
		   WHILE (GN_counter > 0) LOOP

			     GN_suma:= GN_suma + ( GN_avalores(GN_contador) * TO_NUMBER(SUBSTR(GV_idsinguion,GN_counter,1)) );

		         GN_counter := GN_counter-1;
				 GN_contador:= GN_contador-1;
		   END LOOP;


			GN_residuo := MOD( GN_suma, CV_valordiv );

			IF GN_residuo > 1 THEN
			   GN_residuo := CV_valordiv - GN_residuo;
			END IF;

		    GN_digver := GN_residuo;
		   --FIN P-COL-05026

			IF GN_digver = SUBSTR(GV_idsinguion, LENGTH(GV_idsinguion),1) THEN
			    -- Saca ceros a la izquierda Incidencia XO-627
				GV_idsinguion:= TO_CHAR(TO_NUMBER(GV_idsinguion));
				--Formatear identificador
				GV_idvalido := SUBSTR(GV_idsinguion,1,LENGTH(GV_idsinguion)-1) || CV_separador || SUBSTR(GV_idsinguion,LENGTH(GV_idsinguion),1);

				--retornar identificador formateado
			ELSE
				GV_idvalido := 'ERROR Digito verificador no coincide ' || EV_num_ident || ', Favor Verificar.';
			END IF;
	   ELSE
		     GV_idvalido := 'ERROR Formato no valido ' || EV_num_ident || ', Favor Verificar.';
	   END IF;

	END IF;

	--Retorna identificador del cliente formateado o mensaje de error --
	RETURN GV_idvalido;
END VE_VALIDANIT_FN;

FUNCTION VE_VALIDARUCPRIVADA_FN (EV_num_ident    IN ge_clientes.num_ident%TYPE,
                          EV_cod_tipident IN ge_tipident.cod_tipident%TYPE)
RETURN VARCHAR2 IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "VE_VALIDARUCPRIVADA_FN" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="igr" Ambiente="DEIMOS_ANDINA">
<Retorno>VARCHAR2</Retorno>
<Descripción>Funcion que retorna el identificador-
--           RUC del Cliente previa validacion   -
--           La validaciones a efectuar corresponden a:
--           - Sociedades Privadas y extranjeros sin cedula  --
-- Formato   : 1234567890123                       -
</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_ident" Tipo="STRING">numero identificatorio</param>
<param nom="EV_cod_tipident" Tipo="STRING">codigo tipident</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
GV_idvalido     VARCHAR2(200);
--Valores fijos --
CN_valormin   NUMBER :=1;
CN_valormax   NUMBER :=22;
CN_tercerpri  NUMBER :=9;
CV_numestable VARCHAR2(3):='001';
CN_posfinal   NUMBER :=9;

--Variables --
GV_idsinguion GE_CLIENTES.NUM_IDENT%TYPE;
GB_procesar   BOOLEAN:= TRUE;
GN_avalores   IntArray;
GN_modulo	  NUMBER := 11;
GN_digver 	  NUMBER := 0;

BEGIN
	GV_idvalido   := EV_num_ident;
	GV_idsinguion := EV_num_ident;

   	IF TO_NUMBER(SUBSTR(GV_idsinguion,1,2)) < CN_valormin OR TO_NUMBER(SUBSTR(GV_idsinguion,1,2)) > CN_valormax THEN
		GB_procesar := FALSE;
   	END IF;

   	--3 digito 9 - 6 - menor a 6	   -
   	IF GB_procesar THEN
	   IF TO_NUMBER(SUBSTR(GV_idsinguion,3,1)) <> CN_tercerpri THEN
			GB_procesar := FALSE;
	   END IF;
   	END IF;

   	--11-13 digito siempre igual a 0001  -
   	IF GB_procesar THEN
	   IF SUBSTR(GV_idsinguion,11,3) <> CV_numestable THEN
			GB_procesar := FALSE;
	   END IF;
   	END IF;

   	IF NOT GB_procesar THEN
   	  RETURN 'ERROR Formato no válido ' || GV_idsinguion || ', Favor Verificar';
   	END IF;

	--Realiza calculo de digito verificador --
	IF GB_procesar THEN
	   --Asigna coeficientes --
	   --Valores fijos a multiplicar segun posicion
	   GN_avalores := IntArray(4, 3, 2, 7, 6, 5, 4, 3, 2);

	   GN_digver := VE_CALCULADIGITO_FN( GV_idsinguion, GN_avalores, CN_posfinal, GN_modulo, FALSE);

	   --Es digito verificador correcto
	   IF GN_digver = SUBSTR(GV_idsinguion, (CN_posfinal+1),1) THEN
	   	    GV_idvalido := GV_idsinguion;
	   ELSE
			GV_idvalido := 'ERROR Digito verificador no coincide ' || EV_num_ident || ', Favor Verificar.';
	   END IF;

	END IF;

	--Retorna identificador del cliente o mensaje de error --
	RETURN GV_idvalido;

END VE_VALIDARUCPRIVADA_FN;

FUNCTION VE_VALIDARUCNATURAL_FN (EV_num_ident    IN ge_clientes.num_ident%TYPE,
                          		 EV_cod_tipident IN ge_tipident.cod_tipident%TYPE)
RETURN VARCHAR2 IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "VE_VALIDARUCNATURAL_FN" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="igr" Ambiente="DEIMOS_ANDINA">
<Retorno>VARCHAR2</Retorno>
<Descripción>Funcion que retorna el identificador-
--           RUC del Cliente previa validacion   -
--           La validaciones a efectuar corresponden a:
--           - Personas naturales
-- Formato   : 1234567890123                       -
</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_ident"    Tipo="STRING">numero identificatorio</param>
<param nom="EV_cod_tipident" Tipo="STRING">codigo tipident</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
GV_idvalido     VARCHAR2(200);
--Valores fijos --
CN_valormin   NUMBER :=1;
CN_valormax   NUMBER :=22;
CN_tercernat  NUMBER :=6;
CV_numestable VARCHAR2(3):='001';
CN_posfinal   NUMBER :=9;

--Variables --
GV_idsinguion GE_CLIENTES.NUM_IDENT%TYPE;
GB_procesar   BOOLEAN:= TRUE;
GN_avalores   IntArray;
GN_digver 	  NUMBER := 0;
GN_modulo	  NUMBER := 10;

BEGIN
	GV_idvalido   := EV_num_ident;
	GV_idsinguion := EV_num_ident;

	--1-2 digitos entre 01 y 22     -
    IF TO_NUMBER(SUBSTR(GV_idsinguion,1,2)) < CN_valormin OR TO_NUMBER(SUBSTR(GV_idsinguion,1,2)) > CN_valormax THEN
		GB_procesar := FALSE;
	END IF;

   	--3 digito 9 - 6 - menor a 6	   -
   	IF GB_procesar THEN
	   IF TO_NUMBER(SUBSTR(GV_idsinguion,3,1)) >= CN_tercernat THEN
			GB_procesar := FALSE;
	   END IF;
   	END IF;

   --11-13 digito siempre igual a 0001  -
   IF GB_procesar THEN
	   IF SUBSTR(GV_idsinguion,11,3) <> CV_numestable THEN
			GB_procesar := FALSE;
	   END IF;
   END IF;

   IF NOT GB_procesar THEN
   	  RETURN 'ERROR Formato no válido ' || GV_idsinguion || ', Favor Verificar';
   END IF;

	--Realiza calculo de digito verificador --
	IF GB_procesar THEN
	   --Asigna coeficientes --
	   GN_avalores := IntArray(2, 1, 2, 1, 2, 1, 2, 1, 2);

       --Calculo multiplicacion y suma--
	   GN_digver := VE_CALCULADIGITO_FN(GV_idsinguion, GN_avalores, CN_posfinal, GN_modulo, TRUE);

	   --Es digito verificador correcto  --
	   IF GN_digver = SUBSTR(GV_idsinguion, (CN_posfinal+1),1) THEN
	   	    GV_idvalido := GV_idsinguion;
	   ELSE
			GV_idvalido := 'ERROR Digito verificador no coincide ' || EV_num_ident || ', Favor Verificar.';
	   END IF;

	END IF;

	--Retorna identificador del cliente o mensaje de error --
	RETURN GV_idvalido;

END VE_VALIDARUCNATURAL_FN;

FUNCTION VE_VALIDARUCPUBLICA_FN (EV_num_ident    IN ge_clientes.num_ident%TYPE,
                          		 EV_cod_tipident IN ge_tipident.cod_tipident%TYPE)
RETURN VARCHAR2 IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "VE_VALIDARUCPUBLICA_FN" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="igr" Ambiente="DEIMOS_ANDINA">
<Retorno>VARCHAR2</Retorno>
<Descripción>Funcion que retorna el identificador-
--           RUC del Cliente previa validacion   -
--           La validaciones a efectuar corresponden a:
--           - Sociedades publicas
-- Formato   : 1234567890123                       -
</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_ident" Tipo="STRING">numero identificatorio</param>
<param nom="EV_cod_tipident" Tipo="STRING">codigo tipident</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
GV_idvalido     VARCHAR2(200);
--Valores fijos --
CN_valormin   NUMBER :=1;
CN_valormax   NUMBER :=22;
CN_tercerpub  NUMBER :=6;
CV_numestapub VARCHAR2(4):='0001';
CN_posfinal   NUMBER :=8;

--Variables --
GV_idsinguion GE_CLIENTES.NUM_IDENT%TYPE;
GB_procesar   BOOLEAN:= TRUE;
GN_avalores   IntArray;
GN_modulo	  NUMBER := 11;
GN_digver 	  NUMBER := 0;

BEGIN
	GV_idvalido   := EV_num_ident;
	GV_idsinguion := EV_num_ident;

   	--1-2 digitos entre 01 y 22     -
   	IF TO_NUMBER(SUBSTR(GV_idsinguion,1,2)) < CN_valormin OR TO_NUMBER(SUBSTR(GV_idsinguion,1,2)) > CN_valormax THEN
		GB_procesar := FALSE;
   	END IF;

   	--3 digito 9 - 6 - menor a 6	   -
   	IF GB_procesar THEN
	   IF TO_NUMBER(SUBSTR(GV_idsinguion,3,1)) <> CN_tercerpub THEN
			GB_procesar := FALSE;
	   END IF;
   	END IF;

   	--11-13 digito siempre igual a 0001  -
   	IF GB_procesar THEN
	   IF SUBSTR(GV_idsinguion,10,4) <> CV_numestapub THEN
			GB_procesar := FALSE;
	   END IF;
   	END IF;

   	IF NOT GB_procesar THEN
   		return 'ERROR Formato no válido ' || GV_idsinguion || ', Favor Verificar';
   	END IF;

	--Realiza calculo de digito verificador --
	IF GB_procesar THEN
	   --Asigna coeficientes --
	   GN_avalores := IntArray(3, 2, 7, 6, 5, 4, 3, 2, 0); --ojo el ultimo no se cuenta
	   GN_modulo   := 11;

	   --Calculo multiplicacion y suma--
	   GN_digver := VE_CALCULADIGITO_FN(GV_idsinguion, GN_avalores, CN_posfinal, GN_modulo, FALSE);

	   --Es digito verificador correcto?  --
	   IF GN_digver = SUBSTR(GV_idsinguion, (CN_posfinal+1),1) THEN
	   	    GV_idvalido := GV_idsinguion;
	   ELSE
			GV_idvalido := 'ERROR Digito verificador no coincide ' || EV_num_ident || ', Favor Verificar.';
	   END IF;
	END IF;

	--Retorna identificador del cliente o mensaje de error --
	RETURN GV_idvalido;

END VE_VALIDARUCPUBLICA_FN;

FUNCTION VE_VALIDARUCCEDULA_FN (EV_num_ident    IN ge_clientes.num_ident%TYPE,
                          EV_cod_tipident IN ge_tipident.cod_tipident%TYPE)
RETURN VARCHAR2 IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "VE_VALIDARUCCEDULA_FN" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="igr" Ambiente="DEIMOS_ANDINA">
<Retorno>VARCHAR2</Retorno>
<Descripción>Funcion que retorna el identificador-
--           RUC del Cliente previa validacion   -
--           La validaciones a efectuar corresponden a:
--           - Cedula Personas naturales
-- Formato   : 1234567890123                       -
</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_ident" Tipo="STRING">numero identificatorio</param>
<param nom="EV_cod_tipident" Tipo="STRING">codigo tipident</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
GV_idvalido     VARCHAR2(200);
--Valores fijos --
CV_modulo     GED_PARAMETROS.COD_MODULO%TYPE   := 'GA';
CV_largoced   GED_PARAMETROS.NOM_PARAMETRO%TYPE:= 'LARGO_IDCEDULA';
CN_producto   NUMBER:= 1;
CV_blanco     VARCHAR2(1):=' ';
CN_valormin   NUMBER :=1;
CN_valormax   NUMBER :=22;
CN_tercernat  NUMBER :=6;
CN_posfinal   NUMBER :=9;
CN_cero       NUMBER :=0;
CN_nueve      NUMBER :=9;
CS_error      VARCHAR(5):= 'ERROR';
--Variables --
GV_idsinguion GE_CLIENTES.NUM_IDENT%TYPE;
GN_counter	  NUMBER;
GN_modulo	  NUMBER := 10;
GV_largoced	  GED_PARAMETROS.VAL_PARAMETRO%TYPE:= '0';
GN_valor      NUMBER := 0;
GN_suma	   	  NUMBER := 0;
GN_residuo 	  NUMBER := 0;
GN_digver 	  NUMBER := 0;
GB_procesar   BOOLEAN:= TRUE;
GN_avalores   IntArray;

BEGIN

    GV_idvalido:=EV_num_ident;

	--OBTIENE VALORES DESDE TABLA DE PARAMETROS
	--Obtiene largo id CEDULA--
   GV_largoced := GE_FN_DEVVALPARAM(CV_modulo, CN_producto, CV_largoced );

   IF GV_largoced=CS_error THEN
      RETURN 'ERROR No existe parametro largo ID en ged_parametros ' || CV_largoced || ', Favor Verificar' ;
   END IF;

   --Asigna tip ident sacando los blancos
   GV_idsinguion := REPLACE(EV_num_ident, CV_blanco, '');

	--REVISAR QUE EL RUC SEA NUMERICO -
	BEGIN
		 GN_valor:= TO_NUMBER(GV_idsinguion);
	EXCEPTION
         WHEN OTHERS THEN
	         RETURN 'ERROR Valor no numerico en ' || GV_idsinguion || ', Favor Verificar';
	END;

	--Validaciones
   --Largo correcto     -
   IF LENGTH(GV_idsinguion) <> TO_NUMBER(GV_largoced) THEN
		GB_procesar := FALSE;
   END IF;
   --1-2 digitos entre 01 y 22     -
   IF GB_procesar THEN
	   IF TO_NUMBER(SUBSTR(GV_idsinguion,1,2)) < CN_valormin OR TO_NUMBER(SUBSTR(GV_idsinguion,1,2)) > CN_valormax THEN
			GB_procesar := FALSE;
	   END IF;
   END IF;

   IF NOT GB_procesar THEN
   	  RETURN 'ERROR Formato no válido ' || GV_idsinguion || ', Favor Verificar';
   END IF;

	--Realiza calculo de digito verificador --
	IF GB_procesar THEN
	   --Asigna coeficientes --
	   GN_avalores := IntArray(2, 1, 2, 1, 2, 1, 2, 1, 2);

	   GN_digver := VE_CALCULADIGITO_FN(GV_idsinguion, GN_avalores, CN_posfinal, GN_modulo, TRUE);

	   --Es digito verificador correcto?  --
	   IF GN_digver = SUBSTR(GV_idsinguion, (CN_posfinal+1),1) THEN
	   	    GV_idvalido := GV_idsinguion;
	   ELSE
			GV_idvalido := 'ERROR Digito verificador no coincide ' || EV_num_ident || ', Favor Verificar.';
	   END IF;

	END IF;

	--Retorna identificador del cliente o mensaje de error --
	RETURN GV_idvalido;
END VE_VALIDARUCCEDULA_FN;

FUNCTION VE_VALIDARUC_FN (EV_num_ident    IN ge_clientes.num_ident%TYPE,
                          EV_cod_tipident IN ge_tipident.cod_tipident%TYPE)
RETURN VARCHAR2 IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "VE_VALIDARUC_FN" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="igr" Ambiente="DEIMOS_ANDINA">
<Retorno>VARCHAR2</Retorno>
<Descripción>Funcion que llama al validador indicado-
--           - Cedula Ciudadana
--           - Cedula Especial
--           - Cedula RUC
-- Formato   : 1234567890123                       -
</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_ident"    Tipo="STRING">numero identificatorio</param>
<param nom="EV_cod_tipident" Tipo="STRING">codigo tipident</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
--Valores fijos --
CV_modulo     	GED_PARAMETROS.COD_MODULO%TYPE   := 'GA';
CV_ciudadana  	GED_PARAMETROS.NOM_PARAMETRO%TYPE:= 'CEDULA_CIUDADANA';
CV_especial   	GED_PARAMETROS.NOM_PARAMETRO%TYPE:= 'CEDULA_ESPECIAL';
CV_cedularuc   	GED_PARAMETROS.NOM_PARAMETRO%TYPE:= 'CEDULA_RUC';
CN_producto   	NUMBER:= 1;
CS_error      	VARCHAR(5):= 'ERROR';
GN_valor        NUMBER:= 0;

--Variables --
GV_celciudadana GED_PARAMETROS.NOM_PARAMETRO%TYPE;
GV_celespecial  GED_PARAMETROS.NOM_PARAMETRO%TYPE;
GV_celruc		GED_PARAMETROS.NOM_PARAMETRO%TYPE;

BEGIN

	--OBTIENE VALORES DESDE TABLA DE PARAMETROS
	--Obtiene codigo CEDULA_CIUDADANA --
	GV_celciudadana := GE_FN_DEVVALPARAM(CV_modulo, CN_producto, CV_ciudadana );

	IF GV_celciudadana=CS_error THEN
	  RETURN 'ERROR No existe parametro codigo CEDULA CIUDADANA ' || CV_ciudadana || ', Favor Verificar' ;
	END IF;

	--Obtiene codigo CEDULA_ESPECIAL --
	GV_celespecial := GE_FN_DEVVALPARAM(CV_modulo, CN_producto, CV_especial );

	IF GV_celespecial=CS_error THEN
	  RETURN 'ERROR No existe parametro codigo CEDULA ESPECIAL ' || CV_especial || ', Favor Verificar' ;
	END IF;

	--Obtiene codigo CEDULA_RUC --
	GV_celruc := GE_FN_DEVVALPARAM(CV_modulo, CN_producto, CV_cedularuc  );

	IF GV_celruc=CS_error THEN
	  RETURN 'ERROR No existe parametro codigo CEDULA RUC ' || CV_cedularuc  || ', Favor Verificar' ;
	END IF;

	-- REVISA QUE TIPO DE IDENTIFICADOR SEA VALIDO
	BEGIN
		 SELECT count(1) INTO GN_valor
		   FROM ge_tipident a
	      WHERE a.cod_tipident = EV_cod_tipident;

	     IF GN_valor=CN_cero THEN
		    RETURN 'ERROR Tipo de identificacion RUC ' || EV_cod_tipident || ' no existe';
		 END IF;
	EXCEPTION
	   WHEN NO_DATA_FOUND THEN
	         RETURN 'ERROR Tipo de identificacion RUC ' || EV_cod_tipident || ' no existe';
	   WHEN OTHERS THEN
	         RETURN 'ERROR VE_VALIDARUC_FN SQLERRM:' || SUBSTR(SQLERRM,1,150);
	END;

	-- LLAMA A FUNCION QUE CORRESPONDE, SEGUN EL TIPO DE IDENTIFICADOR
	IF EV_cod_tipident = GV_celciudadana THEN
			RETURN VE_VALIDARUCCEDULA_FN(EV_num_ident, EV_cod_tipident);
	ELSIF EV_cod_tipident = GV_celespecial THEN

			RETURN VE_VALIDARUCESPECIAL_FN(EV_num_ident, EV_cod_tipident);
	ELSIF EV_cod_tipident = GV_celruc THEN
			RETURN VE_VALIDARUCTIPO_FN(EV_num_ident, EV_cod_tipident);
	ELSE
		RETURN EV_num_ident;
	END IF;

END VE_VALIDARUC_FN;

FUNCTION VE_VALIDARUCTIPO_FN (EV_num_ident    IN ge_clientes.num_ident%TYPE,
                          	  EV_cod_tipident IN ge_tipident.cod_tipident%TYPE)
RETURN VARCHAR2 IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "VE_VALIDARUCTIPO_FN" Lenguaje="PL/SQL" Fecha="22-07-2005" Versión="1.0.0" Diseñador="" Programador="MQG" Ambiente="DEIMOS_ANDINA">
<Retorno>VARCHAR2</Retorno>
<Descripción>Funcion que llama al validador indicado-
--           - Sociedades Privadas y extranjeros sin cedula  --
--           - Sociedades publicas
--           - Cedula Personas naturales
-- Formato   : 1234567890123                       -
</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_ident"    Tipo="STRING">numero identificatorio</param>
<param nom="EV_cod_tipident" Tipo="STRING">codigo tipident</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
--Valores fijos --
CV_modulo     		GED_PARAMETROS.COD_MODULO%TYPE   := 'GA';
CV_largo_idruc		GED_PARAMETROS.NOM_PARAMETRO%TYPE:= 'LARGO_IDRUC';
CN_producto  		NUMBER		:= 1;
CS_error      		VARCHAR(5)	:= 'ERROR';
CV_blanco     		VARCHAR2(1)	:=' ';

--Variables --
GV_largocedularuc 	GED_PARAMETROS.VAL_PARAMETRO%TYPE:= '0';
GV_idsinguion 		GE_CLIENTES.NUM_IDENT%TYPE;
GN_valor      		NUMBER := 0;
GN_digitoruc   		NUMBER := 0;

BEGIN

	--OBTIENE VALORES DESDE TABLA DE PARAMETROS
	--Obtiene largo identificador RUC --
   	GV_largocedularuc := GE_FN_DEVVALPARAM(CV_modulo, CN_producto, CV_largo_idruc );

   	IF GV_largocedularuc=CS_error THEN
      RETURN 'ERROR No existe parametro largo RUC en ged_parametros ' || CV_largo_idruc || ', Favor Verificar' ;
   	END IF;

   	--Asigna tip ident sacando los blancos
   	GV_idsinguion := REPLACE(EV_num_ident, CV_blanco, '');

	-- VALIDACIONES
	-- Verificando que RUC sea numerico
	BEGIN
		 GN_valor:= TO_NUMBER(GV_idsinguion);
	EXCEPTION
         WHEN OTHERS THEN
	         RETURN 'ERROR Valor no numerico en ' || GV_idsinguion || ', Favor Verificar';
	END;

   	-- Largo correcto     -
   	IF LENGTH(GV_idsinguion) <> TO_NUMBER(GV_largocedularuc) THEN
		RETURN 'ERROR Largo del Identificador ' || GV_idsinguion || '  Incorrecto , Favor Verificar';
   	END IF;

   	-- Identificando Tipo de RUC (PRIVADO - PUBLICO - NATURAL)
	BEGIN
		GN_digitoruc := TO_NUMBER(SUBSTR(GV_idsinguion,3,1));
	EXCEPTION
         WHEN OTHERS THEN
	         RETURN 'ERROR Valor no numerico en ' || GV_idsinguion || ', Favor Verificar';
  	END;

	IF ((GN_digitoruc >= 0) AND (GN_digitoruc<=5)) THEN
			RETURN VE_VALIDARUCNATURAL_FN(GV_idsinguion, EV_cod_tipident);
    ELSIF (GN_digitoruc = 6) THEN
			RETURN VE_VALIDARUCPUBLICA_FN(GV_idsinguion, EV_cod_tipident);
    ELSIF (GN_digitoruc = 9) THEN
			RETURN VE_VALIDARUCPRIVADA_FN(GV_idsinguion, EV_cod_tipident);
    ELSE
		RETURN 'ERROR RUC ' || GV_idsinguion || ' no corresponde a PRIVADO, PUBLICO o NATURAL, Favor Verificar';
    END IF;

END VE_VALIDARUCTIPO_FN;


FUNCTION VE_VALIDARUCESPECIAL_FN (EV_num_ident    IN ge_clientes.num_ident%TYPE,
                          	      EV_cod_tipident IN ge_tipident.cod_tipident%TYPE)
RETURN VARCHAR2 IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "VE_VALIDARUCESPECIAL_FN" Lenguaje="PL/SQL" Fecha="22-07-2005" Versión="1.0.0" Diseñador="" Programador="MQG" Ambiente="DEIMOS_ANDINA">
<Retorno>VARCHAR2</Retorno>
<Descripción>Funcion que llama al validador indicado-
--           - Especial
-- Formato   : 1234567890123                       -
</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_ident"    Tipo="STRING">numero identificatorio</param>
<param nom="EV_cod_tipident" Tipo="STRING">codigo tipident</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
--Valores fijos --
CV_modulo     		GED_PARAMETROS.COD_MODULO%TYPE   := 'GA';
CV_largo_idrucesp	GED_PARAMETROS.NOM_PARAMETRO%TYPE:= 'LARGO_IDESPECIAL';
CN_producto  		NUMBER		:= 1;
CS_error      		VARCHAR(5)	:= 'ERROR';
CV_blanco     		VARCHAR2(1)	:=' ';

--Variables --
GV_largocedespecial GED_PARAMETROS.VAL_PARAMETRO%TYPE:= '0';
GV_idsinguion 		GE_CLIENTES.NUM_IDENT%TYPE;
GN_valor      		NUMBER := 0;

BEGIN

	--OBTIENE VALORES DESDE TABLA DE PARAMETROS
	--Obtiene largo identificador RUC ESPECIAL --
   	GV_largocedespecial := GE_FN_DEVVALPARAM(CV_modulo, CN_producto, CV_largo_idrucesp );

   	IF GV_largocedespecial=CS_error THEN
      RETURN 'ERROR No existe parametro largo RUC ESPECIAL en ged_parametros ' || CV_largo_idrucesp || ', Favor Verificar' ;
   	END IF;

   	--Asigna tip ident sacando los blancos
   	GV_idsinguion := REPLACE(EV_num_ident, CV_blanco, '');

	-- VALIDACIONES
	-- Verificando que RUC sea numerico
	BEGIN
		 GN_valor:= TO_NUMBER(GV_idsinguion);
	EXCEPTION
         WHEN OTHERS THEN
	         RETURN 'ERROR Valor no numerico en ' || GV_idsinguion || ', Favor Verificar';
	END;

   	-- Largo correcto     -
   	IF LENGTH(GV_idsinguion) <> TO_NUMBER(GV_largocedespecial) THEN
		RETURN 'ERROR Largo del Identificador ' || GV_idsinguion || '  Incorrecto , Favor Verificar';
   	END IF;

	RETURN EV_num_ident;

END VE_VALIDARUCESPECIAL_FN;

END VE_VALIDACION_PG;
/
SHOW ERRORS
