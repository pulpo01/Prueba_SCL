CREATE OR REPLACE PACKAGE BODY GR_RETENCIONES_PG
AS

/*******************************************************************************************************************************************************************/

FUNCTION GR_ModificaVigencia( v_CodModulo   IN  VARCHAR2,
	   				          v_CodCriterio IN  NUMBER,
					          v_Vigencia    IN  VARCHAR2 )  RETURN BOOLEAN IS
    BEGIN
       UPDATE ge_criterios_oper_to
	   SET ind_vigencia = v_Vigencia
	   WHERE cod_modulo = v_CodModulo
	   AND cod_criterio = v_CodCriterio;

       RETURN TRUE;

 	EXCEPTION
		WHEN OTHERS THEN
	   		 RETURN FALSE;

END GR_ModificaVigencia;


FUNCTION GR_IndVigencia( v_CodModulo   IN  VARCHAR2,
			     		     v_CodCriterio IN  NUMBER,
					         v_Vigencia    IN  VARCHAR2 )  RETURN VARCHAR IS

    IndVigencia   CHAR(1);

 	BEGIN
       IndVigencia := null;
       SELECT ind_vigencia
	   INTO   IndVigencia
	   FROM   ge_criterios_oper_to
	   WHERE  cod_modulo = v_CodModulo
	   AND    cod_criterio = v_CodCriterio;

	   RETURN (IndVigencia);

 	EXCEPTION
 		WHEN NO_DATA_FOUND THEN
	   		 RETURN (IndVigencia);

	    WHEN OTHERS THEN
	   		 RAISE_APPLICATION_ERROR(-20100,'No es Posible Recuperar Vigencia');

END GR_IndVigencia;

/*******************************************************************************************************************************************************************/

FUNCTION GR_InsertaCriterio( v_CodModulo   IN  VARCHAR2,
	                             v_CodCriterio IN  NUMBER,
					             v_Vigencia    IN  VARCHAR2 )  RETURN BOOLEAN IS

    BEGIN

       INSERT INTO ge_criterios_oper_to (cod_modulo, cod_criterio, ind_vigencia)
	   VALUES (v_CodModulo,v_CodCriterio,v_Vigencia);
	   RETURN TRUE;

 	EXCEPTION
	   WHEN OTHERS THEN
	   		RETURN FALSE;
END GR_InsertaCriterio;

FUNCTION GR_CodModulo ( v_CodModulo   IN  VARCHAR2,
					        v_CodCriterio IN  NUMBER,
					        v_Vigencia    IN  VARCHAR2 )  RETURN BOOLEAN IS

    CodModulo   CHAR(2);

    BEGIN

       SELECT DISTINCT cod_modulo
	   INTO CodModulo
	   FROM ge_rangos_to
	   WHERE cod_modulo = v_CodModulo
	   AND cod_criterio = v_CodCriterio;

	   RETURN TRUE;

 	EXCEPTION

	   WHEN NO_DATA_FOUND THEN
	   		RETURN FALSE;

	   WHEN OTHERS THEN
	   		RAISE_APPLICATION_ERROR(-20100,'No es Posible Recuperar Codigo del Modulo');

END GR_CodModulo;

/*******************************************************************************************************************************************************************/

 FUNCTION GR_GRABAERROR_FN (NOM_PL       IN  VARCHAR2,
                            NOM_TABLA    IN  VARCHAR2,
                            NumError     IN  NUMBER,
					        Descripcion  IN  VARCHAR2,
					        EVENTO       OUT NUMBER )  RETURN BOOLEAN IS

 sNumProceso   VARCHAR2(25);
 sTerminal     VARCHAR2(25);

 BEGIN

    SELECT NVL(process,'NO PROCESS'), NVL(terminal,'NO TERMINAL')
    INTO   sNumProceso, sTerminal
    FROM   V$SESSION
    WHERE  username = user AND status = 'ACTIVE';

	EVENTO := GE_ERRORES_PG.GRABAR(0, 'RET', 'Ejecucion de Package ret_retenciones_pg', '1',
	          user, sNumProceso, sTerminal, NOM_PL, NOM_TABLA, NumError, Descripcion);
    RETURN TRUE;

 EXCEPTION

    WHEN NO_DATA_FOUND THEN
 	   RETURN FALSE;
 	WHEN OTHERS THEN
 	   RETURN FALSE;

 END GR_GRABAERROR_FN;

/*******************************************************************************************************************************************************************/

FUNCTION GR_RECUPERAPARAMETROS_FN(NomParametros varchar2,CodModulo varchar2,CodProducto   number) RETURN VARCHAR2
IS
sValParam VARCHAR2(60);
BEGIN
	SELECT VAL_PARAMETRO
	INTO sValParam
	FROM ged_parametros
	WHERE nom_parametro = NomParametros
	AND cod_modulo = CodModulo
	AND cod_producto = CodProducto;

RETURN sValParam;
   EXCEPTION
   WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20700,'GR_RECUPERAPARAMETROS_FN('||NomParametros||', '||CodModulo||', '||CodProducto||') ');
END GR_RECUPERAPARAMETROS_FN;

/*******************************************************************************************************************************************************************/

FUNCTION GR_BUSCAVALORRANGO_FN (
p_codmodulo IN GE_RANGOS_TO.COD_MODULO%TYPE,
p_codcriterio IN GE_RANGOS_TO.COD_CRITERIO%TYPE,
p_valrango IN NUMBER)
RETURN VARCHAR2 IS

v_nValRango NUMBER;

BEGIN

	SELECT VAL_RANGO
	INTO v_nValRango
	FROM ge_rangos_to
	WHERE COD_MODULO = p_codmodulo
	AND COD_CRITERIO = p_codcriterio
	AND TIPO_RANGO = 1--VALOR IGUAL A
	AND MIN_RANGO = p_valrango;
RETURN v_nValRango;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
	    BEGIN
		  	SELECT VAL_RANGO
			INTO v_nValRango
			FROM ge_rangos_to
			WHERE COD_MODULO = p_codmodulo
			AND COD_CRITERIO = p_codcriterio
			AND TIPO_RANGO = 2--INTERVALO, VALORES ENTRE
			AND MIN_RANGO <= p_valrango
			AND MAX_RANGO >= p_valrango;
			 EXCEPTION
			    WHEN NO_DATA_FOUND THEN
			    BEGIN
				  	SELECT VAL_RANGO
					INTO v_nValRango
					FROM ge_rangos_to
					WHERE COD_MODULO = p_codmodulo
					AND COD_CRITERIO = p_codcriterio
					AND TIPO_RANGO = 3--MENOR QUE
					AND MIN_RANGO > p_valrango;

					EXCEPTION
					    WHEN NO_DATA_FOUND THEN
					     BEGIN
						  	SELECT VAL_RANGO
							INTO v_nValRango
							FROM ge_rangos_to
							WHERE COD_MODULO = p_codmodulo
							AND COD_CRITERIO = p_codcriterio
							AND TIPO_RANGO = 4--MAYOR QUE
							AND MAX_RANGO < p_valrango;
						 EXCEPTION
						    WHEN NO_DATA_FOUND THEN
				               v_nValRango:= 0;
				        END;
			    END;
		END;
RETURN v_nValRango;
	WHEN OTHERS THEN
          v_nValRango:='E';
		  RETURN v_nValRango;
END GR_BUSCAVALORRANGO_FN;

/*******************************************************************************************************************************************************************/

PROCEDURE GR_AGREGAEVALUACIONCONTACTO_PR
                          ( v_NumContacto IN ret_contactos_evaluacion_th.NUM_CONTACTO%TYPE,
	   	  		  		    v_NumAbonado  IN ret_contactos_evaluacion_th.NUM_ABONADO%TYPE  ,
							cod_criterio  IN ret_contactos_evaluacion_th.COD_CRITERIO%TYPE,
							nIdDetalle    IN ret_contactos_evaluacion_th.ID_DETALLE%TYPE,
							sValDetalle   IN ret_contactos_evaluacion_th.VAL_DETALLE%TYPE) IS

BEGIN

