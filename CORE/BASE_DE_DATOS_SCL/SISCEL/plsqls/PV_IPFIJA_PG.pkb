CREATE OR REPLACE PACKAGE BODY PV_IPFIJA_PG AS
----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_registra_error_pr
		 (
		 EN_cod_error     IN OUT     ge_errores_pg.CodError,
		 EV_cadena_error  IN      ge_errores_pg.vQuery,
		 EV_procedimiento IN	  VARCHAR2,
   		 SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
   		 SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
   		 SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
		 )
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ga_registra_error_fn"
      Lenguaje="PL/SQL"
      Fecha="28-07-2005"
      Versión="1.0"
      Diseñador="Ricardo Roco"
      Programador="Diego Mejias"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtiene datos desde la GED_PARAMETROS</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_error"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="EV_cadena_error"  Tipo="CARACTER">Query que tubo el problema</param>
            <param nom="EV_procedimiento" Tipo="CARACTER">Procedimiento Afectado</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

BEGIN
	 SN_cod_retorno  := 0;
   	 SN_num_evento   := 0;
   	 SV_mens_retorno := '';

	 IF NOT Ge_Errores_Pg.MENSAJEERROR(EN_cod_error,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
     END IF;
	 GV_des_error   := EV_procedimiento || ' ' || SQLERRM;
     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'pv_ipfija_pg', EV_cadena_error, SQLCODE, GV_des_error );
	 SN_cod_retorno := EN_cod_error;

END pv_registra_error_pr;
----------------------------------------------------------------------------------------------------------------------
FUNCTION pv_busca_ip_fn
		 (
		 EN_num_abonado  IN  pv_ipservsuplabo_to.num_abonado%TYPE,
		 EV_cod_servicio IN  ga_servsupl.cod_servicio%TYPE,
		 EV_fec_altabd	 IN  pv_ipservsuplabo_to.fec_altabd%TYPE,
		 EN_cod_ss		 IN  pv_ipservsuplabo_to.cod_servsupl%TYPE,
		 EN_cod_nivel	 IN  pv_ipservsuplabo_to.cod_nivel%TYPE,
		 SV_num_ip		 OUT NOCOPY pv_ipservsuplabo_to.num_ip%TYPE,
   		 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
   		 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
   		 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
		 )
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ga_busca_ip_fn"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador="Ricardo Roco"
      Programador="Diego Mejias"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtiene datos desde la GED_PARAMETROS</Descripción>
      <Parámetros>
         <Entrada>
			<param nom="EV_cod_servicio" Tipo="NUMERICO">Codigo de Servicio</param>
			<param nom="EN_num_abonado"  Tipo="NUMERICO">Numero de Abonado</param>
			<param nom="EN_fec_altabd"   Tipo="NUMERICO">Fecha de Alta de BD</param>
			<param nom="EN_cod_ss"       Tipo="NUMERICO">Codigo de SS</param>
			<param nom="EN_cod_nivel"    Tipo="NUMERICO">Codigo de nivel de SS</param>
         </Entrada>
         <Salida>
		    <param nom="SV_num_ip"         Tipo="VARCHAR" >Numero de IP</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN  BOOLEAN
AS
error_parametros EXCEPTION;
CN_nom_proced VARCHAR2(27):='pv_busca_ip_fn';

BEGIN
	 SN_cod_retorno  := 0;
   	 SN_num_evento   := 0;
   	 SV_mens_retorno := '';

	 IF TRIM(EV_cod_servicio) IS NULL OR TRIM(EV_fec_altabd) IS NULL OR EN_num_abonado = 0 OR EN_cod_ss = 0 OR EN_cod_nivel = 0 THEN
	 	RAISE error_parametros;
	 END IF;

	 GV_sSql:= 'SELECT a.num_ip '||
	   		   'FROM pv_ipservsuplabo_to a '||
	  		   'WHERE a.num_abonado  ='|| EN_num_abonado ||
	    	   '  AND a.cod_servicio ='|| EV_cod_servicio||
			   '  AND a.fec_altabd   ='|| EV_fec_altabd  ||
			   '  AND a.cod_servsupl ='|| EN_cod_ss      ||
			   '  AND a.cod_nivel	 ='|| EN_cod_nivel;

	 SELECT a.num_ip
	   INTO SV_num_ip
	   FROM pv_ipservsuplabo_to a
	  WHERE a.num_abonado  = EN_num_abonado
	    AND a.cod_servicio = EV_cod_servicio
		AND trunc(a.fec_altabd)   = trunc(EV_fec_altabd)
		AND a.cod_servsupl = EN_cod_ss
		AND a.cod_nivel	   = EN_cod_nivel;

	 RETURN  TRUE;

