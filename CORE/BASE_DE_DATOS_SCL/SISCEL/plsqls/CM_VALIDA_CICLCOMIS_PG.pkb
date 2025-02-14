CREATE OR REPLACE PACKAGE BODY CM_VALIDA_CICLCOMIS_PG AS
/* *************************************************************************** */
/* 20030804 Fabian Aedo R. Versionado CUZCO 2003                               */
/* Se incorporan campos nuevos de la tabla Tip_CiclComis (P)                   */
/* y Des_CiclComis (NULL) SOLO SE CREAN CICLOS DE COMISION PERIODICOS.         */
/* *************************************************************************** */

sCODESTADO      VARCHAR2(3);
ERROR_PROCESO   Exception;
/* *************************************************************************** */
/* PROCEDURE CreaCiclComis                                                     */
/* ------------------------                                                    */
/* Procedimiento que crea un ciclo comisional normal, mensual.                 */
/* *************************************************************************** */
PROCEDURE CreaCiclComis(iCodCiclComis IN NUMBER)
IS
Fec_Desde_Normal        Date;
Fec_Desde_Prepago       Date;
Fec_Desde_Aceptacion    Date;
Fec_Desde_Recepcion     Date;
Fec_Hasta_Normal        Date;
Fec_Hasta_Prepago       Date;
Fec_Hasta_Aceptacion    Date;
Fec_Hasta_Recepcion     Date;
Fec_Desde_Todos         Date;
Fec_Hasta_Otros         Date;
V_BANDERA               NUMBER;
BEGIN
	BEGIN
		  SELECT Fec_Hasta_Normal  ,
		         Fec_Hasta_Prepago ,
		         Fec_Hasta_Aceptacion ,
		         Fec_Hasta_Recepcion
		     into
		         Fec_Desde_Normal,
		         Fec_Desde_Prepago,
		         Fec_Desde_Aceptacion,
		         Fec_Desde_Recepcion
		  From CM_CICLCOMIS_TD
		  Where  Cod_ciclcomis = (Select to_number(to_char(add_months(to_date(iCodCiclComis,'yyyymmdd'),-1),'yyyymmdd'))
		                    From DUAL )
			AND TIP_CICLCOMIS = 'P';
		  V_BANDERA := 0;
	EXCEPTION
			 WHEN NO_DATA_FOUND THEN
			 	  V_BANDERA := 1;
	END;
  IF V_BANDERA= 0 THEN
      Select to_date(to_char(add_months(last_day(Fec_Desde_Normal),1),    'dd/mm/yyyy'),'dd/mm/yyyy') -1,
	         to_date(to_char(add_months(last_day(Fec_Desde_Prepago),1),   'dd/mm/yyyy'),'dd/mm/yyyy') ,
			 to_date(to_char(add_months(last_day(Fec_Desde_Aceptacion),1),'dd/mm/yyyy'),'dd/mm/yyyy') ,
			 to_date(to_char(add_months(last_day(Fec_Desde_Recepcion),1), 'dd/mm/yyyy'),'dd/mm/yyyy')
	  INTO
	         Fec_Hasta_Normal    ,
			 Fec_Hasta_Prepago   ,
             Fec_Hasta_Aceptacion,
             Fec_Hasta_Recepcion
      From Dual;
   ELSE
   /* obtener el primer dia del ciclo y dejarlo en Fec_Desde  */
      Select to_date(iCodCiclComis,'YYYYMMDD') into Fec_Desde_Todos from Dual;
	  Fec_Desde_Normal     := Fec_Desde_Todos;
      Fec_Desde_Prepago    := Fec_Desde_Todos;
      Fec_Desde_Aceptacion := Fec_Desde_Todos;
      Fec_Desde_Recepcion  := Fec_Desde_Todos;

   /* obtener el ultimo dia del ciclo y dejarlo en Fec_Hasta  */
      Select ADD_MONTHS(Fec_Desde_Todos, 1) INTO Fec_Hasta_Otros  From Dual;
      Fec_Hasta_Prepago      := Fec_Hasta_Otros;
      Fec_Hasta_Aceptacion   := Fec_Hasta_Otros;
	  Fec_Hasta_Recepcion    := Fec_hasta_Otros;
	  Fec_Hasta_Normal       := Fec_hasta_Otros;
   END IF;

   INSERT INTO CM_CICLCOMIS_TD
         (
           Id_Ciclcomis
          ,Cod_Ciclcomis
          ,Tip_Periodo
          ,Num_Secuencia
          ,Cod_Ciclo
		  ,TIP_CICLCOMIS
		  ,DES_CICLCOMIS
          ,FEC_DESDE_NORMAL
          ,FEC_HASTA_NORMAL
          ,FEC_DESDE_PREPAGO
          ,FEC_HASTA_PREPAGO
          ,FEC_HASTA_ACEPTACION
          ,FEC_HASTA_RECEPCION
          ,FEC_DESDE_ACEPTACION
          ,FEC_DESDE_RECEPCION
          ,COD_ESTADO
          ,FEC_ULTMOD
          ,NOM_USUARIO)
    VALUES (
           iCodCiclComis||'M1'
          ,iCodCiclComis
          ,'M'
          ,1
          ,to_number(substr(to_char(iCodCiclComis),7,2))
          ,'P'
		  ,NULL
		  ,Fec_Desde_Normal
          ,Fec_Hasta_Normal
          ,Fec_Desde_Prepago
          ,Fec_Hasta_Prepago
          ,Fec_Hasta_Aceptacion
          ,Fec_Hasta_Recepcion
          ,Fec_Desde_Aceptacion
          ,Fec_Desde_Recepcion
          ,'INI'
          ,sysdate
          ,user);

EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
             RAISE_APPLICATION_ERROR (-20101, 'ERROR Ciclo de Comisiones ya Existe.');
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR (-20101, 'ERROR Ciclo de Comisiones no pudo ser creado.');
END CreaCiclComis;
/* *************************************************************************** */
/* FUNCTION GetCiclComisFecha                                                  */
/* -------------------------------------                                       */
/* Para una fecha, determina el ciclo que le corresponde.                      */
/* Se le incorpora un segundo parametro para desfasar la consulta en meses.    */
/* parametro sFecha     -> Corresponde a la fecha a consultar (YYYYMMDD).      */
/*           iMeses = 0 -> corresponde al mes actual                           */
/*           iMeses > 0 -> n-meses para adelante.                              */
/*           iMeses < 0 -> n-meses para atras.                                 */
/* *************************************************************************** */
FUNCTION GetCiclComisFecha (sFecha IN VARCHAR2, iMeses IN NUMBER , Cod_Ciclo IN NUMBER )
        RETURN NUMBER IS

		Cod_CiclComis  Number(10);
        CodCiclComis   Number(10);
        Ciclo          varchar(2);
        Fecha_Recivida Date;

BEGIN
      If ( sFecha = '' or sFecha IS NULL ) THEN
                RAISE ERROR_PROCESO;
        End If;
        Fecha_Recivida := to_date(sFecha,'yyyymmdd');
        If ( Cod_Ciclo <= 0 and Cod_Ciclo >= 32 ) THEN
                RAISE ERROR_PROCESO;
        End If;
        if ( Cod_Ciclo > 0 and Cod_Ciclo < 10 ) then
             Ciclo := '0'||to_char(Cod_Ciclo);
           else
             Ciclo := to_char(Cod_Ciclo);
        End If;
        Cod_CiclComis := to_number(to_char(Fecha_Recivida,'yyyy')||to_char(Fecha_Recivida,'mm')||Ciclo);
        If ( Fecha_Recivida > to_date(Cod_CiclComis,'yyyymmdd') ) Then
             CodCiclComis := Cod_CiclComis;
        Else
             CodCiclcomis := to_number(to_char(add_months(to_date(Cod_Ciclcomis,'yyyymmdd'),-1),'yyyymmdd'));
        End If;
        If iMeses = 0 Then
             CodCiclComis := to_number(to_char(Fecha_Recivida,'yyyy')||to_char(Fecha_Recivida,'mm')||Ciclo);
        Else
             CodCiclcomis := to_number(to_char(add_months(to_date(Cod_Ciclcomis,'yyyymmdd'),iMeses),'yyyymmdd'));
        End If;

        RETURN CodCiclComis;

EXCEPTION
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR (-20101, 'Ciclo de Comisiones no pudo ser obtenido');
END GetCiclComisFecha;
/* *************************************************************************** */
/* FUNCTION GetEstadoCiclComis.                                                */
/* Dado un ciclo de comisiones, devuelve el estado del mismo. Si no existe  ,  */
/* gatilla una exception.                                                      */
/* *************************************************************************** */
FUNCTION GetEstadoCiclComis (iCodCiclComis IN NUMBER)
         RETURN VARCHAR2 IS