dbms_output.put_line(v_NumContacto||','||v_NumAbonado||','||cod_criterio||','||nIdDetalle||','||sValDetalle);

	 INSERT INTO ret_contactos_evaluacion_th
	       ( num_contacto, num_abonado, cod_criterio, id_detalle, val_detalle )
	 VALUES
	       ( v_NumContacto, v_NumAbonado, cod_criterio, nIdDetalle, sValDetalle);

EXCEPTION WHEN OTHERS THEN
	 RAISE_APPLICATION_ERROR(-20500,'GR_AGREGAEVALUACIONCONTACTO_PR('||v_NumContacto||', '||v_NumAbonado||', '||cod_criterio||', '||nIdDetalle||', '||sValDetalle||') '||SQLERRM);

END GR_AGREGAEVALUACIONCONTACTO_PR;

/*******************************************************************************************************************************************************************/

PROCEDURE GR_CRITERIOPER_PR	( v_CodModulo   IN  VARCHAR2,
							  v_CodCriterio IN  NUMBER,
							  v_Vigencia    IN  VARCHAR2,
							  v_Usuario     IN  VARCHAR2,
							  Error			OUT VARCHAR2,
							  Evento        OUT VARCHAR2,
							  DesError      OUT VARCHAR2  )	IS

 	ERRO_INSERTACRITERIO  EXCEPTION;
 	ERRO_MODIFICAVIGENCIA EXCEPTION;
 	VIGENCIA  VARCHAR2(2);


   BEGIN

 	 	 VIGENCIA := GR_IndVigencia( v_CodModulo, v_CodCriterio, v_Vigencia);

		 IF VIGENCIA IS NULL THEN
	     	IF NOT GR_InsertaCriterio( v_CodModulo, v_CodCriterio, v_Vigencia ) THEN
	   	       RAISE ERRO_INSERTACRITERIO;
	    	END IF;
		 END IF;


		 IF v_Vigencia = 'V' THEN

	     	IF NOT GR_ModificaVigencia( v_CodModulo, v_CodCriterio, v_Vigencia ) THEN
	   	  	   RAISE ERRO_MODIFICAVIGENCIA;
	   		END IF;

		 ELSIF VIGENCIA = 'V' THEN

	        IF NOT GR_CodModulo ( v_CodModulo, v_CodCriterio, v_Vigencia ) THEN

	   		   IF NOT GR_ModificaVigencia( v_CodModulo, v_CodCriterio, v_Vigencia ) THEN

	   			  RAISE ERRO_MODIFICAVIGENCIA;

	   	       END IF;

	   	    END IF;
	     END IF;
   EXCEPTION
         WHEN ERRO_INSERTACRITERIO  THEN
            BEGIN
   		  	   Error       := 'FALSE';
	   	       DesError    := 'Error, al insertar en la tabla ge_criterios_oper_to';

		       IF NOT GR_RETENCIONES_PG.GR_GRABAERROR_FN('PL: gr_criterioper_pr','ge_criterios_oper_to', 2, DesError, Evento) THEN
		       	  RAISE_APPLICATION_ERROR(-20098,'No es Posible Grabar el Error');
		  	   END IF;

            END;
         WHEN ERRO_MODIFICAVIGENCIA THEN
   	  	 	BEGIN

   		  	   Error       := 'FALSE';
	   	       DesError    := 'No es Posible Modificar la Vigencia en la tabla ge_criterios_oper_to';

		       IF NOT GR_RETENCIONES_PG.GR_GRABAERROR_FN('PL: gr_criterioper_pr','ge_criterios_oper_to', 3, DesError, Evento) THEN
		          RAISE_APPLICATION_ERROR(-20098,'No es Posible Grabar el Error');
		       END IF;
            END;
   END GR_CRITERIOPER_PR;

/*******************************************************************************************************************************************************************/

PROCEDURE GR_CATEGORIACLIENTE_PR (nCodCliente IN ga_valor_cli.cod_cliente%TYPE,
	   	  		  						  p_codmodulo IN VARCHAR,
										  CodCriterio IN NUMBER,
										  v_NumContacto IN NUMBER,
										  v_NumAbonado IN NUMBER,
										  nPuntaje    IN OUT NUMBER,
										  nTraDato    OUT NUMBER) IS
	nCodCategoria NUMBER;
	nValRango VARCHAR2(10);
	BEGIN


		SELECT COD_CATEGORIA
		INTO nCodCategoria
		FROM ge_clientes
		WHERE cod_cliente = nCodCliente;


		nValRango := GR_RETENCIONES_PG.GR_BUSCAVALORRANGO_FN (p_codmodulo ,CodCriterio ,nCodCategoria);

		IF nValRango <> 'E' THEN

	 	   nPuntaje := TO_NUMBER(nValRango);

		   GR_RETENCIONES_PG.GR_AGREGAEVALUACIONCONTACTO_PR(v_NumContacto,v_NumAbonado,codcriterio,15,nCodCategoria);
		   nTraDato := 0;

		ELSE
		   nTraDato := -1;
		END IF;


		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				nTraDato := -1;
			WHEN OTHERS THEN
			    RAISE_APPLICATION_ERROR(-20511,'GR_CATEGORIACLIENTE_PR('||nCodCliente||', '||p_codmodulo||', '||CodCriterio||', '||v_NumContacto||', '||v_NumAbonado||', '||nPuntaje||', '||nTraDato||') - '||SQLERRM);
	END GR_CATEGORIACLIENTE_PR;

/*******************************************************************************************************************************************************************/

PROCEDURE GR_CODIGOARTDELEQUIPO_PR (sCodTecnologia IN VARCHAR2,
	   	  		  							   	v_NumAbonado   IN GA_EQUIPABOSER.NUM_ABONADO%TYPE,
												nNumImei       IN GA_EQUIPABOSER.NUM_IMEI%TYPE,
	   	  		  							   	nNumSerie      IN GA_EQUIPABOSER.NUM_SERIE%TYPE,
												sFecAlta       IN GA_EQUIPABOSER.FEC_ALTA%TYPE,
												nCodArticulo   OUT GA_EQUIPABOSER.COD_ARTICULO%TYPE,
												nTraDato       OUT NUMBER
												)IS
BEGIN
	IF sCodTecnologia = 'GSM' Then

			SELECT cod_articulo
			INTO nCodArticulo
			FROM GA_EQUIPABOSER
			WHERE fec_alta = sFecAlta
			AND num_imei = nNumImei
			AND num_abonado = v_NumAbonado;
	ELSE

			SELECT cod_articulo
			INTO nCodArticulo
			FROM GA_EQUIPABOSER
			WHERE fec_alta = sFecAlta
			AND num_serie = nNumSerie
			AND num_abonado = v_NumAbonado;
	END IF;

				EXCEPTION
				WHEN NO_DATA_FOUND THEN
					nTraDato := -1;
					nCodArticulo :=0;
				WHEN OTHERS THEN
					 RAISE_APPLICATION_ERROR(-20600,'GR_CODIGOARTDELEQUIPO_PR('||sCodTecnologia||', '||v_NumAbonado||', '||nNumImei||', '||nNumSerie||', '||sFecAlta||', '||nCodArticulo||', '||nTraDato||') - '||SQLERRM);

END GR_CODIGOARTDELEQUIPO_PR;

/*******************************************************************************************************************************************************************/

