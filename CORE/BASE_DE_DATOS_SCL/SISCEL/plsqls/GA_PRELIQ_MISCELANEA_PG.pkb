CREATE OR REPLACE PACKAGE BODY        GA_PRELIQ_MISCELANEA_PG IS

  /*
  <Documentación TipoDoc = "GA_PRELIQ_MISCELANEA_PG
  <Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="16-06-2005" Versión="1.0.0" Diseñador="Lidia Ponce" Programador="Roberto Pérez" Ambiente="BD">
  <Retorno>NA</Retorno>
  <Descripción> Body de GA_PRELIQ_MISCELANEA_PG /Descripción>
  <Parámetros>
  <Entrada>
  <param nom="" Tipo="STRING">Descripción Parametro1</param>
  </Entrada>
  <Salida>
  <param nom="" Tipo="STRING">Descripción Parametro4</param>
  </Salida>
  </Parámetros>
  </Elemento>
  </Documentación>
  */

--Incidencia RA-200601030480 [PAAA 06-01-2006] versión 1.1


FUNCTION GA_RETORNA_VERSION_FN RETURN VARCHAR2
IS
  p_version    CONSTANT VARCHAR2(3) := '001';
  p_subversion CONSTANT VARCHAR2(3) := '000';
BEGIN
   RETURN('Version : '||p_version||' <--> SubVersion : '||p_subversion);
END;


PROCEDURE GA_PRELIQ_MISCELANEA_PR(SN_coderror OUT NOCOPY NUMBER,
      	               SV_error    OUT NOCOPY VARCHAR2) IS

  /*
  <Documentación TipoDoc = "VGA_PRELIQ_MISCELANEA_PR
  <Elemento Nombre = "PROCEDURE" Lenguaje="PL/SQL" Fecha="16-06-2005" Versión="1.0.0" Diseñador="Lidia Ponce" Programador="Roberto Pérez" Ambiente="BD">
  <Retorno>PLS_INTEGER</Retorno>
  <Descripción> Determina si un cliente existe en la tabla de clientes ventaos o lista negra /Descripción>
  <Parámetros>
  <Entrada>
  <param nom="EV_NUMIDENT" Tipo="STRING">Numero de identidad del cliente a verificar</param>
  <param nom="EV_TIPIDENT" Tipo="STRING">Tipo identidad del cliente a verificar</param>
  </Entrada>
  <Salida>
  <param nom="SN_coderror Tipo="STRING">codigo de error parametrico</param>
  <param nom="SV_ERROR" Tipo="STRING">Descripcion de un error si es que se produce</param>
  </Salida>
  </Parámetros>
  </Elemento>
  </Documentación>
  */

	  v_DatosC          vCursor;
	  v_Dealer          vCursor;

	  LV_obj              VARCHAR2(50):='GA_PRELIQ_MISCELANEA_PG.GA_PRELIQ_MISCELANEA_PR';
	  LV_tabla            VARCHAR2(50);
	  LV_act              VARCHAR2(50);

	  LN_cod_cliente       ga_preliquidacion.cod_cliente%TYPE;
	  LN_num_abonado       ga_det_preliq.num_abonado%TYPE;  -- Validar.
	  LN_cod_master_dealer  	   ga_preliquidacion.cod_master_dealer%TYPE;  --RA-0631
	  LN_cod_concepto      NUMBER;
	  LN_num_proceso       NUMBER;
	  LN_cod_producto      NUMBER;
	  LD_fec_vencimiento   DATE;
	  LV_cod_moneda	       fa_datosgener.cod_monefact%TYPE;
	  LN_cod_miscela       fa_datosgener.cod_miscela%TYPE;
	  LV_cod_oficina	   ge_seg_usuario.cod_oficina%TYPE;
	  LV_user			   ge_seg_usuario.nom_usuario%TYPE;
	  LV_cod_region		   ge_oficinas.cod_region%TYPE;
	  LV_cod_provincia	   ge_oficinas.cod_provincia%TYPE;
	  LV_cod_ciudad		   ge_direcciones.cod_ciudad%TYPE;
	  LV_cod_comuna  	   ge_oficinas.cod_comuna%TYPE;
	  LV_cod_modulo        ge_modulos.cod_modulo%TYPE;
	  LN_cod_centremi	   al_docum_sucursal.cod_centremi%TYPE;
	  LN_cod_catimpos	   fa_prefactura.cod_catimpos%TYPE;
	  LV_letra			   ge_letras.letra%TYPE;
	  LC_cod_catribut 	   ga_catributclie.cod_catribut%TYPE;
	  LV_cod_modgener	   fa_gencentremi.cod_modgener%TYPE;
	  LN_num_venta         fa_interfact.num_venta%TYPE;
	  LN_cod_estadoc	   fa_interfact.cod_estadoc%TYPE;
	  LN_cod_estproc	   fa_interfact.cod_estproc%TYPE;
	  LN_cod_tipmovimien   fa_interfact.cod_tipmovimien%TYPE;
	  LV_pref_plaza   	   fa_interfact.pref_plaza%TYPE;
	  LV_pref_plazarel     fa_interfact.pref_plazarel%TYPE;
	  LN_cod_tipdocum      fa_tipmovimien.cod_tipdocum%TYPE;
	  LV_tip_foliacion     fa_tipmovimien.tip_foliacion%TYPE;
	  LN_dias_vencimiento  NUMBER;
  	  LB_Estado			   BOOLEAN;

