CREATE OR REPLACE PACKAGE BODY aip_consultas_mask_pg AS

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultaestados_pr (
    tEstado       OUT NOCOPY refcursor,
    SV_retorno    OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTAESTADOS_PR"
      Lenguaje="PL/SQL"
      Fecha creación="12-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Estados</Descripción>
      <Parámetros>
         <Salida>
            <param nom="tEstado" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    N_cod_retorno  ge_errores_pg.CodError;
    V_mens_retorno ge_errores_pg.MsgError;
    N_num_evento   ge_errores_pg.Evento;
BEGIN

    N_cod_retorno := 0;
    N_num_evento := 0;
    V_mens_retorno := '0';

       aip_administracion_pg.aip_consultaestados_pr(tEstado, N_cod_retorno, V_mens_retorno, N_num_evento);

    IF N_cod_retorno = 0 THEN
        SV_retorno := '0-No Error';
    ELSE
        OPEN testado FOR
        SELECT NULL FROM DUAL;

        SV_retorno := TO_CHAR( N_num_evento ) || '-' || V_mens_retorno;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
        SV_retorno := '-1' || '-' || SQLERRM ;

END aip_consultaestados_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultatecnologia_pr (
    tTecnologia    OUT NOCOPY refcursor,
    SV_retorno     OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTATECNOLOGIA_PR"
      Lenguaje="PL/SQL"
      Fecha creación="12-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Tecnologia</Descripción>
      <Parámetros>
         <Salida>
            <param nom="tTecnologia" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    N_cod_retorno  ge_errores_pg.CodError;
    V_mens_retorno ge_errores_pg.MsgError;
    N_num_evento   ge_errores_pg.Evento;
BEGIN

    N_cod_retorno := 0;
    N_num_evento := 0;
    V_mens_retorno := '0';

       aip_administracion_pg.aip_consultatecnologia_pr(tTecnologia, N_cod_retorno, V_mens_retorno, N_num_evento);

    IF N_cod_retorno = 0 THEN
        SV_retorno := '0-No Error';
    ELSE
        OPEN tTecnologia FOR
        SELECT NULL FROM DUAL;

        SV_retorno := TO_CHAR( N_num_evento ) || '-' || V_mens_retorno;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
        SV_retorno := '-1' || '-' || SQLERRM ;

END aip_consultatecnologia_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultasersuplement_pr (
    tSerSupl       OUT NOCOPY refcursor,
    SV_retorno     OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTASERSUPLEMENT_PR"
      Lenguaje="PL/SQL"
      Fecha creación="12-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Servicios Suplementarios</Descripción>
      <Parámetros>
         <Salida>
            <param nom="tSerSupl" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    N_cod_retorno  ge_errores_pg.CodError;
    V_mens_retorno ge_errores_pg.MsgError;
    N_num_evento   ge_errores_pg.Evento;
BEGIN

    N_cod_retorno := 0;
    N_num_evento := 0;
    V_mens_retorno := '0';

       aip_administracion_pg.aip_consultasersuplement_pr(tSerSupl, N_cod_retorno, V_mens_retorno, N_num_evento);

    IF N_cod_retorno = 0 THEN
        SV_retorno := '0-No Error';
    ELSE
        OPEN tSerSupl FOR
        SELECT NULL FROM DUAL;

        SV_retorno := TO_CHAR( N_num_evento ) || '-' || V_mens_retorno;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
        SV_retorno := '-1' || '-' || SQLERRM ;

END aip_consultasersuplement_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultaapiqos_pr (
    EV_vigencia    IN               aip_qos_to.vigencia%TYPE,
    tApiQos        OUT NOCOPY       refcursor,
    SV_retorno     OUT NOCOPY       VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTAAPIQOS_PR"
      Lenguaje="PL/SQL"
      Fecha creación="12-08-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Consulta Api QoS</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_vigencia" Tipo="CARACTER">Vigencia</param>
         </Entrada>
         <Salida>
            <param nom="tApiQos" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    N_cod_retorno  ge_errores_pg.CodError;
    V_mens_retorno ge_errores_pg.MsgError;
    N_num_evento   ge_errores_pg.Evento;
BEGIN

    N_cod_retorno := 0;
    N_num_evento := 0;
    V_mens_retorno := '0';

       aip_administracion_pg.aip_consultaapiqos_pr(EV_vigencia, tApiQos, N_cod_retorno, V_mens_retorno, N_num_evento);

    IF N_cod_retorno = 0 THEN
        SV_retorno := '0-No Error';
    ELSE
        OPEN tApiQos FOR
        SELECT NULL FROM DUAL;

        SV_retorno := TO_CHAR( N_num_evento ) || '-' || V_mens_retorno;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
        SV_retorno := '-1' || '-' || SQLERRM ;

END aip_consultaapiqos_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultacompqos_pr (
    SC_conqos     OUT NOCOPY refcursor,
    SV_retorno    OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_ConsultaCompQoS_PR"
      Lenguaje="PL/SQL"
      Fecha="11-08-2005"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Descripción>Recupera Componentes QoS</Descripción>
      <Parámetros>
         <Entrada>
        </Entrada>
         <Salida>
            <param nom="SC_ConQoS"    Tipo="Cursor">Datos de los componentes QoS</param>
            <param nom="SV_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    N_cod_retorno  ge_errores_pg.CodError;
    V_mens_retorno ge_errores_pg.MsgError;
    N_num_evento   ge_errores_pg.Evento;
BEGIN

    N_cod_retorno := 0;
    N_num_evento := 0;
    V_mens_retorno := '0';

       aip_administracion_pg.aip_consultacompqos_pr(SC_conqos, N_cod_retorno, V_mens_retorno, N_num_evento);

    IF N_cod_retorno = 0 THEN
        SV_retorno := '0-No Error';
    ELSE
        OPEN SC_conqos FOR
        SELECT NULL FROM DUAL;

        SV_retorno := TO_CHAR( N_num_evento ) || '-' || V_mens_retorno;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
        SV_retorno := '-1' || '-' || SQLERRM ;

END aip_consultacompqos_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultaapiapn_pr (
    EV_vigencia    IN aip_apn_to.vigencia%TYPE,
    SC_apiapn     OUT NOCOPY refcursor,
    SV_retorno    OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_ConsultaApiAPN_PR"
      Lenguaje="PL/SQL"
      Fecha="11-08-2005"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Descripción>Recupera consulta ApiAPN</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_vigencia"   Tipo="CARACTER">Indicador de vigencia</param>
        </Entrada>
         <Salida>
            <param nom="SC_ApiAPN"    Tipo="Cursor">Datos de ApiAPN</param>
            <param nom="SV_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    N_cod_retorno  ge_errores_pg.CodError;
    V_mens_retorno ge_errores_pg.MsgError;
    N_num_evento   ge_errores_pg.Evento;
BEGIN

    N_cod_retorno := 0;
    N_num_evento := 0;
    V_mens_retorno := '0';

       aip_administracion_pg.aip_consultaapiapn_pr(EV_vigencia, SC_apiapn, N_cod_retorno, V_mens_retorno, N_num_evento);

    IF N_cod_retorno = 0 THEN
        SV_retorno := '0-No Error';
    ELSE
        OPEN SC_apiapn FOR
        SELECT NULL FROM DUAL;

        SV_retorno := TO_CHAR( N_num_evento ) || '-' || V_mens_retorno;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
        SV_retorno := '-1' || '-' || SQLERRM ;

END aip_consultaapiapn_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultaestadoip_pr (
    SC_estadoip    OUT NOCOPY    refcursor,
    SV_retorno     OUT NOCOPY    VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_ConsultaEstadoIP_PR"
      Lenguaje="PL/SQL"
      Fecha="11-08-2005"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Descripción>Recupera consulta estados Ip</Descripción>
      <Parámetros>
         <Entrada>
        </Entrada>
         <Salida>
            <param nom="SC_EstadoIP"   Tipo="Cursor">Datos de estados de ip</param>
            <param nom="SV_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    N_cod_retorno  ge_errores_pg.CodError;
    V_mens_retorno ge_errores_pg.MsgError;
    N_num_evento   ge_errores_pg.Evento;
BEGIN

    N_cod_retorno := 0;
    N_num_evento := 0;
    V_mens_retorno := '0';

       aip_administracion_pg.aip_consultaestadoip_pr(SC_estadoip, N_cod_retorno, V_mens_retorno, N_num_evento);

    IF N_cod_retorno = 0 THEN
        SV_retorno := '0-No Error';
    ELSE
        OPEN SC_estadoip FOR
        SELECT NULL FROM DUAL;

        SV_retorno := TO_CHAR( N_num_evento ) || '-' || V_mens_retorno;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
        SV_retorno := '-1' || '-' || SQLERRM ;

END aip_consultaestadoip_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultarangosip_pr (
    EN_cod_rangoip     IN aip_rangoipta_to.cod_rangoip%TYPE,
    EV_cod_tecnologia  IN aip_rangoipta_to.cod_tecnologia%TYPE,
    EN_cod_apn         IN aip_rangoipta_to.cod_apn%TYPE,
    EV_fecha_desde     IN VARCHAR2,
    EV_fecha_hasta     IN VARCHAR2,
    EN_octeto_ini_1    IN aip_rangoipta_to.octeto_ini_1%TYPE,
    EN_octeto_ini_2    IN aip_rangoipta_to.octeto_ini_2%TYPE,
    EN_octeto_ini_3    IN aip_rangoipta_to.octeto_ini_3%TYPE,
    EN_octeto_ini_4    IN aip_rangoipta_to.octeto_ini_4%TYPE,
    EN_octeto_fin_1    IN aip_rangoipta_to.octeto_fin_1%TYPE,
    EN_octeto_fin_2    IN aip_rangoipta_to.octeto_fin_2%TYPE,
    EN_octeto_fin_3    IN aip_rangoipta_to.octeto_fin_3%TYPE,
    EN_octeto_fin_4    IN aip_rangoipta_to.octeto_fin_4%TYPE,
    SC_rangosip       OUT NOCOPY refcursor,
    SV_retorno        OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTARANGOSIP_PR"
      Lenguaje="PL/SQL"
      Fecha="11-08-2005"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
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
            <param nom="SV_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    N_cod_retorno  ge_errores_pg.CodError;
    V_mens_retorno ge_errores_pg.MsgError;
    N_num_evento   ge_errores_pg.Evento;
BEGIN

    N_cod_retorno := 0;
    N_num_evento := 0;
    V_mens_retorno := '0';

       aip_administracion_pg.aip_consultarangosip_pr(EN_cod_rangoip,EV_cod_tecnologia,EN_cod_apn,EV_fecha_desde,EV_fecha_hasta,EN_octeto_ini_1,EN_octeto_ini_2,EN_octeto_ini_3,EN_octeto_ini_4,EN_octeto_fin_1,EN_octeto_fin_2,EN_octeto_fin_3,EN_octeto_fin_4,SC_rangosip,N_cod_retorno,V_mens_retorno,N_num_evento);

    IF N_cod_retorno = 0 THEN
        SV_retorno := '0-No Error';
    ELSE
        OPEN SC_rangosip FOR
        SELECT NULL FROM DUAL;

        SV_retorno := TO_CHAR( N_num_evento ) || '-' || V_mens_retorno;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
        SV_retorno := '-1' || '-' || SQLERRM ;

END aip_consultarangosip_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultaips_pr (
    EV_cod_tecnologia  IN aip_ip_to.cod_tecnologia%TYPE,
    EN_cod_apn         IN aip_ip_to.cod_apn%TYPE,
    EV_fecha_desde     IN VARCHAR2,
    EV_fecha_hasta     IN VARCHAR2,
    EN_octeto_ini_1    IN aip_ip_to.octeto_1%TYPE,
    EN_octeto_ini_2    IN aip_ip_to.octeto_2%TYPE,
    EN_octeto_ini_3    IN aip_ip_to.octeto_3%TYPE,
    EN_octeto_ini_4    IN aip_ip_to.octeto_4%TYPE,
    EN_octeto_fin_1    IN aip_ip_to.octeto_1%TYPE,
    EN_octeto_fin_2    IN aip_ip_to.octeto_2%TYPE,
    EN_octeto_fin_3    IN aip_ip_to.octeto_3%TYPE,
    EN_octeto_fin_4    IN aip_ip_to.octeto_4%TYPE,
    SC_ips            OUT NOCOPY refcursor,
    SV_retorno        OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_ConsultaIPs_PR"
      Lenguaje="PL/SQL"
      Fecha="11-08-2005"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
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
            <param nom="SV_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    N_cod_retorno  ge_errores_pg.CodError;
    V_mens_retorno ge_errores_pg.MsgError;
    N_num_evento   ge_errores_pg.Evento;
BEGIN

    N_cod_retorno := 0;
    N_num_evento := 0;
    V_mens_retorno := '0';

       aip_administracion_pg.aip_consultaips_pr(EV_cod_tecnologia,EN_cod_apn,EV_fecha_desde,EV_fecha_hasta,EN_octeto_ini_1,EN_octeto_ini_2,EN_octeto_ini_3,EN_octeto_ini_4,EN_octeto_fin_1,EN_octeto_fin_2,EN_octeto_fin_3,EN_octeto_fin_4,SC_ips,N_cod_retorno,V_mens_retorno,N_num_evento);

    IF N_cod_retorno = 0 THEN
        SV_retorno := '0-No Error';
    ELSE
        OPEN SC_ips FOR
        SELECT NULL FROM DUAL;

        SV_retorno := TO_CHAR( N_num_evento ) || '-' || V_mens_retorno;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
        SV_retorno := '-1' || '-' || SQLERRM ;

END aip_consultaips_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultaipshis_pr (
    EN_cod_apn        IN aip_ip_th.cod_apn%TYPE,
    EN_num_celular    IN aip_ip_th.num_celular%TYPE,
    EN_cod_estado_ip  IN aip_ip_th.cod_estado_ip%TYPE,
    EV_fecha_desde    IN VARCHAR2,
    EV_fecha_hasta    IN VARCHAR2,
    EN_octeto_ini_1   IN aip_ip_th.octeto_1%TYPE,
    EN_octeto_ini_2   IN aip_ip_th.octeto_2%TYPE,
    EN_octeto_ini_3   IN aip_ip_th.octeto_3%TYPE,
    EN_octeto_ini_4   IN aip_ip_th.octeto_4%TYPE,
    EN_octeto_fin_1   IN aip_ip_th.octeto_1%TYPE,
    EN_octeto_fin_2   IN aip_ip_th.octeto_2%TYPE,
    EN_octeto_fin_3   IN aip_ip_th.octeto_3%TYPE,
    EN_octeto_fin_4   IN aip_ip_th.octeto_4%TYPE,
    SC_ipshis         OUT NOCOPY refcursor,
    SV_retorno        OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_ConsultaIPsHis_PR"
      Lenguaje="PL/SQL"
      Fecha="11-08-2005"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
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
            <param nom="SC_ipshis"    Tipo="Cursor">Datos históricos de la ip </param>
            <param nom="SV_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    N_cod_retorno  ge_errores_pg.CodError;
    V_mens_retorno ge_errores_pg.MsgError;
    N_num_evento   ge_errores_pg.Evento;
BEGIN

    N_cod_retorno := 0;
    N_num_evento := 0;
    V_mens_retorno := '0';

       aip_administracion_pg.aip_consultaipshis_pr(EN_cod_apn,EN_num_celular,EN_cod_estado_ip,EV_fecha_desde,EV_fecha_hasta,EN_octeto_ini_1,EN_octeto_ini_2,EN_octeto_ini_3,EN_octeto_ini_4,EN_octeto_fin_1,EN_octeto_fin_2,EN_octeto_fin_3,EN_octeto_fin_4,SC_ipshis,N_cod_retorno,V_mens_retorno,N_num_evento);

    IF N_cod_retorno = 0 THEN
        SV_retorno := '0-No Error';
    ELSE
        OPEN SC_ipshis FOR
        SELECT NULL FROM DUAL;

        SV_retorno := TO_CHAR( N_num_evento ) || '-' || V_mens_retorno;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
        SV_retorno := '-1' || '-' || SQLERRM ;

END aip_consultaipshis_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultadisponibilizar_pr (
    EV_cod_tecnologia     IN aip_rangoipta_to.cod_tecnologia%TYPE,
    EN_cod_apn            IN aip_rangoipta_to.cod_apn%TYPE,
    EV_formato_fecha      IN VARCHAR2,
    EV_fecha_movimiento   IN VARCHAR2,
    EV_disponibilizar     IN VARCHAR2,
    SC_disponibilizarip  OUT NOCOPY refcursor,
    SV_retorno           OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_ConsultaDisponibilizar_PR"
      Lenguaje="PL/SQL"
      Fecha="11-08-2005"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
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
            <param nom="SV_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    N_cod_retorno  ge_errores_pg.CodError;
    V_mens_retorno ge_errores_pg.MsgError;
    N_num_evento   ge_errores_pg.Evento;
BEGIN

    N_cod_retorno := 0;
    N_num_evento := 0;
    V_mens_retorno := '0';

       aip_administracion_pg.aip_consultadisponibilizar_pr(EV_cod_tecnologia,EN_cod_apn,TO_DATE(EV_fecha_movimiento, EV_formato_fecha),EV_disponibilizar,SC_disponibilizarip,N_cod_retorno,V_mens_retorno,N_num_evento);

    IF N_cod_retorno = 0 THEN
        SV_retorno := '0-No Error';
    ELSE
        OPEN SC_disponibilizarip FOR
        SELECT NULL FROM DUAL;

        SV_retorno := TO_CHAR( N_num_evento ) || '-' || V_mens_retorno;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
        SV_retorno := '-1' || '-' || SQLERRM ;

END aip_consultadisponibilizar_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultavigencia_pr (
    SC_vigencia   OUT NOCOPY refcursor,
    SV_retorno    OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_ConsultaVigencia_PR"
      Lenguaje="PL/SQL"
      Fecha="11-08-2005"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Descripción>Consulta datos de parametros de vigencia para IP</Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
            <param nom="SC_Vigencia"    Tipo="Cursor">Datos de los parametros de vigencia</param>
            <param nom="SV_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    N_cod_retorno  ge_errores_pg.CodError;
    V_mens_retorno ge_errores_pg.MsgError;
    N_num_evento   ge_errores_pg.Evento;
BEGIN

    N_cod_retorno := 0;
    N_num_evento := 0;
    V_mens_retorno := '0';

       aip_administracion_pg.aip_consultavigencia_pr(SC_vigencia, N_cod_retorno, V_mens_retorno, N_num_evento);

    IF N_cod_retorno = 0 THEN
        SV_retorno := '0-No Error';
    ELSE
        OPEN SC_vigencia FOR
        SELECT NULL FROM DUAL;

        SV_retorno := TO_CHAR( N_num_evento ) || '-' || V_mens_retorno;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
        SV_retorno := '-1' || '-' || SQLERRM ;

END aip_consultavigencia_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE aip_consultaTipoIp_pr (
    sc_TipoIp      OUT NOCOPY refcursor,
    SV_retorno     OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AIP_CONSULTASERSUPLEMENT_PR"
      Lenguaje="PL/SQL"
      Fecha creación="12-08-2005"
      Creado por=""
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Servicios Suplementarios</Descripción>
      <Parámetros>
         <Salida>
            <param nom="tSerSupl" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    N_cod_retorno  ge_errores_pg.CodError;
    V_mens_retorno ge_errores_pg.MsgError;
    N_num_evento   ge_errores_pg.Evento;
BEGIN

    N_cod_retorno := 0;
    N_num_evento := 0;
    V_mens_retorno := '0';

       aip_administracion_pg.aip_consultaTipoIp_pr(sc_TipoIp, N_cod_retorno, V_mens_retorno, N_num_evento);

    IF N_cod_retorno = 0 THEN
        SV_retorno := '0-No Error';
    ELSE
        OPEN sc_TipoIp FOR
        SELECT NULL FROM DUAL;

        SV_retorno := TO_CHAR( N_num_evento ) || '-' || V_mens_retorno;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
        SV_retorno := '-1' || '-' || SQLERRM ;

END aip_consultaTipoIp_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END aip_consultas_mask_pg; 
/
SHOW ERRORS