PROCEDURE GR_DIASFALTANTES_PR(nTipoAbonado  IN  NUMBER,
	   	  		  			  v_NumAbonado  IN  NUMBER,
							  p_codmodulo   IN  VARCHAR2,
							  cod_criterio  IN  NUMBER,
							  v_NumContacto IN NUMBER,
							  nTraDato      OUT NUMBER,
							  nPuntaje      OUT NUMBER
										    ) IS


  nDiasFaltantes    NUMBER;
  nValRango         VARCHAR2(10);

 	BEGIN



		IF nTipoAbonado = 2 or nTipoAbonado = 3 THEN
			SELECT NVL(TRUNC(GREATEST(SYSDATE - fec_fincontra,0)),0)
			INTO nDiasFaltantes
			FROM ga_abocel
			WHERE num_abonado = v_NumAbonado;
		ELSE
			SELECT NVL(TRUNC(GREATEST(SYSDATE - fec_fincontra,0)),0)
			INTO nDiasFaltantes
			FROM ga_aboamist
			WHERE num_abonado = v_NumAbonado;
		END IF;


		nValRango := GR_RETENCIONES_PG.GR_BUSCAVALORRANGO_FN (p_codmodulo ,cod_criterio ,nDiasFaltantes);

		IF nValRango <> 'E' THEN

	 	nPuntaje := TO_NUMBER(nValRango);

		   GR_RETENCIONES_PG.GR_AGREGAEVALUACIONCONTACTO_PR(v_NumContacto,v_NumAbonado,cod_criterio,8,nDiasFaltantes);
		   nTraDato := 0;

		ELSE
			nTraDato := -1;
		END IF ;

		EXCEPTION
				 WHEN NO_DATA_FOUND THEN
				 	  nTraDato := -1;
				 WHEN OTHERS THEN
				      RAISE_APPLICATION_ERROR(-20507, 'GR_DIASFALTANTES_PR('||nTipoAbonado||', '||v_NumAbonado||', '||p_codmodulo||', '||cod_criterio||', '||v_NumContacto||', '||nTraDato||', '||nPuntaje||')- '||SQLERRM);

	END GR_DIASFALTANTES_PR;

/*******************************************************************************************************************************************************************/

PROCEDURE GR_FACTURACIONPROMEDIO_PR ( nCodCliente     IN NUMBER,
                                      v_CantidadMeses IN NUMBER,
									  p_codmodulo     IN VARCHAR2,
									  cod_criterio    IN NUMBER,
									  v_NumContacto   IN NUMBER,
									  v_NumAbonado    IN NUMBER,
									  nTraDato        OUT NUMBER,
									  nPuntaje        IN OUT NUMBER
									  ) IS
  nFacPromedio   NUMBER;
  nValRango      VARCHAR2(10);

  BEGIN

     SELECT NVL(TRUNC((SUM(a.Tot_factura))/v_CantidadMeses),0)
	 INTO   nFacPromedio
	 FROM   fa_histdocu a, fa_tipdocumen b
	 WHERE  a.fec_emision < ADD_MONTHS(SYSDATE,  (-1*v_CantidadMeses)) ---  PREGUNTAR POR EL CAMBIO DE SIGNO
	 AND    a.cod_cliente = nCodCliente
	 AND    a.ind_anulada = 0
	 AND    b.ind_ciclo = 1
	 AND    a.cod_tipdocum = b.cod_tipdocummov;



	 nValRango   := GR_RETENCIONES_PG.GR_BUSCAVALORRANGO_FN (p_codmodulo ,cod_criterio ,nFacPromedio);

	 IF nValRango <> 'E' THEN

	 	nPuntaje := TO_NUMBER(nValRango);

		GR_RETENCIONES_PG.GR_AGREGAEVALUACIONCONTACTO_PR(v_NumContacto,v_NumAbonado,cod_criterio,2,nFacPromedio);
		nTraDato := 0;

     ELSE
	    nTraDato := 1;
	 END IF;



  EXCEPTION
	 WHEN NO_DATA_FOUND THEN
		nTraDato := -1;
	WHEN OTHERS THEN
	    RAISE_APPLICATION_ERROR(-20501,'GR_FACTURACIONPROMEDIO_PR('||nCodCliente||', '||v_CantidadMeses||', '||p_codmodulo||', '||cod_criterio||', '||v_NumContacto||', '||v_NumAbonado||', '||nTraDato||', '||nPuntaje ||')- ' || SQLERRM);

  END GR_FACTURACIONPROMEDIO_PR;

/*******************************************************************************************************************************************************************/

PROCEDURE GR_MOROSIDADHISTORICA_PR ( v_CantidadMesesMor IN  NUMBER,
	   	  		  								  nCodCliente        IN  NUMBER,
									   			  p_codmodulo        IN  VARCHAR2,
									   			  cod_criterio       IN  NUMBER,
												  v_NumContacto      IN  NUMBER,
												  v_NumAbonado       IN NUMBER,
									   			  nTraDato           OUT NUMBER,
									   			  nPuntaje           IN OUT NUMBER
									   			  ) IS
  sAntig∆edad    NUMBER;
  nValRango      VARCHAR2(10);
  nCantHistorico NUMBER;

  BEGIN
     -- ************   MOROSIDAD HISTORICA   ***************
     SELECT count(1)
	 INTO   nCantHistorico
	 FROM   co_hmorosos
	 WHERE  Fec_ingreso >= ADD_MONTHS(SYSDATE,  (-1*v_CantidadMesesMor))
	 AND    cod_cliente = nCodCliente
	 GROUP  BY cod_cliente;

 	 nValRango   := GR_RETENCIONES_PG.GR_BUSCAVALORRANGO_FN (p_codmodulo ,cod_criterio ,nCantHistorico);

	 IF nValRango <> 'E' THEN

	 	nPuntaje := TO_NUMBER(nValRango);

		GR_RETENCIONES_PG.GR_AGREGAEVALUACIONCONTACTO_PR(v_NumContacto, v_NumAbonado, cod_criterio, 5, nCantHistorico);
		nTraDato := 0;

     ELSE
	    nTraDato := -1;
	 END IF;

  EXCEPTION
	 WHEN NO_DATA_FOUND THEN
		nTraDato := -1;
	 WHEN OTHERS THEN
	    RAISE_APPLICATION_ERROR(-20504,'GR_MOROSIDADHISTORICA_PR('||v_CantidadMesesMor||', '||nCodCliente||', '||p_codmodulo||', '||cod_criterio||', '||v_NumContacto||', '||v_NumAbonado||', '||nTraDato||', '||nPuntaje||', '|| ') - '||SQLERRM);

END GR_MOROSIDADHISTORICA_PR;

/*******************************************************************************************************************************************************************/

PROCEDURE GR_MOROSIDADVIGENTE_PR ( nCodCliente       IN  NUMBER,
                              v_CantidadMeses   IN  NUMBER,
							  p_codmodulo       IN  VARCHAR2,
							  cod_criterio      IN  NUMBER,
							  v_NumAbonado      IN  NUMBER,
							  v_NumContacto     IN  NUMBER,
							  v_CantidadDiasMor IN  NUMBER,
							  v_MontoMinimoMor  IN  NUMBER,
							  nTraDato          OUT NUMBER,
							  nPuntaje          OUT NUMBER
							  ) IS
  nMontoDeuda    NUMBER;
  nValRango      VARCHAR2(10);
  nDiasMor       NUMBER;
  nFacPromedio   NUMBER;


  BEGIN

	  SELECT NVL(deu_vencida,0)
	  INTO   nMontoDeuda
	  FROM   co_morosos
	  WHERE  Fec_ingreso < SYSDATE - v_CantidadDiasMor  ---  PREGUNTAR POR EL CAMBIO DE SIGNO
	  AND    cod_cliente = nCodCliente
	  AND    deu_vencida >= v_MontoMinimoMor;


	  GR_RETENCIONES_PG.GR_AGREGAEVALUACIONCONTACTO_PR(v_NumContacto, v_NumAbonado, cod_criterio, 3, nMontoDeuda);


	  SELECT TRUNC(SYSDATE - Fec_ingreso)
	  INTO   nDiasMor
	  FROM   co_morosos
	  WHERE  cod_cliente = nCodCliente;

	  nValRango   := GR_RETENCIONES_PG.GR_BUSCAVALORRANGO_FN (p_codmodulo ,cod_criterio ,nMontoDeuda);

	  IF nValRango <> 'E' THEN

	 	nPuntaje := TO_NUMBER(nValRango);

		 GR_RETENCIONES_PG.GR_AGREGAEVALUACIONCONTACTO_PR(v_NumContacto,v_NumAbonado,cod_criterio,4,nDiasMor);
		 nTraDato := 0;

      ELSE
	     nTraDato := 1;
	  END IF;


  EXCEPTION
	  WHEN NO_DATA_FOUND THEN
		  nTraDato := -1;
	  WHEN OTHERS THEN
	      RAISE_APPLICATION_ERROR(-20502,'GR_MOROSIDADVIGENTE_PR('|| nCodCliente||', '||v_CantidadMeses||', '||p_codmodulo||', '||cod_criterio||', '||v_NumAbonado||', '||v_NumContacto||', '||v_CantidadDiasMor||', '||v_MontoMinimoMor||', '||nTraDato||', '||nPuntaje||')- '||SQLERRM);


  END GR_MOROSIDADVIGENTE_PR;