BEGIN
        IF iCodCiclComis = 0 or iCodCiclComis IS NULL THEN
                RAISE ERROR_PROCESO;
        END IF;
        SELECT COD_ESTADO  INTO  sCODESTADO
        FROM CM_CICLCOMIS_TD
        WHERE COD_CICLCOMIS     = iCodCiclComis
          AND ((TIP_PERIODO   = 'M' AND
	  			NUM_SECUENCIA = 1   AND
	  			TIP_CICLCOMIS ='P')
		  OR  (TIP_CICLCOMIS = 'E'));
        RETURN sCODESTADO ;
EXCEPTION
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR (-20101, 'Error, Ciclo de Comisiones No Existe.');
END GetEstadoCiclComis;
/* *************************************************************************** */
/* FUNCTION ExisteCiclComis                                                    */
/* Funcion que valida la existencia de un ciclo  normal, dado un ciclo.        */
/* Retorno : 1: El ciclo existe.                                               */
/*           0: El ciclo no existe.                                            */
/* *************************************************************************** */
FUNCTION ExisteCiclComis(iCodCiclComis IN NUMBER)
         RETURN NUMBER IS
BEGIN
        SELECT COD_ESTADO INTO sCODESTADO
        FROM CM_CICLCOMIS_TD
        WHERE COD_CICLCOMIS = iCodCiclComis
          AND ((TIP_PERIODO   = 'M' AND
	  			NUM_SECUENCIA = 1   AND
	  			TIP_CICLCOMIS = 'P')
		  OR  (TIP_CICLCOMIS = 'E'));
        RETURN 1;
EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
END ExisteCiclComis;
/* ****************************************************************************** */
/* FUNCTION ValidaCicloComis                                                      */
/* Funcion que valida la existencia de fechas hasta superiores al dia de proceso  */
/* Retorno : 1: fachas hasta superiores al dia de proceso.                        */
/*           0: existe una fecha hasta inferior al dia de proceso                 */
/* ****************************************************************************** */
FUNCTION ValidaCiclComis(iCodCiclComis IN NUMBER, szTipCiclComis IN CHAR)
         RETURN NUMBER IS
BEGIN
        SELECT COD_ESTADO INTO sCODESTADO
        FROM CM_CICLCOMIS_TD
        WHERE COD_CICLCOMIS = iCodCiclComis
		  AND TIP_PERIODO   = 'M'
		  AND TIP_CICLCOMIS = szTipCiclComis
          AND FEC_HASTA_NORMAL     < SYSDATE
          AND FEC_HASTA_PREPAGO    < SYSDATE
          AND FEC_HASTA_ACEPTACION < SYSDATE
          AND FEC_HASTA_RECEPCION  < SYSDATE;
        RETURN 1;
EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
END ValidaCiclComis;
/* ****************************************************************************** */
/* FUNCTION iGetIndOficinaPropia                                                  */
/* Funcion que retorna el indicador de oficina propia de un vendedor.             */
/* Retorno : 1: distribuidor opera en oficina de propiedad de la operadora.       */
/*           0: distribuidor opera en oficina propia.                             */
/* Navega a traves de la red de ventas, y hereda la definicion de los niveles     */
/* supoeriores. Esto es, evalua el nivel del vendedor, y luego los niveles superi.*/
/* ****************************************************************************** */
FUNCTION iGetIndOficinaPropia(plCodVendedor IN NUMBER,piTipoRed IN NUMBER)
RETURN NUMBER IS
	lCodVendedor	NUMBER(6);
	lCodVendePadre	NUMBER(6);
	iNumNivel		NUMBER(2);
	iIndOficina		NUMBER(1);
