CREATE OR REPLACE PACKAGE BODY aip_administracion_pg AS

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION aip_portecapnestado_fn (
    EV_cod_tecnologia  IN aip_ip_to.cod_tecnologia%TYPE,
   	EN_cod_apn 		   IN aip_ip_to.cod_apn%TYPE,
	EN_cod_estado_ip   IN aip_ip_to.cod_estado_ip%TYPE,
    EN_tipo_ip         IN aip_apn_to.tipo_ip%TYPE,
    EN_cod_qos         IN aip_apn_to.cod_qos%TYPE,
	SN_octeto_1		   OUT NOCOPY aip_ip_to.octeto_1%TYPE,
	SN_octeto_2		   OUT NOCOPY aip_ip_to.octeto_1%TYPE,
	SN_octeto_3		   OUT NOCOPY aip_ip_to.octeto_1%TYPE,
	SN_octeto_4		   OUT NOCOPY aip_ip_to.octeto_1%TYPE,
	SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Función">
   <Elemento
      Nombre = "AIP_PorTecApnEstado_FN"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtiene IP por tecnologia,apn y estado disponible</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_tecnologia"  Tipo="CARACTER">Código de tecnología</param>
            <param nom="EN_cod_apn"  Tipo="NUMERICO">Código que identifica el apn</param>
            <param nom="EN_cod_estado_ip"  Tipo="NUMERICO">Código del estado de la ip </param>
         </Entrada>
         <Salida>
            <param nom="SN_octeto_1"       Tipo="NUMERICO">Primer octeto de Ip</param>
            <param nom="SN_octeto_2"       Tipo="NUMERICO">Segundo octeto de Ip</param>
            <param nom="SN_octeto_3"       Tipo="NUMERICO">Tercer octeto de Ip</param>
            <param nom="SN_octeto_4"       Tipo="NUMERICO">Cuarto octeto de Ip</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
    V_des_error      ge_errores_pg.DesEvent;
    sSql             ge_errores_pg.vQuery;
BEGIN

   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= '0';
   SN_octeto_1:=NULL;
   SN_octeto_2:=NULL;
   SN_octeto_3:=NULL;
   SN_octeto_4:=NULL;

   sSql:='SELECT a.octeto_1, a.octeto_2, a.octeto_3, a.octeto_4 '||
         'INTO SN_octeto_1,SN_octeto_2,SN_octeto_3,SN_octeto_4 '||
      	 ' FROM  aip_ip_to a '||
         ' WHERE a.octeto_1> = '||CN_cero||
         ' AND a.octeto_2 >= '||CN_cero||
         ' AND a.octeto_3 >= '||CN_cero||
         ' AND a.octeto_4 >= '||CN_cero||
         ' AND a.cod_tecnologia = '''||EV_cod_tecnologia||''||
         ' AND a.cod_apn = '||EN_cod_apn||
         ' AND a.cod_estado_ip = '||EN_cod_estado_ip||
         ' AND a.cod_tipo_ip='||EN_tipo_ip ||
         ' AND a.cod_qos='||EN_cod_qos ||
         ' AND ROWNUM<2;';

   SELECT a.octeto_1, a.octeto_2, a.octeto_3, a.octeto_4
     INTO SN_octeto_1,SN_octeto_2,SN_octeto_3,SN_octeto_4
     FROM  aip_ip_to a
    WHERE a.octeto_1 >= CN_cero
	  AND a.octeto_2 >= CN_cero
	  AND a.octeto_3 >= CN_cero
	  AND a.octeto_4 >= CN_cero
	  AND a.cod_tecnologia = EV_cod_tecnologia
	  AND a.cod_apn = EN_cod_apn
	  AND a.cod_estado_ip = EN_cod_estado_ip
      AND a.cod_tipo_ip=EN_tipo_ip
      AND a.cod_qos=EN_cod_qos
	  AND ROWNUM < 2;
   RETURN TRUE;

EXCEPTION
   WHEN  NO_DATA_FOUND THEN
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno:=410;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_portecapnestado_fn('''||EV_cod_tecnologia||''','||EN_cod_apn||','||EN_cod_estado_ip||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_portecapnestado_fn', sSql, SN_cod_retorno, V_des_error );
	  RETURN FALSE ;

END aip_portecapnestado_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION aip_rangoportecapn_fn (
    EV_cod_tecnologia IN  aip_ip_to.cod_tecnologia%TYPE,
   	EN_cod_apn 		  IN  aip_ip_to.cod_apn%TYPE,
    EN_tipo_ip        IN aip_apn_to.tipo_ip%TYPE,
    EN_cod_qos        IN aip_apn_to.cod_qos%TYPE,
	SN_cod_rangoip    OUT NOCOPY   aip_rangoipta_to.cod_rangoip%TYPE,
	SN_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
    SN_num_evento     OUT NOCOPY   ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Función">
   <Elemento
      Nombre = "AIP_RangoPorTecApn_FN"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtiene Rango de IP por tecnologia y apn</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_tecnologia"  Tipo="CARACTER">Código de tecnología</param>
            <param nom="EN_cod_apn"  Tipo="NUMERICO">Código que identifica el apn</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_rangoip"     Tipo="NUMERICO">Código del rango de ip</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
    V_des_error         ge_errores_pg.DesEvent;
    sSql             ge_errores_pg.vQuery;
BEGIN

   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= '0';
   SN_cod_rangoip:=NULL;

   sSql:=' SELECT a.cod_rangoip ';
   sSql:= sSql||' FROM aip_rangoipta_to a, aip_apn_to b ';
   sSql:= sSql||'      WHERE a.cod_tecnologia ='|| EV_cod_tecnologia;
   sSql:= sSql||'      AND b.cod_apn='||EN_cod_apn;
   sSql:= sSql||'      AND b.tipo_ip='||EN_tipo_ip;
   sSql:= sSql||'      AND b.cod_qos='||EN_cod_qos;
   sSql:= sSql||'      AND a.cod_apn=b.cod_apn';
   sSql:= sSql||'      AND ROWNUM=1';


    SELECT a.cod_rangoip
    INTO SN_cod_rangoip
    FROM aip_rangoipta_to a, aip_apn_to b
    WHERE a.cod_tecnologia = EV_cod_tecnologia
    AND b.cod_apn=EN_cod_apn
    AND b.tipo_ip=EN_tipo_ip
    AND b.cod_qos=EN_cod_qos
    AND a.cod_apn=b.cod_apn
    AND ROWNUM=1;



   RETURN TRUE;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '455';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_rangoportecapn_fn(); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_rangoportecapn_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;
   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error:='aip_rangoportecapn_fn('''||EV_cod_tecnologia||''','||EN_cod_apn||');-' || SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_rangoportecapn_fn', sSql, SN_cod_retorno, V_des_error );
      RETURN FALSE ;
END aip_rangoportecapn_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION aip_ingresa_historico_fn(
    EN_octeto_1      IN        aip_ip_to.octeto_1%TYPE,
	EN_octeto_2      IN        aip_ip_to.octeto_2%TYPE,
	EN_octeto_3      IN        aip_ip_to.octeto_3%TYPE,
	EN_octeto_4      IN        aip_ip_to.octeto_4%TYPE,
    SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
)
RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "AIP_INGRESA_HISTORICO_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Ingresa Rango a Historico</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_octeto_1" Tipo="NUMERICO">Octeto Incial 1</param>
            <param nom="EN_octeto_3" Tipo="NUMERICO">Octeto Incial 2</param>
            <param nom="EN_octeto_3" Tipo="NUMERICO">Octeto Incial 3</param>
            <param nom="EN_octeto_4" Tipo="NUMERICO">Octeto Incial 4</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error  ge_errores_pg.DesEvent;
   sSql         ge_errores_pg.vQuery;
   LN_num_celular aip_ip_to.num_celular%type;
   LN_cod_estado_ip aip_ip_to.cod_estado_ip%type;
   LN_cod_apn aip_ip_to.cod_apn%type;
BEGIN

    SN_cod_retorno :=  0;
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

	sSql := 'SELECT a.octeto_1,a.octeto_2,a.octeto_3,a.octeto_4,SYSDATE,a.num_celular,user,a.cod_estado_ip,a.cod_apn';
	sSql := sSql || ' FROM aip_ip_to a';
	sSql := sSql || ' WHERE a.octeto_1 = '||EN_octeto_1;
	sSql := sSql || ' AND a.octeto_2 = '||EN_octeto_2;
	sSql := sSql || ' AND a.octeto_3 = '||EN_octeto_3;
	sSql := sSql || ' AND a.octeto_4 = '||EN_octeto_4;
	SELECT a.num_celular,a.cod_estado_ip,a.cod_apn
    INTO LN_num_celular, LN_cod_estado_ip, LN_cod_apn
	FROM aip_ip_to a
	WHERE a.octeto_1 = EN_octeto_1
	AND a.octeto_2 = EN_octeto_2
	AND a.octeto_3 = EN_octeto_3
	AND a.octeto_4 = EN_octeto_4;

    sSql := 'INSERT INTO aip_ip_th (OCTETO_1,OCTETO_2,OCTETO_3,OCTETO_4,FECHA_MOVIMIENTO,NUM_CELULAR,USUARIO,COD_ESTADO_IP,COD_APN)';
    sSql := sSql || ' VALUES('||EN_octeto_1||','||EN_octeto_2||','||EN_octeto_3||','||EN_octeto_4||','||sysdate||','||LN_num_celular||','||user||','||LN_cod_estado_ip||','|| LN_cod_apn||' )';
	RETURN TRUE;

EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno := '156';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_ingresa_historico_pr('||EN_octeto_1||','||EN_octeto_2||','||EN_octeto_3||','||EN_octeto_4||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_ingresa_historico_pr', sSql, SQLCODE, V_des_error );
      RETURN FALSE;
END aip_ingresa_historico_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION aip_recupera_info_rangoip_fn (
    EN_cod_rangoip      IN aip_rangoipta_to.cod_rangoip%TYPE,
    SN_octeto_1	   	   OUT NOCOPY aip_rangoipta_to.octeto_ini_1%TYPE,
    SN_octeto_2		   OUT NOCOPY aip_rangoipta_to.octeto_ini_2%TYPE,
    SN_octeto_3		   OUT NOCOPY aip_rangoipta_to.octeto_ini_3%TYPE,
    SN_octeto_4		   OUT NOCOPY aip_rangoipta_to.octeto_ini_4%TYPE,
	SN_octeto_fin_1	   OUT NOCOPY aip_rangoipta_to.octeto_fin_1%TYPE,
	SN_octeto_fin_2	   OUT NOCOPY aip_rangoipta_to.octeto_fin_2%TYPE,
	SN_octeto_fin_3	   OUT NOCOPY aip_rangoipta_to.octeto_fin_3%TYPE,
	SN_octeto_fin_4	   OUT NOCOPY aip_rangoipta_to.octeto_fin_4%TYPE,
	SN_cod_tipo_ip	   OUT NOCOPY aip_apn_to.tipo_ip%TYPE,
	SN_cod_apn	   	   OUT NOCOPY aip_apn_to.cod_apn%TYPE,
	SN_cod_qos 	   	   OUT NOCOPY aip_apn_to.cod_qos%TYPE,
	SV_cod_tecnologia  OUT NOCOPY aip_rangoipta_to.cod_tecnologia%TYPE,
	SN_cod_producto	   OUT NOCOPY aip_apn_to.cod_producto%TYPE,
	SV_cod_servicio	   OUT NOCOPY aip_apn_to.cod_servicio%TYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
)
RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "AIP_RECUPERA_INFO_RANGOIP_FN"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recuperar informacion de un Rango de Ip</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_rangoip" Tipo="CARACTER">Codigo de Rango IP</param>
         </Entrada>
         <Salida>
            <param nom="SN_octeto_1" Tipo="NUMERICO">Octeto Incial 1</param>
            <param nom="SN_octeto_2" Tipo="NUMERICO">Octeto Incial 2</param>
            <param nom="SN_octeto_3" Tipo="NUMERICO">Octeto Incial 3</param>
            <param nom="SN_octeto_4" Tipo="NUMERICO">Octeto Incial 4</param>
            <param nom="SN_octeto_fin_1" Tipo="NUMERICO">Octeto Final 1</param>
            <param nom="SN_octeto_fin_2" Tipo="NUMERICO">Octeto Final 2</param>
            <param nom="SN_octeto_fin_3" Tipo="NUMERICO">Octeto Final 3</param>
            <param nom="SN_octeto_fin_4" Tipo="NUMERICO">Octeto Final 4</param>
            <param nom="SN_cod_tipo_ip" Tipo="NUMERICO">Tipo IP</param>
            <param nom="SN_cod_apn" Tipo="NUMERICO">Codigo APN</param>
            <param nom="SN_cod_qos" Tipo="NUMERICO">Codigo QOS</param>
            <param nom="SV_cod_tecnologia" Tipo="CARACTER">Tecnologia</param>
            <param nom="SN_cod_producto" Tipo="NUMERICO">Producto</param>
            <param nom="SV_cod_servicio" Tipo="CARACTER">Codigo de Servicio</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error  ge_errores_pg.DesEvent;
   sSql         ge_errores_pg.vQuery;
BEGIN

    SN_cod_retorno :=  0;
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

	sSql := 'SELECT a.octeto_ini_1,a.octeto_ini_2,a.octeto_ini_3,a.octeto_ini_4,';
	sSql := sSql || ' a.octeto_fin_3,a.octeto_fin_4,b.tipo_ip,b.cod_apn,b.cod_qos,';
	sSql := sSql || ' a.cod_tecnologia,b.cod_producto,b.cod_servicio';
	sSql := sSql || ' INTO sn_octeto_1,sn_octeto_2,sn_octeto_3,sn_octeto_4,';
	sSql := sSql || ' sn_octeto_fin_3,sn_octeto_fin_4,sn_cod_tipo_ip,sn_cod_apn,sn_cod_qos,';
	sSql := sSql || ' sv_cod_tecnologia,sn_cod_producto,sv_cod_servicio';
	sSql := sSql || ' FROM aip_rangoipta_to a, aip_apn_to b';
	sSql := sSql || ' WHERE a.cod_rangoip = '||EN_cod_rangoip;
	sSql := sSql || ' AND a.cod_apn = b.cod_apn;';

    SELECT a.octeto_ini_1,a.octeto_ini_2,a.octeto_ini_3,a.octeto_ini_4, a.octeto_fin_3,a.octeto_fin_4,b.tipo_ip,b.cod_apn,b.cod_qos,
		   a.cod_tecnologia,b.cod_producto,b.cod_servicio
	  INTO sn_octeto_1,sn_octeto_2,sn_octeto_3,sn_octeto_4, sn_octeto_fin_3,sn_octeto_fin_4,sn_cod_tipo_ip,sn_cod_apn,sn_cod_qos,
		   sv_cod_tecnologia,sn_cod_producto,sv_cod_servicio
	  FROM aip_rangoipta_to a, aip_apn_to b
	 WHERE a.cod_rangoip = EN_cod_rangoip
	   AND a.cod_apn = b.cod_apn;

    RETURN TRUE;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := '455';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_recupera_info_rangoip_fn('||EN_cod_rangoip||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_recupera_info_rangoip_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := '156';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_recupera_info_rangoip_fn('||EN_cod_rangoip||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_recupera_info_rangoip_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

END aip_recupera_info_rangoip_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION aip_recupera_parametros_fn (
    EV_nom_parametro IN      ged_parametros.nom_parametro%TYPE,
    EV_cod_modulo    IN      ged_parametros.cod_modulo%TYPE,
    EN_cod_producto  IN      ged_parametros.cod_producto%TYPE,
    SV_val_parametro OUT     NOCOPY ged_parametros.val_parametro%TYPE,
    SN_cod_retorno   OUT     NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno  OUT     NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento    OUT     NOCOPY ge_errores_pg.Evento
)
RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "AIP_RECUPERA_PARAMETROS_FN"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Recuperar parametros de sistema</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_nom_parametro" Tipo="CARACTER">Nombre del Parametro</param>
            <param nom="EV_cod_modulo"    Tipo="CARACTER">Codigo de Modulo</param>
            <param nom="EN_cod_producto"  Tipo="NUMERICO">Codigo de Producto</param>
         </Entrada>
         <Salida>
            <param nom="SV_val_parametro" Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error  ge_errores_pg.DesEvent;
   sSql         ge_errores_pg.vQuery;
BEGIN

   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= '0';

   sSql := 'SELECT param.val_parametro';
   sSql := sSql || ' INTO EV_val_parametro';
   sSql := sSql || ' FROM ged_parametros param';
   sSql := sSql || ' WHERE nom_parametro = '|| EV_nom_parametro;
   sSql := sSql || ' AND cod_modulo = '|| EV_cod_modulo;
   sSql := sSql || ' AND cod_producto = '|| EN_cod_producto;

   SELECT param.val_parametro
     INTO SV_val_parametro
     FROM ged_parametros param
    WHERE nom_parametro = EV_nom_parametro
      AND cod_modulo = EV_cod_modulo
      AND cod_producto = EN_cod_producto;

   RETURN TRUE;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := '215';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_recupera_parametros_fn('|| EV_nom_parametro||', '||EV_cod_modulo||', '||EN_cod_producto||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_recupera_parametros_fn', sSql, SQLCODE, V_des_error );

      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := '442';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_recupera_parametros_fn('|| EV_nom_parametro||', '||EV_cod_modulo||', '||EN_cod_producto||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_recupera_parametros_fn', sSql, SQLCODE, V_des_error );

      RETURN FALSE;

END aip_recupera_parametros_FN;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_modificaparametro_pr(
   ev_nom_parametro  IN              ged_parametros.nom_parametro%TYPE,
   ev_val_parametro  IN              ged_parametros.val_parametro%TYPE,
   sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
   sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
   sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_MODIFICAPARAMETRO_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Procedimiento que modifica el valor de un parametro</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="ev_nom_parametro"  Tipo="NUMERICO">Nombre del parametro</param>
            <param nom="ev_val_parametro"  Tipo="NUMERICO">Valor del parametro</param>
         </Entrada>
         <Salida>
            <param nom="sn_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="sv_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="sn_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   errro_modparam   EXCEPTION;
BEGIN

   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= '0';

   sSql := 'SELECT a.val_parametro INTO sv_val_parametro FROM GED_PARAMETROS a WHERE a.cod_modulo = '
        || cv_modulo||' AND a.cod_producto = '||cn_cod_producto||' AND a.nom_parametro = '||ev_nom_parametro;

   UPDATE ged_parametros
      SET val_parametro = ev_val_parametro
    WHERE cod_modulo = cv_modulo
      AND cod_producto = cn_cod_producto
      AND nom_parametro = ev_nom_parametro;

   IF SQL%ROWCOUNT <= cn_cero THEN
      RAISE errro_modparam;
   END IF;

EXCEPTION
   WHEN errro_modparam THEN
      SN_cod_retorno := 424;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modificaparametro_pr('||ev_nom_parametro||', '||ev_val_parametro||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modificaparametro_pr', sSql, SN_cod_retorno, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 442;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modificaparametro_pr('||ev_nom_parametro||', '||ev_val_parametro||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modificaparametro_pr', sSql, SN_cod_retorno, V_des_error );

END aip_modificaparametro_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_ingresa_apn_pr(
   ev_des_apn        IN              aip_apn_to.des_apn%TYPE,
   en_tipo_ip        IN              aip_apn_to.tipo_ip%TYPE,
   ev_dns            IN              aip_apn_to.dns%TYPE,
   ev_vigencia       IN              aip_apn_to.vigencia%TYPE,
   en_cod_qos        IN              aip_apn_to.cod_qos%TYPE,
   en_cod_producto   IN              aip_apn_to.cod_producto%TYPE,
   ev_cod_servicio   IN              aip_apn_to.cod_servicio%TYPE,
   en_cod_tecnologia IN              aip_apn_to.cod_tecnologia%TYPE,
   sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
   sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
   sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_INGRESA_APN_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Procedimiento que agrega un registro APN</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="ev_des_apn"           Tipo="CARACTER">Descripción del APN</param>
            <param nom="en_tipo_ip"           Tipo="NUMERICO">Tipo de IP (Fija / Dinamica)</param>
            <param nom="ev_dns"               Tipo="CARACTER">DNS del APN, que podría ser una IP u el nombre del servidor</param>
            <param nom="ev_vigencia"          Tipo="CARACTER">Vigencia del APN</param>
            <param nom="en_cod_qos"           Tipo="NUMERICO">Código que identifica al QoS</param>
            <param nom="en_cod_producto"      Tipo="NUMERICO">Código que identifica la producto, en este caso celular</param>
            <param nom="ev_cod_servicio"      Tipo="CARACTER">Código de servicio suplementario</param>
            <param nom="en_cod_tecnologia"    Tipo="NUMERICO">Código que identifica a la tecnologia</param>
         </Entrada>
         <Salida>
            <param nom="sn_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="sv_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="sn_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   n_cod_apn        aip_apn_to.cod_apn%TYPE;
BEGIN

   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   sSql := 'SELECT aip_apn_sq.NEXTVAL INTO n_cod_apn FROM dual';

   SELECT aip_apn_sq.NEXTVAL
     INTO n_cod_apn
     FROM dual;

   sSql := 'INSERT INTO aip_apn_to (cod_apn,des_apn,tipo_ip,dns,vigencia,usuario,fecha_movimiento,cod_qos,cod_producto,cod_servicio,cod_tecnologia) VALUES'
        || '('||n_cod_apn||', '||EV_des_apn||', '||EN_tipo_ip||', '||EV_dns||', '||EV_vigencia||', '||USER||', '||SYSDATE||', '||EN_cod_qos||', '
        || EN_cod_producto||', '||EV_cod_servicio||', '||EN_cod_tecnologia||')';

   INSERT INTO aip_apn_to
               (cod_apn, des_apn, tipo_ip, dns, vigencia, usuario, fecha_movimiento, cod_qos, cod_producto, cod_servicio, cod_tecnologia)
        VALUES (n_cod_apn, ev_des_apn, en_tipo_ip, ev_dns, ev_vigencia, USER, SYSDATE, en_cod_qos, en_cod_producto, ev_cod_servicio, en_cod_tecnologia);

EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno := 434;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_ingresa_apn_pr('||ev_des_apn||', '||en_tipo_ip||', '||ev_dns||', '||ev_vigencia||', '||en_cod_qos||', '||en_cod_producto||', '||ev_cod_servicio||', '||en_cod_tecnologia||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_ingresa_apn_pr', sSql, SN_cod_retorno, V_des_error );

END aip_ingresa_apn_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_modifica_apn_pr(
   en_cod_apn        IN              aip_apn_to.cod_apn%TYPE,
   ev_des_apn        IN              aip_apn_to.des_apn%TYPE,
   en_tipo_ip        IN              aip_apn_to.tipo_ip%TYPE,
   ev_dns            IN              aip_apn_to.dns%TYPE,
   ev_vigencia       IN              aip_apn_to.vigencia%TYPE,
   en_cod_qos        IN              aip_apn_to.cod_qos%TYPE,
   en_cod_producto   IN              aip_apn_to.cod_producto%TYPE,
   ev_cod_servicio   IN              aip_apn_to.cod_servicio%TYPE,
   en_cod_tecnologia IN              aip_apn_to.cod_tecnologia%TYPE,
   sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
   sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
   sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_MODIFICA_APN_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. - "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Procedimiento que modififca un registro APN</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="en_cod_apn"           Tipo="CARACTER">Código que identifica al APN</param>
            <param nom="ev_des_apn"           Tipo="CARACTER">Descripción del APN</param>
            <param nom="en_tipo_ip"           Tipo="NUMERICO">Tipo de IP (Fija / Dinamica)</param>
            <param nom="ev_dns"               Tipo="CARACTER">DNS del APN, que podría ser una IP u el nombre del servidor</param>
            <param nom="ev_vigencia"          Tipo="CARACTER">Vigencia del APN</param>
            <param nom="en_cod_qos"           Tipo="NUMERICO">Código que identifica al QoS</param>
            <param nom="en_cod_producto"      Tipo="NUMERICO">Código que identifica la producto, en este caso celular</param>
            <param nom="ev_cod_servicio"      Tipo="CARACTER">Código de servicio suplementario</param>
            <param nom="en_cod_tecnologia"    Tipo="NUMERICO">Código que identifica a la tecnologia</param>
         </Entrada>
         <Salida>
            <param nom="sn_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="sv_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="sn_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error        ge_errores_pg.DesEvent;
   sSql               ge_errores_pg.vQuery;
   error_modapiapn    EXCEPTION;
   error_cantidadips  EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   sSql := 'SELECT COUNT(1) INTO ln_cantidad FROM aip_ip_to a WHERE a.cod_apn = '||en_cod_apn;

   SELECT COUNT(1)
     INTO LN_cantidad
     FROM aip_ip_to a
    WHERE a.cod_apn = en_cod_apn;

   IF LN_cantidad = CN_cero THEN
      sSql := 'UPDATE aip_apn_to SET des_apn = '||ev_des_apn||', tipo_ip = '||en_tipo_ip||', dns = '||ev_dns||', vigencia = '
           || ev_vigencia||', usuario = '||USER||', fecha_movimiento = '||SYSDATE||', cod_qos = '||EN_cod_qos||', cod_producto = '
           || EN_cod_producto||', cod_servicio = '||EV_cod_servicio||', cod_tecnologia = '||EN_cod_tecnologia||' WHERE cod_apn = '||EN_cod_apn;

      UPDATE aip_apn_to
         SET des_apn = ev_des_apn,
             tipo_ip = en_tipo_ip,
             dns = ev_dns,
             vigencia = ev_vigencia,
             usuario = USER,
             fecha_movimiento = SYSDATE,
             cod_qos = en_cod_qos,
             cod_producto = en_cod_producto,
             cod_servicio = ev_cod_servicio,
             cod_tecnologia = en_cod_tecnologia
       WHERE cod_apn = en_cod_apn;

      IF SQL%ROWCOUNT <= CN_cero THEN
         RAISE error_modapiapn;
      END IF;

   ELSE
      RAISE error_cantidadips;
   END IF;

EXCEPTION
   WHEN error_modapiapn THEN
      SN_cod_retorno := 424;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modifica_apn_pr('||en_cod_apn||', '||ev_des_apn||', '||en_tipo_ip||', '||ev_dns||', '||ev_vigencia||', '||en_cod_qos||', '||en_cod_producto||', '||ev_cod_servicio||', '||en_cod_tecnologia||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modifica_apn_pr', sSql, SN_cod_retorno, V_des_error );

   WHEN error_cantidadips THEN
      SN_cod_retorno := 457;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modifica_apn_pr('||en_cod_apn||', '||ev_des_apn||', '||en_tipo_ip||', '||ev_dns||', '||ev_vigencia||', '||en_cod_qos||', '||en_cod_producto||', '||ev_cod_servicio||', '||en_cod_tecnologia||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modifica_apn_pr', sSql, SN_cod_retorno, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 434;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modifica_apn_pr('||en_cod_apn||', '||ev_des_apn||', '||en_tipo_ip||', '||ev_dns||', '||ev_vigencia||', '||en_cod_qos||', '||en_cod_producto||', '||ev_cod_servicio||', '||en_cod_tecnologia||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modifica_apn_pr', sSql, SN_cod_retorno, V_des_error );

END aip_modifica_apn_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_elimina_apn_pr(
   en_cod_apn        IN              aip_apn_to.cod_apn%TYPE,
   sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
   sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
   sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_ELIMINA_APN_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Procedimiento que elimina un registro APN</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="en_cod_apn"        Tipo="CARACTER">Código que identifica al APN</param>
         </Entrada>
         <Salida>
            <param nom="sn_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="sv_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="sn_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error        ge_errores_pg.DesEvent;
   sSql               ge_errores_pg.vQuery;
   error_delapiapn    EXCEPTION;
   error_cantidadips  EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   sSql := 'SELECT COUNT(1) INTO ln_cantidad FROM aip_ip_to a WHERE a.cod_apn = '||en_cod_apn;

   SELECT COUNT(1)
     INTO LN_cantidad
     FROM aip_ip_to a
    WHERE a.cod_apn = en_cod_apn;

   IF LN_cantidad = CN_cero THEN

      sSql := 'DELETE aip_apn_to WHERE cod_apn = EN_cod_apn;';

      DELETE aip_apn_to
	  WHERE cod_apn = EN_cod_apn;

      IF SQL%ROWCOUNT <= cn_cero THEN
         RAISE error_delapiapn;
      END IF;

   ELSE
      RAISE error_cantidadips;
   END IF;

EXCEPTION
   WHEN error_delapiapn THEN
      SN_cod_retorno := 431;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_elimina_apn_pr('||en_cod_apn||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_elimina_apn_pr', sSql, SN_cod_retorno, V_des_error );

   WHEN error_cantidadips THEN
      SN_cod_retorno := 417;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_elimina_apn_pr('||en_cod_apn||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_elimina_apn_pr', sSql, SN_cod_retorno, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 434;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_elimina_apn_pr('||en_cod_apn||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_elimina_apn_pr', sSql, SN_cod_retorno, V_des_error );

END aip_elimina_apn_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_ingresa_qos_pr(
   ev_componentes_qos IN              aip_qos_to.componentes_qos%TYPE,
   ev_des_qos         IN              aip_qos_to.des_qos%TYPE,
   ev_vigencia        IN              aip_qos_to.vigencia%TYPE,
   en_eqosid          IN              aip_qos_to.eqosid%TYPE,
   sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
   sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
   sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_INGRESA_APN_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. -"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Procedimiento que agrega un registro Qos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="ev_componentes_qos"  Tipo="CARACTER">Componentes del QoS</param>
            <param nom="ev_des_qos"          Tipo="CARACTER">Descripcón del Qos</param>
            <param nom="ev_vigencia"         Tipo="CARACTER">Vigencia del QoS</param>
            <param nom="en_eqosid"           Tipo="NUMERICO">ID del Qos</param>
         </Entrada>
         <Salida>
            <param nom="sn_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="sv_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="sn_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   n_cod_qos        aip_qos_to.cod_qos%TYPE;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   sSql := 'SELECT aip_qos_sq.NEXTVAL INTO n_cod_qos FROM dual';

   SELECT aip_qos_sq.NEXTVAL
     INTO n_cod_qos
     FROM dual;

   sSql := 'INSERT INTO aip_qos_to (cod_qos,componentes_qos,des_qos,vigencia,eqosid,usuario,fecha_movimiento)	VALUES ('
        ||n_cod_qos||', '||EV_componentes_qos||', '||EV_des_qos||', '||EV_vigencia||', '||EN_eqosid||', '||USER||', '||SYSDATE||')';

   INSERT INTO aip_qos_to
			   (cod_qos,componentes_qos,des_qos,vigencia,eqosid,usuario,fecha_movimiento)
	    VALUES (n_cod_qos, EV_componentes_qos, EV_des_qos, EV_vigencia, EN_eqosid, USER, SYSDATE);

EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno := 438;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_ingresa_qos_pr('||ev_componentes_qos||', '||ev_des_qos||', '||ev_vigencia||', '||en_eqosid||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_ingresa_qos_pr', sSql, SN_cod_retorno, V_des_error );

END aip_ingresa_qos_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_modifica_qos_pr(
   en_cod_qos         IN              aip_qos_to.cod_qos%TYPE,
   ev_componentes_qos IN              aip_qos_to.componentes_qos%TYPE,
   ev_des_qos         IN              aip_qos_to.des_qos%TYPE,
   ev_vigencia        IN              aip_qos_to.vigencia%TYPE,
   en_eqosid          IN              aip_qos_to.eqosid%TYPE,
   sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
   sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
   sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_MODIFICA_QOS_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Procedimiento que modififca un registro Qos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="en_cod_qos"           Tipo="CARACTER">Código que identifica al QoS</param>
            <param nom="ev_componentes_qos"   Tipo="CARACTER">Componentes del QoS</param>
            <param nom="ev_des_qos"           Tipo="NUMERICO">Descripcón del Qos</param>
            <param nom="ev_vigencia           Tipo="CARACTER">Vigencia del QoS</param>
            <param nom="en_eqosid"            Tipo="CARACTER">ID del Qos</param>
         </Entrada>
         <Salida>
            <param nom="sn_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="sv_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="sn_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error        ge_errores_pg.DesEvent;
   sSql               ge_errores_pg.vQuery;
   error_modapiapn    EXCEPTION;
   error_cantidadips  EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

      sSql := 'SELECT COUNT(1) INTO ln_cantidad FROM aip_apn_to a WHERE a.cod_qos = '||en_cod_qos;

   SELECT COUNT(1)
     INTO LN_cantidad
     FROM aip_apn_to a
    WHERE a.cod_qos = en_cod_qos;

   IF LN_cantidad = CN_cero THEN
      sSql := 'UPDATE aip_qos_to SET componentes_qos = EV_componentes_qos,des_qos = EV_des_qos,vigencia = EV_vigencia,  eqosid = EN_eqosid WHERE cod_qos = EN_cod_qos;';

      UPDATE aip_qos_to
         SET componentes_qos = EV_componentes_qos,
             des_qos = EV_des_qos,
             vigencia = EV_vigencia,
             eqosid = EN_eqosid
       WHERE cod_qos = EN_cod_qos;

      IF SQL%ROWCOUNT <= CN_cero THEN
         RAISE error_modapiapn;
      END IF;

   ELSE
      RAISE error_cantidadips;
   END IF;

EXCEPTION
   WHEN error_modapiapn THEN
      SN_cod_retorno := 424;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modifica_qos_pr('||en_cod_qos||', '||ev_componentes_qos||', '||ev_des_qos||', '||ev_vigencia||', '||en_eqosid||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modifica_qos_pr', sSql, SN_cod_retorno, V_des_error );

   WHEN error_cantidadips THEN
      SN_cod_retorno := 421;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modifica_qos_pr('||en_cod_qos||', '||ev_componentes_qos||', '||ev_des_qos||', '||ev_vigencia||', '||en_eqosid||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modifica_qos_pr', sSql, SN_cod_retorno, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 438;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modifica_qos_pr('||en_cod_qos||', '||ev_componentes_qos||', '||ev_des_qos||', '||ev_vigencia||', '||en_eqosid||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modifica_qos_pr', sSql, SN_cod_retorno, V_des_error );

END aip_modifica_qos_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_elimina_qos_pr(
   en_cod_qos        IN              aip_qos_to.cod_qos%TYPE,
   sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
   sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
   sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_ELIMINA_QOS_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Procedimiento que elimina un registro Qos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="en_cod_qos"           Tipo="CARACTER">Código que identifica al QoS</param>
         </Entrada>
         <Salida>
            <param nom="sn_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="sv_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="sn_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error        ge_errores_pg.DesEvent;
   sSql               ge_errores_pg.vQuery;
   error_delapiapn    EXCEPTION;
   error_cantidadips  EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   sSql := 'SELECT COUNT(1) INTO ln_cantidad FROM aip_apn_to a WHERE a.cod_qos = '||en_cod_qos;

   SELECT COUNT(1)
     INTO LN_cantidad
     FROM aip_apn_to a
    WHERE a.cod_qos = en_cod_qos;

   IF LN_cantidad = CN_cero THEN

      sSql := 'DELETE aip_qos_to WHERE cod_qos = EN_cod_qos;';

      DELETE aip_qos_to
	   WHERE cod_qos = en_cod_qos;

      IF SQL%ROWCOUNT <= CN_cero THEN
         RAISE error_delapiapn;
      END IF;
   ELSE
      RAISE error_cantidadips;
   END IF;

EXCEPTION
   WHEN error_delapiapn THEN
      SN_cod_retorno := 431;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_elimina_qos_pr('||en_cod_qos||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_elimina_qos_pr', sSql, SN_cod_retorno, V_des_error );

   WHEN error_cantidadips THEN
      SN_cod_retorno := 418;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_elimina_qos_pr('||en_cod_qos||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_elimina_qos_pr', sSql, SN_cod_retorno, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 438;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_elimina_qos_pr('||en_cod_qos||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_elimina_qos_pr', sSql, SN_cod_retorno, V_des_error );

END aip_elimina_qos_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_ingresa_estado_pr(
   ev_des_estado_ip  IN              aip_estado_ip_to.des_estado_ip%TYPE,
   ev_vigencia       IN              aip_estado_ip_to.vigencia%TYPE,
   sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
   sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
   sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_ELIMINA_QOS_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Procedimiento que agrega un registro de estados</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="ev_des_estado_ip"     Tipo="CARACTER">Descripción del estado</param>
            <param nom="ev_vigencia"          Tipo="CARACTER">Vigencia del estado</param>
         </Entrada>
         <Salida>
            <param nom="sn_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="sv_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="sn_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   n_cod_estado_ip    aip_estado_ip_to.cod_estado_ip%TYPE;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   sSql := 'SELECT aip_estado_ip_sq.NEXTVAL INTO n_cod_estado_ip FROM dual';

   SELECT aip_estado_ip_sq.NEXTVAL
     INTO n_cod_estado_ip
     FROM dual;

   sSql := 'INSERT INTO aip_estado_ip_to (cod_estado_ip, des_estado_ip, vigencia, usuario, fecha_movimiento) VALUE  ('
        ||n_cod_estado_ip||', '||EV_des_estado_ip||', '||EV_vigencia||', '||USER||', '||SYSDATE||')';

   INSERT INTO aip_estado_ip_to
	    	   (cod_estado_ip, des_estado_ip, vigencia, usuario, fecha_movimiento)
		VALUES (n_cod_estado_ip, ev_des_estado_ip, ev_vigencia, USER, SYSDATE);

EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno := 439;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_ingresa_estado_pr('||ev_des_estado_ip||', '||ev_vigencia||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_ingresa_estado_pr', sSql, SN_cod_retorno, V_des_error );

END aip_ingresa_estado_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_modifica_estado_pr(
    EN_cod_estado_ip  IN              aip_estado_ip_to.cod_estado_ip%TYPE,
	EV_des_estado_ip  IN              aip_estado_ip_to.des_estado_ip%TYPE,
	EV_vigencia       IN              aip_estado_ip_to.vigencia%TYPE,
    SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
    SN_num_evento     OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_MODIFICA_ESTADO_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Procedimiento que modififca un registro de estados</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="en_cod_estado_ip"     Tipo="NUMERICO">Código que identifica al Estado</param>
            <param nom="ev_des_estado_ip"     Tipo="CARACTER">Descripción del estado</param>
            <param nom="ev_vigencia"          Tipo="CARACTER">Vigencia del estado</param>
         </Entrada>
         <Salida>
            <param nom="sn_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="sv_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="sn_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error        ge_errores_pg.DesEvent;
   sSql               ge_errores_pg.vQuery;
   error_modapiapn    EXCEPTION;
   error_cantidadips  EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   sSql := 'SELECT COUNT(1) INTO ln_cantidad FROM aip_ip_to a WHERE a.cod_estado_ip = '||en_cod_estado_ip;

   SELECT COUNT(1)
     INTO LN_cantidad
     FROM aip_ip_to a
    WHERE a.cod_estado_ip = en_cod_estado_ip;

   IF LN_cantidad = CN_cero THEN

      sSql := 'UPDATE aip_estado_ip_to SET des_estado_ip = EV_des_estado_ip,vigencia = EV_vigencia WHERE  cod_estado_ip = EN_cod_estado_ip;';

      UPDATE aip_estado_ip_to
         SET des_estado_ip = ev_des_estado_ip,
			 vigencia = ev_vigencia
	   WHERE cod_estado_ip = en_cod_estado_ip;

      IF SQL%ROWCOUNT <= CN_cero THEN
         RAISE error_modapiapn;
      END IF;

   ELSE
      RAISE error_cantidadips;
   END IF;

EXCEPTION
   WHEN error_modapiapn THEN
      SN_cod_retorno := 424;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modifica_estado_pr('||en_cod_estado_ip||', '||ev_des_estado_ip||', '||ev_vigencia||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modifica_estado_pr', sSql, SN_cod_retorno, V_des_error );

   WHEN error_cantidadips THEN
      SN_cod_retorno := 458;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modifica_estado_pr('||en_cod_estado_ip||', '||ev_des_estado_ip||', '||ev_vigencia||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modifica_estado_pr', sSql, SN_cod_retorno, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 439;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modifica_estado_pr('||en_cod_estado_ip||', '||ev_des_estado_ip||', '||ev_vigencia||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modifica_estado_pr', sSql, SN_cod_retorno, V_des_error );

END aip_modifica_estado_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_elimina_estado_pr(
    en_cod_estado_ip  IN  aip_estado_ip_to.cod_estado_ip%TYPE,
    sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    sn_num_evento     OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_ELIMINA_ESTADO_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Procedimiento que elimina un registro de estados</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="en_cod_estado_ip"     Tipo="CARACTER">Código que identifica al Estado</param>
         </Entrada>
         <Salida>
            <param nom="sn_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="sv_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="sn_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error        ge_errores_pg.DesEvent;
   sSql               ge_errores_pg.vQuery;
   error_delapiapn    EXCEPTION;
   error_cantidadips  EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   sSql := 'SELECT COUNT(1) INTO ln_cantidad FROM aip_ip_to a WHERE a.cod_estado_ip = '||en_cod_estado_ip;

   SELECT COUNT(1)
     INTO LN_cantidad
     FROM aip_ip_to a
    WHERE a.cod_estado_ip = en_cod_estado_ip;

   IF LN_cantidad = CN_cero THEN

      sSql := 'DELETE aip_estado_ip_to WHERE cod_estado_ip = '||en_cod_estado_ip;

      DELETE aip_estado_ip_to
       WHERE cod_estado_ip = en_cod_estado_ip;

      IF SQL%ROWCOUNT <= cn_cero THEN
         RAISE error_delapiapn;
      END IF;

   ELSE
      RAISE error_cantidadips;
   END IF;

EXCEPTION
   WHEN error_delapiapn THEN
      SN_cod_retorno := 431;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_elimina_estado_pr('||en_cod_estado_ip||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_elimina_estado_pr', sSql, SN_cod_retorno, V_des_error );

   WHEN error_cantidadips THEN
      SN_cod_retorno := 419;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_elimina_estado_pr('||en_cod_estado_ip||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_elimina_estado_pr', sSql, SN_cod_retorno, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 439;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_elimina_estado_pr('||en_cod_estado_ip||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_elimina_estado_pr', sSql, SN_cod_retorno, V_des_error );

END aip_elimina_estado_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_ingresa_rangoip_pr(
     EN_octeto_ini_1   IN aip_rangoipta_to.octeto_ini_1%TYPE,
	 EN_octeto_ini_2   IN aip_rangoipta_to.octeto_ini_2%TYPE,
	 EN_octeto_ini_3   IN aip_rangoipta_to.octeto_ini_3%TYPE,
	 EN_octeto_ini_4   IN aip_rangoipta_to.octeto_ini_4%TYPE,
	 EN_octeto_fin_1   IN aip_rangoipta_to.octeto_fin_1%TYPE,
	 EN_octeto_fin_2   IN aip_rangoipta_to.octeto_fin_2%TYPE,
	 EN_octeto_fin_3   IN aip_rangoipta_to.octeto_fin_3%TYPE,
	 EN_octeto_fin_4   IN aip_rangoipta_to.octeto_fin_4%TYPE,
	 EN_cod_apn        IN aip_rangoipta_to.cod_apn%TYPE,
	 EV_cod_tecnologia IN aip_rangoipta_to.cod_tecnologia%TYPE,
  	 EB_disponibilizar IN VARCHAR2,
	 SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
     SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
     SN_num_evento     OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_INGRESA_RANGOIP_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Ingresa Rango</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_octeto_ini_1" Tipo="NUMERICO">Octeto Inicial 1</param>
            <param nom="EN_octeto_ini_2" Tipo="NUMERICO">Octeto Inicial 2</param>
            <param nom="EN_octeto_ini_3" Tipo="NUMERICO">Octeto Inicial 3</param>
            <param nom="EN_octeto_ini_4" Tipo="NUMERICO">Octeto Inicial 4</param>
            <param nom="EN_octeto_fin_1" Tipo="NUMERICO">Octeto Final 1</param>
            <param nom="EN_octeto_fin_2" Tipo="NUMERICO">Octeto Final 2</param>
            <param nom="EN_octeto_fin_3" Tipo="NUMERICO">Octeto Final 3</param>
            <param nom="EN_octeto_fin_4" Tipo="NUMERICO">Octeto Final 4</param>
            <param nom="EN_cod_apn" Tipo="NUMERICO">Codigo APN</param>
            <param nom="EV_cod_tecnologia" Tipo="CARACTER">Tecnologia</param>
            <param nom="EB_disponibilizar" Tipo="BOOLEANO">Indicador de Disponibilidad</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error        ge_errores_pg.DesEvent;
   sSql               ge_errores_pg.vQuery;
   LN_cod_rangoip     aip_rangoipta_to.cod_rangoip%TYPE;
   error_ejecucion	   EXCEPTION;
BEGIN

   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= '0';

   sSql := 'SELECT aip_rangoipta_sq.NEXTVAL INTO LN_cod_rangoip FROM DUAL;';

   SELECT aip_rangoipta_sq.NEXTVAL
	  INTO LN_cod_rangoip
	  FROM DUAL;

   sSql := 'INSERT INTO aip_rangoipta_to (cod_rangoip,octeto_ini_1,octeto_ini_2,octeto_ini_3,octeto_ini_4, octeto_fin_1,octeto_fin_2,octeto_fin_3,octeto_fin_4, cod_apn,cod_tecnologia,usuario,fecha_movimiento)';
   sSql := sSql || 'VALUES (LN_cod_rangoip,EN_octeto_ini_1,EN_octeto_ini_2,EN_octeto_ini_3,EN_octeto_ini_4,';
   sSql := sSql || 'EN_octeto_fin_1,EN_octeto_fin_2,EN_octeto_fin_3,EN_octeto_fin_4,';
   sSql := sSql || 'EN_cod_apn,EV_cod_tecnologia,USER,SYSDATE);';

   INSERT INTO aip_rangoipta_to
	  		   (cod_rangoip,octeto_ini_1,octeto_ini_2,octeto_ini_3,octeto_ini_4, octeto_fin_1,octeto_fin_2,octeto_fin_3,octeto_fin_4,
				cod_apn,cod_tecnologia,usuario,fecha_movimiento)
	    VALUES (LN_cod_rangoip, EN_octeto_ini_1, EN_octeto_ini_2, EN_octeto_ini_3, EN_octeto_ini_4,	EN_octeto_fin_1,EN_octeto_fin_2,EN_octeto_fin_3,EN_octeto_fin_4,
			    EN_cod_apn,EV_cod_tecnologia,USER,SYSDATE);

   IF EB_disponibilizar = 'TRUE' THEN
	  aip_disponibilizarip_pr(LN_cod_rangoip,NULL,NULL,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  	  IF SN_cod_retorno <> 0 THEN
	     RAISE error_ejecucion;
      END IF;
   END IF;

EXCEPTION
   WHEN error_ejecucion THEN
      V_des_error := 'aip_ingresa_rangoip_pr('||EN_octeto_ini_1||','||EN_octeto_ini_2||','||EN_octeto_ini_3||','||EN_octeto_ini_4||'.'||EN_octeto_fin_1||','||EN_octeto_fin_2||','||EN_octeto_fin_3||','||EN_octeto_fin_4||','||EN_cod_apn||','||EV_cod_tecnologia||','||EB_disponibilizar||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_ingresa_rangoip_pr', sSql, SQLCODE, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 437;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_ingresa_rangoip_pr('||EN_octeto_ini_1||','||EN_octeto_ini_2||','||EN_octeto_ini_3||','||EN_octeto_ini_4||'.'||EN_octeto_fin_1||','||EN_octeto_fin_2||','||EN_octeto_fin_3||','||EN_octeto_fin_4||','||EN_cod_apn||','||EV_cod_tecnologia||','||EB_disponibilizar||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_ingresa_rangoip_pr', sSql, SQLCODE, V_des_error );

END aip_ingresa_rangoip_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_modifica_rangoip_pr(
    EN_cod_rangoip    IN aip_rangoipta_to.cod_rangoip%TYPE,
	EN_octeto_ini_1   IN aip_rangoipta_to.octeto_ini_1%TYPE,
	EN_octeto_ini_2   IN aip_rangoipta_to.octeto_ini_2%TYPE,
	EN_octeto_ini_3   IN aip_rangoipta_to.octeto_ini_3%TYPE,
	EN_octeto_ini_4   IN aip_rangoipta_to.octeto_ini_4%TYPE,
	EN_octeto_fin_1   IN aip_rangoipta_to.octeto_fin_1%TYPE,
	EN_octeto_fin_2   IN aip_rangoipta_to.octeto_fin_2%TYPE,
	EN_octeto_fin_3   IN aip_rangoipta_to.octeto_fin_3%TYPE,
	EN_octeto_fin_4   IN aip_rangoipta_to.octeto_fin_4%TYPE,
	EN_cod_apn        IN aip_rangoipta_to.cod_apn%TYPE,
	EV_cod_tecnologia IN aip_rangoipta_to.cod_tecnologia%TYPE,
	EB_disponibilizar IN VARCHAR2,
    SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento     OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_MODIFICA_RANGOIP_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Modifica Rango</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_rangoip" Tipo="NUMERICO">Codigo de Ranggo IP</param>
            <param nom="EN_octeto_ini_1" Tipo="NUMERICO">Octeto Inicial 1</param>
            <param nom="EN_octeto_ini_2" Tipo="NUMERICO">Octeto Inicial 2</param>
            <param nom="EN_octeto_ini_3" Tipo="NUMERICO">Octeto Inicial 3</param>
            <param nom="EN_octeto_ini_4" Tipo="NUMERICO">Octeto Inicial 4</param>
            <param nom="EN_octeto_fin_1" Tipo="NUMERICO">Octeto Final 1</param>
            <param nom="EN_octeto_fin_2" Tipo="NUMERICO">Octeto Final 2</param>
            <param nom="EN_octeto_fin_3" Tipo="NUMERICO">Octeto Final 3</param>
            <param nom="EN_octeto_fin_4" Tipo="NUMERICO">Octeto Final 4</param>
            <param nom="EN_cod_apn" Tipo="NUMERICO">Codigo APN</param>
            <param nom="EV_cod_tecnologia" Tipo="CARACTER">Tecnologia</param>
            <param nom="EB_disponibilizar" Tipo="BOOLEANO">Indicador de Disponibilidad</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error        ge_errores_pg.DesEvent;
   sSql               ge_errores_pg.vQuery;

   error_ejecucion	   EXCEPTION;
   error_cantidadips  EXCEPTION;
   error_update	   EXCEPTION;
BEGIN

   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= '0';

   sSql := 'SELECT COUNT(1) INTO LN_cantidad FROM aip_ip_to a WHERE a.cod_rangoip = '||EN_cod_rangoip;

   SELECT COUNT(1)
     INTO LN_cantidad
	 FROM aip_ip_to a
	WHERE a.cod_rangoip = EN_cod_rangoip;

   IF LN_cantidad = CN_cero THEN

      sSql := 'UPDATE AIP_RANGOIPTA_TO SET octeto_ini_1 = EN_octeto_ini_1,octeto_ini_2 = EN_octeto_ini_2,octeto_ini_3 = EN_octeto_ini_3,octeto_ini_4 = EN_octeto_ini_4,';
      sSql := sSql  ||'octeto_fin_1 = EN_octeto_fin_1,octeto_fin_2 = EN_octeto_fin_2,octeto_fin_3 = EN_octeto_fin_3,octeto_fin_4 = EN_octeto_fin_4,cod_apn = EN_cod_apn,cod_tecnologia = EV_cod_tecnologia WHERE cod_rangoip = EN_cod_rangoip;';

      UPDATE aip_rangoipta_to
         SET octeto_ini_1 = EN_octeto_ini_1,
		     octeto_ini_2 = EN_octeto_ini_2,
   		     octeto_ini_3 = EN_octeto_ini_3,
		     octeto_ini_4 = EN_octeto_ini_4,
		     octeto_fin_1 = EN_octeto_fin_1,
		     octeto_fin_2 = EN_octeto_fin_2,
		     octeto_fin_3 = EN_octeto_fin_3,
		     octeto_fin_4 = EN_octeto_fin_4,
		     cod_apn = EN_cod_apn,
		     cod_tecnologia = EV_cod_tecnologia
	  WHERE cod_rangoip = EN_cod_rangoip;

      IF SQL%ROWCOUNT <= CN_cero THEN
         RAISE error_update;
      ELSIF EB_disponibilizar = 'TRUE' THEN
         aip_disponibilizarip_pr(EN_cod_rangoip,NULL,NULL,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
         IF SN_cod_retorno <> 0 THEN
            RAISE error_ejecucion;
         END IF;
      ELSE
         aip_indisponibilizarip_pr(EN_cod_rangoip,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
         IF SN_cod_retorno <> 0 THEN
            RAISE error_ejecucion;
         END IF;
      END IF;
   ELSE
      RAISE error_cantidadips;
   END IF;

EXCEPTION
   WHEN error_ejecucion THEN
      V_des_error := 'aip_modifica_rangoip_pr('||EN_cod_rangoip||','||EN_octeto_ini_1||','||EN_octeto_ini_2||','||EN_octeto_ini_3||','||EN_octeto_ini_4||'.'||EN_octeto_fin_1||','||EN_octeto_fin_2||','||EN_octeto_fin_3||','||EN_octeto_fin_4||','||EN_cod_apn||','||EV_cod_tecnologia||','||EB_disponibilizar||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modifica_rangoip_pr', sSql, SQLCODE, V_des_error );

   WHEN error_update THEN
      SN_cod_retorno := 424;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modifica_rangoip_pr('||EN_cod_rangoip||','||EN_octeto_ini_1||','||EN_octeto_ini_2||','||EN_octeto_ini_3||','||EN_octeto_ini_4||'.'||EN_octeto_fin_1||','||EN_octeto_fin_2||','||EN_octeto_fin_3||','||EN_octeto_fin_4||','||EN_cod_apn||','||EV_cod_tecnologia||','||EB_disponibilizar||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modifica_rangoip_pr', sSql, SQLCODE, V_des_error );

   WHEN error_cantidadips THEN
      SN_cod_retorno := 420;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modifica_rangoip_pr('||EN_cod_rangoip||','||EN_octeto_ini_1||','||EN_octeto_ini_2||','||EN_octeto_ini_3||','||EN_octeto_ini_4||'.'||EN_octeto_fin_1||','||EN_octeto_fin_2||','||EN_octeto_fin_3||','||EN_octeto_fin_4||','||EN_cod_apn||','||EV_cod_tecnologia||','||EB_disponibilizar||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modifica_rangoip_pr', sSql, SQLCODE, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 437;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modifica_rangoip_pr('||EN_cod_rangoip||','||EN_octeto_ini_1||','||EN_octeto_ini_2||','||EN_octeto_ini_3||','||EN_octeto_ini_4||'.'||EN_octeto_fin_1||','||EN_octeto_fin_2||','||EN_octeto_fin_3||','||EN_octeto_fin_4||','||EN_cod_apn||','||EV_cod_tecnologia||','||EB_disponibilizar||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modifica_rangoip_pr', sSql, SQLCODE, V_des_error );

END aip_modifica_rangoip_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_elimina_rangoip_pr(
    EN_cod_rangoip     IN aip_rangoipta_to.cod_rangoip%TYPE,
    SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento     OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_ELIMINA_RANGOIP_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Elimina Rango</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_rangoip" Tipo="NUMERICO">Codigo de Ranggo IP</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    V_des_error        ge_errores_pg.DesEvent;
    sSql               ge_errores_pg.vQuery;

	error_ejecucion	   EXCEPTION;
	error_cantidadips  EXCEPTION;
	error_delete	   EXCEPTION;
BEGIN

    SN_cod_retorno :=  0;
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

	sSql := 'SELECT COUNT(CN_uno) INTO LN_cantidad FROM aip_ip_to a	WHERE a.cod_rangoip = '||EN_cod_rangoip;

	SELECT COUNT(CN_uno)
	INTO LN_cantidad
	FROM aip_ip_to a
	WHERE a.cod_rangoip = EN_cod_rangoip;

	IF 	LN_cantidad = CN_cero THEN
        sSql := 'DELETE	aip_rangoipta_to WHERE cod_rangoip = EN_cod_rangoip;';

		DELETE	aip_rangoipta_to
		WHERE cod_rangoip = EN_cod_rangoip;

		IF SQL%ROWCOUNT <= CN_cero THEN
			RAISE error_delete;
		END IF;
	ELSE
		RAISE error_cantidadips;
	END IF;

EXCEPTION
   WHEN error_delete THEN
      SN_cod_retorno := 431;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_elimina_rangoip_pr('||EN_cod_rangoip||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_elimina_rangoip_pr', sSql, SQLCODE, V_des_error );

   WHEN error_cantidadips THEN
      SN_cod_retorno := 459;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_elimina_rangoip_pr('||EN_cod_rangoip||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_elimina_rangoip_pr', sSql, SQLCODE, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 437;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_elimina_rangoip_pr('||EN_cod_rangoip||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_elimina_rangoip_pr', sSql, SQLCODE, V_des_error );

END aip_elimina_rangoip_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_disponibilizarip_pr(
    EN_cod_rangoip     IN aip_rangoipta_to.cod_rangoip%TYPE,
	EN_cod_tipo_ip     IN aip_ip_to.cod_tipo_ip%TYPE,
	EN_cod_estado_ip   IN aip_ip_to.cod_estado_ip%TYPE,
    SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento     OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_DISPONIBILIZARIP_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Disponibiliza Rangos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_rangoip" Tipo="NUMERICO">Codigo Rango IP</param>
            <param nom="EN_cod_tipo_ip" Tipo="NUMERICO">Codigo Tipo IP</param>
            <param nom="EN_cod_estado_ip" Tipo="NUMERICO">Codigo Estado IP</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   LN_octeto 	     aip_ip_to.octeto_1%TYPE;
   LN_octeto_ant     aip_ip_to.octeto_1%TYPE;
   LN_octeto_1       aip_ip_to.octeto_1%TYPE;
   LN_octeto_2       aip_ip_to.octeto_2%TYPE;
   LN_octeto_3 	     aip_ip_to.octeto_3%TYPE;
   LN_octeto_4 	     aip_ip_to.octeto_4%TYPE;
   LN_octeto_fin_1   aip_ip_to.octeto_3%TYPE;
   LN_octeto_fin_2   aip_ip_to.octeto_4%TYPE;
   LN_octeto_fin_3   aip_ip_to.octeto_3%TYPE;
   LN_octeto_fin_4   aip_ip_to.octeto_4%TYPE;
   LN_cod_tipo_ip 	 aip_ip_to.cod_tipo_ip%TYPE;
   LN_cod_apn 	     aip_ip_to.cod_apn%TYPE;
   LN_cod_qos  	     aip_ip_to.cod_qos%TYPE;
   LN_cod_estado_ip  aip_ip_to.cod_estado_ip%TYPE;
   LV_cod_tecnologia aip_ip_to.cod_tecnologia%TYPE;
   LN_cod_rangoip    aip_ip_to.cod_rangoip%TYPE;
   LN_cod_producto   aip_ip_to.cod_producto%TYPE;
   LV_cod_servicio   aip_ip_to.cod_servicio%TYPE;
   LN_inc	  		 PLS_INTEGER;
   LN_fin	  		 PLS_INTEGER;

   TYPE TYP_octeto_3 IS TABLE OF aip_ip_to.octeto_3%TYPE  INDEX BY BINARY_INTEGER;
   TYPE TYP_octeto_4 IS TABLE OF aip_ip_to.octeto_4%TYPE  INDEX BY BINARY_INTEGER;
   C_octeto_3        TYP_octeto_3;
   C_octeto_4        TYP_octeto_4;

   V_des_error       ge_errores_pg.DesEvent;
   sSql              ge_errores_pg.vQuery;

   error_ejecucion   EXCEPTION;
BEGIN

   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= '0';

   IF EN_cod_estado_ip IS NULL THEN
      IF NOT aip_recupera_parametros_fn (CV_estado_disponible, CV_modulo, cn_cod_producto, LN_cod_estado_ip, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
         RAISE error_ejecucion;
      END IF;
   ELSE
      LN_cod_estado_ip := EN_cod_estado_ip;
   END IF;

   IF NOT aip_recupera_info_rangoip_fn(EN_cod_rangoip,LN_octeto_1,LN_octeto_2,LN_octeto_3,LN_octeto_4,LN_octeto_fin_1,LN_octeto_fin_2,LN_octeto_fin_3,LN_octeto_fin_4,LN_cod_tipo_ip,LN_cod_apn,LN_cod_qos,LV_cod_tecnologia,LN_cod_producto,LV_cod_servicio,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

   IF NOT EN_cod_tipo_ip IS NULL THEN
      LN_cod_tipo_ip := EN_cod_tipo_ip;
   END IF;

   LN_inc:=CN_cero;
   LN_octeto_ant:=LN_octeto_3;
   LN_octeto:=LN_octeto_4;

   IF LN_octeto_3 <> LN_octeto_fin_3 THEN
      FOR LN_octeto_ant IN LN_octeto_3 .. LN_octeto_fin_3 LOOP
         IF LN_octeto_ant <> LN_octeto_fin_3 THEN
            FOR LN_octeto IN LN_octeto_4 .. CN_maxocteto LOOP
               LN_inc:= LN_inc + CN_uno;
               C_octeto_3(LN_inc):= LN_octeto_ant;
               C_octeto_4(LN_inc):= LN_octeto;
            END LOOP;
         ELSE
            FOR LN_octeto IN CN_uno .. LN_octeto_fin_4 LOOP
               LN_inc:= LN_inc + CN_uno;
               C_octeto_3(LN_inc):= LN_octeto_ant;
               C_octeto_4(LN_inc):= LN_octeto;
            END LOOP;
         END IF;
      END LOOP;
   ELSE
      FOR LN_octeto IN LN_octeto_4 .. LN_octeto_fin_4 LOOP
         LN_inc:= LN_inc + CN_uno;
         C_octeto_3(LN_inc):= LN_octeto_3;
         C_octeto_4(LN_inc):= LN_octeto;
      END LOOP;
   END IF;

   LN_fin:=LN_inc;

   FOR LN_inc IN CN_uno..LN_fin LOOP

       sSql := 'INSERT INTO aip_ip_to (octeto_1, octeto_2, octeto_3, octeto_4, cod_tipo_ip, cod_apn, cod_qos, cod_estado_ip, cod_tecnologia,';
	   sSql := sSql || ' cod_rangoip, cod_producto, cod_servicio, usuario, fecha_movimiento)';
	   sSql := sSql || ' VALUES ('||ln_octeto_1||','||ln_octeto_2||','||c_octeto_3 (ln_inc)||','||c_octeto_4 (ln_inc)||','||ln_cod_tipo_ip||','||ln_cod_apn;
	   sSql := sSql || ' ,'||ln_cod_qos||','||ln_cod_estado_ip||','||lv_cod_tecnologia||','||en_cod_rangoip||','||ln_cod_producto||','||lv_cod_servicio||', USER, SYSDATE);';

       INSERT INTO aip_ip_to
                   (octeto_1, octeto_2, octeto_3, octeto_4, cod_tipo_ip, cod_apn, cod_qos, cod_estado_ip, cod_tecnologia, cod_rangoip, cod_producto,
                    cod_servicio, usuario, fecha_movimiento)
            VALUES (ln_octeto_1, ln_octeto_2, c_octeto_3 (ln_inc), c_octeto_4 (ln_inc), ln_cod_tipo_ip, ln_cod_apn, ln_cod_qos, ln_cod_estado_ip,
                    lv_cod_tecnologia, en_cod_rangoip, ln_cod_producto, lv_cod_servicio, USER, SYSDATE);
   END LOOP;

   FOR LN_inc IN CN_uno..LN_fin LOOP

       sSql := 'INSERT INTO aip_ip_th';
	   sSql := sSql || ' SELECT a.octeto_1,a.octeto_2,a.octeto_3,a.octeto_4,SYSDATE,a.num_celular,USER,a.cod_estado_ip,a.cod_apn';
	   sSql := sSql || ' FROM aip_ip_to a';
	   sSql := sSql || ' WHERE a.octeto_1 = '||LN_octeto_1;
	   sSql := sSql || ' AND a.octeto_2 = '||LN_octeto_2;
	   sSql := sSql || ' AND a.octeto_3 = '||C_octeto_3(LN_inc);
	   sSql := sSql || ' AND a.octeto_4 = '||C_octeto_4(LN_inc);

       INSERT INTO aip_ip_th
            SELECT a.octeto_1,a.octeto_2,a.octeto_3,a.octeto_4,SYSDATE,a.num_celular,USER,a.cod_estado_ip,a.cod_apn
	 	      FROM aip_ip_to a
		     WHERE a.octeto_1 = LN_octeto_1
		       AND a.octeto_2 = LN_octeto_2
		       AND a.octeto_3 = C_octeto_3(LN_inc)
		       AND a.octeto_4 = C_octeto_4(LN_inc);
	END LOOP;

EXCEPTION
   WHEN error_ejecucion THEN
      V_des_error := 'aip_disponibilizarip_pr('||EN_cod_rangoip||','||EN_cod_tipo_ip||','||EN_cod_estado_ip||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_disponibilizarip_pr', sSql, SQLCODE, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 422;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_disponibilizarip_pr('||EN_cod_rangoip||','||EN_cod_tipo_ip||','||EN_cod_estado_ip||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_disponibilizarip_pr', sSql, SQLCODE, V_des_error );

END aip_disponibilizarip_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_indisponibilizarip_pr(
    EN_cod_rangoip  IN aip_rangoipta_to.cod_rangoip%TYPE,
	SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento   OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_INDISPONIBILIZARIP_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Indisponibiliza Rango</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_rangoip" Tipo="NUMERICO">Codigo Rango IP</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
	CURSOR aip_ip(EN_cod_rangoip IN aip_rangoipta_to.cod_rangoip%TYPE)
	IS
	SELECT a.octeto_1,a.octeto_2,a.octeto_3,a.octeto_4
      FROM aip_ip_to a
	 WHERE cod_rangoip = EN_cod_rangoip;

    LN_cod_estado_ip  aip_ip_to.cod_estado_ip%TYPE;
    V_des_error       ge_errores_pg.DesEvent;
    sSql              ge_errores_pg.vQuery;

	error_ejecucion    EXCEPTION;
	error_cantidadips  EXCEPTION;
	error_delete	   EXCEPTION;

BEGIN

    SN_cod_retorno :=  0;
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

	IF NOT aip_recupera_parametros_fn (CV_estado_disponible, CV_modulo, cn_cod_producto, LN_cod_estado_ip, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
	    RAISE error_ejecucion;
	END IF;

	sSql := 'SELECT COUNT(1) INTO LN_cantidad FROM aip_ip_to a	WHERE a.cod_rangoip = '||EN_cod_rangoip||' AND a.cod_estado_ip <> '||LN_cod_estado_ip;

	SELECT COUNT(1)
	INTO LN_cantidad
	FROM aip_ip_to a
	WHERE a.cod_rangoip = EN_cod_rangoip
	AND a.cod_estado_ip <> LN_cod_estado_ip;

	IF LN_cantidad = CN_cero THEN

        IF NOT aip_recupera_parametros_fn (CV_estado_eliminado, CV_modulo, cn_cod_producto, LN_cod_estado_ip, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
	        RAISE error_ejecucion;
	    END IF;

		FOR C_aip_ip IN aip_ip(EN_cod_rangoip) LOOP

		    IF not aip_ingresa_historico_fn(C_aip_ip.octeto_1,C_aip_ip.octeto_2,C_aip_ip.octeto_3,C_aip_ip.octeto_4,SN_cod_retorno,SV_mens_retorno,SN_num_evento) then
			    RAISE error_ejecucion;
			END IF;

			sSql := 'DELETE aip_ip_to';
			sSql := sSql || ' WHERE octeto_1 = '||C_aip_ip.octeto_1;
			sSql := sSql || ' AND octeto_2 = '||C_aip_ip.octeto_2;
			sSql := sSql || ' AND octeto_3 = '||C_aip_ip.octeto_3;
			sSql := sSql || ' AND octeto_4 = '||C_aip_ip.octeto_4;

			DELETE aip_ip_to
			 WHERE octeto_1 = C_aip_ip.octeto_1
			   AND octeto_2 = C_aip_ip.octeto_2
			   AND octeto_3 = C_aip_ip.octeto_3
			   AND octeto_4 = C_aip_ip.octeto_4;

			IF SQL%ROWCOUNT <= CN_cero THEN
				RAISE error_delete;
			END IF;

		END LOOP;

	ELSE
		RAISE error_cantidadips;
	END IF;

EXCEPTION
   WHEN error_ejecucion THEN
      V_des_error := 'aip_indisponibilizarip_pr('||EN_cod_rangoip||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_indisponibilizarip_pr', sSql, SQLCODE, V_des_error );

   WHEN error_delete THEN
      SN_cod_retorno := 423;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_indisponibilizarip_pr('||EN_cod_rangoip||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_indisponibilizarip_pr', sSql, SQLCODE, V_des_error );

   WHEN error_cantidadips THEN
      SN_cod_retorno := 423;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_indisponibilizarip_pr('||EN_cod_rangoip||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_indisponibilizarip_pr', sSql, SQLCODE, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 423;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_indisponibilizarip_pr('||EN_cod_rangoip||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_indisponibilizarip_pr', sSql, SQLCODE, V_des_error );

END aip_indisponibilizarip_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_modifica_estadoips_pr(
    EN_octeto_1       IN aip_ip_to.octeto_1%TYPE,
	EN_octeto_2       IN aip_ip_to.octeto_2%TYPE,
	EN_octeto_3       IN aip_ip_to.octeto_3%TYPE,
	EN_octeto_4       IN aip_ip_to.octeto_4%TYPE,
	EN_cod_estado_ip  IN aip_ip_to.cod_estado_ip%TYPE,
	EN_num_celular    IN aip_ip_to.num_celular%TYPE,
	SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento    OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_MODIFICA_ESTADOIPS_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Modifica Estado IP</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_octeto_ini_1" Tipo="NUMERICO">Octeto Inicial 1</param>
            <param nom="EN_octeto_ini_2" Tipo="NUMERICO">Octeto Inicial 2</param>
            <param nom="EN_octeto_ini_3" Tipo="NUMERICO">Octeto Inicial 3</param>
            <param nom="EN_octeto_ini_4" Tipo="NUMERICO">Octeto Inicial 4</param>
            <param nom="EN_cod_estado_ip" Tipo="CARACTER">Estado Ip</param>
            <param nom="EN_num_celular" Tipo="BOOLEANO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    V_des_error        ge_errores_pg.DesEvent;
    sSql               ge_errores_pg.vQuery;

    error_ejecucion	   EXCEPTION;
    error_update	   EXCEPTION;

    LN_cod_estado_ip   aip_ip_to.cod_estado_ip%TYPE;
    LN_num_celular     aip_ip_to.num_celular%TYPE;

BEGIN

    SN_cod_retorno :=  0;
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';
    LN_cod_estado_ip:=NULL;


   sSql:='aip_recupera_parametros_fn('''||CV_estado_disponible||''','''||CV_modulo||''','||CN_cod_producto||')';
   IF NOT aip_recupera_parametros_fn(CV_estado_disponible,CV_modulo,CN_cod_producto,LN_cod_estado_ip,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;
   IF EN_cod_estado_ip = LN_cod_estado_ip THEN
   	   LN_num_celular := NULL;
   ELSE
   	   LN_num_celular := nvl(EN_num_celular,null);
   END IF;
    sSql := 'UPDATE aip_ip_to SET cod_estado_ip = '||EN_cod_estado_ip||',';
    sSql := sSql || ' num_celular = '||LN_num_celular;
	sSql := sSql || ' WHERE octeto_1 = '||EN_octeto_1;
	sSql := sSql || ' AND octeto_2 = '||EN_octeto_2;
	sSql := sSql || ' AND octeto_3 = '||EN_octeto_3;
	sSql := sSql || ' AND octeto_4 = '||EN_octeto_4;

	UPDATE aip_ip_to SET
		   cod_estado_ip = EN_cod_estado_ip,
		   num_celular = LN_num_celular
	 WHERE octeto_1 = EN_octeto_1
	   AND octeto_2 = EN_octeto_2
	   AND octeto_3 = EN_octeto_3
	   AND octeto_4 = EN_octeto_4;

	IF SQL%ROWCOUNT <= CN_cero THEN
		RAISE error_update;
	ELSE

	    IF not aip_ingresa_historico_fn(EN_octeto_1,EN_octeto_2,EN_octeto_3,EN_octeto_4,SN_cod_retorno,SV_mens_retorno,SN_num_evento)  THEN
		    RAISE error_ejecucion;
		END IF;
	END IF;

EXCEPTION
   WHEN error_ejecucion THEN
      V_des_error := 'aip_modifica_estadoips_pr('||EN_octeto_1||','||EN_octeto_2||','||EN_octeto_3||','||EN_octeto_4||','||EN_cod_estado_ip||','||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modifica_estadoips_pr', sSql, SQLCODE, V_des_error );

   WHEN error_update THEN
      SN_cod_retorno := 424;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modifica_estadoips_pr('||EN_octeto_1||','||EN_octeto_2||','||EN_octeto_3||','||EN_octeto_4||','||EN_cod_estado_ip||','||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_modifica_estadoips_pr', sSql, SQLCODE, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 441;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_modifica_estadoips_pr('||EN_octeto_1||','||EN_octeto_2||','||EN_octeto_3||','||EN_octeto_4||','||EN_cod_estado_ip||','||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_indisponibilizarip_pr', sSql, SQLCODE, V_des_error );

END aip_modifica_estadoips_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultaestados_pr(
    tEstado          OUT NOCOPY refCursor,
	SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento    OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTAESTADOS_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Estados</Descripción>
      <Parámetros>
         <Salida>
            <param nom="tEstado" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    V_des_error        ge_errores_pg.DesEvent;
    sSql               ge_errores_pg.vQuery;
BEGIN

   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= '0';

   sSql := 'SELECT cod_estado, des_estado FROM al_estados WHERE ind_disponibilidad = 1 AND cod_estado > 0;';

     OPEN tEstado FOR
   SELECT a.cod_estado, a.des_estado
     FROM al_estados a
    WHERE a.ind_disponibilidad = CN_uno
      AND a.cod_estado > CN_cero;

   EXCEPTION

      WHEN OTHERS THEN
         SN_cod_retorno := 443;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         V_des_error := 'aip_consultaestados_pr(); - ' || SQLERRM;
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_consultaestados_pr', sSql, SQLCODE, V_des_error );

END aip_consultaestados_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultatecnologia_pr(
    tTecnologia      OUT NOCOPY refCursor,
	SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento    OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTATECNOLOGIA_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Tecnologia</Descripción>
      <Parámetros>
         <Salida>
            <param nom="tTecnologia" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    V_des_error        ge_errores_pg.DesEvent;
    sSql               ge_errores_pg.vQuery;
BEGIN

   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= '0';

   sSql := 'SELECT cod_tecnologia, des_tecnologia, nom_usuario, cod_grupo';
   sSql := sSql || ' FROM al_tecnologia';
   sSql := sSql || ' WHERE cod_tecnologia > 0;';

     OPEN tTecnologia FOR
   SELECT a.cod_tecnologia, a.des_tecnologia, a.nom_usuario, a.cod_grupo
	 FROM al_tecnologia a;



EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno := 444;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_consultatecnologia_pr(); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_consultatecnologia_pr', sSql, SQLCODE, V_des_error );

END aip_consultatecnologia_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultasersuplement_pr(
    tSerSupl         OUT NOCOPY refCursor,
	SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento    OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTASERSUPLEMENT_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. - Jubitza Villanueva G."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Servicios Suplementarios</Descripción>
      <Parámetros>
         <Salida>
            <param nom="tSerSupl" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    V_des_error        ge_errores_pg.DesEvent;
    sSql               ge_errores_pg.vQuery;
BEGIN

    SN_cod_retorno :=  0;
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

	sSql := 'SELECT a.cod_servicio, a.des_servicio FROM  ga_servsupl a WHERE cod_producto = 1 ORDER BY a.des_servicio;';

     OPEN tSerSupl FOR
   SELECT a.cod_servicio, a.des_servicio, a.cod_producto
     FROM ga_servsupl a
    WHERE cod_producto = cn_cod_producto
    ORDER BY a.des_servicio;

EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno := 445;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_consultasersuplement_pr(); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_consultasersuplement_pr', sSql, SQLCODE, V_des_error );

END aip_consultasersuplement_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultaapiqos_pr (
    EN_vigencia       IN aip_qos_to.vigencia%TYPE,
    tApiQos          OUT NOCOPY refcursor,
	SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento    OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTAAPIQOS_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Consulta Api QoS</Descripción>
      <Parámetros>
	     <Entrada>
            <param nom="EN_vigencia" Tipo="NUMERICO">Vigencia</param>
         </Entrada>
         <Salida>
            <param nom="tApiQos" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    V_des_error        ge_errores_pg.DesEvent;
    sSql               ge_errores_pg.vQuery;
BEGIN

    SN_cod_retorno :=  0;
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

   sSql := 'SELECT  a.cod_qos, a.componentes_qos, a.des_qos, a.vigencia, a.eqosid';
   sSql := sSql || ' FROM aip_qos_to a';
   sSql := sSql || ' WHERE a.cod_qos > 0';
   sSql := sSql || ' AND a.vigencia = DECODE('||EN_vigencia||', NULL, a.vigencia, '||EN_vigencia||')';
   sSql := sSql || ' ORDER BY a.des_qos;';

     OPEN tApiQoS FOR
   SELECT a.cod_qos, a.componentes_qos, a.des_qos, a.vigencia, a.eqosid
	 FROM aip_qos_to a
 	WHERE a.cod_qos > CN_cero
	  AND a.vigencia = DECODE(EN_vigencia, NULL, a.vigencia, EN_vigencia)
	ORDER BY a.des_qos;

EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno := 446;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_consultaapiqos_pr('||EN_vigencia||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_consultaapiqos_pr', sSql, SQLCODE, V_des_error );

END aip_consultaapiqos_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultacompqos_pr(
    SC_ConQoS         OUT NOCOPY refCursor,
	SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento     OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTACOMPQOS_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Componentes QoS</Descripción>
      <Parámetros>
         <Entrada>
        </Entrada>
         <Salida>
            <param nom="SC_ConQoS"    Tipo="Cursor">Datos de los componentes QoS</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    V_des_error      ge_errores_pg.DesEvent;
    sSql             ge_errores_pg.vQuery;
BEGIN

   SN_num_evento:=CN_cero;
   SN_cod_retorno:=CN_cero;
   SV_mens_retorno:=NULL;

   sSql:='OPEN SC_ConQoS FOR '||
	     ' SELECT a.cod_valor, a.des_valor '||
		 ' FROM ged_codigos a '||
		 ' WHERE a.cod_modulo='''||CV_modulo||''||
		 ' AND a.nom_tabla='''||CV_tabla||''||
		 ' ORDER BY a.des_valor; ';

     OPEN SC_ConQoS FOR
   SELECT a.cod_valor, a.des_valor
	 FROM ged_codigos a
	WHERE a.cod_modulo = CV_modulo
	  AND a.nom_tabla = CV_tabla
	ORDER BY a.des_valor;

EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno:= 447;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno:=CV_error_no_clasif;
      END IF;
      V_des_error:='aip_consultacompqos_pr() - '||SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_consultacompqos_pr', sSql, SN_cod_retorno, V_des_error);

END aip_consultacompqos_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultaapiapn_pr(
    EV_vigencia       IN  aip_apn_to.vigencia%TYPE,
   	SC_ApiAPN         OUT NOCOPY refCursor,
	SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   	SN_num_evento     OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTAAPIAPN_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera consulta ApiAPN</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_vigencia"   Tipo="CARACTER">Indicador de vigencia</param>
        </Entrada>
         <Salida>
            <param nom="SC_ApiAPN"    Tipo="Cursor">Datos de ApiAPN</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    V_des_error         ge_errores_pg.DesEvent;
    sSql                ge_errores_pg.vQuery;
    LV_Modulo           VARCHAR2(5):='IP';
    LV_Tabla            VARCHAR2(10):='TIPO_IP';
    LV_Campo            VARCHAR2(10):='TIPO_IP';
BEGIN

   SN_num_evento:=CN_cero;
   SN_cod_retorno:=CN_cero;
   SV_mens_retorno:=NULL;

   sSql:='OPEN SC_ApiAPN FOR '||
	     ' SELECT a.cod_apn,a.des_apn,a.vigencia, a.cod_tecnologia,b.des_tecnologia,  a.cod_qos,c.des_qos,a.tipo_ip,'||
		 '	      a.cod_servicio,d.des_servicio, a.dns,a.usuario,a.fecha_movimiento,a.cod_producto '||
		 '   FROM aip_apn_to a, al_tecnologia b, aip_qos_to c, ga_servsupl d '||
		 '  WHERE a.cod_apn >'||CN_cero||
	     '	  AND a.vigencia = DECODE('''||EV_vigencia||''',NULL,a.vigencia,'''||EV_vigencia||''') '||
		 '	  AND a.cod_tecnologia = b.cod_tecnologia '||
		 '	  AND a.cod_qos = c.cod_qos '||
		 '	  AND a.cod_servicio = d.cod_servicio '||
		 '  ORDER BY a.des_apn;';

     OPEN SC_ApiAPN FOR
   SELECT a.cod_apn,a.des_apn,a.vigencia, a.cod_tecnologia,b.des_tecnologia, a.cod_qos,c.des_qos, a.tipo_ip, e.des_valor,
          a.cod_servicio,d.des_servicio, a.dns,a.usuario,a.fecha_movimiento,a.cod_producto
     FROM aip_apn_to a, al_tecnologia b, aip_qos_to c, ga_servsupl d, ged_codigos e
    WHERE a.cod_apn > CN_cero
      AND a.vigencia = DECODE(EV_vigencia,NULL,a.vigencia,EV_vigencia)
      AND e.cod_modulo=LV_Modulo
      AND e.nom_tabla=LV_Tabla
      AND e.nom_columna=LV_Campo
      AND a.tipo_ip=e.cod_valor
	  AND a.cod_tecnologia = b.cod_tecnologia
	  AND a.cod_qos = c.cod_qos
	  AND a.cod_servicio = d.cod_servicio
	ORDER BY a.des_apn;

EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno:= 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno:=CV_error_no_clasif;
      END IF;
      V_des_error:='aip_consultaapiapn_pr('''||EV_vigencia||''');-'||SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_consultaapiapn_pr', sSql, SN_cod_retorno, V_des_error);

END aip_consultaapiapn_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultaestadoip_pr(
    SC_EstadoIP     OUT NOCOPY  refCursor,
	SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento   OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTAESTADOIP_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera consulta estados Ip</Descripción>
      <Parámetros>
         <Entrada>
        </Entrada>
         <Salida>
            <param nom="SC_EstadoIP"   Tipo="Cursor">Datos de estados de ip</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    V_des_error      ge_errores_pg.DesEvent;
    sSql             ge_errores_pg.vQuery;
BEGIN

   SN_num_evento:=CN_cero;
   SN_cod_retorno:=CN_cero;
   SV_mens_retorno:=NULL;

   sSql:='OPEN SC_EstadoIP FOR '||
	     'SELECT a.cod_estado_ip, a.des_estado_ip, a.vigencia '||
	     ' FROM AIP_ESTADO_IP_TO a ';


     OPEN SC_EstadoIP FOR
   SELECT a.cod_estado_ip, a.des_estado_ip, a.vigencia
	 FROM aip_estado_ip_to a;


EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno:= 448;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno:=CV_error_no_clasif;
      END IF;
      V_des_error:='aip_consultaestadoip_pr(); - '||SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_consultaestadoip_pr', sSql, SN_cod_retorno, V_des_error);

END aip_consultaestadoip_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultarangosip_pr  (
    EN_cod_rangoip    IN aip_rangoipta_to.cod_rangoip%TYPE,
  	EV_cod_tecnologia IN aip_rangoipta_to.cod_tecnologia%TYPE,
  	EN_cod_apn        IN aip_rangoipta_to.cod_apn%TYPE,
	EV_fecha_desde    IN VARCHAR2,
	EV_fecha_hasta    IN VARCHAR2,
	EN_octeto_ini_1   IN aip_rangoipta_to.octeto_ini_1%TYPE,
	EN_octeto_ini_2   IN aip_rangoipta_to.octeto_ini_2%TYPE,
	EN_octeto_ini_3   IN aip_rangoipta_to.octeto_ini_3%TYPE,
	EN_octeto_ini_4   IN aip_rangoipta_to.octeto_ini_4%TYPE,
	EN_octeto_fin_1   IN aip_rangoipta_to.octeto_fin_1%TYPE,
	EN_octeto_fin_2   IN aip_rangoipta_to.octeto_fin_2%TYPE,
	EN_octeto_fin_3   IN aip_rangoipta_to.octeto_fin_3%TYPE,
	EN_octeto_fin_4   IN aip_rangoipta_to.octeto_fin_4%TYPE,
  	SC_RangosIP       OUT NOCOPY refCursor,
	SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento     OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTAIPSHIS_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera consulta de Rangos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_rangoip"    Tipo="NUMERICO">Código del rango de ip</param>
            <param nom="EV_cod_tecnologia" Tipo="CARACTER">Código de tecnología</param>
            <param nom="EN_cod_apn"        Tipo="NUMERICO">Código que identifica el apn</param>
            <param nom="EV_fecha_desde"    Tipo="CARACTER">Fecha desde</param>
            <param nom="EV_fecha_hasta"    Tipo="CARACTER">Fecha hasta</param>
            <param nom="EN_octeto_ini_1"   Tipo="NUMERICO">Primer octeto inicial de la ip</param>
            <param nom="EN_octeto_ini_2"   Tipo="NUMERICO">Segundo octeto inicial de la ip</param>
            <param nom="EN_octeto_ini_3"   Tipo="NUMERICO">Tercer octeto inicial de la ip</param>
            <param nom="EN_octeto_ini_4"   Tipo="NUMERICO">Cuarto octeto inicial de la ip</param>
            <param nom="EN_octeto_fin_1"   Tipo="NUMERICO">Primer octeto de la ip</param>
            <param nom="EN_octeto_fin_2"   Tipo="NUMERICO">Segundo octeto final de la ip</param>
            <param nom="EN_octeto_fin_3"   Tipo="NUMERICO">Tercer octeto final de la ip</param>
            <param nom="EN_octeto_fin_4"   Tipo="NUMERICO">Cuarto octeto final de la ip</param>
        </Entrada>
         <Salida>
            <param nom="SC_RangosIP"    Tipo="Cursor">Datos rangos de ips</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    V_des_error      ge_errores_pg.DesEvent;
    sSql             ge_errores_pg.vQuery;
BEGIN

        SN_num_evento:=CN_cero;
		SN_cod_retorno:=CN_cero;
		SV_mens_retorno:=NULL;

   sSql:='OPEN SC_RangosIP FOR '||
         ' SELECT a.cod_rangoip, '||
         ' a.octeto_ini_1,a.octeto_ini_2,a.octeto_ini_3,a.octeto_ini_4, a.octeto_fin_1,a.octeto_fin_2,a.octeto_fin_3, '||
		 ' a.octeto_fin_4, a.fecha_movimiento,a.cod_apn,b.des_apn, a.cod_tecnologia,c.des_tecnologia,a.usuario, '||
		  '(a.octeto_fin_3 - a.octeto_ini_3) + (a.octeto_fin_4 - a.octeto_ini_4) + 1 CANTIDAD, aip_disponible_fn( a.cod_rangoip ) AS DISPONIBLE '||
         '  FROM aip_rangoipta_to a, aip_apn_to b, al_tecnologia c '||
         ' WHERE a.cod_rangoip>'||CN_cero||
         '   AND a.cod_rangoip=DECODE('||EN_cod_rangoip||',NULL,a.cod_rangoip,'||EN_cod_rangoip||') '||
         '   AND a.cod_tecnologia=DECODE('''||EV_cod_tecnologia||''',NULL,a.cod_tecnologia,'''||EV_cod_tecnologia||''')'||
         '   AND a.cod_apn=DECODE('||EN_cod_apn||',NULL,a.cod_apn,'||EN_cod_apn||') '||
         '   AND  TO_CHAR(a.fecha_movimiento,''DD-MM-YYYY'')=DECODE('''||EV_fecha_desde||''',NULL,TO_CHAR(a.fecha_movimiento,''DD-MM-YYYY''),'''||EV_fecha_desde||''')'||
         '   AND  TO_CHAR(a.fecha_movimiento,''DD-MM-YYYY'')=DECODE('''||EV_fecha_hasta||''',NULL,TO_CHAR(a.fecha_movimiento,''DD-MM-YYYY''),'''||EV_fecha_hasta||''')'||
         '   AND (a.octeto_ini_1||a.octeto_ini_2||a.octeto_ini_3||a.octeto_ini_4)>='||
         '       DECODE(('||EN_octeto_ini_1||EN_octeto_ini_2||EN_octeto_ini_3||EN_octeto_ini_4||'),NULL, '||
         '       (a.octeto_ini_1||a.octeto_ini_2||a.octeto_ini_3||a.octeto_ini_4), '||
         '       ('||EN_octeto_ini_1||EN_octeto_ini_2||EN_octeto_ini_3||EN_octeto_ini_4||')) '||
         '   AND (a.octeto_fin_1||a.octeto_fin_2||a.octeto_fin_3||a.octeto_fin_4)<='||
         '       DECODE(('||EN_octeto_fin_1||EN_octeto_fin_2||EN_octeto_fin_3||EN_octeto_fin_4||'),NULL, '||
         '       (a.octeto_fin_1||a.octeto_fin_2||a.octeto_fin_3||a.octeto_fin_4), '||
         '       ('||EN_octeto_fin_1||EN_octeto_fin_2||EN_octeto_fin_3||EN_octeto_fin_4||')) '||
         '   AND a.cod_apn = b.cod_apn '||
         '   AND a.cod_tecnologia = c.cod_tecnologia;';

     OPEN SC_RangosIP FOR
   SELECT a.cod_rangoip,
          a.octeto_ini_1,a.octeto_ini_2,a.octeto_ini_3,a.octeto_ini_4, a.octeto_fin_1,a.octeto_fin_2,a.octeto_fin_3,
		  a.octeto_fin_4, a.fecha_movimiento,a.cod_apn,b.des_apn, a.cod_tecnologia,c.des_tecnologia,a.usuario,
		  (a.octeto_fin_3 - a.octeto_ini_3) + (a.octeto_fin_4 - a.octeto_ini_4) + 1 CANTIDAD, aip_disponible_fn( a.cod_rangoip ) AS DISPONIBLE
     FROM aip_rangoipta_to a, aip_apn_to b, al_tecnologia c
    WHERE a.cod_rangoip > CN_cero
      AND a.cod_rangoip = DECODE(EN_cod_rangoip,NULL,a.cod_rangoip,EN_cod_rangoip)
      AND a.cod_tecnologia = DECODE(EV_cod_tecnologia,NULL,a.cod_tecnologia,EV_cod_tecnologia)
      AND a.cod_apn = DECODE(EN_cod_apn,NULL,a.cod_apn,EN_cod_apn)
      AND TO_CHAR(a.fecha_movimiento,'DD-MM-YYYY') = DECODE(EV_fecha_desde,NULL,TO_CHAR(a.fecha_movimiento,'DD-MM-YYYY'),EV_fecha_desde)
      AND TO_CHAR(a.fecha_movimiento,'DD-MM-YYYY') = DECODE(EV_fecha_hasta,NULL,TO_CHAR(a.fecha_movimiento,'DD-MM-YYYY'),EV_fecha_hasta)
	  AND TO_NUMBER((TRIM(TO_CHAR(a.octeto_ini_1,'099')) || TRIM(TO_CHAR(a.octeto_ini_2,'099')) || TRIM(TO_CHAR(a.octeto_ini_3,'099')) || TRIM(TO_CHAR(a.octeto_ini_4,'099')))) >=
			TO_NUMBER(DECODE((TRIM(TO_CHAR(EN_octeto_ini_1,'099')) || TRIM(TO_CHAR(EN_octeto_ini_2,'099')) || TRIM(TO_CHAR(EN_octeto_ini_3,'099')) || TRIM(TO_CHAR(EN_octeto_ini_4,'099'))),NULL,
			(TRIM(TO_CHAR(a.octeto_ini_1,'099')) || TRIM(TO_CHAR(a.octeto_ini_2,'099')) || TRIM(TO_CHAR(a.octeto_ini_3,'099')) || TRIM(TO_CHAR(a.octeto_ini_4,'099'))),
			(TRIM(TO_CHAR(EN_octeto_ini_1,'099')) || TRIM(TO_CHAR(EN_octeto_ini_2,'099')) || TRIM(TO_CHAR(EN_octeto_ini_3,'099')) || TRIM(TO_CHAR(EN_octeto_ini_4,'099')))))
	  AND TO_NUMBER((TRIM(TO_CHAR(a.octeto_fin_1,'099')) || TRIM(TO_CHAR(a.octeto_fin_2,'099')) || TRIM(TO_CHAR(a.octeto_fin_3,'099')) || TRIM(TO_CHAR(a.octeto_fin_4,'099')))) <=
			TO_NUMBER(DECODE((TRIM(TO_CHAR(EN_octeto_fin_1,'099')) || TRIM(TO_CHAR(EN_octeto_fin_2,'099')) || TRIM(TO_CHAR(EN_octeto_fin_3,'099')) || TRIM(TO_CHAR(EN_octeto_fin_4,'099'))),NULL,
			(TRIM(TO_CHAR(a.octeto_fin_1,'099')) || TRIM(TO_CHAR(a.octeto_fin_2,'099')) || TRIM(TO_CHAR(a.octeto_fin_3,'099')) || TRIM(TO_CHAR(a.octeto_fin_4,'099'))),
			(TRIM(TO_CHAR(EN_octeto_fin_1,'099')) || TRIM(TO_CHAR(EN_octeto_fin_2,'099')) || TRIM(TO_CHAR(EN_octeto_fin_3,'099')) || TRIM(TO_CHAR(EN_octeto_fin_4,'099')))))
      AND a.cod_apn = b.cod_apn
      AND a.cod_tecnologia = c.cod_tecnologia;

EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno:= 449;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno:=CV_error_no_clasif;
      END IF;
      V_des_error:='aip_consultarangosip_pr('||EN_cod_rangoip||','''||EV_cod_tecnologia||''','||EN_cod_apn||','''||
                                              EV_fecha_desde||''','''||EV_fecha_hasta||''','||EN_octeto_ini_1||','||EN_octeto_ini_2||','||
			                                  EN_octeto_ini_3||','||EN_octeto_ini_4||','||EN_octeto_fin_1||','||EN_octeto_fin_2||','||
		                                      EN_octeto_fin_3||','||EN_octeto_fin_4||'); -'||SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_consultarangosip_pr', sSql, SN_cod_retorno, V_des_error);

END aip_consultarangosip_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultaips_pr  (
    EV_cod_tecnologia IN  aip_ip_to.cod_tecnologia%TYPE,
	EN_cod_apn        IN  aip_ip_to.cod_apn%TYPE,
	EV_fecha_desde    IN  VARCHAR2,
	EV_fecha_hasta    IN  VARCHAR2,
	EN_octeto_ini_1   IN  aip_ip_to.octeto_1%TYPE,
	EN_octeto_ini_2   IN  aip_ip_to.octeto_2%TYPE,
	EN_octeto_ini_3   IN  aip_ip_to.octeto_3%TYPE,
	EN_octeto_ini_4   IN  aip_ip_to.octeto_4%TYPE,
	EN_octeto_fin_1   IN  aip_ip_to.octeto_1%TYPE,
	EN_octeto_fin_2   IN  aip_ip_to.octeto_2%TYPE,
	EN_octeto_fin_3   IN  aip_ip_to.octeto_3%TYPE,
	EN_octeto_fin_4   IN  aip_ip_to.octeto_4%TYPE,
	SC_IPs            OUT NOCOPY  refCursor,
	SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento     OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTAIPS_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta de IPs</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_tecnologia"  Tipo="CARACTER">Código de tecnología</param>
            <param nom="EN_cod_apn"  Tipo="NUMERICO">Código que identifica el apn</param>
            <param nom="EV_fecha_desde"  Tipo="CARACTER">Fecha desde</param>
            <param nom="EV_fecha_hasta"  Tipo="CARACTER">Fecha hasta</param>
            <param nom="EN_octeto_ini_1"  Tipo="NUMERICO">Primer octeto inicial de la ip</param>
            <param nom="EN_octeto_ini_2"  Tipo="NUMERICO">Segundo octeto inicial de la ip</param>
            <param nom="EN_octeto_ini_3"  Tipo="NUMERICO">Tercer octeto inicial de la ip</param>
            <param nom="EN_octeto_ini_4"  Tipo="NUMERICO">Cuarto octeto inicial de la ip</param>
            <param nom="EN_octeto_fin_1"  Tipo="NUMERICO">Primer octeto de la ip</param>
            <param nom="EN_octeto_fin_2"  Tipo="NUMERICO">Segundo octeto final de la ip</param>
            <param nom="EN_octeto_fin_3"  Tipo="NUMERICO">Tercer octeto final de la ip</param>
            <param nom="EN_octeto_fin_4"  Tipo="NUMERICO">Cuarto octeto final de la ip</param>
        </Entrada>
         <Salida>
            <param nom="SC_IPs"    Tipo="Cursor">Datos de las IPs </param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    V_des_error      ge_errores_pg.DesEvent;
    sSql             ge_errores_pg.vQuery;
BEGIN

   SN_num_evento:=CN_cero;
   SN_cod_retorno:=CN_cero;
   SV_mens_retorno:=NULL;

   sSql:='  OPEN SC_IPs FOR '||
         'SELECT a.cod_rangoip,a.octeto_1,a.octeto_2,a.octeto_3,a.octeto_4, a.cod_tipo_ip,a.cod_apn, b.des_apn,'||
		 '	     a.cod_tipo_ip,a.cod_apn, b.des_apn, '||
		 '		 a.cod_qos, d.des_qos, '||
		 '		 a.cod_estado_ip,e.des_estado_ip, '||
		 '		 a.cod_tecnologia,c.des_tecnologia, '||
		 '		 a.cod_producto,a.cod_servicio, f.des_servicio,a.fecha_movimiento '||
		 '	FROM aip_ip_to a, aip_apn_to b, al_tecnologia c, aip_qos_to d, aip_estado_ip_to e, ga_servsupl f '||
		 ' WHERE a.octeto_1 >= 0 '||
		 '	 AND a.octeto_2 >= 0 '||
		 '	 AND a.octeto_3 >= 0 '||
		 '	 AND a.octeto_4 >= 0 '||
		 '	 AND a.cod_tecnologia = DECODE('''||EV_cod_tecnologia||''',NULL,a.cod_tecnologia,'''||EV_cod_tecnologia||''') '||
		 '	 AND a.cod_apn = DECODE('||EN_cod_apn||',NULL,a.cod_apn,'||EN_cod_apn||') '||
		 '	 AND TO_CHAR(a.fecha_movimiento,''DD-MM-YYYY'') >= DECODE('''||EV_fecha_desde||''',NULL,TO_CHAR(a.fecha_movimiento,''DD-MM-YYYY''),'''||EV_fecha_desde||''') '||
		 '	 AND TO_CHAR(a.fecha_movimiento,''DD-MM-YYYY'') <= DECODE(EV_fecha_hasta,NULL,TO_CHAR(a.fecha_movimiento,''DD-MM-YYYY''),'''||EV_fecha_hasta||''') '||
		 '	 AND TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,''099'')) || LTRIM(TO_CHAR(a.octeto_2,''099'')) || LTRIM(TO_CHAR(a.octeto_3,''099'')) || LTRIM(TO_CHAR(a.octeto_4,''099''))) >= '||
		 '		 DECODE(TO_NUMBER(LTRIM(TO_CHAR('||EN_octeto_ini_1||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_ini_2||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_ini_3||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_ini_4||',''099''))),null, '||
		 '		 TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,''099'')) || LTRIM(TO_CHAR(a.octeto_2,''099'')) || LTRIM(TO_CHAR(a.octeto_3,''099'')) || LTRIM(TO_CHAR(a.octeto_4,''099''))), '||
		 '		 TO_NUMBER(LTRIM(TO_CHAR('||EN_octeto_ini_1||',''099''))||LTRIM(TO_CHAR('||EN_octeto_ini_2||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_ini_3||',''099''))||LTRIM(TO_CHAR('||EN_octeto_ini_4||',''099'')))) '||
		 '	 AND TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,''099'')) || LTRIM(TO_CHAR(a.octeto_2,''099'')) || LTRIM(TO_CHAR(a.octeto_3,''099'')) || LTRIM(TO_CHAR(a.octeto_4,''099''))) <= '||
		 '		 DECODE(TO_NUMBER(LTRIM(TO_CHAR('||EN_octeto_fin_1||',''099''))||LTRIM(TO_CHAR('||EN_octeto_fin_2||',''099''))||LTRIM(TO_CHAR('||EN_octeto_fin_3||',''099''))||LTRIM(TO_CHAR('||EN_octeto_fin_4||',''099''))),null, '||
		 '		 TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,''099'')) || LTRIM(TO_CHAR(a.octeto_2,''099'')) || LTRIM(TO_CHAR(a.octeto_3,''099'')) || LTRIM(TO_CHAR(a.octeto_4,''099''))), '||
		 '		 TO_NUMBER(LTRIM(TO_CHAR('||EN_octeto_fin_1||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_fin_2||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_fin_3||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_fin_4||',''099'')))) '||
		 '	 AND a.cod_apn = b.cod_apn '||
		 '	 AND a.cod_tecnologia = c.cod_tecnologia '||
		 '	 AND a.cod_qos = d.cod_qos '||
		 '	 AND a.cod_estado_ip = e.cod_estado_ip '||
		 '	 AND a.cod_servicio = f.cod_servicio '||
		 '	 AND a.cod_producto = f.cod_producto; ';

     OPEN SC_IPs FOR
   SELECT a.cod_rangoip,a.octeto_1,a.octeto_2,a.octeto_3,a.octeto_4, a.cod_tipo_ip,a.cod_apn, b.des_apn,
          a.cod_qos, d.des_qos, a.cod_estado_ip,e.des_estado_ip, a.cod_tecnologia,c.des_tecnologia, a.cod_producto,a.cod_servicio, f.des_servicio,a.fecha_movimiento
     FROM aip_ip_to a, aip_apn_to b, al_tecnologia c, aip_qos_to d, aip_estado_ip_to e, ga_servsupl f
    WHERE a.octeto_1 >= 0
      AND a.octeto_2 >= 0
      AND a.octeto_3 >= 0
      AND a.octeto_4 >= 0
      AND a.cod_tecnologia = DECODE(EV_cod_tecnologia,NULL,a.cod_tecnologia,EV_cod_tecnologia)
      AND a.cod_apn = DECODE(EN_cod_apn,NULL,a.cod_apn,EN_cod_apn)
      AND TO_CHAR(a.fecha_movimiento,'DD-MM-YYYY') >= DECODE(EV_fecha_desde,NULL,TO_CHAR(a.fecha_movimiento,'DD-MM-YYYY'),EV_fecha_desde)
      AND TO_CHAR(a.fecha_movimiento,'DD-MM-YYYY') <= DECODE(EV_fecha_hasta,NULL,TO_CHAR(a.fecha_movimiento,'DD-MM-YYYY'),EV_fecha_hasta)
      AND TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,'099')) || LTRIM(TO_CHAR(a.octeto_2,'099')) || LTRIM(TO_CHAR(a.octeto_3,'099')) || LTRIM(TO_CHAR(a.octeto_4,'099'))) >=
          DECODE(TO_NUMBER(LTRIM(TO_CHAR(EN_octeto_ini_1,'099')) || LTRIM(TO_CHAR(EN_octeto_ini_2,'099')) || LTRIM(TO_CHAR(EN_octeto_ini_3,'099')) || LTRIM(TO_CHAR(EN_octeto_ini_4,'099'))),null,
          TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,'099')) || LTRIM(TO_CHAR(a.octeto_2,'099')) || LTRIM(TO_CHAR(a.octeto_3,'099')) || LTRIM(TO_CHAR(a.octeto_4,'099'))),
          TO_NUMBER(LTRIM(TO_CHAR(EN_octeto_ini_1,'099')) || LTRIM(TO_CHAR(EN_octeto_ini_2,'099')) || LTRIM(TO_CHAR(EN_octeto_ini_3,'099')) || LTRIM(TO_CHAR(EN_octeto_ini_4,'099'))))
      AND TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,'099')) || LTRIM(TO_CHAR(a.octeto_2,'099')) || LTRIM(TO_CHAR(a.octeto_3,'099')) || LTRIM(TO_CHAR(a.octeto_4,'099'))) <=
          DECODE(TO_NUMBER(LTRIM(TO_CHAR(EN_octeto_ini_1,'099')) || LTRIM(TO_CHAR(EN_octeto_fin_2,'099')) || LTRIM(TO_CHAR(EN_octeto_fin_3,'099')) || LTRIM(TO_CHAR(EN_octeto_fin_4,'099'))),null,
          TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,'099')) || LTRIM(TO_CHAR(a.octeto_2,'099')) || LTRIM(TO_CHAR(a.octeto_3,'099')) || LTRIM(TO_CHAR(a.octeto_4,'099'))),
          TO_NUMBER(LTRIM(TO_CHAR(EN_octeto_fin_1,'099')) || LTRIM(TO_CHAR(EN_octeto_fin_2,'099')) || LTRIM(TO_CHAR(EN_octeto_fin_3,'099')) || LTRIM(TO_CHAR(EN_octeto_fin_4,'099'))))
      AND a.cod_apn = b.cod_apn
      AND a.cod_tecnologia = c.cod_tecnologia
      AND a.cod_qos = d.cod_qos
      AND a.cod_estado_ip = e.cod_estado_ip
      AND a.cod_servicio = f.cod_servicio
      AND a.cod_producto = f.cod_producto;

EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno:= 450;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno:=CV_error_no_clasif;
      END IF;
      V_des_error:='aip_consultaips_pr('''||EV_cod_tecnologia||''','||EN_cod_apn||','||','''||
                                           EV_fecha_desde||''','''||EV_fecha_hasta||''','||EN_octeto_ini_1||','||EN_octeto_ini_2||','||
		                                   EN_octeto_ini_3||','||EN_octeto_ini_4||','||EN_octeto_fin_1||','||EN_octeto_fin_2||','||
		                                   EN_octeto_fin_3||','||EN_octeto_fin_4||'); -'||SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_consultaips_pr', sSql, SN_cod_retorno, V_des_error);

END aip_consultaips_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultaipshis_pr  (
    EN_cod_apn       IN  aip_ip_th.cod_apn%TYPE,
  	EN_num_celular   IN  aip_ip_th.num_celular%TYPE,
	EN_cod_estado_ip IN  aip_ip_th.cod_estado_ip%TYPE,
	EV_fecha_desde   IN  VARCHAR2,
	EV_fecha_hasta   IN  VARCHAR2,
	EN_octeto_ini_1  IN  aip_ip_th.octeto_1%TYPE,
	EN_octeto_ini_2  IN  aip_ip_th.octeto_2%TYPE,
	EN_octeto_ini_3  IN  aip_ip_th.octeto_3%TYPE,
	EN_octeto_ini_4  IN  aip_ip_th.octeto_4%TYPE,
	EN_octeto_fin_1  IN  aip_ip_th.octeto_1%TYPE,
	EN_octeto_fin_2  IN  aip_ip_th.octeto_2%TYPE,
	EN_octeto_fin_3  IN  aip_ip_th.octeto_3%TYPE,
	EN_octeto_fin_4  IN  aip_ip_th.octeto_4%TYPE,
	SC_IPsHis        OUT NOCOPY refCursor,
	SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento    OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "aip_consultaipshis_pr"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta de IPs histórica</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_apn"  Tipo="NUMERICO">Código que identifica el apn</param>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EN_cod_estado_ip"  Tipo="NUMERICO">Código del estado de la ip </param>
            <param nom="EV_fecha_desde"  Tipo="CARACTER">Fecha desde</param>
            <param nom="EV_fecha_hasta"  Tipo="CARACTER">Fecha hasta</param>
            <param nom="EN_octeto_ini_1"  Tipo="NUMERICO">Primer octeto inicial de la ip</param>
            <param nom="EN_octeto_ini_2"  Tipo="NUMERICO">Segundo octeto inicial de la ip</param>
            <param nom="EN_octeto_ini_3"  Tipo="NUMERICO">Tercer octeto inicial de la ip</param>
            <param nom="EN_octeto_ini_4"  Tipo="NUMERICO">Cuarto octeto inicial de la ip</param>
            <param nom="EN_octeto_fin_1"  Tipo="NUMERICO">Primer octeto de la ip</param>
            <param nom="EN_octeto_fin_2"  Tipo="NUMERICO">Segundo octeto final de la ip</param>
            <param nom="EN_octeto_fin_3"  Tipo="NUMERICO">Tercer octeto final de la ip</param>
            <param nom="EN_octeto_fin_4"  Tipo="NUMERICO">Cuarto octeto final de la ip</param>
        </Entrada>
         <Salida>
            <param nom="SC_DisponibilizarIP"    Tipo="Cursor">Datos históricos de la ip </param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   sSql             ge_errores_pg.vQuery;
   V_des_error         ge_errores_pg.DesEvent;
BEGIN

   SN_num_evento:=CN_cero;
   SN_cod_retorno:=CN_cero;
   SV_mens_retorno:=NULL;

   sSql:='   OPEN SC_IPsHis FOR '||
         ' SELECT a.octeto_1,a.octeto_2,a.octeto_3,a.octeto_4, a.num_celular,a.cod_estado_ip,c.des_estado_ip,a.cod_apn, b.des_apn, a.fecha_movimiento '||
		 '   FROM aip_ip_th a, aip_apn_to b, aip_estado_ip_to c '||
		 '	WHERE a.octeto_1 >= 0 '||
		 '	  AND a.octeto_2 >= 0 '||
		 '	  AND a.octeto_3 >= 0 '||
		 '	  AND a.octeto_4 >= 0 '||
		 '	  AND a.cod_apn = DECODE('||EN_cod_apn||',NULL,a.cod_apn,'||EN_cod_apn||') '||
		 '	  AND NVL(a.num_celular,0) = DECODE('||EN_num_celular||',NULL,DECODE(a.num_celular,NULL,0,a.num_celular),'||EN_num_celular||') '||
		 '	  AND a.cod_estado_ip = DECODE('||EN_cod_estado_ip||',NULL,a.cod_estado_ip,'||EN_cod_estado_ip||') '||
		 '	  AND TO_CHAR(a.fecha_movimiento,''DD-MM-YYYY'') >= DECODE('''||EV_fecha_desde||''',NULL,TO_CHAR(a.fecha_movimiento,''DD-MM-YYYY''),'''||EV_fecha_desde||''') '||
		 '	  AND TO_CHAR(a.fecha_movimiento,''DD-MM-YYYY'') <= DECODE('''||EV_fecha_hasta||''',NULL,TO_CHAR(a.fecha_movimiento,''DD-MM-YYYY''),'''||EV_fecha_hasta||''') '||
		 '	  AND TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,''099'')) || LTRIM(TO_CHAR(a.octeto_2,''099'')) || LTRIM(TO_CHAR(a.octeto_3,''099'')) || LTRIM(TO_CHAR(a.octeto_4,''099''))) >= '||
		 '	      DECODE(TO_NUMBER(LTRIM(TO_CHAR('||EN_octeto_ini_1||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_ini_2||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_ini_3||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_ini_4||',''099''))),null, '||
		 '		  TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,''099'')) || LTRIM(TO_CHAR(a.octeto_2,''099'')) || LTRIM(TO_CHAR(a.octeto_3,''099'')) || LTRIM(TO_CHAR(a.octeto_4,''099''))), '||
		 '		  TO_NUMBER(LTRIM(TO_CHAR('||EN_octeto_ini_1||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_ini_2||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_ini_3||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_ini_4||',''099'')))) '||
		 '	  AND TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,''099'')) || LTRIM(TO_CHAR(a.octeto_2,''099'')) || LTRIM(TO_CHAR(a.octeto_3,''099'')) || LTRIM(TO_CHAR(a.octeto_4,''099''))) <= '||
		 '		  DECODE(TO_NUMBER(LTRIM(TO_CHAR('||EN_octeto_fin_1||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_fin_2||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_fin_3||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_fin_4||',''099''))),null, '||
		 '		  TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,''099'')) || LTRIM(TO_CHAR(a.octeto_2,''099'')) || LTRIM(TO_CHAR(a.octeto_3,''099'')) || LTRIM(TO_CHAR(a.octeto_4,''099''))), '||
		 '		  TO_NUMBER(LTRIM(TO_CHAR('||EN_octeto_fin_1||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_fin_2||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_fin_3||',''099'')) || LTRIM(TO_CHAR('||EN_octeto_fin_4||',''099'')))) '||
		 '	  AND a.cod_apn = b.cod_apn '||
		 '	  AND a.cod_estado_ip = c.cod_estado_ip;';


     OPEN SC_IPsHis FOR
   SELECT a.octeto_1,a.octeto_2,a.octeto_3,a.octeto_4, a.num_celular,a.cod_estado_ip,c.des_estado_ip,a.cod_apn, b.des_apn, a.fecha_movimiento
	 FROM aip_ip_th a, aip_apn_to b, aip_estado_ip_to c
	WHERE a.octeto_1 >= 0
	  AND a.octeto_2 >= 0
	  AND a.octeto_3 >= 0
	  AND a.octeto_4 >= 0
	  AND a.cod_apn = DECODE(EN_cod_apn,NULL,a.cod_apn,EN_cod_apn)
	  AND NVL(a.num_celular,0) = DECODE(EN_num_celular,NULL,DECODE(a.num_celular,NULL,0,a.num_celular),EN_num_celular)
	  AND a.cod_estado_ip = DECODE(EN_cod_estado_ip,NULL,a.cod_estado_ip,EN_cod_estado_ip)
	  AND TO_CHAR(a.fecha_movimiento,'DD-MM-YYYY') >= DECODE(EV_fecha_desde,NULL,TO_CHAR(a.fecha_movimiento,'DD-MM-YYYY'),EV_fecha_desde)
	  AND TO_CHAR(a.fecha_movimiento,'DD-MM-YYYY') <= DECODE(EV_fecha_hasta,NULL,TO_CHAR(a.fecha_movimiento,'DD-MM-YYYY'),EV_fecha_hasta)
	  AND TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,'099')) || LTRIM(TO_CHAR(a.octeto_2,'099')) || LTRIM(TO_CHAR(a.octeto_3,'099')) || LTRIM(TO_CHAR(a.octeto_4,'099'))) >=
	  	  DECODE(TO_NUMBER(LTRIM(TO_CHAR(EN_octeto_ini_1,'099')) || LTRIM(TO_CHAR(EN_octeto_ini_2,'099')) || LTRIM(TO_CHAR(EN_octeto_ini_3,'099')) || LTRIM(TO_CHAR(EN_octeto_ini_4,'099'))),null,
		  TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,'099')) || LTRIM(TO_CHAR(a.octeto_2,'099')) || LTRIM(TO_CHAR(a.octeto_3,'099')) || LTRIM(TO_CHAR(a.octeto_4,'099'))),
		  TO_NUMBER(LTRIM(TO_CHAR(EN_octeto_ini_1,'099')) || LTRIM(TO_CHAR(EN_octeto_ini_2,'099')) || LTRIM(TO_CHAR(EN_octeto_ini_3,'099')) || LTRIM(TO_CHAR(EN_octeto_ini_4,'099'))))
	  AND TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,'099')) || LTRIM(TO_CHAR(a.octeto_2,'099')) || LTRIM(TO_CHAR(a.octeto_3,'099')) || LTRIM(TO_CHAR(a.octeto_4,'099'))) <=
	  	  DECODE(TO_NUMBER(LTRIM(TO_CHAR(EN_octeto_fin_1,'099')) || LTRIM(TO_CHAR(EN_octeto_fin_2,'099')) || LTRIM(TO_CHAR(EN_octeto_fin_3,'099')) || LTRIM(TO_CHAR(EN_octeto_fin_4,'099'))),null,
		  TO_NUMBER(LTRIM(TO_CHAR(a.octeto_1,'099')) || LTRIM(TO_CHAR(a.octeto_2,'099')) || LTRIM(TO_CHAR(a.octeto_3,'099')) || LTRIM(TO_CHAR(a.octeto_4,'099'))),
		  TO_NUMBER(LTRIM(TO_CHAR(EN_octeto_fin_1,'099')) || LTRIM(TO_CHAR(EN_octeto_fin_2,'099')) || LTRIM(TO_CHAR(EN_octeto_fin_3,'099')) || LTRIM(TO_CHAR(EN_octeto_fin_4,'099'))))
	  AND a.cod_apn = b.cod_apn
	  AND a.cod_estado_ip = c.cod_estado_ip;


EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno:= 451;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno:=CV_error_no_clasif;
      END IF;
      V_des_error:='aip_consultaipshis_pr('||EN_cod_apn||','||EN_num_celular||','||EN_cod_estado_ip||','''||
                                            EV_fecha_desde||''','''||EV_fecha_hasta||''','||EN_octeto_ini_1||','||EN_octeto_ini_2||','||
		                                    EN_octeto_ini_3||','||EN_octeto_ini_4||','||EN_octeto_fin_1||','||EN_octeto_fin_2||','||
		                                    EN_octeto_fin_3||','||EN_octeto_fin_4||'); -'||SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_consultaipshis_pr', sSql, SN_cod_retorno, V_des_error);

END aip_consultaipshis_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultadisponibilizar_pr(
    EV_cod_tecnologia     IN aip_rangoipta_to.cod_tecnologia%TYPE,
  	EN_cod_apn            IN aip_rangoipta_to.cod_apn%TYPE,
	ED_fecha_movimiento   IN aip_rangoipta_to.fecha_movimiento%TYPE,
	EV_disponibilizar     IN VARCHAR2,
  	SC_DisponibilizarIP  OUT NOCOPY refCursor,
	SN_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento        OUT NOCOPY ge_errores_pg.evento

)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTADISPONIBILIZAR_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta disponibilizar IP</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_tecnologia"  Tipo="CARACTER">Código de tecnología</param>
            <param nom="EN_cod_apn"  Tipo="NUMERICO">Código que identifica el apn</param>
            <param nom="ED_fecha_movimiento"  Tipo="FECHA">Fecha del movimiento</param>
            <param nom="EV_disponibilizar  Tipo="CARACTER"></param>
         </Entrada>
         <Salida>
            <param nom="SC_DisponibilizarIP"    Tipo="Cursor">Datos de rangos para disponibilizacion </param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error         ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
BEGIN

   SN_num_evento:=CN_cero;
   SN_cod_retorno:=CN_cero;
   SV_mens_retorno:=NULL;

   sSql:='OPEN SC_DisponibilizarIP FOR '||
         'SELECT aip_disponible_fn( a.cod_rangoip ) AS DISPONIBLE,a.cod_rangoip, a.octeto_ini_1,a.octeto_ini_2,a.octeto_ini_3,a.octeto_ini_4, '||
		 '   a.octeto_fin_1,a.octeto_fin_2,a.octeto_fin_3,a.octeto_fin_4, a.cod_tecnologia, a.cod_apn '||
		 ' FROM aip_rangoipta_to a '||
		 ' WHERE a.cod_rangoip>'||CN_cero||
		 ' AND IP_Disponible_FN( a.cod_rangoip )='''||EV_disponibilizar||''||
		 ' AND a.cod_tecnologia=DECODE('''||EV_cod_tecnologia||''',NULL,a.cod_tecnologia,'''||EV_cod_tecnologia||''')'||
		 ' AND a.cod_apn=DECODE('||EN_cod_apn||',NULL,a.cod_apn,'||EN_cod_apn||')'||
		 ' AND a.fecha_movimiento = DECODE('||ED_fecha_movimiento||',NULL,a.fecha_movimiento,'||ED_fecha_movimiento||')'||
		 ' ORDER BY 2;';

       OPEN SC_DisponibilizarIP FOR
     SELECT aip_disponible_fn( a.cod_rangoip ) AS DISPONIBLE,a.cod_rangoip, a.octeto_ini_1,a.octeto_ini_2,a.octeto_ini_3,a.octeto_ini_4,
		    a.octeto_fin_1,a.octeto_fin_2,a.octeto_fin_3,a.octeto_fin_4, a.cod_tecnologia, a.cod_apn
	   FROM aip_rangoipta_to a
      WHERE a.cod_rangoip > CN_cero
        AND aip_disponible_fn( a.cod_rangoip ) = EV_disponibilizar
        AND a.cod_tecnologia = DECODE(EV_cod_tecnologia,NULL,a.cod_tecnologia,EV_cod_tecnologia)
        AND a.cod_apn = DECODE(EN_cod_apn,NULL,a.cod_apn,EN_cod_apn)
        AND a.fecha_movimiento = DECODE(ED_fecha_movimiento,NULL,a.fecha_movimiento,ED_fecha_movimiento)
   ORDER BY 2;

EXCEPTION

   WHEN OTHERS THEN
      SN_cod_retorno:= 452;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno:=CV_error_no_clasif;
      END IF;
      V_des_error:='aip_consultadisponibilizar_pr('''||EV_cod_tecnologia||''','||EN_cod_apn||','||ED_fecha_movimiento||','''||EV_disponibilizar||''') - '||SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_consultadisponibilizar_pr', sSql, SN_cod_retorno, V_des_error);

END aip_consultadisponibilizar_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultavigencia_pr(
    SC_Vigencia     OUT NOCOPY  refCursor,
	SN_cod_retorno  OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento   OUT NOCOPY  ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTAVIGENCIA_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta datos de parametros de vigencia para IP</Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
            <param nom="SC_Vigencia"    Tipo="Cursor">Datos de los parametros </param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error         ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
BEGIN

   SN_num_evento:=CN_cero;
   SN_cod_retorno:=CN_cero;
   SV_mens_retorno:=NULL;

   sSql:='SELECT val_parametro, nom_parametro '||
	     'FROM ged_parametros par '||
	     'WHERE (par.nom_parametro='''||CV_vigente||''' OR par.nom_parametro='''||CV_novigente||''')'||
	     ' AND par.cod_modulo='||CV_modulo||
	     ' AND par.cod_producto='||CN_cod_producto;

     OPEN SC_Vigencia FOR
   SELECT par.val_parametro, par.nom_parametro
	 FROM ged_parametros par
	WHERE (par.nom_parametro=CV_vigente OR par.nom_parametro=CV_novigente)
	  AND par.cod_modulo=CV_modulo
	  AND par.cod_producto=CN_cod_producto;

EXCEPTION

   WHEN OTHERS THEN
      SN_cod_retorno:= 453;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno:=CV_error_no_clasif;
      END IF;
      V_des_error:='aip_consultavigencia_pr(); - '|| SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_consultavigencia_pr', sSql, SN_cod_retorno, V_des_error);

END aip_consultavigencia_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultasolapamiento_pr(
    EN_octeto_ini_1  IN aip_rangoipta_to.octeto_ini_1%TYPE,
 	EN_octeto_ini_2  IN aip_rangoipta_to.octeto_ini_2%TYPE,
	EN_octeto_ini_3  IN aip_rangoipta_to.octeto_ini_3%TYPE,
	EN_octeto_ini_4  IN aip_rangoipta_to.octeto_ini_4%TYPE,
	EN_octeto_fin_1  IN aip_rangoipta_to.octeto_fin_1%TYPE,
	EN_octeto_fin_2  IN aip_rangoipta_to.octeto_fin_2%TYPE,
	EN_octeto_fin_3  IN aip_rangoipta_to.octeto_fin_3%TYPE,
	EN_octeto_fin_4  IN aip_rangoipta_to.octeto_fin_4%TYPE,
 	SN_Solapamiento OUT NOCOPY  NUMBER,
	SN_cod_retorno  OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento   OUT NOCOPY  ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTASOLAPAMIENTO_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta si hay solapamiento</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_octeto_ini_1"  Tipo="NUMERICO">Primer octeto inicial de la ip</param>
            <param nom="EN_octeto_ini_2"  Tipo="NUMERICO">Segundo octeto inicial de la ip</param>
            <param nom="EN_octeto_ini_3"  Tipo="NUMERICO">Tercer octeto inicial de la ip</param>
            <param nom="EN_octeto_ini_4"  Tipo="NUMERICO">Cuarto octeto inicial de la ip</param>
            <param nom="EN_octeto_fin_1"  Tipo="NUMERICO">Primer octeto de la ip</param>
            <param nom="EN_octeto_fin_2"  Tipo="NUMERICO">Segundo octeto final de la ip</param>
            <param nom="EN_octeto_fin_3"  Tipo="NUMERICO">Tercer octeto final de la ip</param>
            <param nom="EN_octeto_fin_4"  Tipo="NUMERICO">Cuarto octeto final de la ip</param>
         </Entrada>
         <Salida>
            <param nom="SN_Solapamiento"    Tipo="NUMERICO"></param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   V_des_error         ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
BEGIN

   SN_num_evento:=CN_cero;
   SN_cod_retorno:=CN_cero;
   SV_mens_retorno:=NULL;
   SN_Solapamiento:=0;

   sSql:='SELECT COUNT(a.cod_rangoip) INTO SN_Solapamiento'||
	' FROM AIP_RANGOIPTA_TO a'||
	'WHERE LTRIM(TO_CHAR(EN_octeto_ini_1,''009'')) || LTRIM(TO_CHAR(EN_octeto_ini_2,''009'')) || LTRIM(TO_CHAR(EN_octeto_ini_3,''009'')) || LTRIM(TO_CHAR(EN_octeto_ini_4,''009'')) BETWEEN'||
	     ' LTRIM(TO_CHAR(a.octeto_ini_1,''009''))|| LTRIM(TO_CHAR(a.octeto_ini_2,''009''))|| LTRIM(TO_CHAR(a.octeto_ini_3,''009''))||LTRIM(TO_CHAR(a.octeto_ini_4,''009''))   and'||
         ' LTRIM(TO_CHAR(a.octeto_fin_1,''009'')) || LTRIM(TO_CHAR(a.octeto_fin_2,''009'')) || LTRIM(TO_CHAR(a.octeto_fin_3,''009''))||LTRIM(TO_CHAR(a.octeto_fin_4,''009''))'||
      ' or LTRIM(TO_CHAR(EN_octeto_fin_1,''009'')) || LTRIM(TO_CHAR(EN_octeto_fin_2,''009'')) || LTRIM(TO_CHAR(EN_octeto_fin_3,''009'')) || LTRIM(TO_CHAR(EN_octeto_fin_4,''009'')) BETWEEN'||
	   '   LTRIM(TO_CHAR(a.octeto_ini_1,''009''))|| LTRIM(TO_CHAR(a.octeto_ini_2,''009''))|| LTRIM(TO_CHAR(a.octeto_ini_3,''009''))||LTRIM(TO_CHAR(a.octeto_ini_4,''009''))   and'||
        '  LTRIM(TO_CHAR(a.octeto_fin_1,''009'')) || LTRIM(TO_CHAR(a.octeto_fin_2,''009'')) || LTRIM(TO_CHAR(a.octeto_fin_3,''009''))||LTRIM(TO_CHAR(a.octeto_fin_4,''009''))';


   SELECT COUNT(a.cod_rangoip) INTO SN_Solapamiento
	 FROM AIP_RANGOIPTA_TO a
	WHERE LTRIM(TO_CHAR(EN_octeto_ini_1,'009')) || LTRIM(TO_CHAR(EN_octeto_ini_2,'009')) || LTRIM(TO_CHAR(EN_octeto_ini_3,'009')) || LTRIM(TO_CHAR(EN_octeto_ini_4,'009')) BETWEEN
	      LTRIM(TO_CHAR(a.octeto_ini_1,'009'))|| LTRIM(TO_CHAR(a.octeto_ini_2,'009'))|| LTRIM(TO_CHAR(a.octeto_ini_3,'009'))||LTRIM(TO_CHAR(a.octeto_ini_4,'009'))   and
          LTRIM(TO_CHAR(a.octeto_fin_1,'009')) || LTRIM(TO_CHAR(a.octeto_fin_2,'009')) || LTRIM(TO_CHAR(a.octeto_fin_3,'009'))||LTRIM(TO_CHAR(a.octeto_fin_4,'009'))
       or LTRIM(TO_CHAR(EN_octeto_fin_1,'009')) || LTRIM(TO_CHAR(EN_octeto_fin_2,'009')) || LTRIM(TO_CHAR(EN_octeto_fin_3,'009')) || LTRIM(TO_CHAR(EN_octeto_fin_4,'009')) BETWEEN
	      LTRIM(TO_CHAR(a.octeto_ini_1,'009'))|| LTRIM(TO_CHAR(a.octeto_ini_2,'009'))|| LTRIM(TO_CHAR(a.octeto_ini_3,'009'))||LTRIM(TO_CHAR(a.octeto_ini_4,'009'))   and
          LTRIM(TO_CHAR(a.octeto_fin_1,'009')) || LTRIM(TO_CHAR(a.octeto_fin_2,'009')) || LTRIM(TO_CHAR(a.octeto_fin_3,'009'))||LTRIM(TO_CHAR(a.octeto_fin_4,'009'));

EXCEPTION
   WHEN NO_DATA_FOUND THEN
	     NULL;
   WHEN OTHERS THEN
      SN_cod_retorno:= 454;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno:=CV_error_no_clasif;
      END IF;
      V_des_error:='aip_consultasolapamiento_pr('||EN_octeto_ini_1||','||EN_octeto_ini_2||','||EN_octeto_ini_3||','||EN_octeto_ini_4||','||
                                            EN_octeto_fin_1||','||EN_octeto_fin_2||','||EN_octeto_fin_3||','||EN_octeto_fin_4||');-' || SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_consultasolapamiento_pr', sSql, SN_cod_retorno, V_des_error);

END aip_consultasolapamiento_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_peticionip_pr(
    EV_cod_tecnologia IN aip_ip_to.cod_tecnologia%TYPE,
   	EN_cod_apn 		  IN aip_ip_to.cod_apn%TYPE,
    EN_tipo_ip        IN aip_apn_to.tipo_ip%TYPE,
    EN_cod_qos        IN aip_apn_to.cod_qos%TYPE,
	SN_octeto_1		  OUT NOCOPY aip_ip_to.octeto_1%TYPE,
	SN_octeto_2		  OUT NOCOPY aip_ip_to.octeto_1%TYPE,
	SN_octeto_3		  OUT NOCOPY aip_ip_to.octeto_1%TYPE,
	SN_octeto_4		  OUT NOCOPY aip_ip_to.octeto_1%TYPE,
	SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento     OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_PETICIONIP_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Petición de IP</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_tecnologia"  Tipo="CARACTER">Código de tecnología</param>
            <param nom="EN_cod_apn"  Tipo="NUMERICO">Código que identifica el apn</param>
         </Entrada>
         <Salida>
            <param nom="SN_octeto_1"       Tipo="NUMERICO">Primer octeto de Ip</param>
            <param nom="SN_octeto_2"       Tipo="NUMERICO">Segundo octeto de Ip</param>
            <param nom="SN_octeto_3"       Tipo="NUMERICO">Tercer octeto de Ip</param>
            <param nom="SN_octeto_4"       Tipo="NUMERICO">Cuarto octeto de Ip</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   LN_cod_estado_ip     aip_ip_to.cod_estado_ip%TYPE;
   LN_cod_estado_res_ip aip_ip_to.cod_estado_ip%TYPE;
   LN_cod_rangoip       aip_rangoipta_to.cod_rangoip%TYPE;
   LN_cod_qos           aip_apn_to.cod_qos%TYPE;
   V_des_error          ge_errores_pg.DesEvent;
   sSql                 ge_errores_pg.vQuery;

   error_ejecucion      EXCEPTION;
   error_datos          EXCEPTION;
BEGIN

   SN_num_evento:=CN_cero;
   SN_cod_retorno:=CN_cero;
   SV_mens_retorno:=NULL;
   SN_octeto_1:=NULL;
   SN_octeto_2:=NULL;
   SN_octeto_3:=NULL;
   SN_octeto_4:=NULL;
   LN_cod_rangoip:=NULL;
   LN_cod_qos:=null;

   IF EN_cod_qos is null THEN
      BEGIN
           SELECT cod_qos
           INTO LN_cod_qos
           FROM  aip_qos_to a, ged_parametros b
           WHERE b.cod_modulo='IP'
             AND b.nom_parametro='EQOSID'
             AND b.cod_producto=1
             AND a.eqosid=b.val_parametro
             AND rownum=1 ;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            SN_cod_retorno:= 414;
            RAISE error_ejecucion;
      END;
   ELSE
      LN_cod_qos:=EN_cod_qos;
   END IF;

   LN_cod_estado_ip:=NULL;
   sSql:='aip_recupera_parametros_fn('''||CV_estado_disponible||''','''||CV_modulo||''','||CN_cod_producto||')';
   IF NOT aip_recupera_parametros_fn(CV_estado_disponible,CV_modulo,CN_cod_producto,LN_cod_estado_ip,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

   sSql:='aip_recupera_parametros_fn('''||cv_estado_reservado||''','''||CV_modulo||''','||CN_cod_producto||')';
   IF NOT aip_recupera_parametros_fn(cv_estado_reservado,CV_modulo,CN_cod_producto,LN_cod_estado_res_ip,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

   sSql:='aip_portecapnestado_fn('''||EV_cod_tecnologia||''','||EN_cod_apn||','||LN_cod_estado_ip||')';
   IF NOT aip_portecapnestado_fn(EV_cod_tecnologia,EN_cod_apn,LN_cod_estado_ip,EN_tipo_ip,LN_cod_qos,SN_octeto_1,SN_octeto_2,SN_octeto_3,SN_octeto_4,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
      IF SN_cod_retorno=0 THEN --Significa que no está la ip disponible, se busca si existe el rango para disponibilizarla..
         sSql:='aip_rangoportecapn_fn('''||EV_cod_tecnologia||''','||EN_cod_apn||','||EN_tipo_ip||','||LN_cod_qos||')';
         IF aip_rangoportecapn_fn(EV_cod_tecnologia,EN_cod_apn,EN_tipo_ip,LN_cod_qos,LN_cod_rangoip,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
	        sSql:='aip_disponibilizarip_pr(LN_cod_rangoip,'','')';
	        aip_disponibilizarip_pr(LN_cod_rangoip,'','',SN_cod_retorno,SV_mens_retorno,SN_num_evento);
	        IF SN_cod_retorno<>0 THEN
	  	       RAISE error_ejecucion;
	        END IF;

	        sSql:='aip_portecapnestado_fn('''||EV_cod_tecnologia||''','||EN_cod_apn||','||LN_cod_estado_ip||')- Despues de ejecutar IP_DisponibilizarIP_P ';
            IF NOT aip_portecapnestado_fn(EV_cod_tecnologia,EN_cod_apn,LN_cod_estado_ip,EN_tipo_ip,LN_cod_qos,SN_octeto_1,SN_octeto_2,SN_octeto_3,SN_octeto_4,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
               IF SN_cod_retorno=0 THEN
		          RAISE error_datos;
               END IF;
            ELSE
               aip_modifica_estadoips_pr(SN_octeto_1,SN_octeto_2,SN_octeto_3,SN_octeto_4,LN_cod_estado_res_ip,NULL,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
	           IF SN_cod_retorno<>0 THEN
	  	          RAISE error_ejecucion;
	           END IF;
	        END IF;
	     END IF;
	     IF SN_cod_retorno<>0 THEN
	        RAISE error_ejecucion;
	     END IF;
      ELSE
  	     RAISE error_ejecucion;
      END IF;
   ELSE
       sSql:='aip_modifica_estadoips_pr('||SN_octeto_1||','||SN_octeto_2||','||SN_octeto_3||','||SN_octeto_4||','||LN_cod_estado_res_ip||',NULL,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
       aip_modifica_estadoips_pr(SN_octeto_1,SN_octeto_2,SN_octeto_3,SN_octeto_4,LN_cod_estado_res_ip,NULL,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       IF SN_cod_retorno<>0 THEN
          RAISE error_ejecucion;
       END IF;
   END IF;

EXCEPTION
   WHEN error_ejecucion THEN
      V_des_error := 'aip_peticionip_pr('''||EV_cod_tecnologia||''','||EN_cod_apn||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_peticionip_pr', sSql, SQLCODE, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno:= 410;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_peticionip_pr('''||EV_cod_tecnologia||''','||EN_cod_apn||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_peticionip_pr', sSql, SN_cod_retorno, V_des_error );

END aip_peticionip_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_conapn_pr (
      EN_cod_servicio   IN              aip_apn_to.cod_servicio%TYPE,
      SN_cod_apn        OUT NOCOPY      aip_apn_to.cod_apn%TYPE,
	  SV_cod_tecnologia OUT NOCOPY      aip_apn_to.cod_tecnologia%TYPE,
	  SN_cod_qos        OUT NOCOPY      aip_qos_to.cod_qos%TYPE,
	  SV_eqosid         OUT NOCOPY      aip_qos_to.eqosid%TYPE,
      SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      SN_num_evento     OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONAPN_PR"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción></Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_servicio"  Tipo="NUMERICO"></param>
         </Entrada>
         <Salida>
            <param nom="SC_consulta_apn"      Tipo="CURSOR">Cursor de salida</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   error_ejecucion      EXCEPTION;
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   lv_vigente		aip_qos_to.vigencia%TYPE;
BEGIN

   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;


   sSql:='aip_recupera_parametros_fn('''||EN_cod_servicio||''','''||CV_modulo||''','||CN_cod_producto||')';
   IF NOT aip_recupera_parametros_fn(cv_vigente,CV_modulo,CN_cod_producto,lv_vigente,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

   sSql := 'SELECT apapn.cod_apn, apapn.cod_tecnologia, apqos.cod_qos, apqos.eqosid FROM ga_servsupl sersu, aip_apn_to apapn, aip_qos_to apqos'
        || ' WHERE apapn.cod_servicio = sersu.cod_servicio AND apqos.cod_qos = apapn.cod_qos AND apapn.vigencia = ' || lv_vigente || 'AND apapn.cod_apn > '||CN_cero
        || ' AND sersu.cod_producto = '||CN_cod_producto||' AND sersu.cod_servicio = '||EN_cod_servicio;


   SELECT apapn.cod_apn, apapn.cod_tecnologia, apqos.cod_qos, apqos.eqosid
     INTO SN_cod_apn, SV_cod_tecnologia, SN_cod_qos, SV_eqosid
     FROM ga_servsupl sersu, aip_apn_to apapn, aip_qos_to apqos
    WHERE apapn.cod_servicio = sersu.cod_servicio
      AND apqos.cod_qos = apapn.cod_qos
	  AND apapn.vigencia = lv_vigente
      AND apapn.cod_apn > CN_cero
      AND sersu.cod_producto = CN_cod_producto
      AND sersu.cod_servicio = EN_cod_servicio;


EXCEPTION
   WHEN error_ejecucion THEN
      V_des_error := 'aip_conapn_pr('||en_cod_servicio||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_conapn_pr', sSql, SQLCODE, V_des_error );

   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 416;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_conapn_pr('||en_cod_servicio||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_conapn_pr', sSql, SN_cod_retorno, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_conapn_pr('||en_cod_servicio||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_conapn_pr', sSql, SN_cod_retorno, V_des_error );

END aip_conapn_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION aip_disponible_fn (
    EN_cod_rangoip IN aip_ip_to.cod_rangoip%TYPE
)
/*
<Documentación
  TipoDoc = "Función">
   <Elemento
      Nombre = "AIP_DISPONIBLE_FN"
      Lenguaje="PL/SQL"
      Fecha creación="16-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S. "
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Retorno>CARACTER."TRUE"si existe el rango. "FALSE" si no existe o hay algun error</Retorno>
      <Descripción>Verifica si existe rango de ip disponible</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_rangoip"  Tipo="NUMERICO"></param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN VARCHAR2
     AS
      v_Retorno        VARCHAR2(10);
     BEGIN
        SELECT 'TRUE' INTO   v_Retorno
        FROM   aip_ip_to a
        WHERE  a.cod_rangoip = EN_cod_rangoip ;
        RETURN v_Retorno ;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN 'FALSE' ;
   WHEN TOO_MANY_ROWS THEN
      RETURN 'TRUE' ;
   WHEN OTHERS THEN
      RETURN 'FALSE' ;

END aip_disponible_fn;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultaTipoIp_pr(
    sc_TipoIp         OUT NOCOPY refCursor,
	SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento    OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_consultaTipoIp_PR"
      Lenguaje="PL/SQL"
      Fecha creación=""
      Creado por=""
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Servicios Suplementarios</Descripción>
      <Parámetros>
         <Salida>
            <param nom="tSerSupl" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    V_des_error        ge_errores_pg.DesEvent;
    sSql               ge_errores_pg.vQuery;
    LV_Modulo          VARCHAR2(5):='IP';
    LV_Tabla           VARCHAR2(10):='TIPO_IP';
    LV_Campo           VARCHAR2(10):='TIPO_IP';
BEGIN

    SN_cod_retorno :=  0;
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

    sSql := 'SELECT cod_valor, des_valor ';
    sSql :=sSql || 'FROM GED_CODIGOS ';
    sSql :=sSql || 'WHERE cod_modulo= '|| LV_Modulo;
    sSql :=sSql || '  AND nom_tabla='|| LV_Tabla;
    sSql :=sSql || '  AND nom_columna='|| LV_Campo;

    OPEN sc_TipoIp FOR
        SELECT cod_valor, des_valor
        FROM GED_CODIGOS
        WHERE cod_modulo= LV_Modulo
        AND nom_tabla=LV_Tabla
        AND nom_columna=LV_Campo;



EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno := 445;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_consultaTipoIp_pr(); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_consultaTipoIp_pr', sSql, SQLCODE, V_des_error );

END aip_consultaTipoIp_pr;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_cambioip_pr (
        EV_cod_tecnologia    IN               aip_ip_to.cod_tecnologia%TYPE,
        EN_cod_apn           IN               aip_ip_to.cod_apn%TYPE,
        EN_octeto_1          IN               aip_ip_to.octeto_1%TYPE,
        EN_octeto_2          IN               aip_ip_to.octeto_2%TYPE,
        EN_octeto_3          IN               aip_ip_to.octeto_3%TYPE,
        EN_octeto_4          IN               aip_ip_to.octeto_4%TYPE,
		SN_octeto_1		     OUT NOCOPY       aip_ip_to.octeto_1%TYPE,
		SN_octeto_2		     OUT NOCOPY       aip_ip_to.octeto_1%TYPE,
		SN_octeto_3		     OUT NOCOPY       aip_ip_to.octeto_1%TYPE,
		SN_octeto_4		  	 OUT NOCOPY       aip_ip_to.octeto_1%TYPE,
        SN_cod_retorno       OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno      OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        SN_num_evento        OUT NOCOPY       ge_errores_pg.evento
)
AS
    V_des_error            ge_errores_pg.DesEvent;
    sSql                   ge_errores_pg.vQuery;
    LN_retorno             integer;
    LN_Celular             aip_ip_to.num_celular%type;
    LV_EstadoAsignada_IP   varchar2(10);
    LV_EstadoDisponible_IP varchar2(10);
    LN_tipo_ip             aip_apn_to.tipo_ip%TYPE;
    LN_cod_qos             aip_apn_to.cod_qos%TYPE;
BEGIN
     SN_cod_retorno:=0;
     SV_mens_retorno:=' ';
     SN_num_evento:=0;
     sSql:='aip_recupera_parametros_fn('''||cv_estado_asignado||''','''||CV_modulo||''','||CN_cod_producto||')';
     IF NOT aip_recupera_parametros_fn(cv_estado_asignado,CV_modulo,CN_cod_producto,LV_EstadoAsignada_IP,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
         RAISE ERROR_CONTROLADO;
     END IF;

     BEGIN
        sSql:=' SELECT num_celular,cod_tipo_ip, cod_qos ';
        sSql:=sSql||' FROM  aip_ip_to a ';
        sSql:=sSql||' WHERE a.cod_tecnologia = '||EV_cod_tecnologia;
        sSql:=sSql||' AND a.cod_apn = '||EN_cod_apn;
        sSql:=sSql||' AND a.cod_estado_ip = '||LV_EstadoAsignada_IP;
        sSql:=sSql||' AND a.octeto_1 = '||EN_octeto_1;
        sSql:=sSql||' AND a.octeto_2 = '||EN_octeto_2;
        sSql:=sSql||' AND a.octeto_3 = '||EN_octeto_3;
        sSql:=sSql||' AND a.octeto_4 = '||EN_octeto_4;
        SELECT num_celular ,cod_tipo_ip, cod_qos
        INTO LN_Celular,LN_tipo_ip, LN_cod_qos
        FROM  aip_ip_to a
        WHERE a.cod_tecnologia = EV_cod_tecnologia
        AND a.cod_apn = EN_cod_apn
        AND a.cod_estado_ip = LV_EstadoAsignada_IP
        AND a.octeto_1 = EN_octeto_1
        AND a.octeto_2 = EN_octeto_2
        AND a.octeto_3 = EN_octeto_3
        AND a.octeto_4 = EN_octeto_4;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
             SN_cod_retorno :=2836 ;--IP no se encuentra en el sistema ó no está ASIGNADA
             RAISE ERROR_CONTROLADO;
     END;
    ---Buscar IP para reemplazar
     sSql:='aip_peticionip_pr('||EV_cod_tecnologia||','||EN_cod_apn||','||LN_tipo_ip||','||LN_cod_qos||',SN_octeto_1,SN_octeto_2,SN_octeto_3,SN_octeto_4,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
     aip_peticionip_pr(EV_cod_tecnologia,EN_cod_apn,LN_tipo_ip,LN_cod_qos ,SN_octeto_1,SN_octeto_2,SN_octeto_3,SN_octeto_4,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
     IF SN_cod_retorno <> cn_cero THEN
       RAISE ERROR_CONTROLADO;
     END IF;
     ---Cambio IP anterior
     sSql:='aip_recupera_parametros_fn('''||CV_estado_disponible||''','''||CV_modulo||''','||CN_cod_producto||')';
     IF NOT aip_recupera_parametros_fn(CV_estado_disponible,CV_modulo,CN_cod_producto,LV_EstadoDisponible_IP,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
         RAISE ERROR_CONTROLADO;
     END IF;
     sSql:='aip_modifica_estadoips_pr('||EN_octeto_1||','||EN_octeto_2||','||EN_octeto_3||','||EN_octeto_4||','||LV_EstadoDisponible_IP||','||LN_Celular||',SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
     aip_modifica_estadoips_pr(EN_octeto_1,EN_octeto_2,EN_octeto_3,EN_octeto_4,LV_EstadoDisponible_IP,LN_Celular,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
     IF SN_cod_retorno <> cn_cero THEN
       RAISE ERROR_CONTROLADO;
     END IF;
     sSql:='aip_modifica_estadoips_pr('||SN_octeto_1||','||SN_octeto_2||','||SN_octeto_3||','||SN_octeto_4||','||LV_EstadoAsignada_IP||','||LN_Celular||',SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
     aip_modifica_estadoips_pr(SN_octeto_1,SN_octeto_2,SN_octeto_3,SN_octeto_4,LV_EstadoAsignada_IP,LN_Celular,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
     IF SN_cod_retorno <> cn_cero THEN
       RAISE ERROR_CONTROLADO;
     END IF;
EXCEPTION
   WHEN ERROR_CONTROLADO THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_cambioip_pr(); - '||SV_mens_retorno ;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_cambioip_pr', sSql, SN_cod_retorno, V_des_error );
   WHEN OTHERS THEN
      SN_cod_retorno :=2835 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'aip_cambioip_pr(); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_cambioip_pr', sSql, SQLCODE, V_des_error );
END aip_cambioip_pr;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultasolapamiento_m_pr(
    EN_octeto_ini_1  IN aip_rangoipta_to.octeto_ini_1%TYPE,
 	EN_octeto_ini_2  IN aip_rangoipta_to.octeto_ini_2%TYPE,
	EN_octeto_ini_3  IN aip_rangoipta_to.octeto_ini_3%TYPE,
	EN_octeto_ini_4  IN aip_rangoipta_to.octeto_ini_4%TYPE,
	EN_octeto_fin_1  IN aip_rangoipta_to.octeto_fin_1%TYPE,
	EN_octeto_fin_2  IN aip_rangoipta_to.octeto_fin_2%TYPE,
	EN_octeto_fin_3  IN aip_rangoipta_to.octeto_fin_3%TYPE,
	EN_octeto_fin_4  IN aip_rangoipta_to.octeto_fin_4%TYPE,
    EN_codrangoip    IN aip_rangoipta_to.cod_rangoip%TYPE,    
 	SN_Solapamiento OUT NOCOPY  NUMBER,
	SN_cod_retorno  OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento   OUT NOCOPY  ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTASOLAPAMIENTO_M_PR"
      Lenguaje="PL/SQL"
      Fecha creación="08-09-2009"
      Creado por="Jubitza Villanueva G."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta si hay solapamiento</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_octeto_ini_1"  Tipo="NUMERICO">Primer octeto inicial de la ip</param>
            <param nom="EN_octeto_ini_2"  Tipo="NUMERICO">Segundo octeto inicial de la ip</param>
            <param nom="EN_octeto_ini_3"  Tipo="NUMERICO">Tercer octeto inicial de la ip</param>
            <param nom="EN_octeto_ini_4"  Tipo="NUMERICO">Cuarto octeto inicial de la ip</param>
            <param nom="EN_octeto_fin_1"  Tipo="NUMERICO">Primer octeto de la ip</param>
            <param nom="EN_octeto_fin_2"  Tipo="NUMERICO">Segundo octeto final de la ip</param>
            <param nom="EN_octeto_fin_3"  Tipo="NUMERICO">Tercer octeto final de la ip</param>
            <param nom="EN_octeto_fin_4"  Tipo="NUMERICO">Cuarto octeto final de la ip</param>
            <param nom="EN_codrangoip"    Tipo="NUMERICO">Código de rango ip</param>
         </Entrada>
         <Salida>
            <param nom="SN_Solapamiento"    Tipo="NUMERICO"></param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   LN_cod_rangoip   aip_rangoipta_to.cod_rangoip%TYPE;
BEGIN

   SN_num_evento:=CN_cero;
   SN_cod_retorno:=CN_cero;
   SV_mens_retorno:=NULL;
   LN_cod_rangoip:=null;


   sSql:='SELECT COUNT(a.cod_rangoip) INTO SN_Solapamiento'||
	' FROM AIP_RANGOIPTA_TO a'||
	'WHERE LTRIM(TO_CHAR(EN_octeto_ini_1,''009'')) || LTRIM(TO_CHAR(EN_octeto_ini_2,''009'')) || LTRIM(TO_CHAR(EN_octeto_ini_3,''009'')) || LTRIM(TO_CHAR(EN_octeto_ini_4,''009'')) BETWEEN'||
	     ' LTRIM(TO_CHAR(a.octeto_ini_1,''009''))|| LTRIM(TO_CHAR(a.octeto_ini_2,''009''))|| LTRIM(TO_CHAR(a.octeto_ini_3,''009''))||LTRIM(TO_CHAR(a.octeto_ini_4,''009''))   and'||
         ' LTRIM(TO_CHAR(a.octeto_fin_1,''009'')) || LTRIM(TO_CHAR(a.octeto_fin_2,''009'')) || LTRIM(TO_CHAR(a.octeto_fin_3,''009''))||LTRIM(TO_CHAR(a.octeto_fin_4,''009''))'||
      ' or LTRIM(TO_CHAR(EN_octeto_fin_1,''009'')) || LTRIM(TO_CHAR(EN_octeto_fin_2,''009'')) || LTRIM(TO_CHAR(EN_octeto_fin_3,''009'')) || LTRIM(TO_CHAR(EN_octeto_fin_4,''009'')) BETWEEN'||
	   '   LTRIM(TO_CHAR(a.octeto_ini_1,''009''))|| LTRIM(TO_CHAR(a.octeto_ini_2,''009''))|| LTRIM(TO_CHAR(a.octeto_ini_3,''009''))||LTRIM(TO_CHAR(a.octeto_ini_4,''009''))   and'||
        '  LTRIM(TO_CHAR(a.octeto_fin_1,''009'')) || LTRIM(TO_CHAR(a.octeto_fin_2,''009'')) || LTRIM(TO_CHAR(a.octeto_fin_3,''009''))||LTRIM(TO_CHAR(a.octeto_fin_4,''009''))';


   SELECT COUNT(a.cod_rangoip) INTO SN_Solapamiento
	 FROM AIP_RANGOIPTA_TO a
	WHERE LTRIM(TO_CHAR(EN_octeto_ini_1,'009')) || LTRIM(TO_CHAR(EN_octeto_ini_2,'009')) || LTRIM(TO_CHAR(EN_octeto_ini_3,'009')) || LTRIM(TO_CHAR(EN_octeto_ini_4,'009')) BETWEEN
	      LTRIM(TO_CHAR(a.octeto_ini_1,'009'))|| LTRIM(TO_CHAR(a.octeto_ini_2,'009'))|| LTRIM(TO_CHAR(a.octeto_ini_3,'009'))||LTRIM(TO_CHAR(a.octeto_ini_4,'009'))   and
          LTRIM(TO_CHAR(a.octeto_fin_1,'009')) || LTRIM(TO_CHAR(a.octeto_fin_2,'009')) || LTRIM(TO_CHAR(a.octeto_fin_3,'009'))||LTRIM(TO_CHAR(a.octeto_fin_4,'009'))
       or LTRIM(TO_CHAR(EN_octeto_fin_1,'009')) || LTRIM(TO_CHAR(EN_octeto_fin_2,'009')) || LTRIM(TO_CHAR(EN_octeto_fin_3,'009')) || LTRIM(TO_CHAR(EN_octeto_fin_4,'009')) BETWEEN
	      LTRIM(TO_CHAR(a.octeto_ini_1,'009'))|| LTRIM(TO_CHAR(a.octeto_ini_2,'009'))|| LTRIM(TO_CHAR(a.octeto_ini_3,'009'))||LTRIM(TO_CHAR(a.octeto_ini_4,'009'))   and
          LTRIM(TO_CHAR(a.octeto_fin_1,'009')) || LTRIM(TO_CHAR(a.octeto_fin_2,'009')) || LTRIM(TO_CHAR(a.octeto_fin_3,'009'))||LTRIM(TO_CHAR(a.octeto_fin_4,'009'));



    IF SN_Solapamiento=1 THEN
       sSql:='a.cod_rangoip into LN_cod_rangoip'||
        ' FROM AIP_RANGOIPTA_TO a'||
        'WHERE LTRIM(TO_CHAR(EN_octeto_ini_1,''009'')) || LTRIM(TO_CHAR(EN_octeto_ini_2,''009'')) || LTRIM(TO_CHAR(EN_octeto_ini_3,''009'')) || LTRIM(TO_CHAR(EN_octeto_ini_4,''009'')) BETWEEN'||
             ' LTRIM(TO_CHAR(a.octeto_ini_1,''009''))|| LTRIM(TO_CHAR(a.octeto_ini_2,''009''))|| LTRIM(TO_CHAR(a.octeto_ini_3,''009''))||LTRIM(TO_CHAR(a.octeto_ini_4,''009''))   and'||
             ' LTRIM(TO_CHAR(a.octeto_fin_1,''009'')) || LTRIM(TO_CHAR(a.octeto_fin_2,''009'')) || LTRIM(TO_CHAR(a.octeto_fin_3,''009''))||LTRIM(TO_CHAR(a.octeto_fin_4,''009''))'||
          ' or LTRIM(TO_CHAR(EN_octeto_fin_1,''009'')) || LTRIM(TO_CHAR(EN_octeto_fin_2,''009'')) || LTRIM(TO_CHAR(EN_octeto_fin_3,''009'')) || LTRIM(TO_CHAR(EN_octeto_fin_4,''009'')) BETWEEN'||
           '   LTRIM(TO_CHAR(a.octeto_ini_1,''009''))|| LTRIM(TO_CHAR(a.octeto_ini_2,''009''))|| LTRIM(TO_CHAR(a.octeto_ini_3,''009''))||LTRIM(TO_CHAR(a.octeto_ini_4,''009''))   and'||
            '  LTRIM(TO_CHAR(a.octeto_fin_1,''009'')) || LTRIM(TO_CHAR(a.octeto_fin_2,''009'')) || LTRIM(TO_CHAR(a.octeto_fin_3,''009''))||LTRIM(TO_CHAR(a.octeto_fin_4,''009''))';

       SELECT a.cod_rangoip into LN_cod_rangoip
         FROM AIP_RANGOIPTA_TO a
        WHERE LTRIM(TO_CHAR(EN_octeto_ini_1,'009')) || LTRIM(TO_CHAR(EN_octeto_ini_2,'009')) || LTRIM(TO_CHAR(EN_octeto_ini_3,'009')) || LTRIM(TO_CHAR(EN_octeto_ini_4,'009')) BETWEEN
              LTRIM(TO_CHAR(a.octeto_ini_1,'009'))|| LTRIM(TO_CHAR(a.octeto_ini_2,'009'))|| LTRIM(TO_CHAR(a.octeto_ini_3,'009'))||LTRIM(TO_CHAR(a.octeto_ini_4,'009'))   and
              LTRIM(TO_CHAR(a.octeto_fin_1,'009')) || LTRIM(TO_CHAR(a.octeto_fin_2,'009')) || LTRIM(TO_CHAR(a.octeto_fin_3,'009'))||LTRIM(TO_CHAR(a.octeto_fin_4,'009'))
           or LTRIM(TO_CHAR(EN_octeto_fin_1,'009')) || LTRIM(TO_CHAR(EN_octeto_fin_2,'009')) || LTRIM(TO_CHAR(EN_octeto_fin_3,'009')) || LTRIM(TO_CHAR(EN_octeto_fin_4,'009')) BETWEEN
              LTRIM(TO_CHAR(a.octeto_ini_1,'009'))|| LTRIM(TO_CHAR(a.octeto_ini_2,'009'))|| LTRIM(TO_CHAR(a.octeto_ini_3,'009'))||LTRIM(TO_CHAR(a.octeto_ini_4,'009'))   and
              LTRIM(TO_CHAR(a.octeto_fin_1,'009')) || LTRIM(TO_CHAR(a.octeto_fin_2,'009')) || LTRIM(TO_CHAR(a.octeto_fin_3,'009'))||LTRIM(TO_CHAR(a.octeto_fin_4,'009'));


        IF LN_cod_rangoip=EN_codrangoip THEN
           SN_Solapamiento:=0;
        END IF;
    END IF;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
	     NULL;
   WHEN OTHERS THEN
      SN_cod_retorno:= 454;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno:=CV_error_no_clasif;
      END IF;
      V_des_error:='aip_consultasolapamiento_m_pr('||EN_octeto_ini_1||','||EN_octeto_ini_2||','||EN_octeto_ini_3||','||EN_octeto_ini_4||','||
                                            EN_octeto_fin_1||','||EN_octeto_fin_2||','||EN_octeto_fin_3||','||EN_octeto_fin_4||');-' || SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AIP', SV_mens_retorno, '1.0', USER, 'aip_administracion_pg.aip_consultasolapamiento_m_pr', sSql, SN_cod_retorno, V_des_error);

END aip_consultasolapamiento_m_pr;
------------------------------------------------------------------------------------------------------------------------------------------------------------------
END aip_administracion_pg; 
/
SHOW ERRORS