/*******************************************************************************************************************************************************************/

PROCEDURE GR_RETENCIONESHISTORICAS_PR  ( v_NumAbonado       IN  NUMBER,
	   	  		  						 v_CantidadMeses    IN  NUMBER,
	   	  		  						 nCodCliente        IN  NUMBER,
									   	 p_codmodulo        IN  VARCHAR2,
									   	 cod_criterio       IN  NUMBER,
										 v_NumContacto      IN NUMBER,
									   	 nTraDato           OUT NUMBER,
									   	 nPuntaje           IN OUT NUMBER
									   	 ) IS
  sAntig∆edad    NUMBER;
  nValRango      VARCHAR2(10);
  nCantRetHist   NUMBER;

  BEGIN
     -- ************   RETENCIONES HISTORICAS   ***************
	 SELECT COUNT(1)
	 INTO   nCantRetHist
	 FROM   RET_FICHAS_TH
	 WHERE  num_abonado = v_NumAbonado
	 AND    fec_ficha > ADD_MONTHS(SYSDATE,  (-1*v_CantidadMeses))
	 AND    num_ficha > 0
	 AND    cod_estado_ficha <> 1;


	 nValRango   := GR_RETENCIONES_PG.GR_BUSCAVALORRANGO_FN (p_codmodulo ,cod_criterio ,nCantRetHist);

	 IF nValRango <> 'E' THEN

	 	nPuntaje := TO_NUMBER(nValRango);

		GR_RETENCIONES_PG.GR_AGREGAEVALUACIONCONTACTO_PR(v_NumContacto, v_NumAbonado, cod_criterio, 6, nCantRetHist);
		nTraDato := 0;

     ELSE
	    nTraDato := 1;
	 END IF;

  EXCEPTION
	 WHEN NO_DATA_FOUND THEN
		nTraDato := 1;
	 WHEN OTHERS THEN
	    RAISE_APPLICATION_ERROR(-20505,'GR_RETENCIONESHISTORICAS_PR('||v_CantidadMeses||', '||nCodCliente||', '||p_codmodulo||', '||cod_criterio||', '||v_NumContacto||', '||nTraDato||', '||nPuntaje||')- '||SQLERRM);

  END GR_RETENCIONESHISTORICAS_PR;

/*******************************************************************************************************************************************************************/

  PROCEDURE GR_RETENCIONESHISTACEPTADAS_PR ( v_NumAbonado       IN  NUMBER,
	   	  		  						     v_CantidadMeses    IN  NUMBER,
	   	  		  						     nCodCliente        IN  NUMBER,
									   	     p_codmodulo        IN  VARCHAR2,
									   	     cod_criterio       IN  NUMBER,
											 v_NumContacto      IN  NUMBER,
									   	     nTraDato           OUT NUMBER,
									   	     nPuntaje           IN OUT NUMBER
									   	     ) IS
  sAntig∆edad    NUMBER;
  nValRango      VARCHAR2(10);
  nCantRetHistAceptadas   NUMBER;

  BEGIN
     -- ************   RETENCIONES HISTORICAS ACEPTADAS  ***************
	 SELECT COUNT(1)-1
	 INTO   nCantRetHistAceptadas
	 FROM   RET_FICHAS_TH
	 WHERE  num_abonado = v_NumAbonado
	 AND    fec_ficha > ADD_MONTHS(SYSDATE,  (-1*v_CantidadMeses))
	 AND    cod_ult_resultado = 1
	 AND    num_ficha > 0;


	 nValRango := GR_RETENCIONES_PG.GR_BUSCAVALORRANGO_FN (p_codmodulo ,cod_criterio ,nCantRetHistAceptadas);

	 IF nValRango <> 'E' THEN

	 	nPuntaje := TO_NUMBER(nValRango);

		 GR_RETENCIONES_PG.GR_AGREGAEVALUACIONCONTACTO_PR(v_NumContacto, v_NumAbonado, cod_criterio, 7, nCantRetHistAceptadas);
		 nTraDato := 0;

     ELSE
	     nTraDato := 1;
	 END IF;

  EXCEPTION
	 WHEN NO_DATA_FOUND THEN
		nTraDato := 1;
	 WHEN OTHERS THEN
	    RAISE_APPLICATION_ERROR(-20506,'GR_RETENCIONESHISTACEPTADAS_PR('||v_NumAbonado||', '||v_CantidadMeses||', '||nCodCliente||', '||p_codmodulo||', '||cod_criterio||', '||v_NumContacto||', '||nTraDato||', '||nPuntaje||') -'||SQLERRM);

  END GR_RETENCIONESHISTACEPTADAS_PR;

/*******************************************************************************************************************************************************************/

  PROCEDURE GR_CRITERIOTIPOABONADO_PR (nTipoAbonado IN NUMBER,
							   		   v_NumContacto IN NUMBER,
							   		   v_NumAbonado  IN NUMBER,
							   		   nPuntaje IN OUT NUMBER,
							   		   nTraDato OUT NUMBER,
							   		   CodCriterio IN NUMBER,
							   		   p_codmodulo IN  VARCHAR2
								       ) IS


	    nValRango VARCHAR2(10);
		BEGIN

			nValRango := GR_RETENCIONES_PG.GR_BUSCAVALORRANGO_FN (p_codmodulo ,CodCriterio ,nTipoAbonado);

			IF nValRango <> 'E' THEN

	 	         nPuntaje := TO_NUMBER(nValRango);
				 GR_RETENCIONES_PG.GR_AGREGAEVALUACIONCONTACTO_PR(v_NumContacto,v_NumAbonado,codcriterio,13,nTipoAbonado);
				 nTraDato := 0;

			ELSE
				 nTraDato := -1;
		    END IF;

		EXCEPTION
		     WHEN OTHERS THEN
		     	  RAISE_APPLICATION_ERROR(-20510,'GR_CRITERIOTIPOABONADO_PR('||nTipoAbonado||', '||v_NumContacto||', '||v_NumAbonado||', '||nPuntaje||', '||nTraDato||', '||CodCriterio||', '||p_codmodulo||') - '||SQLERRM);

  END GR_CRITERIOTIPOABONADO_PR;

/*******************************************************************************************************************************************************************/

  PROCEDURE GR_TIPOEQUIPO_PR (v_NumAbonado  IN GA_ABOCEL.NUM_ABONADO%TYPE,
	   	  		  			  nTipoAbonado  IN  NUMBER,
							  v_NumContacto IN RET_CONTACTOS_EVALUACION_TH.NUM_CONTACTO%TYPE,
							  codcriterio   IN NUMBER,
							  p_codmodulo   IN VARCHAR,
							  nTraDato      OUT NUMBER,
							  nPuntaje      IN OUT NUMBER) IS

	sCodTecnologia GA_ABOCEL.cod_tecnologia%TYPE;
	nNumSerie	   GA_ABOCEL.num_serie%TYPE;
	nNumImei	   GA_ABOCEL.num_imei%TYPE;
	sFecAlta	   GA_ABOCEL.fec_alta%TYPE;
	nCodArticulo   GA_EQUIPABOSER.COD_ARTICULO%TYPE;
	nCodRangoEquipo ret_rango_equipos_to.COD_RANGO_EQUIPO%TYPE;
	nValRango VARCHAR2(10);

	BEGIN

		IF nTipoAbonado = 2 or nTipoAbonado = 3 THEN
			SELECT cod_tecnologia, num_serie, num_imei, fec_alta
			INTO sCodTecnologia,nNumSerie,nNumImei,sFecAlta
			FROM GA_ABOCEL
			WHERE num_abonado = v_NumAbonado;
		ELSE
			SELECT cod_tecnologia, num_serie, num_imei, fec_alta
			INTO sCodTecnologia,nNumSerie,nNumImei,sFecAlta
			FROM GA_ABOAMIST
			WHERE num_abonado = v_NumAbonado;
		END IF;

		GR_RETENCIONES_PG.GR_CODIGOARTDELEQUIPO_PR (sCodTecnologia,v_NumAbonado,nNumImei,nNumSerie,sFecAlta,nCodArticulo,nTraDato);



		SELECT cod_rango_equipo
		INTO nCodRangoEquipo
		FROM ret_rango_equipos_to
		WHERE cod_equipo = nCodArticulo;

		GR_RETENCIONES_PG.GR_AGREGAEVALUACIONCONTACTO_PR(v_NumContacto,v_NumAbonado,codcriterio,9,nCodArticulo);

		nValRango := GR_RETENCIONES_PG.GR_BUSCAVALORRANGO_FN (p_codmodulo ,codcriterio ,nCodRangoEquipo);

		GR_RETENCIONES_PG.GR_AGREGAEVALUACIONCONTACTO_PR(v_NumContacto,v_NumAbonado,codcriterio,10,nCodRangoEquipo);

		IF nValRango <> 'E' THEN

	 	   nPuntaje := TO_NUMBER(nValRango);
		   nTraDato := 0;

		ELSE
		   nTraDato := -1;
		END IF;

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				nTraDato := 1;
			WHEN OTHERS THEN
				 RAISE_APPLICATION_ERROR(-20508,'GR_TIPOEQUIPO_PR('||v_NumAbonado||', '||nTipoAbonado||', '||v_NumContacto||', '||codcriterio||', '||p_codmodulo||', '||nTraDato||', '||nPuntaje||') - '||SQLERRM);