BEGIN
	lCodVendedor := plCodVendedor;
	LOOP
		BEGIN
			SELECT 	A.COD_VENDEDOR,
					A.COD_VENDE_PADRE,
					B.IND_OFICINA_PROPIA,
					A.NUM_NIVEL
			INTO 	lCodVendedor,
					lCodVendePadre,
					iIndOficina,
					iNumNivel
			FROM VE_REDVENTAS_TD A,VE_VENDEDORES B
			WHERE A.COD_TIPORED = piTipoRed
			AND A.COD_VENDEDOR = lCodVendedor
			AND A.COD_VENDEDOR = B.COD_VENDEDOR;
		EXCEPTION
			WHEN OTHERS THEN
         		iIndOficina := 0;
         		iNumNivel   := 1;
		END;

		IF iIndOficina = 1 THEN
			RETURN iIndOficina;
		END IF;

		IF  iNumNivel = 1 THEN
			RETURN iIndOficina;
		END IF;

		lCodVendedor := lCodVendePadre;
	END LOOP;
EXCEPTION
	WHEN OTHERS THEN
   		RAISE_APPLICATION_ERROR (-20102, 'Error Recuperando datos desde Red de Ventas.');
END iGetIndOficinaPropia;

/* ****************************************************************************** */
/* FUNCTION iGetIndOficinaPropia                                                  */
/* Funcion que retorna el  padre de plCodVendedor, en el tipo de red piTipoRed,   */
/* y que ademas, este padre, posee categoria de ventas psTipComis.                */
/* Retorno : El codigo del vendedor padre.                                        */
/*           -1 en caso de Error. No se encontraros datos.                        */
/* Funcion que navega a traves de la red de ventas.                               */
/* ****************************************************************************** */
FUNCTION iGetVendTipComis(plCodVendedor IN NUMBER,piTipoRed IN NUMBER, psTipComis IN VARCHAR2)
RETURN NUMBER IS
	lCodVendedor	NUMBER(6);
	lCodVendePadre	NUMBER(6);
	iNumNivel		NUMBER(2);
	sCodTipComis	VARCHAR2(2);
BEGIN
	lCodVendedor := plCodVendedor;
	LOOP
		sCodTipComis := '';
		BEGIN
			SELECT 	A.COD_VENDEDOR,
					A.COD_VENDE_PADRE,
					B.COD_TIPCOMIS,
					A.NUM_NIVEL
			INTO 	lCodVendedor,
					lCodVendePadre,
					sCodTipComis,
					iNumNivel
			FROM VE_REDVENTAS_TD A, VE_VENDEDORES B
			WHERE A.COD_TIPORED = piTipoRed
			AND A.COD_VENDEDOR = lCodVendedor
			AND A.COD_VENDE_PADRE = B.COD_VENDEDOR;
		EXCEPTION
			WHEN OTHERS THEN
         		iNumNivel   := 1;
		END;

		IF sCodTipComis = psTipComis THEN
			RETURN lCodVendePadre;
		ELSE
			if iNumNivel = 1 THEN
				RETURN 0;
			ELSE
				lCodVendedor := lCodVendePadre;
			END IF;
		END IF;
	END LOOP;
EXCEPTION
	WHEN OTHERS THEN
   		RAISE_APPLICATION_ERROR (-20103, 'Error Recuperando datos desde Red de Ventas.');
END iGetVendTipComis;
/* ****************************************************************************** */
FUNCTION iEsVendePadre(pTipoRed IN NUMBER, pCodVendePadre IN NUMBER, pCodVendedor IN NUMBER)
RETURN NUMBER IS
	lCodVendedor	NUMBER(6);
	lCodVendePadre	NUMBER(6);
	iNumNivel		NUMBER(2);
BEGIN
	lCodVendedor := pCodVendedor;
	LOOP
		BEGIN
			SELECT 	COD_VENDE_PADRE,
					NUM_NIVEL
			INTO	lCodVendePadre,
					iNumNivel
			FROM 	VE_REDVENTAS_TD
			WHERE 	COD_TIPORED  = pTipoRed
			AND 	COD_VENDEDOR = lCodVendedor;
		EXCEPTION
			WHEN OTHERS THEN
				iNumNivel := 1;
		END;

		IF lCodVendePadre = pCodVendePadre THEN
			RETURN 1;
		ELSE
			IF iNumNivel = 1 THEN
				RETURN 0;
			ELSE
				lCodVendedor := lCodVendePadre;
			END IF;
		END IF;
	END LOOP;
EXCEPTION
	WHEN OTHERS THEN
   		RAISE_APPLICATION_ERROR (-20103, 'Error Recuperando datos desde Red de Ventas.');
END iEsVendePadre;
/* ****************************************************************************** */
END CM_VALIDA_CICLCOMIS_PG;
/
SHOW ERRORS