BEGIN
	 SN_coderror    :=0;
     SV_error		:='';

	 LV_user 		:= USER;
	 LV_cod_modulo 	:= 'GA';
	 LN_cod_producto:=1;
	 LV_tabla := 'ge_seg_usuario, ge_oficinas, ve_vendedores';
	 LV_act	  := 'Consultar';

	 --Incidencia RA-200601030480 [PAAA 06-01-2006]
	 LB_Estado	:= GA_ACTUALIZA_TRAZA_FN(CN_cod_proceso,CN_estado_ini,SN_coderror,SV_error);
	 --Fin RA-200601030480

   	 SELECT  a.cod_oficina
     INTO    LV_cod_oficina
     FROM    ge_seg_usuario a, ge_oficinas b, ve_vendedores c
     WHERE   nom_usuario 	= LV_user
     AND     a.cod_oficina  = b.cod_oficina
     AND     a.cod_vendedor = c.cod_vendedor(+);


	 LV_tabla := 'ge_oficinas, ge_direcciones';
	 LV_act	  := 'Consultar';

     SELECT   a.cod_region
  	   		 ,a.cod_provincia
			 ,b.cod_ciudad
			 ,a.cod_comuna
      INTO    LV_cod_region
		     ,LV_cod_provincia
			 ,LV_cod_ciudad
			 ,LV_cod_comuna
      FROM    ge_oficinas a, ge_direcciones b
      WHERE   a.cod_oficina   = LV_cod_oficina
      AND     a.cod_direccion = b.cod_direccion;





	 LV_tabla := 'fa_datosgener';
	 LV_act	  := 'Consultar';

	 SELECT  a.cod_monefact
	 		,a.cod_miscela
	 INTO    LV_cod_moneda
	        ,LN_cod_miscela
	 FROM 	 fa_datosgener a;


	 LV_tabla := 'al_docum_sucursal';
	 LV_act	  := 'Consultar';

  	 SELECT cod_centremi
	 INTO   LN_cod_centremi
     FROM   al_docum_sucursal
     WHERE  cod_oficina  = LV_cod_oficina
     AND    cod_tipdocum = LN_cod_miscela;

	 LV_tabla := 'ged:parametros';
	 LV_act	  := 'Consultar';

  	 SELECT TO_NUMBER(val_parametro)
	 INTO   LN_dias_vencimiento
     FROM   ged_parametros
     WHERE  nom_parametro = 'DIAS_VENC_MIS'
     AND    cod_modulo    =  LV_cod_modulo
	 AND    cod_producto  =  LN_cod_producto;

	 LV_tabla := 'ga_preliquidacion, ve_vendedores';
	 LV_act	  := 'Consultar';

	 OPEN v_Dealer FOR
	 SELECT UNIQUE a.cod_master_dealer, b.cod_cliente  --RA-0631
	 FROM 	ga_preliquidacion a, ve_vendedores b
	 WHERE  a.env_facturacion = 'N'
	 AND    b.cod_vendedor = a.cod_master_dealer;  --RA-0631




	 LOOP FETCH v_Dealer INTO LN_cod_master_dealer,LN_cod_cliente; --RA-0631
	 	  EXIT WHEN v_Dealer%NOTFOUND;

			  LV_tabla := 'ga_preliquidacion, ga_det_preliq';
			  LV_act   := 'Consultar';

	 		 --Inicio Incidencia RA-402, se agregan Un campo y se dejan uno en comentario.
			  OPEN v_DatosC FOR
			  SELECT   a.cod_cliente
			  		  ,b.num_abonado
					  ,(SELECT c.cod_conceptoart FROM al_articulos c WHERE c.cod_articulo = b.cod_articulo) cod_concepto
					  ,b.num_serie_orig
					  ,b.imp_cargo
					  ,b.imp_cargo_final
					  ,b.num_venta
			  FROM   ga_preliquidacion a, ga_det_preliq b
			  WHERE  a.num_venta 	   = b.num_venta
			  AND    a.cod_master_dealer  = LN_cod_master_dealer --RA-0631
			  AND	 a.env_facturacion = 'N';


			  SELECT fa_seq_numpro.NEXTVAL INTO LN_num_proceso FROM dual;
			  --RA-0631
			  IF FA_VENTA_MISCELANEA_PG.FA_PREFACTURA_PR (v_DatosC,LN_cod_master_dealer,LN_num_proceso,LN_cod_producto,LV_cod_moneda
			  							   ,LV_cod_region,LV_cod_provincia,LV_cod_ciudad,LV_cod_comuna,LV_cod_modulo
										   ,SN_coderror,SV_error) = 0 THEN

			     LV_tabla := 'ga_preliquidacion';
			  	 LV_act   := 'Actualizar';

				 UPDATE ga_preliquidacion
				 SET 	env_facturacion = 'S'
				 WHERE  cod_master_dealer = LN_cod_master_dealer; --RA-0631

 			      LV_tabla := 'ge_catimpclientes';
			  	  LV_act   := 'Consultar';

			      SELECT a.cod_catimpos
			      INTO   LN_cod_catimpos
			      FROM   ge_catimpclientes a
			      WHERE  a.cod_cliente = LN_cod_cliente
			      AND    SYSDATE  >= a.FEC_DESDE
				  AND    SYSDATE  <= a.FEC_HASTA;

			      LV_tabla := 'ge_letras';
			  	  LV_act   := 'Consultar';


				  SELECT letra
			      INTO   LV_letra
			      FROM   ge_letras
			      WHERE  cod_tipdocum = LN_cod_miscela
			      AND    cod_catimpos = LN_cod_catimpos;

				  --RA-0631
 				  FA_VENTA_MISCELANEA_PG.FA_PROCESOS_PR (LN_num_proceso,LN_cod_master_dealer,LN_cod_miscela,LN_cod_centremi,LV_letra,SN_coderror,SV_error);

					LN_num_venta       :=   0;
					LN_cod_estadoc     := 100;
					LN_cod_estproc     :=   3;
					LN_cod_tipmovimien :=  18;-- Averiguar--.
					LD_fec_vencimiento := TRUNC(SYSDATE) + LN_dias_vencimiento;
					LV_pref_plaza	   := ' '; -- Averiguar--.
					LV_pref_plazarel   := ' '; -- Averiguar--.

			        LV_tabla := 'ga_catributclie';
			  	    LV_act   := 'Consultar';

					SELECT cod_catribut
			        INTO   LC_cod_catribut
			        FROM   ga_catributclie
			        WHERE  cod_cliente = LN_cod_cliente
			        AND    fec_desde <= SYSDATE
			        AND    fec_hasta >= SYSDATE;

			        LV_tabla := 'fa_tipmovimien';
			  	    LV_act   := 'Consultar';

					SELECT cod_tipdocum, tip_foliacion
		            INTO   LN_cod_tipdocum,LV_tip_foliacion
		            FROM   fa_tipmovimien
		            WHERE  cod_tipmovimien  = LN_cod_tipmovimien
		            AND    cod_catribut	    = LC_cod_catribut
		            AND    cod_modventa	    = 1
		            AND    cod_tipimpositiva = LN_cod_catimpos;

			        LV_tabla := 'fa_gencentremi';
			  	    LV_act   := 'Consultar';


					SELECT cod_modgener
			        INTO   LV_cod_modgener
			        FROM   fa_gencentremi
			        WHERE  cod_centremi    = LN_cod_centremi
			        AND    cod_tipmovimien = LN_cod_miscela
			        AND    cod_catribut    = LC_cod_catribut
			        AND    cod_modventa    = 1;

					FA_VENTA_MISCELANEA_PG.FA_INTERFACT_PR (LN_num_proceso,LN_num_venta,LV_cod_modgener,LN_cod_estadoc,LN_cod_estproc,LN_cod_tipmovimien,LC_cod_catribut,LN_cod_tipdocum,
					                 				LD_fec_vencimiento,LV_pref_plaza,LV_pref_plazarel,LV_tip_foliacion,SN_coderror,SV_error);

			  END IF;
	 END LOOP;
	 CLOSE v_Dealer;

	 LB_Estado	:= GA_ACTUALIZA_TRAZA_FN(CN_cod_proceso,CN_estado_ini,SN_coderror,SV_error);

     EXCEPTION
	 WHEN NO_DATA_FOUND THEN
		 SN_coderror    :=-1;
	     SV_error		:='No existen datos en tabla(s) '||LV_tabla;
		 ROLLBACK;
		 LB_Estado	:= GA_ACTUALIZA_TRAZA_FN(CN_cod_proceso,CN_estado_nok,SN_coderror,SV_error);
     WHEN OTHERS THEN
		 SN_coderror    :=SQLCODE;
	     SV_error		:='Error al '|| LV_act ||' '|| LV_tabla ||':'|| SQLERRM;
		 ROLLBACK;
		 LB_Estado	:= GA_ACTUALIZA_TRAZA_FN(CN_cod_proceso,CN_estado_nok,SN_coderror,SV_error);