END GR_TIPOEQUIPO_PR;

/*******************************************************************************************************************************************************************/

PROCEDURE GR_VALOREXTERNO_PR (nCodCliente IN ga_valor_cli.cod_cliente%TYPE,
	   	  		  						  p_codmodulo IN VARCHAR,
										  CodCriterio IN NUMBER,
										  v_NumContacto IN NUMBER,
										  v_NumAbonado IN NUMBER,
										  nPuntaje    IN OUT NUMBER,
										  nTraDato    OUT NUMBER) IS

	nCodValor NUMBER;
	nValRango VARCHAR2(10);

	BEGIN
		 SELECT COD_VALOR
		 INTO nCodValor
		 FROM ga_valor_cli
		 WHERE cod_cliente = nCodCliente;

		 nValRango := GR_RETENCIONES_PG.GR_BUSCAVALORRANGO_FN (p_codmodulo ,CodCriterio ,nCodValor);

		 IF nValRango <> 'E' THEN

	 	 	 nPuntaje := TO_NUMBER(nValRango);

		 	 GR_RETENCIONES_PG.GR_AGREGAEVALUACIONCONTACTO_PR(v_NumContacto,v_NumAbonado,codcriterio,14,nCodValor);
			 nTraDato := 0;

		 ELSE
		 	 nTraDato := 1;
		 END IF;


		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				nTraDato := 1;
			WHEN OTHERS THEN
			    RAISE_APPLICATION_ERROR(-20511,'GR_VALOREXTERNO_PR('||nCodCliente||', '||p_codmodulo||', '||CodCriterio||', '||v_NumContacto||', '||v_NumAbonado||', '||nPuntaje||', '||nTraDato||') - ');
	END GR_VALOREXTERNO_PR;

/*******************************************************************************************************************************************************************/

PROCEDURE GR_TIPODEPLAN_PR ( nTipoAbonado    IN  NUMBER,
 	   	  		  						   v_NumAbonado    IN  NUMBER,
										   p_codmodulo     IN  VARCHAR2,
										   v_NumContacto   IN  NUMBER,
										   cod_criterio    IN  NUMBER,
									   	   nTraDato        OUT NUMBER,
									   	   nPuntaje        IN OUT NUMBER
									   	   ) IS
  sCodPlanTarif    VARCHAR2(3);
  sCodCargoBasico  VARCHAR2(3);
  nValRango        VARCHAR2(10);
  nImpCargoBasico  NUMBER;
  nValMin          NUMBER;
  nValMax          NUMBER;
  nCodRangoPlan    NUMBER;


  BEGIN
		 IF nTipoAbonado = 2 or nTipoAbonado = 3 THEN
			 SELECT cod_plantarif
			 INTO   sCodPlanTarif
			 FROM   ga_abocel
			 WHERE  num_abonado = v_NumAbonado;
		 ELSE
		 	 SELECT cod_plantarif
			 INTO   sCodPlanTarif
			 FROM   ga_aboamist
			 WHERE  num_abonado = v_NumAbonado;
		 END IF;


		 SELECT cod_cargobasico
		 INTO   sCodCargoBasico
		 FROM   ta_plantarif
		 WHERE  cod_plantarif = sCodPlanTarif;

		 SELECT imp_cargobasico
		 INTO   nImpCargoBasico
		 FROM   ta_cargosbasico
		 WHERE  cod_cargobasico = sCodCargoBasico;

	 	 SELECT val_parametro
		 INTO   nValMin
		 FROM   ged_parametros
		 WHERE  cod_modulo = 'GR'
		 AND    nom_parametro = 'RET_RANGO_BAJO_PLAN'
		 AND    cod_producto = 1;

		 SELECT val_parametro
		 INTO   nValMax
		 FROM   ged_parametros
		 WHERE  cod_modulo = 'GR'
		 AND    nom_parametro = 'RET_RANGO_MEDIO_PLAN'
		 AND    cod_producto = 1;

		 IF nImpCargoBasico <= nValMin THEN
			 nCodRangoPlan  := 1;

		 ELSIF nValMin < nImpCargoBasico AND nImpCargoBasico <=  nValMax THEN
			 nCodRangoPlan  := 2;

		 ELSE
			 nCodRangoPlan  := 3;

		 END IF;

		 GR_AGREGAEVALUACIONCONTACTO_PR( v_NumContacto, v_NumAbonado, cod_criterio, 11, sCodPlanTarif);


		 nValRango := GR_RETENCIONES_PG.GR_BUSCAVALORRANGO_FN (p_codmodulo ,cod_criterio ,nCodRangoPlan);

		 IF nValRango <> 'E' THEN
		 	 nPuntaje    := TO_NUMBER(nValRango);

			 GR_RETENCIONES_PG.GR_AGREGAEVALUACIONCONTACTO_PR(v_NumContacto,v_NumAbonado,cod_criterio,12,nCodRangoPlan);
			 nTraDato := 0;

	     ELSE
		     nTraDato := 1;
		 END IF;

  EXCEPTION
	  WHEN NO_DATA_FOUND THEN
		  nTraDato := 1;
	  WHEN OTHERS THEN
	      RAISE_APPLICATION_ERROR(-20509,'GR_TIPODEPLAN_PR('||nTipoAbonado||', '||v_NumAbonado||', '||p_codmodulo||', '||v_NumContacto||', '||cod_criterio||', '||nTraDato||', '||nPuntaje||') -'||SQLERRM);

  END GR_TIPODEPLAN_PR;

/*******************************************************************************************************************************************************************/

  PROCEDURE GR_ANTIGUEDAD_PR ( nTipoAbonado  IN NUMBER,
                               v_NumAbonado  IN NUMBER,
							   p_codmodulo   IN VARCHAR2,
							   cod_criterio  IN NUMBER,
							   v_NumContacto IN NUMBER,
							   nTraDato      OUT NUMBER,
							   nPuntaje      OUT NUMBER
							   ) IS

  sAntig∆edad    VARCHAR2(1000);
  nValRango      VARCHAR2(10);

  BEGIN -- ************   ANTIGUEDAD   ***************



	 IF nTipoAbonado = 2 or nTipoAbonado = 3 THEN
		SELECT TRUNC(MONTHS_BETWEEN(SYSDATE,fec_alta)) antig∆edad
		INTO   sAntig∆edad
		FROM   GA_ABOCEL
		WHERE  cod_situacion <> 'BAA'
		AND    num_abonado = v_NumAbonado;
	 ELSE
		SELECT TRUNC(months_between(SYSDATE,fec_alta)) antig∆edad
		INTO   sAntig∆edad
		FROM   GA_ABOAMIST
		WHERE  cod_situacion <> 'BAA'
		AND    num_abonado = v_NumAbonado;
	 END IF;

	 nValRango   := GR_RETENCIONES_PG.GR_BUSCAVALORRANGO_FN (p_codmodulo ,cod_criterio ,sAntig∆edad);


	 IF nValRango <> 'E' THEN

	 	nPuntaje := TO_NUMBER(nValRango);

		GR_RETENCIONES_PG.GR_AGREGAEVALUACIONCONTACTO_PR(v_NumContacto,v_NumAbonado,cod_criterio,1,sAntig∆edad);
		nTraDato := 0;

     ELSE
	    nTraDato := 1;
	 END IF;

  EXCEPTION
	 WHEN NO_DATA_FOUND THEN
		nTraDato := 1;
	 WHEN OTHERS THEN
	    RAISE_APPLICATION_ERROR(-20500,'GR_ANTIGUEDAD_PR('||nTipoAbonado||' ,'||v_NumAbonado||' ,'||p_codmodulo||' ,'||cod_criterio||' ,'||v_NumContacto||' ,'||nTraDato||' ,'||nPuntaje||') '||SQLERRM);

  END GR_ANTIGUEDAD_PR;

