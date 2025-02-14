CREATE OR REPLACE FUNCTION CO_NRO_INSTANCIAS_FN(d_Fecha IN DATE, sProceso IN VARCHAR2) RETURN NUMBER
IS
-- *************************************************************
-- * Funcion	       :  CO_NRO_INSTANCIAS_FN
-- * Entrada           :  Fecha inicial del rango a evaluar: fecha final es sysd
-- *                      Codigo de Proceso
-- * Salida            :  Nro. de Instancias propuestas
-- * Descripcion       :  Devuelve Nro. de instancias propuesto para los proceso
-- * Fecha de creacion :  31-12-2003
-- * Responsable       :  CESAR PALMA.
-- *************************************************************
nDesc              NUMBER;
nNro               NUMBER;
nPorcentaje        NUMBER;
nPromedio_Proc     NUMBER;
nPromedio_Ccpu     NUMBER;
n_NumProceso       NUMBER;
n_NumMax  CONSTANT NUMBER:=15;
i 		  		   NUMBER;
BEGIN

	BEGIN
		SELECT  TRUNC(AVG(cnt_procesos_ejecutados)),TRUNC(AVG(carga_cpu))
		  INTO nPromedio_Proc, nPromedio_Ccpu
		  FROM co_parametros_unix_to
		 WHERE cod_proceso = sProceso
		   AND fec_ingreso BETWEEN d_Fecha AND SYSDATE
		GROUP BY 1;

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				nNro:= -1;
				RETURN nNro;
			WHEN OTHERS THEN
				nNro:= -1;
				RETURN nNro;
	END;

	n_NumProceso := TRUNC(n_NumMax - nPromedio_Proc);

	BEGIN
		SELECT PORC_DESC
		  INTO nDesc
		  FROM co_matriz_instancias_td
		 WHERE nPromedio_Ccpu BETWEEN val_min AND val_max;

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				nNro:= -2;
				RETURN nNro;
	END;

	nPorcentaje :=(n_NumProceso * nDesc)/100;
	nNro :=	TRUNC(n_NumProceso - nPorcentaje);

	RETURN nNro;
END CO_NRO_INSTANCIAS_FN;
/
SHOW ERRORS