END GA_PRELIQ_MISCELANEA_PR;

FUNCTION GA_ACTUALIZA_TRAZA_FN(EN_cod_proceso  IN fa_trazaproc.cod_proceso%TYPE
   							  ,EN_cod_estaproc IN fa_trazaproc.cod_estaproc%TYPE
   							  ,SN_coderror 	   OUT NOCOPY NUMBER
		                      ,SV_error 	   OUT NOCOPY VARCHAR2) RETURN BOOLEAN
AS
	  LV_obj              VARCHAR2(50):='GA_PRELIQ_MISCELANEA_PG.GA_ACTUALIZA_TRAZA_FN';
	  LV_tabla            VARCHAR2(50);
	  LV_act              VARCHAR2(50);

BEGIN

	 LV_tabla := 'fa_trazaproc';
	 LV_act	  := 'Actualizar';


	 UPDATE fa_trazaproc SET
	 		cod_estaproc = EN_cod_estaproc
	 WHERE  cod_proceso  = EN_cod_proceso;


	 UPDATE fa_intqueueproc SET
	 		cod_estado = EN_cod_estaproc
	 WHERE  cod_proceso  = EN_cod_proceso AND cod_modgener='DAF';



	 RETURN TRUE;

	 EXCEPTION
	 WHEN OTHERS THEN
		 SN_coderror    :=SQLCODE;
	     SV_error		:='Error al '|| LV_act ||' '|| LV_tabla ||':'|| SQLERRM;
	 	 RETURN FALSE;
		 ROLLBACK;
END	 GA_ACTUALIZA_TRAZA_FN;

END GA_PRELIQ_MISCELANEA_PG;
/
SHOW ERRORS
