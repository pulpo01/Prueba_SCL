CREATE OR REPLACE PACKAGE BODY FA_VENTA_MISCELANEA_PG IS

  /*
  <Documentación TipoDoc = "FA_VENTA_MISCELANEA_PG
  <Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="16-06-2005" Versión="1.0.0" Diseñador="Lidia Ponce" Programador="Roberto Pérez" Ambiente="BD">
  <Retorno>NA</Retorno>
  <Descripción> Body de FA_VENTA_MISCELANEA_PG /Descripción>
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


FUNCTION FA_RETORNA_VERSION_FN RETURN VARCHAR2
IS
  p_version    CONSTANT VARCHAR2(3) := '001';
  /*p_subversion CONSTANT VARCHAR2(3) := '000'; */
  p_subversion CONSTANT VARCHAR2(3) := '001';/*RA-402*/
BEGIN
   RETURN('Version : '||p_version||' <--> SubVersion : '||p_subversion);
END;

FUNCTION FA_PREFACTURA_PR   (EV_cursor   	   IN vCursor
   			 			 	 ,EN_cod_dealer	   IN NUMBER
 						 	 ,EN_num_proceso   IN NUMBER
 					 	 	 ,EN_cod_producto  IN NUMBER
 					 	 	 ,EV_cod_moneda	   IN fa_prefactura.cod_moneda%TYPE
 					 	 	 ,EV_cod_region	   IN ge_oficinas.cod_region%TYPE
 					 	 	 ,EV_cod_provincia IN ge_oficinas.cod_provincia%TYPE
 					 	 	 ,EV_cod_ciudad	   IN ge_direcciones.cod_ciudad%TYPE
 					 	 	 ,EV_cod_comuna    IN ge_oficinas.cod_comuna%TYPE
 					 	 	 ,EV_cod_modulo	   IN fa_prefactura.cod_modulo%TYPE
   			 			 	 ,SN_coderror  	  OUT NOCOPY NUMBER
   			             	 ,SV_error 	   	  OUT NOCOPY VARCHAR2) RETURN NUMBER IS

  /*
  <Documentación TipoDoc = "FA_PREFACTURA_PR
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

    LV_obj              VARCHAR2(50):='FA_VENTA_MISCELANEA_PG.fa_prefactura_pr';
    LV_tabla            VARCHAR2(50);
    LV_act              VARCHAR2(50);


	LN_num_abonado      ga_det_preliq.num_abonado%TYPE;
	LN_num_proceso	    fa_prefactura.num_proceso%TYPE;
	LN_cod_cliente	    fa_prefactura.cod_cliente%TYPE;
	LN_cod_concepto	    fa_prefactura.cod_concepto%TYPE;
	LN_cod_descuento    fa_prefactura.cod_concepto%TYPE; /*RA-402*/
	LN_columna		      fa_prefactura.columna%TYPE;
	LN_cod_producto	    fa_prefactura.cod_producto%TYPE;
	LV_cod_moneda	      fa_prefactura.cod_moneda%TYPE;
	LN_imp_descuento    fa_prefactura.imp_concepto%TYPE;
	LN_imp_concepto		  fa_prefactura.imp_concepto%TYPE;
	LN_imp_facturable	  fa_prefactura.imp_facturable%TYPE;
	LN_imp_montobase	  fa_prefactura.imp_montobase%TYPE;
	LV_cod_region		    fa_prefactura.cod_region%TYPE;
	LV_cod_provincia	  fa_prefactura.cod_provincia%TYPE;
	LV_cod_ciudad		    fa_prefactura.cod_ciudad%TYPE;
	LV_cod_modulo		    fa_prefactura.cod_modulo%TYPE;
	LN_cod_plancom		  fa_prefactura.cod_plancom%TYPE;
	LN_ind_factur		    fa_prefactura.ind_factur%TYPE;
	LN_cod_catimpos		  fa_prefactura.cod_catimpos%TYPE;
	LN_cod_portador		  fa_prefactura.cod_portador%TYPE;
	LN_ind_estado		    fa_prefactura.ind_estado%TYPE;
	LN_cod_tipconce		  fa_prefactura.cod_tipconce%TYPE;
	LN_cod_tipconce_descuento fa_prefactura.cod_tipconce%TYPE;
	LN_num_unidades		  fa_prefactura.num_unidades%TYPE;
	LV_num_seriele		  fa_prefactura.num_seriele%TYPE;
	LN_flag_impues		  fa_prefactura.flag_impues%TYPE;
	LN_flag_dto			    fa_prefactura.flag_dto%TYPE;
	LN_num_cuotas		    fa_prefactura.num_cuotas%TYPE;
	LN_ind_modventa		  fa_prefactura.ind_modventa%TYPE;
	LV_num_seriemec		fa_prefactura.num_seriemec%TYPE;
	LN_num_venta		fa_prefactura.num_venta%TYPE;