/*******************************************************************************************************************************************************************/

  PROCEDURE GR_EXISTENCIAABONADO_PR ( v_NumAbonado     IN NUMBER,
                                        nCodTipoAbonEsp  OUT NUMBER,
										sDesTipoAbonEsp  OUT VARCHAR2,
										sIndRetencion    OUT VARCHAR2,
										nTraDato         OUT NUMBER ) IS

 	BEGIN

    	  SELECT b.cod_tipo_abonesp, b.des_tipo_abonesp, b.ind_retencion
   		  INTO   nCodTipoAbonEsp,    sDesTipoAbonEsp,    sIndRetencion
   		  FROM   ge_abonados_esp_to a, ge_tipabonados_esp_td b
   		  WHERE  a.cod_tipo_abonesp = b.cod_tipo_abonesp
   		  AND    a.num_abonado      = v_NumAbonado;

   		  nTraDato := 0;

		  EXCEPTION
   		  		   WHEN NO_DATA_FOUND THEN
				   		nTraDato := 1;
   					WHEN OTHERS THEN
   						RAISE_APPLICATION_ERROR(-20510, 'GR_EXISTENCIAABONADO_PR('||v_NumAbonado||')- '||SQLERRM);
END GR_EXISTENCIAABONADO_PR;

/*******************************************************************************************************************************************************************/

PROCEDURE GR_BUSCATIPOABONADO_PR ( TotalPuntaje IN  NUMBER,
	   	  		  				   nCodTipoAbon OUT NUMBER,
	   	  		  				   vDesTipoAbon OUT VARCHAR2,
								   nTraDato     OUT NUMBER ) IS

BEGIN

	SELECT cod_tipo_abon, des_tipo_abon
	INTO   nCodTipoAbon,  vDesTipoAbon
	FROM   ge_tipabonados_td
	WHERE  min_tipo <= TotalPuntaje
	AND    max_tipo >= totalPuntaje
	AND    cod_modulo = 'GR';
	nTraDato := 0;
EXCEPTION

	WHEN NO_DATA_FOUND THEN
	     nTraDato := 1;
	WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR(-20510, 'GR_BUSCATIPOABONADO_PR('||TotalPuntaje||')- '||SQLERRM);
END GR_BUSCATIPOABONADO_PR;

/*******************************************************************************************************************************************************************/

PROCEDURE GR_CODIGOCLIENTE_PR ( v_NumAbonado IN  NUMBER,
	   	  		  				nTipoAbonado IN NUMBER,
                                nCodCliente  OUT NUMBER
							   )  IS


 BEGIN
    IF nTipoAbonado = 2 or nTipoAbonado = 3 THEN
        SELECT cod_cliente
        INTO nCodCliente
        FROM ga_abocel
        WHERE num_abonado = v_NumAbonado;
    ELSE
        SELECT cod_cliente
        INTO nCodCliente
        FROM ga_aboamist
        WHERE num_abonado = v_NumAbonado;
    END IF;


 EXCEPTION
    WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20513,'GR_CODIGOCLIENTE_PR('||v_NumAbonado||', '||nTipoAbonado||', '||nCodCliente ||') -'||SQLERRM);

    WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR(-20513,'GR_CODIGOCLIENTE_PR('||v_NumAbonado||', '||nTipoAbonado||', '||nCodCliente ||') -'||SQLERRM);


 END GR_CODIGOCLIENTE_PR;

/*******************************************************************************************************************************************************************/

 PROCEDURE GR_TOTCONTACTOSRET_PR(v_FecDesde   IN Varchar2,
	   	  		  				 v_FecHasta   IN Varchar2,
								 v_Usuario    IN NUMBER,
								 v_Formato	  IN Varchar2,
								 Tot_Contactos OUT NUMBER,
								 Tot_PostPago  OUT NUMBER,
								 Tot_Prepago   OUT NUMBER) IS

    BEGIN

	    SELECT count(1)
	    INTO Tot_Contactos
	    FROM ret_contactos_th
	    WHERE cod_vendedor = v_Usuario
	    AND fec_contacto BETWEEN to_date(v_FecDesde,v_Formato) AND to_date(v_FecHasta,v_Formato);


		SELECT count(1)
		INTO Tot_PostPago
		FROM ret_contactos_th a, ret_fichas_th b
		WHERE A.NUM_FICHA = b.num_ficha
	    AND fec_contacto BETWEEN to_date(v_FecDesde,v_Formato) AND to_date(v_FecHasta,v_Formato)
		AND cod_tipo_producto in (2,3)
		AND cod_resultado = 1
		AND cod_vendedor = v_Usuario;


		SELECT count(1)
		INTO Tot_Prepago
		FROM ret_contactos_th a, ret_fichas_th b
		WHERE a.num_ficha = b.num_ficha
		AND fec_contacto BETWEEN to_date(v_FecDesde,v_Formato) AND to_date(v_FecHasta,v_Formato)
		AND cod_resultado = 1
		AND cod_tipo_producto =1
		AND cod_vendedor = v_Usuario;




 	EXCEPTION

	   WHEN NO_DATA_FOUND THEN

	   Tot_Contactos := 0;
	   Tot_PostPago  := 0;
	   Tot_Prepago   := 0;


	   WHEN OTHERS THEN
	   		RAISE_APPLICATION_ERROR(-20100,'No es Posible Recuperar el Total de Contactos');

 	END GR_TOTCONTACTOSRET_PR;

/*******************************************************************************************************************************************************************/

