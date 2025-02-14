CREATE OR REPLACE PACKAGE BODY PV_SERIES_NEGATIVAS_PG IS

	PROCEDURE PV_SERIES_NEGATIVAS_PR
	(
	  EN_TRANSAC IN NUMBER,
	  EV_SERIE IN VARCHAR2,
  	  EV_CONSULTA IN VARCHAR2,  -- Tipo consulta I: insert; D: delete; S: select
	  EN_NUM_ABONADO IN NUMBER,
	  EV_CODCAUSA IN VARCHAR2,
	  EV_MODLLAMADA IN VARCHAR2
	)IS

	  /*
		<Documentación TipoDoc = "Prcedimiento">
		<Elemento
			Nombre = "PV_SERIES_NEGATIVAS_PR"
			Lenguaje="PL/SQL"
			Fecha="19-04-2007"
			Versión="1.1.0"
			Diseñador="Yesenia Osses"
			Programador="Yesenia Osses"
			Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripción>Llama a procedimientos de Mix_06003_G1</Descripción>
		<Parámetros>
		    <Entrada>
		        <param nom="EN_TRANSAC" Tipo="NUMBER">Numero transaccion</param>
				<param nom="EV_SERIE" Tipo="NUMBER>Numero serie /param>
				<param nom="EV_CONSULTA" Tipo="NUMBER>Tipo consulta I: insert; D: delete; S: select /param>
				<param nom="EN_NUM_ABONADO" Tipo="NUMBER>Numero abonado /param>
				<param nom="EV_CODCAUSA" Tipo="NUMBER>Codigo de la causa segun el caso por baja o por siniestro /param>
				<param nom="EV_MODLLAMADA" Tipo="NUMBER>OOSS del cual envia la consulta EV_MODLLAMADA puede tomar los siguientes valores:
					 -PLAS  :pl aviso siniestro
					 -PLBA  :pl baja abonado
					 -PLVS  :pl valida serie
					 -PLL   :pl logistica
					 -AB    :OOSS anula baja
					 -AS    .OOSS aviso siniestro
					 -BA    :OOSS babonado
					 -PC    :OOSS post venta celular
					 -CE    :OOSS cambio serie
					 -RE    :OOSS rest equipos
				</param>
		    </Entrada>
		    <Salida>
		        <param nom="SC_ERROR" Tipo="VARCHAR2">Numero error que toma segun sea el caso</param>
		    </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
     */

	  SC_ERROR GA_TRANSACABO.NUM_TRANSACCION%TYPE := 0;
 	  PARAMETRO VARCHAR2(1);
	  p_result VARCHAR2(1);

	  P_NSRELECTRONICO VARCHAR2(20);
	  P_CODOPERADOR NUMBER(5);
	  P_CODARTICULO NUMBER(6);
	  P_NSRMECANICO VARCHAR2(20);
	  P_NSRHEXADECIMAL VARCHAR2(8);
	  P_INDPROCEQUI VARCHAR2(1);
	  P_CODABONADO NUMBER(8);
	  P_CODMODULO NUMBER(2);
	  P_INDESTADO NUMBER(2);
	  P_NOMFICHERO VARCHAR(255);
	  P_RESULTADO VARCHAR2(1);
	  P_DESERROR VARCHAR2(100);
	  P_CODERROR NUMBER(3);
	  DES_CADENA VARCHAR(2);
	  NUM_ABONADO_DATO NUMBER;


	  P_FICHEROFINAL VARCHAR2(255);
	  EV_CODCAUSAFINAL NUMBER(3);
	  P_DFECHA VARCHAR2(6);
	  v_es_negativo BOOLEAN;

	  SNOMTABLAABO	 VARCHAR2(20);
	  LV_ga_abocel   CONSTANT VARCHAR2(10) := 'GA_ABOCEL';
	  LV_ga_aboamist CONSTANT VARCHAR2(11) := 'GA_ABOAMIST';
	--  LN_num_abonado ga_abocel.NUM_ABONADO%TYPE;

   bValidaSN BOOLEAN;
   vTipTerminalEQ VARCHAR2(1);
   vTipTerminalParam GED_PARAMETROS.VAL_PARAMETRO%TYPE;

  	BEGIN
      BEGIN
         bValidaSN := TRUE;
         SELECT UNIQUE TIP_TERMINAL INTO vTipTerminalEQ
         FROM GA_EQUIPABOSER
         WHERE NUM_SERIE = EV_SERIE;

         VTIPTERMINALPARAM := GE_FN_DEVVALPARAM('GA',1,'COD_SIMCARD_GSM');

         IF VTIPTERMINALPARAM = VTIPTERMINALEQ AND EV_MODLLAMADA ='PC' THEN
            BVALIDASN := FALSE;
         END IF;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            bValidaSN := TRUE;
      END;

      IF BVALIDASN THEN

         SELECT VALOR_NUMERICO
         INTO PARAMETRO
         FROM   PV_PARAMETROS_SIMPLES_VW
         WHERE  NOM_PARAMETRO = 'FLAG_SERIE_NEGATIVA';

         IF PARAMETRO = '1' THEN -- 1: llamada nueva; 0 llamda actual
            BEGIN
               NUM_ABONADO_DATO := EN_NUM_ABONADO;
               IF EN_NUM_ABONADO = '0' THEN
                  SELECT a.num_abonado, 'GA_ABOCEL'
                  INTO   NUM_ABONADO_DATO, SNOMTABLAABO
                  FROM ga_abocel a
                  WHERE (a.num_imei = EV_SERIE OR a.num_serie = EV_SERIE)
                  AND a.fec_ultmod IN (
                     SELECT MAX(b.fec_ultmod)
                     FROM ga_abocel b
                     WHERE (b.num_imei = EV_SERIE OR b.num_serie = EV_SERIE)
                  )
                  UNION
                  SELECT a.num_abonado, 'GA_ABOAMIST'
                  FROM ga_aboAMIST a
                  WHERE (a.num_imei = EV_SERIE OR a.num_serie = EV_SERIE)
                  AND a.fec_ultmod  = (
                     SELECT MAX(b.fec_ultmod)
                     --from ga_abocel b
                     FROM ga_aboamist b
                  WHERE (b.num_imei = EV_SERIE OR b.num_serie = EV_SERIE));
               ELSE
                  SELECT num_abonado, 'GA_ABOCEL'
                  INTO   NUM_ABONADO_DATO, SNOMTABLAABO
                  FROM   ga_abocel
                  WHERE  num_abonado = EN_NUM_ABONADO
                  UNION
                  SELECT num_abonado, 'GA_ABOAMIST'
                  FROM   ga_aboAMIST
                  WHERE  num_abonado = EN_NUM_ABONADO;
               END IF;

               IF SNOMTABLAABO = 'GA_ABOCEL' THEN  -- ga_abocel --
                  SELECT
                  a.NUM_ABONADO,a.NUM_SERIE,a.IND_PROCEQUI,a.COD_ARTICULO,a.COD_ESTADO,a.NUM_SERIEMEC,b.NUM_SERIEHEX
                  INTO
                  P_CODABONADO,P_NSRELECTRONICO,P_INDPROCEQUI,P_CODARTICULO,P_INDESTADO,P_NSRMECANICO,P_NSRHEXADECIMAL
                  FROM GA_EQUIPABOSER a, GA_ABOCEL b
                  WHERE a.NUM_ABONADO = NUM_ABONADO_DATO
                  AND a.NUM_ABONADO = b.NUM_ABONADO
                  AND a.num_imei IS NULL
                  AND a.fec_alta = (
                     SELECT
                     MAX(a.FEC_ALTA)
                     FROM GA_EQUIPABOSER a, GA_ABOCEL b
                     WHERE a.NUM_ABONADO = NUM_ABONADO_DATO
                     AND a.NUM_ABONADO = b.NUM_ABONADO
                  );

               ELSE

                  SELECT
                  a.NUM_ABONADO,a.NUM_SERIE,a.IND_PROCEQUI,a.COD_ARTICULO,a.COD_ESTADO,a.NUM_SERIEMEC,b.NUM_SERIEHEX
                  INTO
                  P_CODABONADO,P_NSRELECTRONICO,P_INDPROCEQUI,P_CODARTICULO,P_INDESTADO,P_NSRMECANICO,P_NSRHEXADECIMAL
                  FROM GA_EQUIPABOSER a, GA_ABOAMIST b
                  WHERE a.NUM_ABONADO = NUM_ABONADO_DATO
                  AND a.NUM_ABONADO = b.NUM_ABONADO
                  AND a.num_imei IS NULL
                  AND a.fec_alta = (
                     SELECT MAX(a.FEC_ALTA)
                     FROM GA_EQUIPABOSER a, GA_ABOAMIST b
                     WHERE a.NUM_ABONADO = NUM_ABONADO_DATO
                     AND a.NUM_ABONADO = b.NUM_ABONADO
                  );
               END IF;

               SELECT COD_OPERADOR  INTO P_CODOPERADOR FROM TA_DATOSGENER;
               IF EV_CONSULTA = 'I' THEN -- Inserta
                  PV_PAC_SERNEG.PV_P_SERNEG_ALTA(
                     P_NSRELECTRONICO, --P_NSRELECTRONICO
                     P_CODOPERADOR,	--P_CODOPERADOR
                     P_CODARTICULO,	--P_CODARTICULO
                     P_NSRMECANICO,	--P_NSRMECANICO
                     P_NSRHEXADECIMAL,	--P_NSRHEXADECIMAL
                     P_INDPROCEQUI,	--P_INDPROCEQUI
                     P_CODABONADO,		--P_CODABONADO
                     'PV',            	--P_CODMODULO
                     'P',			--P_INDESTADO
                     NULL,             	--P_NOMFICHERO
                     EV_CODCAUSA,		--EV_CODCAUSA
                     P_RESULTADO,		--P_RESULTADO
                     P_DESERROR,		--P_DESERROR
                     P_CODERROR);		--P_CODERROR
                  IF P_RESULTADO = 'C' THEN
                     DES_CADENA := '0';
                  END IF;

                  IF P_RESULTADO = 'E' AND EV_MODLLAMADA = 'PLAS'THEN
                     DES_CADENA := '24';
                  END IF;

                  IF P_RESULTADO = 'E' AND EV_MODLLAMADA = 'PLBA'THEN
                     DES_CADENA := '17';
                  END IF;
               END IF;

               IF EV_CONSULTA = 'D' THEN -- Elimina
                  --PV_PAC_SERNEG.PV_P_SERNEG_BAJA(P_NSRELECTRONICO,    --P_NSRELECTRONICO  -- 45646.
                  
                  -- se comenta ya que es un package propio de la operadora de colombia y para guatemala /salvador no sirve 
                  -- aparte esta pieza no se encuentra en nuestro workset
                  -- 26112009 ocb
                  
                      --PV_PAC_SERNEG.PV_P_SERNEG_BORRA(
                      --   P_NSRELECTRONICO,    --P_NSRELECTRONICO
                      --   P_CODOPERADOR,		--P_CODOPERADOR
                      --   NULL,				--P_FICHEROFINAL
                      --   'P',				--P_INDESTADOFINAL
                      --   NULL,				--EV_CODCAUSAFINAL
                      --   P_RESULTADO,			--P_RESULTADO
                      --   P_DESERROR,			--P_DESERROR
                      --   P_CODERROR, 			--P_CODERROR
                      --   EV_CODCAUSA,			--EV_CODCAUSA
                      --   P_DFECHA);				--P_DFECHA
                      --SC_ERROR := '0';
                           
                     

                  --IF P_RESULTADO = 'C' THEN  -- 45646.
                  --END IF; -- 45646.

                  --IF P_RESULTADO = 'E' THEN -- 45646.
                  --		   SC_ERROR := '4'; -- 45646.
                  --END IF; -- 45646.
                  
                  
                  
                   IF EV_MODLLAMADA = 'AB' THEN    --Elimina OOSS Anula Baja Abonado
                             DELETE GA_LNCELU WHERE NUM_ABONADO = EN_NUM_ABONADO;
                             SC_ERROR := '0';
                  END IF;
                
                  IF EV_MODLLAMADA = 'PC' THEN --Elimina OSSS Post Venta Celular
                             DELETE GA_LNCELU WHERE NUM_ABONADO = EN_NUM_ABONADO AND NUM_SERIE = EV_SERIE;
                             SC_ERROR := '0';
                  END IF;

               END IF;

               IF EV_CONSULTA = 'S' THEN -- Consulta

                  PAC_NSR_NEG.P_CONS_NSR_NEG(
                     P_NSRELECTRONICO,
                     v_es_negativo,
                     P_CODERROR,
                     P_DESERROR);


                  IF v_es_negativo THEN
                     SC_ERROR := '3';
                  END IF;

                  IF v_es_negativo != TRUE THEN
                     SC_ERROR := '0';
                  END IF;

               END IF;
            EXCEPTION
               WHEN NO_DATA_FOUND THEN
                  IF EV_CONSULTA = 'S' THEN -- Consulta
                     PAC_NSR_NEG.P_CONS_NSR_NEG(
                        EV_SERIE,
                        v_es_negativo,
                        P_CODERROR,
                        P_DESERROR);

                     IF v_es_negativo THEN
                        SC_ERROR := '3';
                     END IF;

                     IF v_es_negativo != TRUE THEN
                        SC_ERROR := '0';
                     END IF;
                  END IF;
               WHEN OTHERS THEN
                  SC_ERROR := '4';
            END;
         ELSE
            BEGIN
               IF EV_CONSULTA = 'D' THEN -- Elimina
                  IF EV_MODLLAMADA = 'AB' THEN    --Elimina OOSS Anula Baja Abonado
                     DELETE GA_LNCELU WHERE NUM_ABONADO = EN_NUM_ABONADO;
                     SC_ERROR := '0';
                  END IF;
                  IF EV_MODLLAMADA = 'PC' THEN --Elimina OSSS Post Venta Celular
                     DELETE GA_LNCELU WHERE NUM_ABONADO = EN_NUM_ABONADO AND NUM_SERIE = EV_SERIE;
						   SC_ERROR := '0';
                  END IF;
               END IF;
               IF EV_CONSULTA = 'S' THEN -- Consulta
                  IF EV_MODLLAMADA = 'CE' THEN	-- OOSS Cambio Serie
                     SELECT 1 INTO p_result FROM GA_LNCELU WHERE (NUM_SERIE = EV_SERIE);
                     SC_ERROR := '3';
                  END IF;
                  IF EV_MODLLAMADA = 'PLVS' THEN -- PL valida serie
                     P_VALIDA_ROBADAS (EV_SERIE,SC_ERROR);
                  END IF;
                  IF EV_MODLLAMADA = 'PLL' THEN  --PL Logistica
                     SELECT COUNT(1) INTO p_result FROM GA_LNCELU WHERE NUM_SERIE = EV_SERIE;
                     IF p_result = '1' THEN
                        SC_ERROR := '3';
                     ELSE
                        SC_ERROR := '0';
                     END IF;
                  END IF;
               END IF;
            EXCEPTION
               WHEN NO_DATA_FOUND THEN
                  SC_ERROR := '0';
               WHEN TOO_MANY_ROWS THEN
                  SC_ERROR := '3';
               WHEN OTHERS THEN
                  SC_ERROR := '4';
            END;
         END IF;
      ELSE
         SC_ERROR := '0';
      END IF;
      INSERT INTO GA_TRANSACABO
      (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)
      VALUES
      (EN_TRANSAC,SC_ERROR,DES_CADENA);
   EXCEPTION
      WHEN OTHERS THEN
         SC_ERROR := '4';
   END PV_SERIES_NEGATIVAS_PR;
END PV_SERIES_NEGATIVAS_PG;
/
SHOW ERRORS