BEGIN
	 SN_coderror:=0;


	 v_DatosC := EV_cursor;
	 LN_num_proceso  := EN_num_proceso;
	 LN_cod_producto := EN_cod_producto;
	 LV_cod_moneda	 := EV_cod_moneda;
	 LN_imp_montobase:= 0;

	 LV_cod_region	 :=EV_cod_region;
	 LV_cod_provincia:=EV_cod_provincia;
	 LV_cod_ciudad	 :=EV_cod_ciudad;
	 LV_cod_modulo	 :=EV_cod_modulo;

	 LN_ind_factur	 := 1;
	 LN_columna 	 := 0;
	 LN_cod_portador :=	0;
	 LN_ind_estado	 :=	0;
	 LN_cod_tipconce :=	3;
	 LN_cod_tipconce_descuento := 2; /*RA-402*/
	 LN_num_unidades :=	1;
	 LV_num_seriele	 :=	'0';
	 LN_flag_impues	 :=	0;
	 LN_flag_dto	 :=	0;
	 LN_num_cuotas	 :=	0;
	 LN_ind_modventa :=	0;

     LV_tabla := 'v_DatosC';
     LV_act   := 'Abrir cursor';


	 LOOP FETCH v_DatosC INTO LN_cod_cliente
	                         ,LN_num_abonado
	                         ,LN_cod_concepto
	                         ,LV_num_seriemec
	                         ,LN_imp_concepto
	                         ,LN_imp_descuento /*RA-402*/
	                         ,LN_num_venta;

      EXIT WHEN v_DatosC%NOTFOUND;

		  LN_columna := 	 LN_columna + 1;

     	LV_tabla := 'ga_cliente_pcom';
     	LV_act   := 'Consultar';

		  SELECT a.cod_plancom
	      INTO   LN_cod_plancom
	      FROM   ga_cliente_pcom a
	      WHERE  a.cod_cliente = LN_cod_cliente
	      AND    sysdate >= a.fec_desde
		  AND    sysdate <= nvl(a.fec_hasta,sysdate +1);



     	  LV_tabla := 'ge_catimpclientes';
     	  LV_act   := 'Consultar';

	      SELECT a.cod_catimpos
	      INTO   LN_cod_catimpos
	      FROM   ge_catimpclientes a
	      WHERE  a.cod_cliente = LN_cod_cliente
	      AND    sysdate  >= a.FEC_DESDE
		  AND    sysdate  <= a.FEC_HASTA;

     	  LV_tabla := 'fa_prefactura';
     	  LV_act   := 'Insertar';
		  LV_num_seriele := LV_num_seriemec; /*  RA-200601300671 06.02.2006 */

		  INSERT INTO
		       fa_prefactura (num_proceso
             	 	  				,cod_cliente
             						  ,cod_concepto
          							  ,columna
          							  ,cod_producto
          							  ,cod_moneda
          							  ,fec_valor
          							  ,fec_efectividad
          							  ,imp_concepto
          							  ,imp_facturable
          							  ,imp_montobase
          							  ,cod_region
         							    ,cod_provincia
          							  ,cod_ciudad
          							  ,cod_modulo
          							  ,cod_plancom
          							  ,ind_factur
          							  ,cod_catimpos
          							  ,cod_portador
          			   				,ind_estado
          							  ,cod_tipconce
          							  ,num_unidades
          							  ,num_seriele
          							  ,flag_impues
          							  ,flag_dto
          							  ,num_cuotas
          							  ,ind_modventa
									        ,num_seriemec
									        ,num_venta)
                VALUES  (LN_num_proceso
       						  		,LN_cod_cliente
       								  ,LN_cod_concepto
       								  ,LN_columna
       								  ,LN_cod_producto
       								  ,LV_cod_moneda
       								  ,sysdate
       								  ,sysdate
       								  ,LN_imp_concepto
       								  ,LN_imp_concepto /*RA-402*/
       								  ,LN_imp_montobase
       								  ,LV_cod_region
       								  ,LV_cod_provincia
       								  ,LV_cod_ciudad
       								  ,LV_cod_modulo
       								  ,LN_cod_plancom
       				  				,LN_ind_factur
      								  ,LN_cod_catimpos
     								    ,LN_cod_portador
       								  ,LN_ind_estado
       								  ,LN_cod_tipconce
       								  ,LN_num_unidades
       								  ,LV_num_seriele
       								  ,LN_flag_impues
       								  ,LN_flag_dto
       								  ,LN_num_cuotas
       								  ,LN_ind_modventa
									      ,LV_num_seriemec
									      ,LN_num_venta);

			IF (LN_imp_concepto != LN_imp_descuento) THEN  /*COMIENZO INSERT RA-502*/
			   LN_columna := 	 LN_columna + 1;

         SELECT COD_CONCEPTO
         INTO LN_cod_descuento
         FROM FA_CONCEPTOS
         WHERE COD_CONCORIG = LN_cod_concepto;

         INSERT INTO
		       fa_prefactura (num_proceso
             	 	  				,cod_cliente
             						  ,cod_concepto
          							  ,columna
          							  ,cod_producto
          							  ,cod_moneda
          							  ,fec_valor
          							  ,fec_efectividad
          							  ,imp_concepto
          							  ,imp_facturable
          							  ,imp_montobase
          							  ,cod_region
         							    ,cod_provincia
          							  ,cod_ciudad
          							  ,cod_modulo
          							  ,cod_plancom
          							  ,ind_factur
          							  ,cod_catimpos
          							  ,cod_portador
          			   				,ind_estado
          							  ,cod_tipconce
          							  ,num_unidades
          							  ,num_seriele
          							  ,flag_impues
          							  ,flag_dto
          							  ,num_cuotas
          							  ,ind_modventa
									        ,num_seriemec
									        ,num_venta
									        ,COD_CONCEREL /*RA-402*/
									        ,COLUMNA_REL /*RA-402*/
									        )
                VALUES  (LN_num_proceso
       						  		,LN_cod_cliente
       								  ,LN_cod_descuento /*LN_cod_concepto  RA-402*/
       								  ,LN_columna
       								  ,LN_cod_producto
       								  ,LV_cod_moneda
       								  ,sysdate
       								  ,sysdate
       								  ,LN_imp_descuento - LN_imp_concepto/*RA-402*/
       								  ,LN_imp_descuento - LN_imp_concepto /*RA-402*/
       								  ,LN_imp_concepto  /*IMP_MONTOBASE - RA-402*/
       								  ,LV_cod_region
       								  ,LV_cod_provincia
       								  ,LV_cod_ciudad
       								  ,LV_cod_modulo
       								  ,LN_cod_plancom
       				  				,LN_ind_factur
      								  ,LN_cod_catimpos
     								    ,LN_cod_portador
       								  ,LN_ind_estado
       								  ,LN_cod_tipconce_descuento /*RA-402*/
       								  ,LN_num_unidades
       								  ,LV_num_seriele
       								  ,LN_flag_impues
       								  ,LN_flag_dto
       								  ,LN_num_cuotas
       								  ,LN_ind_modventa
									      ,LV_num_seriemec
									      ,LN_num_venta
									      ,LN_cod_concepto /*RA-402*/
									      ,LN_columna - 1  /*RA-402*/
									      );

      END IF; /*FIN INSERT RA-502*/

	 END LOOP;
 	 LV_tabla := 'v_DatosC';
     LV_act   := 'Cerrar cursor';
	 CLOSE v_DatosC;

	 IF LN_columna = 0 THEN
	 	RETURN 1;
	 ELSE
	 	RETURN 0;
	 END IF;

     EXCEPTION
	 WHEN NO_DATA_FOUND THEN
		 SN_coderror    :=-1;
	     SV_error		:='No existen datos en tabla(s) '||LV_tabla;
		 RETURN -1;
		 rollback;
     WHEN OTHERS THEN
		 SN_coderror    :=SQLCODE;
	     SV_error		:='Error al '|| LV_act ||' '|| LV_tabla ||':'|| SQLERRM;
   	  	 RETURN SQLCODE;
		 rollback;