PROCEDURE GR_GestionComisionistasRet_PR(TipComis   IN NUMBER,
								  		v_FecDesde IN VARCHAR2,
			  					  		v_FecHasta IN VARCHAR2,
			  					  		v_Formato  IN VARCHAR2,
			  					  		FecContacto   out GR_TIPOS_PG.col1,
			  					  		Contactos     out GR_TIPOS_PG.col2,
			  					  		RetenidosCon  out GR_TIPOS_PG.col2,
			  					  		RetenidosPrep out GR_TIPOS_PG.col2,
			  					  		Fugados       out GR_TIPOS_PG.col2) IS

	FecContacto2   GR_TIPOS_PG.COL1;
    FecTmp         GR_TIPOS_PG.col1;
	Contactos2     GR_TIPOS_PG.col2;
	RetenidosCon2  GR_TIPOS_PG.col2;
	RetenidosPrep2 GR_TIPOS_PG.col2;
	Fugados2       GR_TIPOS_PG.col2;
	FecDesTmp      DATE;
    aux            GR_TIPOS_PG.ref_cursor;
    CodVendedor    VE_REDVENTAS_TD.COD_VENDEDOR%type;
    i              NUMBER;
    j              NUMBER;
    TotDias        NUMBER;
    ContDias       NUMBER;
    flag           NUMBER;

   CURSOR REPORTE (XCodVendedor VE_REDVENTAS_TD.COD_VENDEDOR%type, FecDesde2 VARCHAR2, FecHasta2 VARCHAR2, Formato2 VARCHAR2)IS
       SELECT TO_CHAR(FecContacto,'DD-MM-YYYY') AS FecCon,
	       SUM(TotalContactos) AS Contactos,
	       SUM(TotRetenidosCon) AS RetenidosCon,
	       SUM(TotRetenidosPrep) AS RetenidosPrep,
		   SUM(DadosBaja) AS Fugados
		FROM
		  (SELECT TRUNC(fec_contacto) AS FecContacto,
		           COUNT(cod_vendedor) AS TotalContactos,
				   0 AS TotRetenidosCon,
				   0 AS TotRetenidosPrep,
				   0 AS DadosBaja
			FROM ret_contactos_th
			WHERE cod_vendedor = XCodVendedor
		    AND fec_contacto BETWEEN TO_DATE(FecDesde2,v_Formato) AND TO_DATE(FecHasta2,v_Formato)
			GROUP BY TRUNC(fec_contacto)
		    UNION
		    SELECT TRUNC(fec_contacto) AS FecContacto,
			      0 AS TotalContactos,
				  COUNT(cod_vendedor) AS TotRetenidosCon,     --Contrato
				  0 AS TotRetenidosPrep,
				  0 AS DadosBaja
		    FROM ret_contactos_th a, ret_fichas_th b
		    WHERE a.num_ficha = b.num_ficha
		    AND fec_contacto BETWEEN TO_DATE(FecDesde2,v_Formato) AND TO_DATE(FecHasta2,v_Formato)
		    AND cod_tipo_producto IN (2,3)
		    AND cod_resultado = 1
		    AND cod_vendedor = XCodVendedor
			GROUP BY TRUNC(fec_contacto)
		    UNION
		    SELECT TRUNC(fec_contacto) AS FecContacto,
			      0 AS TotalContactos,
				  0 AS TotRetenidosCon,
		  		  COUNT(cod_vendedor) AS TotRetenidosPrep,    -- Retenidos Prepago
				  0 AS DadosBaja
		    FROM ret_contactos_th a, ret_fichas_th b
		    WHERE a.num_ficha = b.num_ficha
		    AND fec_contacto BETWEEN TO_DATE(FecDesde2,v_Formato) AND TO_DATE(FecHasta2,v_Formato)
		    AND cod_tipo_producto = 1
		    AND cod_resultado = 1
		    AND cod_vendedor = XCodVendedor
			GROUP BY TRUNC(fec_contacto)
			UNION
			SELECT TRUNC(fec_contacto) AS FecContacto,
		           0 AS TotalContactos,
				   0 AS TotRetenidosCon,
				   0 AS TotRetenidosPrep,
				   COUNT(cod_vendedor) AS DadosBaja
			FROM ret_contactos_th
			WHERE cod_vendedor = XCodVendedor
		    AND fec_contacto BETWEEN TO_DATE(FecDesde2,v_Formato) AND TO_DATE(FecHasta2,v_Formato)
			AND cod_resultado = 2
			GROUP BY TRUNC(fec_contacto)
		  )
		GROUP BY  FecContacto
		ORDER BY FecContacto;


BEGIN
   VE_RecuperarEjecutivos_PR(TipComis,aux);
   i:= 1;
   TotDias := 0;
   flag:= 0;
   FecDesTmp := to_date(v_FecDesde,v_Formato);

   WHILE FecDesTmp <= TO_DATE(v_FecHasta,v_Formato) LOOP

		 FecTmp(i) := TO_CHAR(FecDesTmp,'dd-mm-yyyy');
		 Contactos2(i)    := 0;
		 RetenidosCon2(i) := 0;
		 RetenidosPrep2(i):= 0;
	 	 Fugados2(i)      := 0;
   		 FecDesTmp := FecDesTmp + 1;
		 i := i + 1;
		 TotDias := TotDias +1;
   END LOOP;

   i := 1;
   loop
        FETCH aux INTO CodVendedor;
		EXIT WHEN aux%NOTFOUND;
		BEGIN
			FOR VAR IN REPORTE(CodVendedor, v_FecDesde, v_FecHasta, v_Formato) LOOP

			    flag := 1;
			    FecContacto(i)  := VAR.FecCon;
				Contactos(i)    := VAR.Contactos;
				RetenidosCon(i) := VAR.RetenidosCon;
				RetenidosPrep(i):= VAR.RetenidosPrep;
				Fugados(i)      := VAR.Fugados;
				i:= i + 1;
			END LOOP;
		END;
   end loop;

   dbms_output.PUT_LINE('Existen >> ' || i || '   Datos ');

   IF flag = 0 THEN
      FecContacto(1) := NULL;
      Contactos(1)   := NULL;
	  RetenidosCon(1)   := NULL;
	  Fugados(1)     := NULL;
   END IF;

   j := 1;
   ContDias := 1;
   WHILE j < i LOOP
        WHILE FecContacto(j) <> FecTmp(ContDias) LOOP
			ContDias := ContDias + 1;
			if ContDias = TotDias THEN
			   ContDias := 1;
			END IF;
	    END LOOP;

	    FecContacto2(ContDias) := FecContacto(j);
		Contactos2(ContDias)    := Contactos2(ContDias) + Contactos(j);
		RetenidosCon2(ContDias) := RetenidosCon2(ContDias) + RetenidosCon(j);
		RetenidosPrep2(ContDias):= RetenidosPrep2(ContDias) + RetenidosPrep(j);
		Fugados2(ContDias)      := Fugados2(ContDias) + Fugados(j);
		j := j + 1;

   END LOOP;

   j:=1;
   ContDias := 1;
   WHILE j < TotDias LOOP
   		IF Contactos2(j) <> 0 OR RetenidosCon2(j) <> 0 OR RetenidosPrep2(j) <> 0 OR Fugados2(j) <> 0 THEN
		    FecContacto(ContDias)  := FecTmp(j);
			Contactos(ContDias)    := Contactos2(j);
			RetenidosCon(ContDias) := RetenidosCon2(j);
			RetenidosPrep(ContDias):= RetenidosPrep2(j);
			Fugados(ContDias)      := Fugados2(j);
			ContDias := ContDias + 1;
		END IF;
		j := j + 1;
   END LOOP;

   WHILE ContDias < i LOOP
	    FecContacto(ContDias)  := NULL;
		Contactos(ContDias)    := NULL;
		RetenidosCon(ContDias) := NULL;
		RetenidosPrep(ContDias):= NULL;
		Fugados(ContDias)      := NULL;
		ContDias := ContDias + 1;
   END LOOP;


END GR_GestionComisionistasRet_PR;


/*******************************************************************************************************************************************************************/

PROCEDURE GR_TIPOABONADO_PR(v_NumAbonado in number,
							 v_Usuario in VARCHAR2,
							 v_NumContacto in number,
							 nTipoAbonado in NUMBER,
							 sRetorno OUT VARCHAR2,
							 ERRORSEV OUT VARCHAR2,
							 NEVENTO OUT NUMBER,
							 ERRORDES OUT VARCHAR2
							 )IS

sNumProceso           VARCHAR(9);
sTerminal             VARCHAR(30);
nCodCliente           NUMBER;
nCodTipoAbonEsp       NUMBER;
sDesTipoAbonEsp       VARCHAR(30);
sIndRetencion         VARCHAR(1);
nPuntaje              NUMBER;
TotalPuntaje          NUMBER;
nCodTipoAbon          NUMBER;
vDesTipoAbon          VARCHAR2(30);
nTraDato			  NUMBER;
v_CantidadMeses       NUMBER;
v_CantidadDiasMor     NUMBER;
v_MontoMinimoMor      NUMBER;
v_CantidadMesesMor    NUMBER;
p_codmodulo           VARCHAR2(2);
ERROR                 BOOLEAN;