EXCEPTION
WHEN  error_parametros THEN
	  pv_registra_error_pr (CN_err_param_entrada, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
      RETURN  FALSE;

WHEN  NO_DATA_FOUND   THEN
      pv_registra_error_pr (CN_err_no_data_found, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
      RETURN  FALSE;

WHEN  OTHERS   THEN
	  pv_registra_error_pr (CN_err_no_data_found, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
      RETURN  FALSE;

END pv_busca_ip_fn;
----------------------------------------------------------------------------------------------------------------------
FUNCTION pv_obtiene_gedparametros_fn
		 (
   		 EV_nom_parametro  IN         ged_parametros.nom_parametro%TYPE,
   		 EV_cod_modulo     IN         ged_parametros.cod_modulo%TYPE,
   		 EN_cod_producto   IN         ged_parametros.cod_producto%TYPE,
   		 SV_val_parametro  OUT NOCOPY ged_parametros.val_parametro%TYPE,
   		 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
   		 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
   		 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
		 )
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ga_obtiene_gedparametros_fn"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador="Ricardo Roco"
      Programador="Diego Mejias"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtiene datos desde la GED_PARAMETROS</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_nom_parametro" Tipo="CARACTER">Nombre del parametro</param>
            <param nom="EV_cod_modulo" Tipo="CARACTER">Nombre del modulo, no es obligatorio</param>
            <param nom="EN_cod_producto" Tipo="NUMERICO">Codigo del producto no es obligatorio</param>
         </Entrada>
         <Salida>
            <param nom="SV_val_parametro"       Tipo="CARACTER">Valor del parametro</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN  BOOLEAN
AS

error_parametros EXCEPTION;
CN_nom_proced VARCHAR2(27):='pv_obtiene_gedparametros_fn';

BEGIN
	  SN_cod_retorno  := 0;
   	  SN_num_evento   := 0;
   	  SV_mens_retorno := '';
   	  SV_val_parametro:= null;

	  IF TRIM(EV_nom_parametro) IS NULL OR TRIM(EV_cod_modulo) IS NULL OR EN_cod_producto = 0 THEN
	  	 RAISE error_parametros;
	  END IF;

   	  GV_sSql:= 'SELECT a.val_parametro  '||
   			 	'  FROM	ged_parametros a '||
   			 	' WHERE a.nom_parametro ='|| EV_nom_parametro ||
   			 	'   AND	a.cod_modulo    ='|| EV_cod_modulo    ||
   			 	'   AND	a.cod_producto  ='|| EN_cod_producto;

   	  SELECT a.val_parametro
   	  INTO   SV_val_parametro
   	  FROM	 ged_parametros a
   	  WHERE  a.nom_parametro = EV_nom_parametro
   	  AND	 a.cod_modulo    = EV_cod_modulo
   	  AND	 a.cod_producto  = EN_cod_producto;

   	  RETURN  TRUE;

EXCEPTION
WHEN  error_parametros THEN
	  pv_registra_error_pr (CN_err_param_entrada, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
      RETURN  FALSE;

WHEN  NO_DATA_FOUND   THEN
      pv_registra_error_pr (CN_err_no_data_found, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
      RETURN  FALSE;

WHEN  OTHERS   THEN
	  pv_registra_error_pr (CN_err_no_data_found, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
      RETURN  FALSE;

END  pv_obtiene_gedparametros_fn;
----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_validar_ss_con_ip_fija_pr
		  (
		  EN_cod_producto IN  ga_servsupl.cod_producto%TYPE,
		  EV_cod_servicio IN  ga_servsupl.cod_servicio%TYPE,
		  SN_ind_ip		  OUT NOCOPY ga_servsupl.ind_ip%TYPE,
   		  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
   		  SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
   		  SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
		  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_validar_ss_con_ip_fija_pr"
      Lenguaje="PL/SQL"
      Fecha="21-07-2005"
      Versión="1.0"
      Diseñador=  Ricardo Roco.
      Programador="DIEGO MEJIAS"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Este servicio entrega si IP corresponde a una IP fija.
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_producto" Tipo="NUMERICO">Codigo de Producto</param>
			<param nom="EV_cod_servicio" Tipo="VARCHAR" >Codigo de Servicio</param>
         </Entrada>
         <Salida>
		    <param nom="SN_ind_ip"		 Tipo="NUMERICO">Retorna el estado de IP</param>
			<param nom="SN_cod_retorno"  Tipo="NUMERICO">Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO">Número de Evento</param>
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_parametros EXCEPTION;

CN_nom_proced 	 VARCHAR2(28):='pv_validar_ss_con_ip_fija_pr';

BEGIN
     SN_cod_retorno  := 0;
     SV_mens_retorno := '';
	 SN_num_evento 	 := 0;

	 IF EN_cod_producto IS NULL OR EV_cod_servicio IS NULL THEN
	 	RAISE error_parametros;
	 END IF;

	 GV_sSql := 'SELECT nvl(a.ind_ip, 0) FROM ga_servsupl a '||
	 		    'WHERE  a.cod_producto = '|| EN_cod_producto ||' '||
				'AND    a.cod_servicio = '|| EV_cod_servicio;

	 SELECT nvl(a.ind_ip, 0)
	 INTO   SN_ind_ip
	 FROM   ga_servsupl a
	 WHERE  a.cod_producto = EN_cod_producto
	 AND    a.cod_servicio = EV_cod_servicio;

EXCEPTION
     WHEN error_parametros THEN
	 	  pv_registra_error_pr (CN_err_param_entrada, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

     WHEN NO_DATA_FOUND THEN
	 	  pv_registra_error_pr (CN_err_serv_no_encontrado, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

     WHEN OTHERS THEN
	 	  pv_registra_error_pr (CN_err_serv_no_encontrado, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

END pv_validar_ss_con_ip_fija_pr;

----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_consultar_apn_pr
		  (
		  EV_cod_servicio   IN  ga_servsupl.cod_servicio%TYPE,
      	          SN_cod_apn        OUT NOCOPY aip_apn_to.cod_apn%TYPE,
	  	  SV_cod_tecnologia OUT NOCOPY aip_apn_to.cod_tecnologia%TYPE,
	  	  SN_cod_qos        OUT NOCOPY aip_qos_to.cod_qos%TYPE,
	  	  SN_cod_qos_id     OUT NOCOPY aip_qos_to.eqosid%TYPE,
   		  SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
   		  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
   		  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
		  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_consultar_apn_pr"
      Lenguaje="PL/SQL"
      Fecha="21-07-2005"
      Versión="1.0"
      Diseñador="Ricardo Roco"
      Programador="DIEGO MEJIAS"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta apn correspondiente al servicio.
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_servicio"   Tipo="VARCHAR" >Codigo de Servicio</param>
         </Entrada>
         <Salida>
		    <param nom="SV_cod_apn"        Tipo="VARCHAR" >Codigo  de APN</param>
			<param nom="SV_cod_tecnologia" Tipo="VARCHAR" >Codigo  de Tecnologia</param>
			<param nom="SN_cod_qos"  	   Tipo="NUMERICO">Codigo  de QoS</param>
			<param nom="SN_cod_qos_id" 	   Tipo="NUMERICO">Codigo ID de QoS</param>
			<param nom="SN_cod_retorno"    Tipo="NUMERICO">Código  de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno"   Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Número  de Evento</param>
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_ejecucion EXCEPTION;
error_llamado 	EXCEPTION;

CN_nom_proced 	VARCHAR2(19):='pv_consultar_apn_pr';
LN_cod_error    ge_errores_pg.CodError;

BEGIN

     SN_cod_retorno  := 0;
     SV_mens_retorno := '';
	 SN_num_evento 	 := 0;

	 IF TRIM(EV_cod_servicio) IS NULL THEN
	 	RAISE error_ejecucion;
	 END IF;

	 GV_sSql := 'aip_administracion_pg.aip_conapn_pr('||EV_cod_servicio||')';

	 aip_administracion_pg.aip_conapn_pr
	     (
		 EV_cod_servicio, SN_cod_apn, SV_cod_tecnologia, SN_cod_qos, SN_cod_qos_id,
		 SN_cod_retorno, SV_mens_retorno, SN_num_evento
		 );

	 IF SN_cod_retorno <> 0 THEN
             LN_cod_error := SN_cod_retorno;
	     RAISE error_llamado;
	 END IF;

EXCEPTION
     WHEN error_llamado THEN
	 	  pv_registra_error_pr (LN_cod_error, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
	 	  SN_cod_apn        := 0;
		  SV_cod_tecnologia := '';
		  SN_cod_qos        := 0;
		  SN_cod_qos_id     := 0;
     WHEN error_ejecucion THEN
	 	  pv_registra_error_pr (CN_err_param_entrada, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
	 	  SN_cod_apn        := 0;
		  SV_cod_tecnologia := '';
		  SN_cod_qos        := 0;
		  SN_cod_qos_id     := 0;

     WHEN OTHERS THEN
	 	  pv_registra_error_pr (CN_err_no_encuentra_apn, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
	 	  SN_cod_apn        := 0;
		  SV_cod_tecnologia := '';
		  SN_cod_qos        := 0;
		  SN_cod_qos_id     := 0;
END pv_consultar_apn_pr;

----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_solicitar_ip_pr
		  (
		  EV_cod_tecnologia IN  al_tecnologia.cod_tecnologia%TYPE,
		  EN_cod_apn	    IN  pv_ipservsuplabo_to.cod_apn%TYPE,
		  EV_TipoIp         IN  GA_SERVSUPL.IND_IP%TYPE,
          EN_cod_qos        IN aip_apn_to.cod_qos%TYPE,
          SV_num_ip			OUT NOCOPY pv_ipservsuplabo_to.num_ip%TYPE,
   		  SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
   		  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
   		  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
		  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_solicitar_ip_pr"
      Lenguaje="PL/SQL"
      Fecha="21-07-2005"
      Versión="1.0"
      Diseñador="Ricardo Roco"
      Programador="DIEGO MEJIAS"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Genera abono minuto para postpago.
      <Parámetros>
         <Entrada>
		    <param nom="EV_cod_tecnologia" Tipo="VARCHAR" >Codigo de Tecnologia</param>
			<param nom="EV_cod_apn"        Tipo="VARCHAR" >Codigo de APN</param>
         </Entrada>
         <Salida>
		    <param nom="SV_num_ip"         Tipo="VARCHAR" >Numero de IP</param>
			<param nom="SN_cod_retorno"    Tipo="NUMERICO">Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno"   Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Número de Evento</param>
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_ejecucion    EXCEPTION;
error_peticion	   EXCEPTION;

LN_cod_transaccion NUMBER(1);
LV_men_transaccion VARCHAR2(15);
LV_octeto_1		   VARCHAR2(3);
LV_octeto_2		   VARCHAR2(3);
LV_octeto_3		   VARCHAR2(3);
LV_octeto_4		   VARCHAR2(3);

CN_nom_proced 	   VARCHAR2(18):='pv_solicitar_ip_pr';

BEGIN
     SN_cod_retorno  := 0;
     SV_mens_retorno := '';
	 SN_num_evento 	 := 0;

	 IF EV_cod_tecnologia IS NULL OR EN_cod_apn IS NULL THEN
	 	RAISE error_ejecucion;
	 END IF;

	 GV_sSql := 'aip_administracion_pg.ip_peticionip_pr('||EV_cod_tecnologia||','||EN_cod_apn||')';

	 aip_administracion_pg.aip_peticionip_pr
	    				  (
						  EV_cod_tecnologia, EN_cod_apn,EV_TipoIp,EN_cod_qos, LV_octeto_1, LV_octeto_2, LV_octeto_3, LV_octeto_4,
						  SN_cod_retorno, SV_mens_retorno, SN_num_evento
						  );

	 IF SN_cod_retorno <> 0 THEN
	    RAISE error_peticion;
	 ELSE
	    SV_num_ip := LV_octeto_1 ||'.'|| LV_octeto_2 ||'.'|| LV_octeto_3 ||'.'|| LV_octeto_4;
	 END IF;

EXCEPTION
     WHEN error_ejecucion THEN
          pv_registra_error_pr (CN_err_param_entrada, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
          SV_num_ip := '';

     WHEN error_peticion THEN
          pv_registra_error_pr (CN_err_peticion_ip, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
          SV_num_ip := '';

     WHEN OTHERS THEN
          pv_registra_error_pr (CN_err_ejecutar_servicio, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
          SV_num_ip := '';

END pv_solicitar_ip_pr;

----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_insertar_datos_ip_fija_pr
		  (
		  EN_num_abonado   IN  pv_ipservsuplabo_to.num_abonado%TYPE,
		  EV_cod_servicio  IN  pv_ipservsuplabo_to.cod_servicio%TYPE,
		  EV_fec_altabd	   IN  pv_ipservsuplabo_to.fec_altabd%TYPE,
		  EN_cod_ss		   IN  pv_ipservsuplabo_to.cod_servsupl%TYPE,
		  EN_cod_nivel	   IN  pv_ipservsuplabo_to.cod_nivel%TYPE,
		  EV_num_ip		   IN  pv_ipservsuplabo_to.num_ip%TYPE,
		  EN_cod_apn	   IN  pv_ipservsuplabo_to.cod_apn%TYPE,
		  EN_cod_qos	   IN  pv_ipservsuplabo_to.cod_qos%TYPE,
		  EN_cod_qos_id	   IN  pv_ipservsuplabo_to.cod_qos_id%TYPE,
   		  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
   		  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
   		  SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
		  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_insertar_datos_ip_fija_pr"
      Lenguaje="PL/SQL"
      Fecha="21-07-2005"
      Versión="1.0"
      Diseñador="Ricardo Roco"
      Programador="DIEGO MEJIAS"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Genera abono minuto para postpago.
      <Parámetros>
         <Entrada>
            <param nom="EN_num_abonado"  Tipo="NUMERICO">Numero de Abonado</param>
			<param nom="EV_cod_servicio" Tipo="VARCHAR" >Codigo de Servicio</param>
			<param nom="EN_fec_altabd"   Tipo="VARCHAR" >Fecha de alta en BD</param>
			<param nom="EN_cod_ss" 		 Tipo="VARCHAR" >Codigo de Servicio Suplementario</param>
			<param nom="EN_cod_nivel"	 Tipo="VARCHAR" >Codigo de Nivel</param>
			<param nom="EV_num_ip"       Tipo="VARCHAR" >Numero de IP</param>
			<param nom="EV_cod_apn"      Tipo="VARCHAR" >Codigo de APN</param>
			<param nom="EN_cod_qos"  	 Tipo="NUMERICO">Codigo de QoS</param>
			<param nom="EN_cod_qos_id"   Tipo="NUMERICO">Codigo de QoS ID</param>
         </Entrada>
         <Salida>
			<param nom="SN_cod_retorno"  Tipo="NUMERICO" >Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO" >Número de Evento</param>
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_parametros EXCEPTION;

CN_nom_proced 	 VARCHAR2(28):='pv_insertar_datos_ip_fija_pr';

BEGIN
     SN_cod_retorno  := 0;
     SV_mens_retorno := '';
	 SN_num_evento 	 := 0;

	 -- Validamos que los datos de entrada no vengan vacios --
	 IF EV_fec_altabd IS NULL OR EV_cod_servicio IS NULL OR EN_num_abonado = 0 OR EN_cod_ss  = 0 OR EN_cod_nivel  = 0 OR
	                             EV_num_ip		 IS NULL OR EN_cod_apn	   = 0 OR EN_cod_qos = 0 OR EN_cod_qos_id = 0 THEN
		RAISE error_parametros;
	 END IF;

	 GV_sSql :=  'INSERT INTO pv_ipservsuplabo_to (num_abonado,cod_servicio,fec_altabd,cod_servsupl,cod_nivel,'||
	 		 	 		 	  					  'num_ip,cod_apn,cod_qos,cod_qos_id)'||
				 'VALUES ('||EN_num_abonado||','||EV_cod_servicio||','||EV_fec_altabd||','||EN_cod_ss||','||
						     EN_cod_nivel||','||EV_num_ip||','||EN_cod_apn||','||EN_cod_qos||','||EN_cod_qos_id||')';

	 INSERT INTO pv_ipservsuplabo_to (
	 			 					  num_abonado,
	 			 					  cod_servicio,
									  fec_altabd,
									  cod_servsupl,
									  cod_nivel,
									  num_ip,
									  cod_apn,
									  cod_qos,
									  cod_qos_id
									  )
							  VALUES (
							  		  EN_num_abonado,
									  EV_cod_servicio,
									  EV_fec_altabd,
									  EN_cod_ss,
									  EN_cod_nivel,
									  EV_num_ip,
									  EN_cod_apn,
		  							  EN_cod_qos,
		  							  EN_cod_qos_id
							  		 );

EXCEPTION
     WHEN error_parametros THEN
	 	  pv_registra_error_pr (CN_err_param_entrada, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

     WHEN OTHERS THEN
	 	  pv_registra_error_pr (CN_err_ejecutar_servicio, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

END pv_insertar_datos_ip_fija_pr;
----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_modifica_ip_hib_pr
		  (EV_num_celular   IN  VARCHAR2,
           EN_num_abonado   IN  pv_ipservsuplabo_to.num_abonado%TYPE,
		   EV_cod_servicio  IN  pv_ipservsuplabo_to.cod_servicio%TYPE,
		   EV_fec_altabd	IN  pv_ipservsuplabo_to.fec_altabd%TYPE,
		   EN_cod_ss		IN  pv_ipservsuplabo_to.cod_servsupl%TYPE,
		   EN_cod_nivel	    IN  pv_ipservsuplabo_to.cod_nivel%TYPE,
   		   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
   		   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
   		   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
		  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_modifica_ip_hib_pr"
      Lenguaje="PL/SQL"
      Fecha="21-07-2005"
      Versión="1.0"
      Diseñador="Vladimir Maureira"
      Programador="Vladimir Maureira"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Cambia estado de IP.
      <Parámetros>
         <Entrada>
            <param nom="EV_num_celular "  Tipo="VARCHAR" >Numero Celular</param>
			<param nom="EN_num_abonado "  Tipo="NUMERICO">Numero de Abonado</param>
			<param nom="EV_cod_servicio"  Tipo="NUMERICO">Codigo de Estado</param>
            <param nom="EV_fec_altabd"    Tipo="NUMERICO">fecha alta bd</param>
            <param nom="EN_cod_ss         Tipo="NUMERICO">Codigo de SS</param>
            <param nom="EN_cod_nivel      Tipo="NUMERICO">Codigo Nivel SS</param>
         </Entrada>
         <Salida>
			<param nom="SN_cod_retorno"  Tipo="NUMERICO" >Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO" >Número de Evento</param>
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_parametros   EXCEPTION;
error_cambestado   EXCEPTION;

LN_cod_transaccion NUMBER(1);
LV_men_transaccion VARCHAR2(250);
LV_val_parametro   ged_parametros.val_parametro%TYPE;
LN_cod_est_hiber   NUMBER(2);
LN_cod_est_dispo   NUMBER(2);
LN_num_celular	   ga_servsuplabo.num_terminal%TYPE;
lV_num_ip		   pv_ipservsuplabo_to.num_ip%TYPE;
ln_cod_estado_ip   aip_ip_to.cod_estado_ip%TYPE;

LN_primera_pos	   NUMBER(1);
LN_segunda_pos	   NUMBER(1);
LN_tercera_pos	   NUMBER(2);
LV_cod_modulo	   CONSTANT VARCHAR2(2)  := 'IP';

CN_nom_proced 	   VARCHAR2(23):='pv_modifica_ip_hib_pr';
CV_ip_disponible  VARCHAR2(17):= 'ESTADO_DISPONIBLE';
CV_ip_hibernacion VARCHAR2(18):= 'ESTADO_HIBERNACION';

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
	SN_num_evento 	 := 0;

	LN_num_celular	 := TO_NUMBER(EV_num_celular);

	 -- rescatar valor del parametro --
	IF NOT pv_obtiene_gedparametros_fn (CV_ip_disponible, LV_cod_modulo, CN_cod_producto, LV_val_parametro,
   										 SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
		RAISE  error_parametros;
	END IF;


	LN_cod_est_dispo := TO_NUMBER(LV_val_parametro);

	 -- rescatar valor del parametro --
    IF NOT pv_obtiene_gedparametros_fn (CV_ip_hibernacion, LV_cod_modulo, CN_cod_producto, LV_val_parametro,
   										 SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
		RAISE  error_parametros;
    END IF;


    LN_cod_est_hiber := TO_NUMBER(LV_val_parametro);


    IF NOT pv_busca_ip_fn (EN_num_abonado, EV_cod_servicio, EV_fec_altabd, EN_cod_ss,EN_cod_nivel,
                           LV_num_ip, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
	   RAISE  error_parametros;
    END IF;


    IF length(LV_num_ip) > 0 THEN
	 LN_primera_pos:= INSTR(LV_num_ip,'.',1,1);
	 LN_segunda_pos:= INSTR(LV_num_ip,'.',1,2);
	 LN_tercera_pos:= INSTR(LV_num_ip,'.',1,3);

	 GN_octeto_1   := SUBSTR(LV_num_ip, 1, LN_primera_pos - 1);
	 GN_octeto_2   := SUBSTR(LV_num_ip, LN_primera_pos + 1, LN_segunda_pos - (LN_primera_pos + 1));
	 GN_octeto_3   := SUBSTR(LV_num_ip, LN_segunda_pos + 1, LN_tercera_pos - (LN_segunda_pos + 1));
	 GN_octeto_4   := SUBSTR(LV_num_ip, LN_tercera_pos + 1, LENGTH(LV_num_ip) - LN_tercera_pos);

     BEGIN
       SELECT cod_estado_ip
       INTO ln_cod_estado_ip
       FROM aip_ip_to
       WHERE octeto_1 = GN_octeto_1
	   AND octeto_2 = GN_octeto_2
	   AND octeto_3 = GN_octeto_3
	   AND octeto_4 = GN_octeto_4;

       EXCEPTION
       WHEN OTHERS THEN
          RAISE error_cambestado;
     END;

     IF  LN_cod_est_hiber  = ln_cod_estado_ip THEN

           GV_sSql := 'aip_cambioestado_pr('||LV_num_ip||','||LN_num_celular||','||LN_cod_est_dispo||')';
	       aip_administracion_pg.aip_modifica_estadoips_pr(GN_octeto_1, GN_octeto_2, GN_octeto_3, GN_octeto_4, LN_cod_est_dispo, LN_num_celular,  SN_cod_retorno, SV_mens_retorno, SN_num_evento);

           IF SN_cod_retorno <> 0 THEN
              RAISE error_cambestado;
           END IF;
     END IF;
    END IF;

EXCEPTION
     WHEN error_parametros THEN
	 	  pv_registra_error_pr (CN_err_param_entrada, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

     WHEN error_cambestado THEN
          pv_registra_error_pr (CN_err_cambio_estado, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

     WHEN OTHERS THEN
	 	  pv_registra_error_pr (CN_err_ejecutar_servicio, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

END pv_modifica_ip_hib_pr;
----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cambiar_estado_ip_pr
		  (
		  EV_num_ip		   IN  pv_ipservsuplabo_to.num_ip%TYPE,
		  EV_num_celular   IN  VARCHAR2,
		  EV_nom_parametro IN  ged_parametros.nom_parametro%TYPE,
   		  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
   		  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
   		  SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
		  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_cambiar_estado_ip_pr"
      Lenguaje="PL/SQL"
      Fecha="21-07-2005"
      Versión="1.0"
      Diseñador="Ricardo Roco"
      Programador="DIEGO MEJIAS"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Cambia estado de IP.
      <Parámetros>
         <Entrada>
            <param nom="EN_num_ip"      Tipo="VARCHAR" >Numero de IP</param>
			<param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
			<param nom="EN_cod_estado"  Tipo="NUMERICO">Codigo de Estado</param>
         </Entrada>
         <Salida>
			<param nom="SN_cod_retorno"  Tipo="NUMERICO" >Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO" >Número de Evento</param>
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_parametros   EXCEPTION;
error_cambestado   EXCEPTION;

LN_cod_transaccion NUMBER(1);
LV_men_transaccion VARCHAR2(250);
LV_val_parametro   ged_parametros.val_parametro%TYPE;
LN_cod_estado	   NUMBER(2);
LN_num_celular	   ga_servsuplabo.num_terminal%TYPE;

LN_primera_pos	   NUMBER(1);
LN_segunda_pos	   NUMBER(1);
LN_tercera_pos	   NUMBER(2);
LV_cod_modulo	   CONSTANT VARCHAR2(2)  := 'IP';

CN_nom_proced 	   VARCHAR2(23):='pv_cambiar_estado_ip_pr';

BEGIN
     SN_cod_retorno  := 0;
     SV_mens_retorno := '';
	 SN_num_evento 	 := 0;
	 LN_num_celular	 := TO_NUMBER(EV_num_celular);


	 IF EV_num_ip IS NULL OR LN_num_celular = 0 OR EV_nom_parametro IS NULL THEN
	    RAISE error_parametros;
	 END IF;

	 -- rescatar valor del parametro --
	 IF NOT pv_obtiene_gedparametros_fn (EV_nom_parametro, LV_cod_modulo, CN_cod_producto, LV_val_parametro,
   										 SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
		RAISE  error_parametros;
	 END IF;

	 LN_cod_estado := TO_NUMBER(LV_val_parametro);

	 LN_primera_pos:= INSTR(EV_num_ip,'.',1,1);
	 LN_segunda_pos:= INSTR(EV_num_ip,'.',1,2);
	 LN_tercera_pos:= INSTR(EV_num_ip,'.',1,3);

	 GN_octeto_1   := SUBSTR(EV_num_ip, 1, LN_primera_pos - 1);
	 GN_octeto_2   := SUBSTR(EV_num_ip, LN_primera_pos + 1, LN_segunda_pos - (LN_primera_pos + 1));
	 GN_octeto_3   := SUBSTR(EV_num_ip, LN_segunda_pos + 1, LN_tercera_pos - (LN_segunda_pos + 1));
	 GN_octeto_4   := SUBSTR(EV_num_ip, LN_tercera_pos + 1, LENGTH(EV_num_ip) - LN_tercera_pos);

	 GV_sSql := 'aip_cambioestado_pr('||EV_num_ip||','||LN_num_celular||','||LN_cod_estado||')';

	 aip_administracion_pg.aip_modifica_estadoips_pr(GN_octeto_1, GN_octeto_2, GN_octeto_3, GN_octeto_4, LN_cod_estado, LN_num_celular,  SN_cod_retorno, SV_mens_retorno, SN_num_evento);

	 IF SN_cod_retorno <> 0 THEN
	    RAISE error_cambestado;
	 END IF;

EXCEPTION
     WHEN error_parametros THEN
	 	  pv_registra_error_pr (CN_err_param_entrada, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

     WHEN error_cambestado THEN
          pv_registra_error_pr (CN_err_cambio_estado, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

     WHEN OTHERS THEN
	 	  pv_registra_error_pr (CN_err_ejecutar_servicio, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

END pv_cambiar_estado_ip_pr;
----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_generar_datos_ip_pr
		  (
		  EN_num_abonado   IN  pv_ipservsuplabo_to.num_abonado%TYPE,
		  EN_num_celular   IN  ga_abocel.num_celular%TYPE,
		  EN_cod_producto  IN  ga_servsupl.cod_producto%TYPE,
		  EV_cod_servicio  IN  ga_servsupl.cod_servicio%TYPE,
		  EV_fec_altabd	   IN  pv_ipservsuplabo_to.fec_altabd%TYPE,
		  EN_cod_ss		   IN  pv_ipservsuplabo_to.cod_servsupl%TYPE,
		  EN_cod_nivel	   IN  pv_ipservsuplabo_to.cod_nivel%TYPE,
		  EV_accion		   IN  VARCHAR2,
		  EN_estado_old	   IN  ga_servsuplabo.ind_estado%TYPE,
		  EN_estado_new	   IN  ga_servsuplabo.ind_estado%TYPE,
   		  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
   		  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
   		  SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
		  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_generar_datos_ip"
      Lenguaje="PL/SQL"
      Fecha="21-07-2005"
      Versión="1.0"
      Diseñador="Ricardo Roco"
      Programador="DIEGO MEJIAS"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Genera datos para IP fija.
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_producto" Tipo="NUMERICO">Codigo de Producto</param>
			<param nom="EV_cod_servicio" Tipo="NUMERICO">Codigo de Servicio</param>
			<param nom="EN_num_abonado"  Tipo="NUMERICO">Numero de Abonado</param>
			<param nom="EN_fec_altabd"   Tipo="NUMERICO">Fecha de Alta de BD</param>
			<param nom="EN_cod_ss"       Tipo="NUMERICO">Codigo de SS</param>
			<param nom="EN_cod_nivel"    Tipo="NUMERICO">Codigo de nivel de SS</param>
         </Entrada>
         <Salida>
			<param nom="SN_cod_retorno"  Tipo="NUMERICO">Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO">Número de Evento</param>
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_parametros  EXCEPTION;
error_ejecucion	  EXCEPTION;
no_aplica		  EXCEPTION;

LN_ind_ip		  ga_servsupl.ind_ip%TYPE;
LV_cod_apn		  pv_ipservsuplabo_to.cod_apn%TYPE;
LV_cod_tecnologia al_tecnologia.cod_tecnologia%TYPE;
LN_cod_qos		  pv_ipservsuplabo_to.cod_qos%TYPE;
LN_cod_qos_id	  pv_ipservsuplabo_to.cod_qos_id%TYPE;
LV_num_ip		  pv_ipservsuplabo_to.num_ip%TYPE;
LV_accion		  VARCHAR2(3);

CV_ip_asignada	  VARCHAR2(10):= 'ESTADO_USO';
CV_ip_disponible  VARCHAR2(17):= 'ESTADO_DISPONIBLE';
CV_ip_hibernacion VARCHAR2(18):= 'ESTADO_HIBERNACION';
CV_accion_ins	  VARCHAR2(3) := 'INS';
CV_accion_upd	  VARCHAR2(3) := 'UPD';
CV_accion_del	  VARCHAR2(3) := 'DEL';
CV_accion_hib	  VARCHAR2(3) := 'HIB';
CV_nom_parametro  ged_parametros.nom_parametro%TYPE:= 'PERMITE_USO_IP_FIJA';
LV_val_parametro  ged_parametros.val_parametro%TYPE;
CN_nom_proced 	  VARCHAR2(19):= 'pv_generar_datos_ip';
LV_TipoIp         GA_SERVSUPL.IND_IP%TYPE;

BEGIN
     SN_cod_retorno  := 0;
     SV_mens_retorno := '';
	 SN_num_evento 	 := 0;


     SELECT IND_IP
     INTO LV_TipoIp
     FROM GA_SERVSUPL
     WHERE COD_SERVICIO=EV_cod_servicio;

	 -- rescatar valor del parametro --
	 IF NOT pv_obtiene_gedparametros_fn (CV_nom_parametro, CV_cod_modulo, CN_cod_producto, LV_val_parametro,
   										 SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
		RAISE  error_parametros;
	 END IF;

	 IF TRIM(LV_val_parametro) <> 'TRUE' THEN
	 	RAISE no_aplica;
	 END IF;

	 IF TRIM(EV_accion) IS NULL THEN
	 	RAISE error_parametros;
	 END IF;

	 LV_accion := UPPER(TRIM(EV_accion));

	 IF LV_accion = CV_accion_ins THEN
		pv_ipfija_pg.pv_validar_ss_con_ip_fija_pr
		            (EN_cod_producto, EV_cod_servicio, LN_ind_ip, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

	    IF SN_cod_retorno <> 0 THEN
		   RAISE error_ejecucion;
	    END IF;

		IF LN_ind_ip <> 0 THEN
	       pv_ipfija_pg.pv_consultar_apn_pr
		 		       (EV_cod_servicio, LV_cod_apn, LV_cod_tecnologia, LN_cod_qos, LN_cod_qos_id, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

	       IF SN_cod_retorno <> 0 THEN
		      RAISE error_ejecucion;
	       END IF;

           pv_ipfija_pg.pv_solicitar_ip_pr
             		   (LV_cod_tecnologia, LV_cod_apn,LV_TipoIp,LN_cod_qos, LV_num_ip, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

	       IF SN_cod_retorno <> 0 THEN
		      RAISE error_ejecucion;
	       END IF;

	       pv_ipfija_pg.pv_insertar_datos_ip_fija_pr
		               (EN_num_abonado, EV_cod_servicio, EV_fec_altabd, EN_cod_ss, EN_cod_nivel, LV_num_ip, LV_cod_apn, LN_cod_qos, LN_cod_qos_id, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

	       IF SN_cod_retorno <> 0 THEN
		      RAISE error_ejecucion;
	       END IF;

	       IF EN_estado_new = CN_alta_centrales THEN
		      pv_ipfija_pg.pv_cambiar_estado_ip_pr
            		      (LV_num_ip, EN_num_celular, CV_ip_asignada, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

			  IF SN_cod_retorno <> 0 THEN
				 RAISE error_ejecucion;
			  END IF;
	       END IF;
		END IF;

	 ELSIF LV_accion = CV_accion_upd THEN
	    pv_ipfija_pg.pv_validar_ss_con_ip_fija_pr
		            (EN_cod_producto, EV_cod_servicio, LN_ind_ip, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

	    IF SN_cod_retorno <> 0 THEN
		   RAISE error_ejecucion;
	    END IF;

		IF LN_ind_ip <> 0 THEN
		   IF EN_estado_new = CN_alta_centrales THEN

			  IF NOT pv_busca_ip_fn (EN_num_abonado, EV_cod_servicio, EV_fec_altabd, EN_cod_ss,EN_cod_nivel,
		 	  	 	 				 LV_num_ip, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
			  	 RAISE  error_parametros;
	 		  END IF;

		      pv_ipfija_pg.pv_cambiar_estado_ip_pr
	                      (LV_num_ip, EN_num_celular, CV_ip_asignada, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

		      IF SN_cod_retorno <> 0 THEN
	 		     RAISE error_ejecucion;
	 	      END IF;

		   ELSIF EN_estado_new IN (CN_baja_centrales,CN_baja_abonado) THEN

			  IF NOT pv_busca_ip_fn (EN_num_abonado, EV_cod_servicio, EV_fec_altabd, EN_cod_ss,EN_cod_nivel,
		 	  	 	 				 LV_num_ip, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
			  	 RAISE  error_parametros;
	 		  END IF;

	 	      pv_ipfija_pg.pv_cambiar_estado_ip_pr
	                      (LV_num_ip, EN_num_celular, CV_ip_disponible, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

		      IF SN_cod_retorno <> 0 THEN
		 	     RAISE error_ejecucion;
		      END IF;
           END IF;
		END IF;

	 ELSIF LV_accion = CV_accion_hib THEN
	    pv_ipfija_pg.pv_validar_ss_con_ip_fija_pr
		            (EN_cod_producto, EV_cod_servicio, LN_ind_ip, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

	    IF SN_cod_retorno <> 0 THEN
		   RAISE error_ejecucion;
	    END IF;

		IF LN_ind_ip <> 0 THEN
			  IF NOT pv_busca_ip_fn (EN_num_abonado, EV_cod_servicio, EV_fec_altabd, EN_cod_ss,EN_cod_nivel,
		 	  	 	 				 LV_num_ip, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
			  	 RAISE  error_parametros;
	 		  END IF;

	 	      pv_ipfija_pg.pv_cambiar_estado_ip_pr
	                      (LV_num_ip, EN_num_celular, CV_ip_hibernacion, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

		      IF SN_cod_retorno <> 0 THEN
		 	     RAISE error_ejecucion;
		      END IF;
		END IF;
	 ELSIF LV_accion = CV_accion_del THEN
	    pv_ipfija_pg.pv_validar_ss_con_ip_fija_pr
		            (EN_cod_producto, EV_cod_servicio, LN_ind_ip, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

	    IF SN_cod_retorno <> 0 THEN
		   RAISE error_ejecucion;
	    END IF;

		IF LN_ind_ip <> 0 THEN

		   IF NOT pv_busca_ip_fn (EN_num_abonado, EV_cod_servicio, EV_fec_altabd, EN_cod_ss,EN_cod_nivel,
	 	  	 	 				 LV_num_ip, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
		  	  RAISE  error_parametros;
		   END IF;

		   IF EN_estado_old IN (CN_alta_bd,CN_alta_centrales,CN_baja_bd) THEN

	 	      pv_ipfija_pg.pv_cambiar_estado_ip_pr
	        	          (LV_num_ip, EN_num_celular, CV_ip_disponible, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

	 	      IF SN_cod_retorno <> 0 THEN
	 		     RAISE error_ejecucion;
	 	      END IF;
		   END IF;
	    END IF;

	 ELSE
	    RAISE error_parametros;
	 END IF;

EXCEPTION
	 WHEN no_aplica THEN
	 	  NULL;

     WHEN error_ejecucion THEN
		  GV_des_error  := 'pv_generar_datos_ip('||EN_num_abonado||'); - ' || SQLERRM;
          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'pv_ipfija_pg', GV_sSql, SQLCODE, GV_des_error );

     WHEN error_parametros THEN
	 	  pv_registra_error_pr (CN_err_param_entrada, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

     WHEN OTHERS THEN
	 	  pv_registra_error_pr (CN_err_ejecutar_servicio, GV_sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

END pv_generar_datos_ip_pr;
FUNCTION pv_valida_estado_ip_fn
		 (
		 EV_num_ip	        IN   pv_ipservsuplabo_to.num_ip%TYPE,
   		 EN_cod_estado_ip   IN   aip_ip_to.cod_estado_ip%type
		 )
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "pv_valida_estado_ip_fn"
      Lenguaje="PL/SQL"
      Fecha="23-08-2005"
      Versión="1.0"
      Diseñador="Vladimir Maureira"
      Programador="Vladimir Maureira"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida estado IP </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_num_ip" Tipo="CARACTER">Numero IP del servicio</param>
            <param nom="EN_cod_estado_ip" Tipo="NUMERO">Estado IP</param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN  BOOLEAN
AS
   LN_primera_pos   NUMBER(1);
   LN_segunda_pos   NUMBER(1);
   LN_tercera_pos   NUMBER(2);
   LN_cod_estado    NUMBER(1);
   LN_cod_estado_ip aip_ip_to.cod_estado_ip%type;
   SN_octeto_1      aip_ip_to.octeto_1%TYPE;
   SN_octeto_2      aip_ip_to.octeto_2%TYPE;
   SN_octeto_3      aip_ip_to.octeto_3%TYPE;
   SN_octeto_4      aip_ip_to.octeto_4%TYPE;

BEGIN
	 LN_primera_pos:= INSTR(EV_num_ip,'.',1,1);
	 LN_segunda_pos:= INSTR(EV_num_ip,'.',1,2);
	 LN_tercera_pos:= INSTR(EV_num_ip,'.',1,3);

	 SN_octeto_1   := SUBSTR(EV_num_ip, 1, LN_primera_pos - 1);
	 SN_octeto_2   := SUBSTR(EV_num_ip, LN_primera_pos + 1, LN_segunda_pos - (LN_primera_pos + 1));
	 SN_octeto_3   := SUBSTR(EV_num_ip, LN_segunda_pos + 1, LN_tercera_pos - (LN_segunda_pos + 1));
	 SN_octeto_4   := SUBSTR(EV_num_ip, LN_tercera_pos + 1, LENGTH(EV_num_ip) - LN_tercera_pos);


     SELECT a.cod_estado_ip
     INTO LN_cod_estado_ip
     FROM  aip_ip_to a
     WHERE a.octeto_1=SN_octeto_1
     AND a.octeto_2=SN_octeto_2
     AND a.octeto_3=SN_octeto_3
     AND a.octeto_4=SN_octeto_4;

     IF LN_cod_estado_ip = EN_cod_estado_ip THEN
	    RETURN  TRUE;
     ELSE
        RETURN  FALSE;
     END IF;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
   		RETURN FALSE;

   WHEN OTHERS THEN
   		RETURN FALSE;

END pv_valida_estado_ip_fn;
----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_activar_ip_ss_pr
          (
		  EN_num_abonado   IN  pv_ipservsuplabo_to.num_abonado%TYPE,
          EN_num_celular   IN  ga_abocel.num_celular%TYPE
		  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_activar_ip_ss_pr"
      Lenguaje="PL/SQL"
      Fecha="01-08-2009"
      Versión="1.0"
      Diseñador="Vladimir Maureira"
      Programador="Vladimir Maureira"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Genera datos para IP fija.
      <Parámetros>
         <Entrada>
			<param nom="EN_num_abonado"  Tipo="NUMERICO">Numero de Abonado</param>
            <param nom="EN_num_celular"  Tipo="NUMERICO">Numero de celular</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_parametros  EXCEPTION;
error_ejecucion	  EXCEPTION;
no_aplica		  EXCEPTION;

CV_accion_ins	  VARCHAR2(3) := 'INS';
CV_accion_del	  VARCHAR2(3) := 'DEL';
CN_nom_proced 	  VARCHAR2(19):= 'pv_activar_ip_ss_pr';
CV_ip_asignada	  VARCHAR2(10):= 'ESTADO_USO';
LV_val_parametro  ged_parametros.val_parametro%TYPE;
LV_num_ip		  pv_ipservsuplabo_to.num_ip%TYPE;
lb_ip_insercion   boolean;
LN_cod_estado_ip  aip_ip_to.cod_estado_ip%type;

        --Activar Servicio IP
        cursor cur_ip_ins is
        select b.cod_servicio,b.cod_servsupl,b.cod_nivel,b.fec_altabd
        from ga_servsuplabo b
        where  b.num_abonado =EN_num_abonado
        and b.cod_servicio in ( select a.cod_servicio
        from ga_servsupl a
        where a.cod_producto = 1
        and a.ind_ip<> 0 )
        and b.ind_estado < 3;

        --Desactivar  Servicio IP
        cursor cur_ip_del is
        select b.cod_servicio,b.cod_servsupl,b.cod_nivel,b.fec_altabd
        from ga_servsuplabo b
        where  b.num_abonado =EN_num_abonado
        and b.cod_servicio in ( select a.cod_servicio
        from ga_servsupl a
        where a.cod_producto = 1
        and a.ind_ip<> 0 )
        and b.ind_estado >= 3
        and b.fec_altabd   = (
				   		   	  SELECT MAX(b.fec_altabd)
				     		    FROM ga_servsuplabo a
					           WHERE a.num_abonado  = b.num_abonado
					             AND a.cod_servsupl = b.cod_servsupl
					  			 AND a.cod_nivel	= b.cod_nivel
					  			 AND a.ind_estado	= b.ind_estado
				             );


        lv_cod_servicio ga_servsuplabo.cod_servicio%type;
        ln_cod_servsupl ga_servsuplabo.cod_servsupl%type;
        ld_fec_altabd   ga_servsuplabo.fec_altabd%type;
        ln_cod_nivel    ga_servsuplabo.cod_nivel%type;

        ln_cod_retorno   ge_errores_pg.CodError;
  		lv_mens_retorno  ge_errores_pg.MsgError;
   		ln_num_evento    ge_errores_pg.Evento;

BEGIN
     ln_cod_retorno  := 0;
     lv_mens_retorno := '';
	 ln_num_evento 	 := 0;

    IF NOT pv_obtiene_gedparametros_fn (CV_ip_asignada,'IP', CN_cod_producto, lv_val_parametro,
   										ln_cod_retorno, lv_mens_retorno, ln_num_evento) THEN
		RAISE  error_parametros;
	END IF;

    LN_cod_estado_ip  := TO_NUMBER(LV_val_parametro);

   -- Servicio IP  = INSERCION
    OPEN cur_ip_ins;
    LOOP
         FETCH cur_ip_ins INTO lv_cod_servicio,ln_cod_servsupl,ln_cod_nivel,ld_fec_altabd;
         EXIT WHEN cur_ip_ins%NOTFOUND;

         IF NOT pv_busca_ip_fn (EN_num_abonado, lv_cod_servicio, ld_fec_altabd, ln_cod_servsupl,ln_cod_nivel,
		 	  	 	 	   LV_num_ip, ln_cod_retorno, lv_mens_retorno, ln_num_evento) THEN
            lb_ip_insercion:=true;
         ELSE
            IF NOT pv_valida_estado_ip_fn(LV_num_ip, LN_cod_estado_ip) THEN
               lb_ip_insercion:=true;
            ELSE
               lb_ip_insercion:=false;
	        END IF;
         END IF;

         IF lb_ip_insercion THEN
           PV_IPFIJA_PG.pv_generar_datos_ip_pr(EN_num_abonado,EN_num_celular,CN_cod_producto,
                                             lv_cod_servicio,ld_fec_altabd,ln_cod_servsupl,ln_cod_nivel,'UPD',3,2,
                                             ln_cod_retorno,lv_mens_retorno,ln_num_evento);
           IF ln_cod_retorno <> 0 THEN
              RAISE error_ejecucion;
           END IF;
         END IF;

    END LOOP;
    CLOSE cur_ip_ins;

    -- Servicio IP  = DELETE
    OPEN cur_ip_del;
    LOOP
         FETCH cur_ip_del INTO lv_cod_servicio,ln_cod_servsupl,ln_cod_nivel,ld_fec_altabd;
         EXIT WHEN cur_ip_del%NOTFOUND;

         PV_IPFIJA_PG.pv_generar_datos_ip_pr(EN_num_abonado,EN_num_celular,CN_cod_producto,
                                             lv_cod_servicio,ld_fec_altabd,ln_cod_servsupl,ln_cod_nivel,'DEL',3,0,
                                             ln_cod_retorno,lv_mens_retorno,ln_num_evento);
         IF ln_cod_retorno <> 0 THEN
              RAISE error_ejecucion;
         END IF;

    END LOOP;
    CLOSE cur_ip_del;

EXCEPTION
	 WHEN no_aplica THEN
	 	  NULL;

     WHEN error_ejecucion THEN
		  GV_des_error  := 'pv_activar_ip_ss_pr('||EN_num_abonado||'); - ' || SQLERRM;
          ln_num_evento := Ge_Errores_Pg.Grabarpl( ln_num_evento, CV_cod_modulo, lv_mens_retorno, GV_version, USER, 'pv_ipfija_pg', GV_sSql, SQLCODE, GV_des_error );

     WHEN error_parametros THEN
	 	  pv_registra_error_pr (CN_err_param_entrada, GV_sSql, CN_nom_proced, ln_cod_retorno, lv_mens_retorno, ln_num_evento);

     WHEN OTHERS THEN
	 	  pv_registra_error_pr (CN_err_ejecutar_servicio, GV_sSql, CN_nom_proced, ln_cod_retorno, lv_mens_retorno, ln_num_evento);

END pv_activar_ip_ss_pr;
----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_activar_ipPA_ss_pr
          (
		  EN_num_abonado           IN  pv_ipservsuplabo_to.num_abonado%TYPE,
          EV_cod_prod_ofertado     IN  PR_PRODUCTOS_CONTRATADOS_TO.COD_PROD_OFERTADO%TYPE
          )
IS
error_parametros  EXCEPTION;
error_ejecucion	  EXCEPTION;
no_aplica		  EXCEPTION;

CV_accion_ins	  VARCHAR2(3) := 'INS';
CV_accion_del	  VARCHAR2(3) := 'DEL';
CN_nom_proced 	  VARCHAR2(19):= 'pv_activar_ip_ss_pr';
CV_ip_asignada	  VARCHAR2(10):= 'ESTADO_USO';
LV_val_parametro  ged_parametros.val_parametro%TYPE;
LV_num_ip		  pv_ipservsuplabo_to.num_ip%TYPE;
lb_ip_insercion   boolean;
LN_cod_estado_ip  aip_ip_to.cod_estado_ip%type;
LN_existe_servicio number(1);
LV_servHomologo    GA_SERVSUPL.COD_SERVICIO%TYPE;
lv_cod_servicio ga_servsuplabo.cod_servicio%type;
ln_cod_servsupl ga_servsuplabo.cod_servsupl%type;
ld_fec_altabd   varchar2(30);
ln_cod_nivel    ga_servsuplabo.cod_nivel%type;

ln_cod_retorno   ge_errores_pg.CodError;
lv_mens_retorno  ge_errores_pg.MsgError;
ln_num_evento    ge_errores_pg.Evento;
LN_num_terminal  ga_abocel.num_celular%TYPE; 
lv_cod_concepto  fa_conceptos.cod_concepto%TYPE;
lv_nom_usuarora  ga_abocel.nom_usuarora%TYPE;
LV_string1        VARCHAR2(100);
LV_string2        VARCHAR2(100);
SV_cadenaSS       GA_ABOCEL.CLASE_SERVICIO%TYPE;
LV_COUNT         NUMBER(2);

BEGIN
     ln_cod_retorno  := 0;
     lv_mens_retorno := '';
	 ln_num_evento 	 := 0;

   IF NOT pv_obtiene_gedparametros_fn (CV_ip_asignada,'IP', CN_cod_producto, lv_val_parametro,
   										ln_cod_retorno, lv_mens_retorno, ln_num_evento) THEN
		RAISE  error_parametros;
	END IF;

   LN_cod_estado_ip  := TO_NUMBER(LV_val_parametro);

   
   SELECT COD_SERVICIO 
   INTO LV_servHomologo
   FROM GA_PA_SERVSUPL_TO
   WHERE COD_PROD_OFERTADO=EV_cod_prod_ofertado;
   
   IF LV_servHomologo IS NOT NULL THEN 
      
      SELECT COUNT(1) 
      INTO LN_existe_servicio
      FROM GA_SERVSUPLABO
      WHERE COD_SERVICIO=LV_servHomologo
      AND NUM_ABONADO=EN_num_abonado
      and ind_estado<=2;
       
      IF LN_existe_servicio =0 THEN 
           -- Servicio IP  = INSERCION
          
           --Crear SS en GA_SERVSUPLABO
              
             SELECT COD_SERVSUPL,COD_NIVEL 
             INTO ln_cod_servsupl,ln_cod_nivel
             FROM GA_SERVSUPL
             WHERE COD_SERVICIO=LV_servHomologo; 
             
             
             SELECT NUM_CELULAR,NOM_USUARORA,TO_CHAR(FEC_ALTA,'DDMMYYYY HH24MISS') 
             INTO LN_num_terminal,lv_nom_usuarora,ld_fec_altabd
             FROM GA_ABOCEL
             WHERE NUM_ABONADO= EN_num_abonado
             AND COD_SITUACION NOT IN ('BAA','BAP')
             UNION 
             SELECT NUM_CELULAR,NOM_USUARORA,TO_CHAR(FEC_ALTA,'DDMMYYYY HH24MISS')
             FROM GA_ABOAMIST
             WHERE NUM_ABONADO = EN_num_abonado
             AND COD_SITUACION NOT IN ('BAA','BAP');
             
             --Obtengo datos del concepto
             
              SELECT
                 NVL(b.cod_concepto,0)
              INTO
                 lv_cod_concepto
              FROM
              ga_servsupl a
              ,ga_actuaserv b
              WHERE a.cod_servsupl = ln_cod_servsupl
              AND a.cod_nivel = ln_cod_nivel
              AND a.cod_producto = CN_cod_producto
              AND a.tip_servicio = CV_TIPSERVICIO_1
              AND a.cod_producto = b.cod_producto(+)
              AND a.cod_servicio = b.cod_servicio(+)
              AND b.cod_actabo(+) = CV_CODACT_FAC
              AND b.cod_tipserv(+) = CV_TIPSERVICIO_2
              AND ROWNUM=1;
             
             BEGIN
             VE_SERV_SUPLEM_ABO_PG.VE_InsertaSSAbonado_PR( EN_num_abonado,LV_servHomologo,ln_cod_servsupl,ln_cod_nivel,CN_cod_producto,LN_num_terminal
                                    ,lv_cod_concepto,CN_alta_centrales,0,ld_fec_altabd,
                                    lv_nom_usuarora,ln_cod_retorno,lv_mens_retorno,ln_num_evento);
             
             UPDATE GA_SERVSUPLABO SET FEC_ALTACEN=SYSDATE, IND_ESTADO=2 
             WHERE NUM_ABONADO=EN_num_abonado
             AND COD_SERVICIO=LV_servHomologo;
             
--             LV_string1  := TO_CHAR(ln_cod_servsupl,'09');
--             LV_string2  := TO_CHAR(ln_cod_nivel,'0999');
--             SV_cadenaSS := SV_cadenaSS || TRIM(LV_string1) || TRIM(LV_string2);
--             
--             UPDATE GA_ABOCEL 
--             SET CLASE_SERVICIO= CLASE_SERVICIO || SV_cadenaSS
--             WHERE NUM_ABONADO=EN_num_abonado;
--             
--             SELECT COUNT(1)
--             INTO LV_COUNT 
--             FROM ICC_MOVIMIENTO 
--             WHERE NUM_ABONADO=EN_num_abonado
--             AND COD_ACTABO = 'SS';
--             
--             IF LV_COUNT>=1 THEN
--                UPDATE ICC_MOVIMIENTO SET COD_SERVICIOS = COD_SERVICIOS || SV_cadenaSS
--                WHERE NUM_ABONADO=EN_num_abonado
--                AND COD_ACTABO='SS';
--             ELSE 
--                SELECT COUNT(1)
--                INTO LV_COUNT 
--                FROM ICC_MOVIMIENTO 
--                WHERE NUM_ABONADO=EN_num_abonado
--                AND (COD_ACTABO='VO' OR COD_ACTABO='VT') ;
--                IF LV_COUNT>=1 THEN 
--                   UPDATE ICC_MOVIMIENTO SET COD_SERVICIOS = COD_SERVICIOS || SV_cadenaSS
--                   WHERE NUM_ABONADO=EN_num_abonado
--                   AND (COD_ACTABO='VO' OR COD_ACTABO='VT');
--                ELSE 
--                   --Es una Postventa
--                   UPDATE GA_ABOCEL SET PERFIL_ABONADO = PERFIL_ABONADO || SV_cadenaSS
--                   WHERE NUM_ABONADO=EN_num_abonado;
--                END IF; 
--             END IF;
             EXCEPTION 
               WHEN OTHERS THEN 
               RAISE NO_APLICA;
             END;
              
      
      END IF;    
   END IF;

EXCEPTION
	 WHEN no_aplica THEN
	 	  NULL;

     WHEN error_ejecucion THEN
		  GV_des_error  := 'pv_activar_ip_ss_pr('||EN_num_abonado||'); - ' || SQLERRM;
          ln_num_evento := Ge_Errores_Pg.Grabarpl( ln_num_evento, CV_cod_modulo, lv_mens_retorno, GV_version, USER, 'pv_ipfija_pg', GV_sSql, SQLCODE, GV_des_error );

     WHEN error_parametros THEN
	 	  pv_registra_error_pr (CN_err_param_entrada, GV_sSql, CN_nom_proced, ln_cod_retorno, lv_mens_retorno, ln_num_evento);

     WHEN OTHERS THEN
	 	  pv_registra_error_pr (CN_err_ejecutar_servicio, GV_sSql, CN_nom_proced, ln_cod_retorno, lv_mens_retorno, ln_num_evento);

END pv_activar_ipPA_ss_pr;
PROCEDURE pv_Desactivar_ipPA_ss_pr
          (
		  EN_num_abonado           IN  pv_ipservsuplabo_to.num_abonado%TYPE,
          EV_cod_prod_ofertado     IN  PR_PRODUCTOS_CONTRATADOS_TO.COD_PROD_OFERTADO%TYPE
          )
IS
error_parametros  EXCEPTION;
error_ejecucion	  EXCEPTION;
no_aplica		  EXCEPTION;

CV_accion_ins	  VARCHAR2(3) := 'INS';
CV_accion_del	  VARCHAR2(3) := 'DEL';
CN_nom_proced 	  VARCHAR2(19):= 'pv_activar_ip_ss_pr';
CV_ip_asignada	  VARCHAR2(10):= 'ESTADO_USO';
LV_val_parametro  ged_parametros.val_parametro%TYPE;
LV_num_ip		  pv_ipservsuplabo_to.num_ip%TYPE;
lb_ip_insercion   boolean;
LN_cod_estado_ip  aip_ip_to.cod_estado_ip%type;
LN_existe_servicio number(1);
LV_servHomologo    GA_SERVSUPL.COD_SERVICIO%TYPE;
lv_cod_servicio ga_servsuplabo.cod_servicio%type;
ln_cod_servsupl ga_servsuplabo.cod_servsupl%type;
ld_fec_altabd   varchar2(30);
ln_cod_nivel    ga_servsuplabo.cod_nivel%type;

ln_cod_retorno   ge_errores_pg.CodError;
lv_mens_retorno  ge_errores_pg.MsgError;
ln_num_evento    ge_errores_pg.Evento;
LN_num_terminal  ga_abocel.num_celular%TYPE; 
lv_cod_concepto  fa_conceptos.cod_concepto%TYPE;
lv_nom_usuarora  ga_abocel.nom_usuarora%TYPE;
LV_string1        VARCHAR2(100);
LV_string2        VARCHAR2(100);
SV_cadenaSS       GA_ABOCEL.CLASE_SERVICIO%TYPE;
V_CLASESERVICIO GA_ABOCEL.CLASE_SERVICIO%TYPE;
V_CLASE GA_ABOCEL.CLASE_SERVICIO%TYPE;
V_SERVNIVEL VARCHAR2(6);
V_SERVSUPL CHAR(2);
V_NIVEL CHAR(4);
V_POS NUMBER(3) := 1;

BEGIN
     ln_cod_retorno  := 0;
     lv_mens_retorno := '';
	 ln_num_evento 	 := 0;

   IF NOT pv_obtiene_gedparametros_fn (CV_ip_asignada,'IP', CN_cod_producto, lv_val_parametro,
   										ln_cod_retorno, lv_mens_retorno, ln_num_evento) THEN
		RAISE  error_parametros;
	END IF;

   LN_cod_estado_ip  := TO_NUMBER(LV_val_parametro);

   
   SELECT COD_SERVICIO 
   INTO LV_servHomologo
   FROM GA_PA_SERVSUPL_TO
   WHERE COD_PROD_OFERTADO=EV_cod_prod_ofertado;
   
   IF LV_servHomologo IS NOT NULL THEN 
      
      SELECT COUNT(1) 
      INTO LN_existe_servicio
      FROM GA_SERVSUPLABO
      WHERE COD_SERVICIO=LV_servHomologo
      AND NUM_ABONADO=EN_num_abonado
      and ind_estado<=2;
       
      IF LN_existe_servicio =1 THEN 
           -- Servicio IP  = INSERCION
          
           --Crear SS en GA_SERVSUPLABO
              
             SELECT COD_SERVSUPL,COD_NIVEL 
             INTO ln_cod_servsupl,ln_cod_nivel
             FROM GA_SERVSUPL
             WHERE COD_SERVICIO=LV_servHomologo; 
             
             
             SELECT NUM_CELULAR,NOM_USUARORA,TO_CHAR(FEC_ALTA,'DDMMYYYY HH24MISS') 
             INTO LN_num_terminal,lv_nom_usuarora,ld_fec_altabd
             FROM GA_ABOCEL
             WHERE NUM_ABONADO= EN_num_abonado
             AND COD_SITUACION NOT IN ('BAA','BAP')
             UNION 
             SELECT NUM_CELULAR,NOM_USUARORA,TO_CHAR(FEC_ALTA,'DDMMYYYY HH24MISS')
             FROM GA_ABOAMIST
             WHERE NUM_ABONADO = EN_num_abonado
             AND COD_SITUACION NOT IN ('BAA','BAP');
             
             --Obtengo datos del concepto
             
              SELECT
                 NVL(b.cod_concepto,0)
              INTO
                 lv_cod_concepto
              FROM
              ga_servsupl a
              ,ga_actuaserv b
              WHERE a.cod_servsupl = ln_cod_servsupl
              AND a.cod_nivel = ln_cod_nivel
              AND a.cod_producto = CN_cod_producto
              AND a.tip_servicio = CV_TIPSERVICIO_1
              AND a.cod_producto = b.cod_producto(+)
              AND a.cod_servicio = b.cod_servicio(+)
              AND b.cod_actabo(+) = CV_CODACT_FAC
              AND b.cod_tipserv(+) = CV_TIPSERVICIO_2
              AND ROWNUM=1;
             
             BEGIN
                 
                 
                 
                 
                 -- Servicio IP  = DELETE
                 PV_IPFIJA_PG.pv_generar_datos_ip_pr(EN_num_abonado,LN_num_terminal,CN_cod_producto,
                                                      LV_servHomologo,TO_DATE(ld_fec_altabd,'DDMMYYYY HH24MISS'),ln_cod_servsupl,ln_cod_nivel,'DEL',3,0,
                                                      ln_cod_retorno,lv_mens_retorno,ln_num_evento);
                  
                 
                 
                 
                  
                  UPDATE GA_SERVSUPLABO 
                 SET IND_ESTADO=4, FEC_BAJABD=SYSDATE
                 ,FEC_BAJACEN=SYSDATE 
                 WHERE NUM_ABONADO=EN_num_abonado
                 AND COD_SERVICIO=LV_servHomologo;
                  
                  
--                  SELECT CLASE_SERVICIO
--                  INTO V_CLASESERVICIO 
--                  FROM GA_ABOCEL 
--                  WHERE NUM_ABONADO=EN_num_abonado
--                  UNION 
--                  SELECT CLASE_SERVICIO 
--                  FROM GA_ABOAMIST 
--                  WHERE NUM_ABONADO=EN_num_abonado;
--                  
--                  LOOP
--                    V_SERVNIVEL := SUBSTR (V_CLASESERVICIO, V_POS, 6);
--                    EXIT WHEN V_SERVNIVEL IS NULL;
--                    V_POS := V_POS + 6;
--                    V_SERVSUPL := SUBSTR(V_SERVNIVEL,1,2);
--                    V_NIVEL    := SUBSTR(V_SERVNIVEL,3,4);
--                    IF TO_NUMBER(V_SERVSUPL) <> ln_cod_servsupl THEN
--                       V_CLASE := V_CLASE||V_SERVSUPL||V_NIVEL;
--                    END IF;
--                  END LOOP;
--                  
--                  SV_cadenaSS:=V_CLASE;
--                  
--                  UPDATE GA_ABOCEL 
--                  SET CLASE_SERVICIO= CLASE_SERVICIO || SV_cadenaSS
--                  WHERE NUM_ABONADO=EN_num_abonado;
--                  
--                  IF ln_cod_retorno <> 0 THEN
--                     RAISE NO_APLICA;
--                  END IF;

             
             EXCEPTION 
               WHEN OTHERS THEN 
               NULL;
             END;
      END IF;    
   END IF;

EXCEPTION
	 WHEN no_aplica THEN
	 	  NULL;

     WHEN error_ejecucion THEN
		  GV_des_error  := 'pv_activar_ip_ss_pr('||EN_num_abonado||'); - ' || SQLERRM;
          ln_num_evento := Ge_Errores_Pg.Grabarpl( ln_num_evento, CV_cod_modulo, lv_mens_retorno, GV_version, USER, 'pv_ipfija_pg', GV_sSql, SQLCODE, GV_des_error );

     WHEN error_parametros THEN
	 	  pv_registra_error_pr (CN_err_param_entrada, GV_sSql, CN_nom_proced, ln_cod_retorno, lv_mens_retorno, ln_num_evento);

     WHEN OTHERS THEN
	 	  pv_registra_error_pr (CN_err_ejecutar_servicio, GV_sSql, CN_nom_proced, ln_cod_retorno, lv_mens_retorno, ln_num_evento);
END pv_Desactivar_ipPA_ss_pr;
END PV_IPFIJA_PG;
/
SHOW ERROR