END FA_PREFACTURA_PR;

PROCEDURE FA_PROCESOS_PR (EN_num_proceso   IN NUMBER
						 ,EN_cod_dealer	   IN NUMBER
						 ,EN_cod_tipdocum  IN fa_procesos.cod_tipdocum%TYPE
						 ,EN_cod_centremi  IN fa_procesos.cod_centremi%TYPE
						 ,EN_letraag	   IN fa_procesos.letraag%TYPE
   			 			 ,SN_coderror  	  OUT NOCOPY NUMBER
   			             ,SV_error 	   	  OUT NOCOPY VARCHAR2) IS

  /*
  <Documentación TipoDoc = "FA_PROCESOS_PR
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

    LV_obj              VARCHAR2(50):='FA_VENTA_MISCELANEA_PG.fa_procesos_pr';
    LV_tabla            VARCHAR2(50);
    LV_act              VARCHAR2(50);


	LN_num_proceso				fa_procesos.num_proceso%TYPE;
	LN_cod_tipdocum             fa_procesos.cod_tipdocum%TYPE;
	LN_cod_vendedor_agente      fa_procesos.cod_vendedor_agente%TYPE;
	LN_cod_centremi             fa_procesos.cod_centremi%TYPE;
	LD_fec_efectividad          fa_procesos.fec_efectividad%TYPE;
	LV_nom_usuarora             fa_procesos.nom_usuarora%TYPE;
	LV_letraag                  fa_procesos.letraag%TYPE;
	LN_ind_estado               fa_procesos.ind_estado%TYPE;


BEGIN
	 SN_coderror:=0;

	 LN_num_proceso  			:= EN_num_proceso;
	 LN_cod_tipdocum 	    	:= EN_cod_tipdocum;
	 LN_cod_vendedor_agente 	:= EN_cod_dealer;
	 LN_cod_centremi			:= EN_cod_centremi;
	 LD_fec_efectividad 		:= TRUNC(SYSDATE);
	 LV_nom_usuarora 			:= USER;
	 LV_letraag					:= 'I'; -- Validar de donde obtener este campo
	 LN_ind_estado				:= 0;






		  LV_tabla := 'fa_procesos';
 		  LV_act   := 'Insertar';


		  INSERT INTO fa_procesos  (num_proceso
									,cod_tipdocum
									,cod_vendedor_agente
									,cod_centremi
									,fec_efectividad
									,nom_usuarora
									,letraag
									,num_secuag
									,ind_estado)
                           VALUES  (LN_num_proceso
									,LN_cod_tipdocum
									,LN_cod_vendedor_agente
									,LN_cod_centremi
									,LD_fec_efectividad
									,LV_nom_usuarora
									,LV_letraag
									,FA_SEQ_MISCELANEA.NEXTVAL
									,LN_ind_estado);


     EXCEPTION
	 WHEN NO_DATA_FOUND THEN
		 SN_coderror    :=-1;
	     SV_error		:='No existen datos en tabla(s) '||LV_tabla;
     WHEN OTHERS THEN
		 SN_coderror    :=SQLCODE;
	     SV_error		:='Error al '|| LV_act ||' '|| LV_tabla ||':'|| SQLERRM;

END FA_PROCESOS_PR;

PROCEDURE FA_INTERFACT_PR   (EN_num_proceso       IN fa_interfact.num_proceso%TYPE
							,EN_num_venta         IN fa_interfact.num_venta%TYPE
							,EV_cod_modgener      IN fa_interfact.cod_modgener%TYPE
							,EN_cod_estadoc       IN fa_interfact.cod_estadoc%TYPE
							,EN_cod_estproc       IN fa_interfact.cod_estproc%TYPE
							,EN_cod_tipmovimien   IN fa_interfact.cod_tipmovimien%TYPE
							,EC_cod_catribut      IN fa_interfact.cod_catribut%TYPE
							,EV_cod_tipdocum      IN fa_interfact.cod_tipdocum%TYPE
							,ED_fec_vencimiento   IN fa_interfact.fec_vencimiento%TYPE
							,EV_pref_plaza        IN fa_interfact.pref_plaza%TYPE
							,EV_pref_plazarel     IN fa_interfact.pref_plazarel%TYPE
							,EV_tip_foliacion     IN fa_interfact.tip_foliacion%TYPE
							,SN_coderror  	  	 OUT NOCOPY NUMBER
   			                ,SV_error 	   	  	 OUT NOCOPY VARCHAR2) IS

  /*
  <Documentación TipoDoc = "FA_INTERFACT_PR
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

    LV_obj              VARCHAR2(50):='FA_VENTA_MISCELANEA_PG.fa_interfact_pr';
    LV_tabla            VARCHAR2(50);
    LV_act              VARCHAR2(50);


	LN_num_proceso		    fa_interfact.num_proceso%TYPE;
	LN_num_venta			fa_interfact.num_venta%TYPE;
	LV_cod_modgener			fa_interfact.cod_modgener%TYPE;
	LN_cod_estadoc			fa_interfact.cod_estadoc%TYPE;
	LN_cod_estproc			fa_interfact.cod_estproc%TYPE;
	LN_cod_tipmovimien		fa_interfact.cod_tipmovimien%TYPE;
	LC_cod_catribut			fa_interfact.cod_catribut%TYPE;
	LV_cod_tipdocum			fa_interfact.cod_tipdocum%TYPE;
	LD_fec_vencimiento		fa_interfact.fec_vencimiento%TYPE;
	LV_pref_plaza    		fa_interfact.pref_plaza%TYPE;
	LV_pref_plazarel		fa_interfact.pref_plazarel%TYPE;
	LV_tip_foliacion		fa_interfact.tip_foliacion%TYPE;


BEGIN
	 SN_coderror:=0;


	 LN_num_proceso      :=EN_num_proceso      ;
	 LN_num_venta        :=EN_num_venta        ;
	 LV_cod_modgener     :=EV_cod_modgener     ;
	 LN_cod_estadoc      :=EN_cod_estadoc      ;
	 LN_cod_estproc      :=EN_cod_estproc      ;
	 LN_cod_tipmovimien  :=EN_cod_tipmovimien  ;
	 LC_cod_catribut     :=EC_cod_catribut     ;
	 LV_cod_tipdocum     :=EV_cod_tipdocum     ;
	 LD_fec_vencimiento  :=ED_fec_vencimiento  ;
	 LV_pref_plaza    	 :=EV_pref_plaza       ;
	 LV_pref_plazarel    :=EV_pref_plazarel    ;
	 LV_tip_foliacion    :=EV_tip_foliacion    ;



		  LV_tabla := 'fa_interfact';
 		  LV_act   := 'Insertar';

		  INSERT INTO fa_interfact  (num_proceso
									,num_venta
									,cod_modgener
									,cod_estadoc
									,cod_estproc
									,cod_tipmovimien
									,cod_catribut
									,cod_tipdocum
									,fec_ingreso
									,fec_vencimiento
									,pref_plaza
									,pref_plazarel
									,tip_foliacion)
                           VALUES   (LN_num_proceso
									,LN_num_venta
									,LV_cod_modgener
									,LN_cod_estadoc
									,LN_cod_estproc
									,LN_cod_tipmovimien
									,LC_cod_catribut
									,LV_cod_tipdocum
									,sysdate
									,LD_fec_vencimiento
									,LV_pref_plaza
									,LV_pref_plazarel
									,LV_tip_foliacion);


     EXCEPTION
	 WHEN NO_DATA_FOUND THEN
		 SN_coderror    :=-1;
	     SV_error		:='No existen datos en tabla(s) '||LV_tabla;
     WHEN OTHERS THEN
		 SN_coderror    :=SQLCODE;
	     SV_error		:='Error al '|| LV_act ||' '|| LV_tabla ||':'|| SQLERRM;
END FA_INTERFACT_PR;

END FA_VENTA_MISCELANEA_PG;
/
SHOW ERRORS