CURSOR Criterios_oper IS
SELECT cod_criterio,ind_vigencia
FROM ge_criterios_oper_to
WHERE ind_vigencia = 'V'
ORDER BY 1;
BEGIN
DBMS_OUTPUT.PUT_LINE('INICIANDO' );
TotalPuntaje :=0;
nEvento := 0;
p_codmodulo := 'GR';
ERROR := FALSE;



    GR_CODIGOCLIENTE_PR (v_NumAbonado,nTipoAbonado,nCodCliente);

	  v_CantidadMeses    :=GR_RETENCIONES_PG.GR_RECUPERAPARAMETROS_FN('RET_NUM_MESES_FACT','GR',1);
      v_CantidadDiasMor  :=GR_RETENCIONES_PG.GR_RECUPERAPARAMETROS_FN('RET_NUMDIAS_MORAVIG','GR',1);
      v_MontoMinimoMor   :=GR_RETENCIONES_PG.GR_RECUPERAPARAMETROS_FN('RET_MTO_MORA_VIG','GR',1);
      v_CantidadMesesMor :=GR_RETENCIONES_PG.GR_RECUPERAPARAMETROS_FN('RET_NUM_MESES_MOROSH','GR',1);

	GR_EXISTENCIAABONADO_PR (v_NumAbonado,nCodTipoAbonEsp,sDesTipoAbonEsp,sIndRetencion,nTraDato);


	IF nTraDato = 1 THEN
	    FOR rReg IN criterios_oper LOOP
		       nTraDato := 0;

		       IF rReg.cod_criterio = 1 THEN

			   	  	 GR_RETENCIONES_PG.GR_ANTIGUEDAD_PR( nTipoAbonado, v_NumAbonado, p_codmodulo, rReg.cod_criterio, v_NumContacto,
									   					 nTraDato, nPuntaje);

					 IF nTraDato = 0 THEN
					 	TotalPuntaje := TotalPuntaje + nPuntaje;
					 ELSE
					 	 ERROR := TRUE;
					 END IF;

			   ELSIF rReg.cod_criterio = 2 THEN

			   		 GR_RETENCIONES_PG.GR_FACTURACIONPROMEDIO_PR( nCodCliente, v_CantidadMeses, p_codmodulo, rReg.cod_criterio, v_NumContacto,
									  							   v_numabonado, nTraDato, nPuntaje );

					 IF nTraDato = 0 THEN
					 	TotalPuntaje := TotalPuntaje + nPuntaje;
					 ELSE
					 	 ERROR := TRUE;
					 END IF;

			   ELSIF rReg.cod_criterio = 3 THEN

			   		 GR_RETENCIONES_PG.GR_MOROSIDADVIGENTE_PR(nCodCliente,v_CantidadMeses,p_codmodulo,rReg.cod_criterio,
					 							  			   v_NumAbonado, v_NumContacto, v_CantidadDiasMor, v_MontoMinimoMor,
															   nTraDato, nPuntaje);

					 IF nTraDato = 0 THEN
					 	TotalPuntaje := TotalPuntaje + nPuntaje;
					 ELSE
					 	 ERROR := TRUE;
					 END IF;

			   ELSIF rReg.cod_criterio = 4 THEN

			   		 GR_RETENCIONES_PG.GR_MOROSIDADHISTORICA_PR(v_CantidadMesesMor, nCodCliente,p_codmodulo,
					 									   		 rReg.cod_criterio, v_NumContacto, v_NumAbonado,
																 nTraDato,nPuntaje);

					 IF nTraDato = 0 THEN
					 	TotalPuntaje := TotalPuntaje + nPuntaje;
					 ELSE
					 	 ERROR := TRUE;
					 END IF;

			   ELSIF rReg.cod_criterio = 5 THEN

			   		 GR_RETENCIONES_PG.GR_RETENCIONESHISTORICAS_PR(v_NumAbonado, v_CantidadMeses, nCodCliente, p_codmodulo, rReg.cod_criterio,
					 									   	 		v_NumContacto, nTraDato,nPuntaje );

					 IF nTraDato = 0 THEN
					 	TotalPuntaje := TotalPuntaje + nPuntaje;
					 ELSE
					 	 ERROR := TRUE;
					 END IF;

			   ELSIF rReg.cod_criterio = 6 THEN

			   		 GR_RETENCIONES_PG.GR_RETENCIONESHISTACEPTADAS_PR(v_NumAbonado, v_CantidadMeses, nCodCliente, p_codmodulo, rReg.cod_criterio,
					 									   	           v_NumContacto, nTraDato, nPuntaje );

					 IF nTraDato = 0 THEN
					 	TotalPuntaje := TotalPuntaje + nPuntaje;
					 ELSE
					 	 ERROR := TRUE;
					 END IF;

			   ELSIF rReg.cod_criterio = 7 THEN

			   		 GR_RETENCIONES_PG.GR_DIASFALTANTES_PR(nTipoAbonado, v_NumAbonado, p_codmodulo, rReg.cod_criterio, v_NumContacto, nTraDato,
					 							  			nPuntaje);

					 IF nTraDato = 0 THEN
					 	TotalPuntaje := TotalPuntaje + nPuntaje;
					 ELSE
					 	 ERROR := TRUE;
					 END IF;

			   ELSIF rReg.cod_criterio = 8 THEN

			   		 GR_RETENCIONES_PG.GR_TIPOEQUIPO_PR(v_NumAbonado,nTipoAbonado, v_NumContacto,rReg.cod_criterio, p_codmodulo,
					    							     nTraDato, nPuntaje );

					 IF nTraDato = 0 THEN
					 	TotalPuntaje := TotalPuntaje + nPuntaje;
					 ELSE
					 	 ERROR := TRUE;
					 END IF;

			   ELSIF rReg.cod_criterio = 9 THEN

			   		 GR_RETENCIONES_PG.GR_TIPODEPLAN_PR(nTipoAbonado,v_NumAbonado, p_codmodulo, v_NumContacto, rReg.cod_criterio,
					                                     nTraDato, nPuntaje);

					 IF nTraDato = 0 THEN
					 	TotalPuntaje := TotalPuntaje + nPuntaje;
					 ELSE
					 	 ERROR := TRUE;
					 END IF;

		       ELSIF rReg.cod_criterio = 10 THEN

			   		 GR_RETENCIONES_PG.GR_CRITERIOTIPOABONADO_PR(nTipoAbonado, v_NumContacto, v_NumAbonado, nPuntaje, nTraDato, rReg.cod_criterio,
					 						                      p_codmodulo);

					 IF nTraDato = 0 THEN
					 	TotalPuntaje := TotalPuntaje + nPuntaje;
					 ELSE
					 	 ERROR := TRUE;
					 END IF;

	  		   ELSIF rReg.cod_criterio = 11 THEN

					 GR_RETENCIONES_PG.GR_VALOREXTERNO_PR(nCodCliente, p_codmodulo, rReg.cod_criterio,v_NumContacto, v_NumAbonado, nPuntaje,
					 									   nTraDato);

					 IF nTraDato = 0 THEN
					 	TotalPuntaje := TotalPuntaje + nPuntaje;
					 ELSE
					 	 ERROR := TRUE;
					 END IF;

	  		   ELSIF rReg.cod_criterio = 12 THEN

			   		 GR_RETENCIONES_PG.GR_CATEGORIACLIENTE_PR (nCodCliente, p_codmodulo, rReg.cod_criterio, v_NumContacto, v_NumAbonado, nPuntaje, nTraDato);

					 IF nTraDato = 0 THEN
					 	TotalPuntaje := TotalPuntaje + nPuntaje;
					 ELSE
					 	 ERROR := TRUE;
					 END IF;

    		   END IF;

		END LOOP;
	    GR_BUSCATIPOABONADO_PR(TotalPuntaje,nCodTipoAbon,vDesTipoAbon,nTraDato);

		sRetorno:= v_NumAbonado||';'||nCodTipoAbon||';'||vDesTipoAbon||';'||TotalPuntaje||';'||'N';

	ELSE

	    sRetorno:= v_NumAbonado||';'||nCodTipoAbonEsp||';'||sDesTipoAbonEsp||';'||0||';'||'E';
	END IF;


EXCEPTION

	WHEN OTHERS THEN

		 ERRORSEV := 'Falso';
		 ERRORDES := 'GR_TIPOABONADO_PR('||TO_CHAR(v_NumAbonado)||', '||v_Usuario||', '||TO_CHAR(v_NumContacto)||', '||TO_CHAR(nTipoAbonado)||') - '||SQLERRM;

	       IF NOT GR_RETENCIONES_PG.GR_GRABAERROR_FN('PL: GR_TIPOABONADO_PR','GR_TIPOABONADO_PR', 3, ERRORDES, nEvento) THEN
		          RAISE_APPLICATION_ERROR(-20098,'No es Posible Grabar el Error');
		   END IF;

END GR_TIPOABONADO_PR;


END GR_RETENCIONES_PG;
/
SHOW ERRORS
