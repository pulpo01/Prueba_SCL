CREATE OR REPLACE PACKAGE BODY Al_Reporte_Consignacion_Pg IS
/*

*/
PROCEDURE AL_OBTIENEPARAMETROS_PR (TV_CantMaxima        OUT  NOCOPY ged_parametros.val_parametro%TYPE,
			 					   TV_CantDiasAviso     OUT  NOCOPY ged_parametros.val_parametro%TYPE,
								   TV_StockConsig       OUT  NOCOPY ged_parametros.val_parametro%TYPE,
								   TV_TipBodDealer      OUT  ged_parametros.val_parametro%TYPE) IS
-- *********************************************************************************************************************
-- <Documentación TipoDoc = "Procedimiento">
-- <Elemento Nombre = " AL_OBTIENEPARAMETROS_PR" Lenguaje="PL/SQL" Fecha="17-05-2005" Versión="1.0" Diseñador="****" Programador="******" Ambiente="BD">
-- <Retorno>String</Retorno>
-- <Descripción>Procedimiento que retorna los parametros a utilizar para formar query de series en consignación</Descripción>
-- <Parámetros>
-- <Entrada>
-- </Entrada>
-- <Salida>
-- <param nom="TV_CantMaxima     Tipo="ged_parametros.val_parametro%TYPE">Dias maximos de consignacion</param>
-- <param nom="TV_CantDiasAviso  Tipo="ged_parametros.val_parametro%TYPE">Dias de aviso antes del vencimiento</param>
-- <param nom="TV_StockConsig    Tipo="ged_parametros.val_parametro%TYPE">Tipo de stock consignación</param>
-- </Salida>
-- </Parámetros>
-- </Elemento>
-- </Documentación>
-- **********************************************************************************************************************

 	  CI_uno      		  CONSTANT PLS_INTEGER:= 1;
	  CV_modulo           CONSTANT VARCHAR2(2):= 'AL';
	  CV_ParamDiasMax     CONSTANT VARCHAR2(20):= 'DIAS_MAXIMO_CONSIG';
	  CV_ParamDiasAviso   CONSTANT VARCHAR2(20):= 'DIAS_AVISO_VENCIM';
	  CV_ParamStockConsig CONSTANT VARCHAR2(20):= 'STOCK_CONSIGNACION';
	  CV_ParamBodDealer   CONSTANT VARCHAR2(20):= 'TIP_BODEGA_DEALER';

      LV_query            VARCHAR2(10000);
	  LV_mensaje          VARCHAR2(10000);


   BEGIN


	LV_mensaje := 'RECUPERANDO PARAMETRO DE DIAS DE PERMANENCIA EN CONSIGNACION PARA REPORTE CONSIGNACIÓN';

	SELECT TO_NUMBER(a.val_parametro)
	INTO   TV_CantMaxima
	FROM   ged_parametros a
	WHERE  a.cod_modulo = CV_modulo
	AND    cod_producto  = CI_uno
	AND    nom_parametro = CV_ParamDiasMax;


	LV_mensaje := 'RECUPERANDO PARAMETRO DE DIAS DE AVISO PARA REPORTE CONSIGNACIÓN';

	SELECT TO_NUMBER(a.val_parametro)
	INTO   TV_CantDiasAviso
	FROM   ged_parametros a
	WHERE  a.cod_modulo = CV_modulo
	AND    cod_producto  = CI_uno
	AND    nom_parametro = CV_ParamDiasAviso;

	LV_mensaje := 'RECUPERANDO PARAMETRO DE STOCK CONSIGNACIÓN';

	SELECT TO_NUMBER(a.val_parametro)
	INTO   TV_StockConsig
	FROM   ged_parametros a
	WHERE  a.cod_modulo = CV_modulo
	AND    cod_producto  = CI_uno
	AND    nom_parametro = CV_ParamStockConsig;

	LV_mensaje := 'RECUPERANDO PARAMETRO DE TIPO BODEGA DEALER';

	SELECT TO_NUMBER(a.val_parametro)
	INTO   TV_TipBodDealer
	FROM   ged_parametros a
	WHERE  a.cod_modulo = CV_modulo
	AND    cod_producto  = CI_uno
	AND    nom_parametro = CV_ParamBodDealer;

   EXCEPTION
      WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20121,SQLCODE ||' ERROR '|| LV_mensaje );


   END AL_OBTIENEPARAMETROS_PR ;
   --

  --
  FUNCTION AL_RETORNOQUERY_FN(EI_UsaBind  IN  PLS_INTEGER, EI_OnlyCount IN PLS_INTEGER DEFAULT NULL) RETURN VARCHAR2 IS
-- *********************************************************************************************************************
-- <Documentación TipoDoc = "Funcion">
-- <Elemento Nombre = " AL_RETORNOQUERY_FN" Lenguaje="PL/SQL" Fecha="17-05-2005" Versión="1.0" Diseñador="****" Programador="******" Ambiente="BD">
-- <Retorno>String</Retorno>
-- <Descripción>Función que retorna la query para reporte de control de rotación de equipos</Descripción>
-- <Parámetros>
-- <Entrada>
-- <param nom="EI_UsaBind" Tipo="BOOLEAN">Indicador de tipo de invocación TRUE= Visual Basic, FALSE = Pro*C</param>
-- </Entrada>
-- <Salida>
-- <param nom="LV_QUERY Tipo="VARCHAR2">query de consignación</param>
-- </Salida>
-- </Parámetros>
-- </Elemento>
-- </Documentación>
-- **********************************************************************************************************************
      CV_EstadoTaspaso    CONSTANT VARCHAR2(2):= 'RM';
	  CI_Zero			  CONSTANT PLS_INTEGER:= 0;
	  CI_Uno			  CONSTANT PLS_INTEGER:= 1;
      LV_query            VARCHAR2(10000);
      LV_TOTAL            NUMBER;
      LV_mensaje          VARCHAR2 (200);
	  LV_CantMaxima       ged_parametros.val_parametro%TYPE;
   	  LV_CantDiasAviso    ged_parametros.val_parametro%TYPE;
	  LV_StockConsig      ged_parametros.val_parametro%TYPE;
      LV_TipBodDealer     ged_parametros.val_parametro%TYPE;
	  LN_DifDias	      NUMBER;
   BEGIN

      LV_mensaje := 'RECUPERANDO PARAMETROS PARA REPORTE CONSIGNACIÓN';

	  AL_OBTIENEPARAMETROS_PR(LV_CantMaxima, LV_CantDiasAviso, LV_StockConsig, LV_TipBodDealer );

      LV_mensaje := 'CONFORMANDO QUERY DEFINITIVA';

	  LN_DifDias := TO_NUMBER(LV_CantMaxima) -   TO_NUMBER(LV_CantDiasAviso);

	  IF EI_OnlyCount = CI_Uno THEN
 			  -- Sólo devuelvo cantidad de series que entregará el reporte.
			  	  	 LV_mensaje := 'CONTANDO SERIES';
		 		     SELECT COUNT(1)
					 INTO LV_QUERY
					 FROM  al_series a, al_ser_traspaso b, al_traspasos c , al_bodegas d,
					 	   al_bodegas e,al_usos f, al_estados g, al_tipos_stock h
					 WHERE c.cod_estado = CV_EstadoTaspaso
					 AND   a.tip_stock = LV_StockConsig
					 AND   e.tip_bodega = LV_TipBodDealer
					 AND   b.num_Traspaso = c.num_traspaso
					 AND   a.num_serie = b.num_serie
					 AND   a.cod_bodega = c.cod_bodega_dest
					 AND   d.cod_bodega = c.cod_bodega_ori
					 AND   e.cod_bodega = c.cod_bodega_Dest
					 AND   a.cod_uso = f.cod_uso
					 AND   a.cod_estado = g.cod_estado
					 AND   a.tip_stock = h.tip_stock
					 AND   TO_DATE(c.fec_recepcion + LN_DifDias) <=SYSDATE
					 ORDER BY c.fec_recepcion ASC;
	  ELSE

			  IF EI_UsaBind = CI_Uno  THEN
			  -- Query creada para Visual Basic, se agregan corchetes para usar en función iDBOpenCursorDirec2
			  		    LV_QUERY := 'SELECT a.num_serie, c.cod_bodega_dest bodega_destino, e.des_bodega bodega_destino,';
					 	LV_QUERY :=  LV_QUERY ||'f.des_uso, g.des_estado, h.des_stock,';
					 	LV_QUERY :=  LV_QUERY ||'TO_CHAR(c.fec_recepcion,'''||'yyyy-mm-dd'||'''), TO_CHAR(c.fec_despacho,'''||'yyyy-mm-dd'||'''), c.usu_autoriza, ';
					 	LV_QUERY :=  LV_QUERY ||'c.cod_bodega_ori, d.des_bodega origen ';
					 	LV_QUERY :=  LV_QUERY ||'FROM al_series a, al_ser_traspaso b, al_traspasos c , al_bodegas d, al_bodegas e, ';
					 	LV_QUERY :=  LV_QUERY ||'al_usos f, al_estados g, al_tipos_stock h ';
					 	LV_QUERY :=  LV_QUERY ||'WHERE c.cod_estado = [';
						LV_QUERY :=  LV_QUERY || CV_EstadoTaspaso||'] ';
					 	LV_QUERY :=  LV_QUERY ||'AND a.tip_stock = ['||LV_StockConsig||'] ';
						LV_QUERY :=  LV_QUERY ||'AND   e.tip_bodega = ['|| LV_TipBodDealer ||'] ';
					 	LV_QUERY :=  LV_QUERY ||'AND b.num_Traspaso = c.num_traspaso ';
					 	LV_QUERY :=  LV_QUERY ||'AND a.num_serie = b.num_serie ';
					 	LV_QUERY :=  LV_QUERY ||'AND a.cod_bodega = c.cod_bodega_dest ';
					 	LV_QUERY :=  LV_QUERY ||'AND d.cod_bodega = c.cod_bodega_ori ';
					 	LV_QUERY :=  LV_QUERY ||'AND e.cod_bodega = c.cod_bodega_Dest ';
					 	LV_QUERY :=  LV_QUERY ||'AND a.cod_uso = f.cod_uso ';
					 	LV_QUERY :=  LV_QUERY ||'AND a.cod_estado = g.cod_estado ';
					 	LV_QUERY :=  LV_QUERY ||'AND a.tip_stock = h.tip_stock ';
					 	LV_QUERY :=  LV_QUERY ||'AND to_date(c.fec_recepcion + [';
						LV_QUERY :=  LV_QUERY || LN_DifDias ;
						LV_QUERY :=  LV_QUERY ||'])<= SYSDATE ';
					 	LV_QUERY :=  LV_QUERY ||'ORDER BY c.fec_recepcion ASC ';
		      ELSE

			-- Query Standar para ser ajecutada directamente, (sin corchetes, PRO*C)
			  		    LV_QUERY := 'SELECT /*+ FIRST_ROWS (1000) */ a.num_serie, c.cod_bodega_dest bodega_destino, e.des_bodega bodega_destino,';
					 	LV_QUERY :=  LV_QUERY ||' f.des_uso, g.des_estado, h.des_stock,';
					 	LV_QUERY :=  LV_QUERY ||' TO_CHAR(c.fec_recepcion,'''||'yyyy-mm-dd'||'''), TO_CHAR(c.fec_despacho,'''||'yyyy-mm-dd'||'''), c.usu_autoriza,';
					 	LV_QUERY :=  LV_QUERY ||' c.cod_bodega_ori, d.des_bodega origen';
					 	LV_QUERY :=  LV_QUERY ||' FROM al_series a, al_ser_traspaso b, al_traspasos c , al_bodegas d, al_bodegas e,';
					 	LV_QUERY :=  LV_QUERY ||' al_usos f, al_estados g, al_tipos_stock h';
					 	LV_QUERY :=  LV_QUERY ||' WHERE c.cod_estado = '''||CV_EstadoTaspaso;
					 	LV_QUERY :=  LV_QUERY ||''' AND a.tip_stock = '||LV_StockConsig;
						LV_QUERY :=  LV_QUERY ||' AND   e.tip_bodega = '|| LV_TipBodDealer;
					 	LV_QUERY :=  LV_QUERY ||' AND b.num_Traspaso = c.num_traspaso';
					 	LV_QUERY :=  LV_QUERY ||' AND a.num_serie = b.num_serie';
					 	LV_QUERY :=  LV_QUERY ||' AND a.cod_bodega = c.cod_bodega_dest';
					 	LV_QUERY :=  LV_QUERY ||' AND d.cod_bodega = c.cod_bodega_ori';
					 	LV_QUERY :=  LV_QUERY ||' AND e.cod_bodega = c.cod_bodega_Dest';
					 	LV_QUERY :=  LV_QUERY ||' AND a.cod_uso = f.cod_uso';
					 	LV_QUERY :=  LV_QUERY ||' AND a.cod_estado = g.cod_estado';
					 	LV_QUERY :=  LV_QUERY ||' AND a.tip_stock = h.tip_stock';
					 	LV_QUERY :=  LV_QUERY ||' AND to_date(c.fec_recepcion + '|| LN_DifDias;
						LV_QUERY :=  LV_QUERY ||' )<= SYSDATE ';
					 	LV_QUERY :=  LV_QUERY ||' ORDER BY c.fec_recepcion ASC';
			  END IF;
	  END IF;

      RETURN LV_query;

   EXCEPTION
      WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20120,SQLCODE ||' ERROR '|| LV_mensaje );


   END AL_RETORNOQUERY_FN ;
   --

   --

END;
/
SHOW ERRORS
