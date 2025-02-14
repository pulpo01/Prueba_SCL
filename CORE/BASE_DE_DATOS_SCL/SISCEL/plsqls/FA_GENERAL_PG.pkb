CREATE OR REPLACE PACKAGE BODY FA_GENERAL_PG AS
/*
<Documentación
  TipoDoc = "Package">
   <Elemento
      Nombre="FA_CAMBIOS_ABONADO_PG"
      Lenguaje="PL/SQL"
      Fecha creación="17-05-2005"
      Creado por="Carlos Navarro H. - Marcelo Godoy S."
      Fecha modificación="17-05-2005"
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Package con el conjunto de servicios del proyecto P-TMC-04020-Mecanismos de Integración entre SCL y Plataformas Comerciales</Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

   CV_error_no_clasif  VARCHAR2(50):= 'No es posible clasificar el error';


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION fa_valida_ciclo_fn (
   EN_cod_ciclfact       IN    fa_ciclfact.cod_ciclfact%TYPE,
   SN_cod_retorno      OUT   NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno     OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento       OUT   NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "fa_valida_ciclo_fn"
      Lenguaje="PL/SQL"
      Fecha="03-05-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Cristian Vargas."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida el ciclo de facturacion traiga datos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_ciclfact" Tipo="NUMERICO">Codigo de Ciclo Factura</param>
         </Entrada>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
   V_des_error        ge_errores_pg.DesEvent;
   sSql               ge_errores_pg.vQuery;
   ln_valida		  number;
   NO_EXISTE_CICLO    EXCEPTION;
BEGIN

    SN_cod_retorno := '0';
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

 sSql := 'SELECT count(0)';
    sSql := sSql || ' INTO ln_valida';
 sSql := sSql || ' FROM fa_ciclfact';
    sSql := sSql || ' WHERE cod_ciclfact = ' || EN_cod_ciclfact;



 SELECT count(0)
    INTO   ln_valida
    FROM   fa_ciclfact
	WHERE cod_ciclfact = EN_cod_ciclfact;

	IF ln_valida = 0 THEN
	   RAISE NO_EXISTE_CICLO;
	END IF;
 RETURN TRUE;

EXCEPTION

   WHEN NO_EXISTE_CICLO THEN

      SN_cod_retorno := '200';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'fa_valida_ciclo_fn('||EN_cod_ciclfact||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_valida_ciclo_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := '156';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'fa_valida_ciclo_fn('||EN_cod_ciclfact||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_valida_ciclo_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

END fa_valida_ciclo_fn;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION fa_recupera_cicloperactual_fn (
   EN_ciclo       IN    fa_ciclfact.cod_ciclo%TYPE,
   SN_cod_ciclfact    OUT  NOCOPY fa_ciclfact.cod_ciclfact%TYPE,
   SN_cod_retorno      OUT   NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno     OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento       OUT   NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "FA_RECUPERA_CICLOPERACTUAL_FN"
      Lenguaje="PL/SQL"
      Fecha="03-05-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera Ciclo de Facturacion Actual</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_ciclo" Tipo="NUMERICO">Codigo de Ciclo</param>
         </Entrada>
            <param nom="SN_cod_ciclofact" Tipo="NUMERICO">Codigo de Ciclo de la Factura</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
   V_des_error        ge_errores_pg.DesEvent;
   sSql               ge_errores_pg.vQuery;
BEGIN

    SN_cod_retorno := '0';
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

 sSql := 'SELECT cod_ciclfact';
    sSql := sSql || ' INTO SN_cod_ciclfact';
 sSql := sSql || ' FROM fa_ciclfact';
    sSql := sSql || ' WHERE cod_ciclo = ' || EN_ciclo;
    sSql := sSql || ' AND SYSDATE BETWEEN fec_desdellam AND fec_hastallam';


	DBMS_OUTPUT.PUT_LINE(' EN_ciclo :' || TO_CHAR(EN_ciclo));
 SELECT cod_ciclfact
    INTO   SN_cod_ciclfact
 FROM   fa_ciclfact
    WHERE  cod_ciclo = EN_ciclo
    AND    SYSDATE  BETWEEN fec_desdellam AND fec_hastallam;
		DBMS_OUTPUT.PUT_LINE('PASO2');
 RETURN TRUE;

EXCEPTION

   WHEN NO_DATA_FOUND THEN
   			DBMS_OUTPUT.PUT_LINE('PASO3');
      SN_cod_retorno := '200';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'fa_recupera_cicloperactual_fn('||EN_ciclo||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_recupera_cicloperactual_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := '156';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'fa_recupera_cicloperactual_fn('||EN_ciclo||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_recupera_cicloperactual_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

END fa_recupera_cicloperactual_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fa_cons_tablas_enlacehist_fn (
   EN_cod_ciclfact    IN    fa_enlacehist.cod_ciclfact%TYPE,
   SV_fa_detcelular    OUT   NOCOPY fa_enlacehist.fa_detcelular%TYPE,
   SV_fa_detroaming    OUT   NOCOPY fa_enlacehist.fa_detroaming%TYPE,
   SV_fa_histdocu    OUT   NOCOPY fa_enlacehist.fa_histdocu%TYPE,
   SV_fa_histconc    OUT   NOCOPY fa_enlacehist.fa_histconc%TYPE,
   SN_cod_tipalmac    OUT   NOCOPY fa_enlacehist.cod_tipalmac%TYPE,
   SN_ind_tasador    OUT   NOCOPY fa_enlacehist.ind_tasador%TYPE,
   SN_cod_retorno      OUT   NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno     OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento       OUT   NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "FA_CONS_TABLAS_ENLACEHIST_FN"
      Lenguaje="PL/SQL"
      Fecha="02-05-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera Tabla de Almacenamiento Historicos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_ciclfact" Tipo="CARACTER">Ciclo de Facturacion</param>
         </Entrada>
   <param nom="SV_fa_detcelular" Tipo="CARACTER">Tabla FA_DETCELULAR</param>
   <param nom="SV_fa_detroaming" Tipo="CARACTER">Tabla FA_DETROAMING</param>
   <param nom="SV_fa_histdocu" Tipo="CARACTER">Tabla FA_HISTDOCU</param>
   <param nom="SV_fa_histconc" Tipo="CARACTER">Tabla FA_HISTCONC</param>
   <param nom="SN_cod_tipalmac" Tipo="NUMERICO">Tipo de Almacenamiento</param>
   <param nom="SN_ind_tasador" Tipo="NUMERICO">Tasador</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
   V_des_error        ge_errores_pg.DesEvent;
   sSql               ge_errores_pg.vQuery;
BEGIN

    SN_cod_retorno := '0';
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

 sSql := 'SELECT fa_detcelular, fa_detroaming, fa_histdocu, fa_histconc, cod_tipalmac, ind_tasador';
	 sSql := sSql || ' FROM fa_enlacehist';
 sSql := sSql || ' WHERE cod_ciclfact = '||EN_cod_ciclfact;

 SELECT fa_detcelular, fa_detroaming, fa_histdocu, fa_histconc, cod_tipalmac, ind_tasador
 INTO   SV_fa_detcelular, SV_fa_detroaming, SV_fa_histdocu, SV_fa_histconc, SN_cod_tipalmac, SN_ind_tasador
 FROM   fa_enlacehist
 WHERE  cod_ciclfact = EN_cod_ciclfact;

 RETURN TRUE;

EXCEPTION

   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := '890037';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'fa_cons_tablas_enlacehist_fn('||EN_cod_ciclfact||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_cons_tablas_enlacehist_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := '156';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'fa_cons_tablas_enlacehist_fn('||EN_cod_ciclfact||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_cons_tablas_enlacehist_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

END fa_cons_tablas_enlacehist_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fa_datos_documento_fn (
   EN_cod_cliente   IN     fa_histdocu.cod_cliente%TYPE,
   EN_cod_ciclfact    IN  fa_histdocu.cod_ciclfact%TYPE,
   SN_num_folio    OUT  NOCOPY fa_histdocu.num_folio%TYPE,
   SN_ind_ordentotal  OUT  NOCOPY fa_histdocu.ind_ordentotal%TYPE,
   SN_num_proceso   OUT  NOCOPY fa_histdocu.num_proceso%TYPE,
   SN_num_secuenci    OUT    NOCOPY fa_histdocu.num_secuenci%TYPE,
   SN_cod_retorno     OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno    OUT    NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento      OUT    NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "FA_DATOS_DOCUMENTO_FN"
      Lenguaje="PL/SQL"
      Fecha="03-05-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera informacion basica de un documento de facturacion</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo de Cliente</param>
            <param nom="EN_cod_ciclfact" Tipo="NUMERICO">Ciclo de Facturacion</param>
         </Entrada>
         <Salida>
            <param nom="SN_num_folio" Tipo="NUMERICO">Numero de Folio</param>
            <param nom="SN_ind_ordentotal" Tipo="NUMERICO">Indicador de Orden Total</param>
            <param nom="SN_num_proceso" Tipo="NUMERICO">Numero de Proceso</param>
            <param nom="SN_num_secuenci" Tipo="NUMERICO">Numero de Secuancia</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS
   V_des_error         ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   error_parametros    EXCEPTION;
BEGIN

    SN_cod_retorno := '0';
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

 sSql := 'SELECT num_folio, ind_ordentotal, num_proceso, num_secuenci';
 sSql := sSql || ' INTO SN_num_folio, SN_ind_ordentotal, SN_num_proceso, SN_num_secuanci';
 sSql := sSql || ' FROM fa_histdocu';
 sSql := sSql || ' WHERE cod_cliente = '||EN_cod_cliente;
 sSql := sSql || ' AND cod_ciclfact = '||EN_cod_ciclfact;

 SELECT num_folio, ind_ordentotal, num_proceso, num_secuenci
 INTO   SN_num_folio, SN_ind_ordentotal, SN_num_proceso, SN_num_secuenci
 FROM   fa_histdocu
 WHERE  cod_cliente = EN_cod_cliente
 AND    cod_ciclfact = EN_cod_ciclfact;

 RETURN TRUE;

EXCEPTION

   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := '253';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'fa_datos_documento_fn('||EN_cod_cliente||','||EN_cod_ciclfact||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_datos_documento_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := '156';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'fa_datos_documento_fn('||EN_cod_cliente||','||EN_cod_ciclfact||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_datos_documento_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

END fa_datos_documento_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fa_cons_llamadas_locales_fn (
   EN_num_abonado    IN    ga_abocel.num_abonado%TYPE,
   EN_cod_ciclfact   IN    fa_ciclfact.cod_ciclfact%TYPE,
   EN_tip_factura  IN    NUMBER,
   SC_cur_llam       OUT   NOCOPY refcursor,
   SN_cod_retorno    OUT   NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT   NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "FA_CONS_LLAMADAS_LOCALES_FN"
      Lenguaje="PL/SQL"
      Fecha="02-05-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H - MArcelo Godoy S"
      Programador="Carlos Navarro H - MArcelo Godoy S"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Recupera llamadas Locales de un Abonado</Descripción>
      <Parámetros>
       <Entrada>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>
            <param nom="EN_cod_ciclfact" Tipo="NUMERICO">Ciclo de Facturacion</param>
            <param nom="EN_tip_factura" Tipo="NUMERICO">Tipo de Facturacion (0-Historica, 1-Actual)</param>
         </Entrada>
         <Salida>
   <param nom="SC_cur_llam" Tipo="CARACTER">Cursor de Salida</param>
   <param nom="SN_cod_retorno" Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql            ge_errores_pg.vQuery;
   V_fa_detcelular    fa_enlacehist.fa_detcelular%TYPE;
   V_fa_detroaming   fa_enlacehist.fa_detroaming%TYPE;
   V_fa_histdocu   fa_enlacehist.fa_histdocu%TYPE;
   V_fa_histconc   fa_enlacehist.fa_histconc%TYPE;
   N_cod_tipalmac   fa_enlacehist.cod_tipalmac%TYPE;
   N_ind_tasador   fa_enlacehist.ind_tasador%TYPE;
   N_cod_ciclfact     fa_ciclfact.cod_ciclfact%TYPE;

   N_cod_cliente   ga_abocel.cod_cliente%TYPE;
   N_num_abonado   ga_abocel.num_abonado%TYPE;
   N_cod_ciclo    ga_abocel.cod_ciclo%TYPE;
   V_tip_terminal   ga_abocel.tip_terminal%TYPE;
   N_cod_central   ga_abocel.cod_central%TYPE;
   V_cod_estado      ga_abocel.cod_estado%TYPE;
   V_num_serie    ga_abocel.num_serie%TYPE;
   V_num_imei    ga_abocel.num_imei%TYPE;
   V_cod_tecnologia   ga_abocel.cod_tecnologia%TYPE;
   V_num_min    ga_abocel.num_min%TYPE;
   N_cod_actcen    ga_actabo.cod_actcen%TYPE;
   D_fec_activacion   ga_abocel.fec_activacion%TYPE;
   V_num_imsi    VARCHAR2(50);
   V_tip_abonado      VARCHAR2(10);
   V_mod     VARCHAR2(1);
   V_cod_sent VARCHAR2(5);  --Incidencia 43298 (GSA 05/09/2007 Soporte)

   -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
   V_VALOPER   VARCHAR2(2);
   -- Fin homologación 44760

   error_ejecucion   EXCEPTION;
   error_tipfactura   EXCEPTION;

BEGIN

    SN_cod_retorno := '0';
    SN_num_evento :=  0;
    SV_mens_retorno := '0';
    V_cod_sent := 'S'; --Incidencia 43298 (GSA 05/09/2007 Soporte)

    -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
    SELECT VAL_PARAMETRO
    INTO V_VALOPER
    FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO ='VER_SERV_ESPC';
    --Fin 44760

    IF EN_tip_factura = 0 THEN

       IF NOT fa_valida_ciclo_fn (EN_cod_ciclfact,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       -- Obtencion de la Tabla de Historica
       IF NOT fa_cons_tablas_enlacehist_fn(EN_cod_ciclfact, V_fa_detcelular, V_fa_detroaming, V_fa_histdocu, V_fa_histconc, N_cod_tipalmac, N_ind_tasador,SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       --Obtencion de datos del abonado
       IF NOT ga_datos_basicosabonando_fn(NULL,EN_num_abonado,N_cod_cliente,N_num_abonado,N_cod_ciclo,V_tip_terminal,N_cod_central,V_cod_estado,V_num_serie,V_num_imei,V_cod_tecnologia,V_num_min,V_num_imsi,D_fec_activacion,V_tip_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
       IF V_VALOPER ='1' THEN
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM ta_tipohorario t, ' || V_fa_detcelular;
          sSql := sSql || ' , ged_codigos g, sch_codigos c ';
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND num_clie= ' || N_cod_cliente;
          sSql := sSql || ' AND cod_llam= g.cod_valor AND G.cod_modulo= '''|| GV_cod_modulo||'''';
          sSql := sSql || ' AND G.nom_tabla= '''|| GV_nom_tabla ||''' AND G.des_valor= '''|| GV_local||'''';
          sSql := sSql || ' AND cod_trana not in (''' || GV_cod_trana || ''') AND T.cod_tipohorario = cod_thor';
          sSql := sSql || ' AND C.cod_param=cod_llam AND C.cod_tipo= '''|| GV_cod_tipo ||'''';
          sSql := sSql || ' AND cod_sent = '''|| V_cod_sent ||'''';   --Incidencia 43298 (GSA 05/09/2007 Soporte)
          sSql := sSql || ' ORDER BY fec_llamada,horario';    --- RRG 40570 05-06-2007 PAN (DESARROLLO)
       ELSE
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM ta_tipohorario t, ' || V_fa_detcelular;
          sSql := sSql || ' , ged_codigos g, sch_codigos c ';
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND cod_llam= g.cod_valor AND G.cod_modulo= '''|| GV_cod_modulo||'''';
          sSql := sSql || ' AND G.nom_tabla= '''|| GV_nom_tabla ||''' AND G.des_valor= '''|| GV_local||'''';
          sSql := sSql || ' AND cod_trana not in (''' || GV_cod_trana || ''') AND T.cod_tipohorario = cod_thor';
          sSql := sSql || ' AND C.cod_param=cod_llam AND C.cod_tipo= '''|| GV_cod_tipo ||'''';
       END IF;
       --Fin 44760

       OPEN SC_cur_llam FOR sSql;

    ELSIF EN_tip_factura = 1 THEN
       --Obtencion de datos del abonado
       IF NOT ga_datos_basicosabonando_fn(NULL,EN_num_abonado,N_cod_cliente,N_num_abonado,N_cod_ciclo,V_tip_terminal,N_cod_central,V_cod_estado,V_num_serie,V_num_imei,V_cod_tecnologia,V_num_min,V_num_imsi,D_fec_activacion,V_tip_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       --Obtencion del Ciclo de Facturacion para el Periodo Actual
       IF NOT fa_recupera_cicloperactual_fn(N_cod_ciclo, N_cod_ciclfact, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
       IF V_VALOPER ='1' THEN
          V_mod := SUBSTR(TO_CHAR(N_cod_cliente), (length(TO_CHAR(N_cod_cliente))), 1);
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM TA_TIPOHORARIO T, TOL_DETFACTURA_0' || V_mod;
          sSql := sSql || ' , GED_CODIGOS G';
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND cod_ciclfact = ' || N_cod_ciclfact;
          sSql := sSql || ' AND T.cod_tipohorario = cod_thor';
          sSql := sSql || ' AND cod_llam= G.cod_valor AND G.cod_modulo= '''|| GV_cod_modulo||'''';
          sSql := sSql || ' AND G.nom_tabla= '''|| GV_nom_tabla ||''' AND G.des_valor= '''|| GV_local||'''';
          sSql := sSql || ' AND ind_tabla != ''' || GV_cod_trana||'''';
          sSql := sSql || ' AND cod_sent = '''|| V_cod_sent ||'''';   --Incidencia 43298 (GSA 05/09/2007 Soporte)
          sSql := sSql || ' ORDER BY fec_llamada,horario'; --- RRG 40570 05-06-2007 PAN (DESARROLLO)
       ELSE
          V_mod := SUBSTR(TO_CHAR(N_cod_cliente), (length(TO_CHAR(N_cod_cliente))), 1);
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM TA_TIPOHORARIO T, TOL_DETFACTURA_0' || V_mod;
          sSql := sSql || ' , GED_CODIGOS G';
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND cod_ciclfact = ' || N_cod_ciclfact;
          sSql := sSql || ' AND T.cod_tipohorario = cod_thor';
          sSql := sSql || ' AND cod_llam= G.cod_valor AND G.cod_modulo= '''|| GV_cod_modulo||'''';
          sSql := sSql || ' AND G.nom_tabla= '''|| GV_nom_tabla ||''' AND G.des_valor= '''|| GV_local||'''';
          sSql := sSql || ' AND ind_tabla != ''' || GV_cod_trana||'''';
       END IF;
	   --Fin 44760

       OPEN SC_cur_llam FOR sSql;

    ELSE
       RAISE error_tipfactura;
    END IF;

    RETURN TRUE;

EXCEPTION

    WHEN error_ejecucion THEN
        V_des_error := 'fa_cons_llamadas_locales_fn('||EN_num_abonado||','||EN_cod_ciclfact||','||EN_tip_factura||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_cons_llamadas_locales_fn', sSql, SQLCODE, V_des_error );
  RETURN FALSE;

    WHEN error_tipfactura THEN
        SN_cod_retorno := '256';
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error := 'fa_cons_llamadas_locales_fn('||EN_num_abonado||','||EN_cod_ciclfact||','||EN_tip_factura||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_cons_llamadas_locales_fn', sSql, SQLCODE, V_des_error );
  RETURN FALSE;

    WHEN OTHERS THEN
        SN_cod_retorno := '156';
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error := 'fa_cons_llamadas_locales_fn('||EN_num_abonado||','||EN_cod_ciclfact||','||EN_tip_factura||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_cons_llamadas_locales_fn', sSql, SQLCODE, V_des_error );
  RETURN FALSE;

END fa_cons_llamadas_locales_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fa_cons_llamadas_especiales_fn (
   EN_num_abonado    IN    ga_abocel.num_abonado%TYPE,
   EN_cod_ciclfact   IN    fa_ciclfact.cod_ciclfact%TYPE,
   EN_tip_factura  IN    NUMBER,
   SC_cur_llam       OUT   NOCOPY refcursor,
   SN_cod_retorno    OUT   NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT   NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "FA_CONS_LLAMADAS_ESPECIALES_FN"
      Lenguaje="PL/SQL"
      Fecha="02-05-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H - MArcelo Godoy S"
      Programador="Carlos Navarro H - MArcelo Godoy S"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Recupera llamadas Especiales de un Abonado</Descripción>
      <Parámetros>
       <Entrada>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>
            <param nom="EN_cod_ciclfact" Tipo="NUMERICO">Ciclo de Facturacion</param>
            <param nom="EN_tip_factura" Tipo="NUMERICO">Tipo de Facturacion (0-Historica, 1-Actual)</param>
         </Entrada>
         <Salida>
   <param nom="SC_cur_llam" Tipo="CARACTER">Cursor de Salida</param>
   <param nom="SN_cod_retorno" Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql            ge_errores_pg.vQuery;
   V_fa_detcelular    fa_enlacehist.fa_detcelular%TYPE;
   V_fa_detroaming   fa_enlacehist.fa_detroaming%TYPE;
   V_fa_histdocu   fa_enlacehist.fa_histdocu%TYPE;
   V_fa_histconc   fa_enlacehist.fa_histconc%TYPE;
   N_cod_tipalmac   fa_enlacehist.cod_tipalmac%TYPE;
   N_ind_tasador   fa_enlacehist.ind_tasador%TYPE;
   N_cod_ciclfact     fa_ciclfact.cod_ciclfact%TYPE;

   N_cod_cliente   ga_abocel.cod_cliente%TYPE;
   N_num_abonado   ga_abocel.num_abonado%TYPE;
   N_cod_ciclo    ga_abocel.cod_ciclo%TYPE;
   V_tip_terminal   ga_abocel.tip_terminal%TYPE;
   N_cod_central   ga_abocel.cod_central%TYPE;
   V_cod_estado      ga_abocel.cod_estado%TYPE;
   V_num_serie    ga_abocel.num_serie%TYPE;
   V_num_imei    ga_abocel.num_imei%TYPE;
   V_cod_tecnologia   ga_abocel.cod_tecnologia%TYPE;
   V_num_min    ga_abocel.num_min%TYPE;
   N_cod_actcen    ga_actabo.cod_actcen%TYPE;
   D_fec_activacion   ga_abocel.fec_activacion%TYPE;
   V_num_imsi    VARCHAR2(50);
   V_tip_abonado      VARCHAR2(10);
   V_mod     VARCHAR2(1);
   V_cod_sent VARCHAR2(5);  --Incidencia 43298 (GSA 05/09/2007 Soporte)

   -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
   V_VALOPER   VARCHAR2(2);
   -- Fin homologación 44760

   error_ejecucion   EXCEPTION;
   error_tipfactura    EXCEPTION;

BEGIN

    SN_cod_retorno := '0';
    SN_num_evento :=  0;
    SV_mens_retorno := '0';
    V_cod_sent := 'S'; --Incidencia 43298 (GSA 05/09/2007 Soporte)

    -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
    SELECT VAL_PARAMETRO
    INTO V_VALOPER
    FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO ='VER_SERV_ESPC';
    --Fin 44760

    IF EN_tip_factura = 0 THEN

       IF NOT fa_valida_ciclo_fn (EN_cod_ciclfact,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       -- Obtencion de la Tabla de Historica
       IF NOT fa_cons_tablas_enlacehist_fn(EN_cod_ciclfact, V_fa_detcelular, V_fa_detroaming, V_fa_histdocu, V_fa_histconc, N_cod_tipalmac, N_ind_tasador,SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       --Obtencion de datos del abonado
       IF NOT ga_datos_basicosabonando_fn(NULL,EN_num_abonado,N_cod_cliente,N_num_abonado,N_cod_ciclo,V_tip_terminal,N_cod_central,V_cod_estado,V_num_serie,V_num_imei,V_cod_tecnologia,V_num_min,V_num_imsi,D_fec_activacion,V_tip_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
       IF V_VALOPER ='1' THEN
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM TA_TIPOHORARIO T, ' || V_fa_detcelular;
          sSql := sSql || ' , GED_CODIGOS G, SCH_CODIGOS C ';
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND num_clie= ' || N_cod_cliente;
          sSql := sSql || ' AND cod_llam= G.cod_valor AND G.cod_modulo='''|| GV_cod_modulo||'''';
          sSql := sSql || ' AND G.nom_tabla= '''|| GV_nom_tabla ||''' AND G.des_valor= '''||GV_especial||'''';
          sSql := sSql || ' AND cod_trana not in (''' || GV_cod_trana || ''') AND T.cod_tipohorario = cod_thor';
          sSql := sSql || ' AND C.cod_param=cod_llam AND C.cod_tipo= '''|| GV_cod_tipo ||'''';
          sSql := sSql || ' AND cod_sent = '''|| V_cod_sent ||'''';   --Incidencia 43298 (GSA 05/09/2007 Soporte)
          sSql := sSql || ' ORDER BY fec_llamada,horario';   --- RRG 40570 05-06-2007 PAN (DESARROLLO)
       ELSE
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM TA_TIPOHORARIO T, ' || V_fa_detcelular;
          sSql := sSql || ' , GED_CODIGOS G, SCH_CODIGOS C ';
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND cod_llam= G.cod_valor AND G.cod_modulo='''|| GV_cod_modulo||'''';
          sSql := sSql || ' AND G.nom_tabla= '''|| GV_nom_tabla ||''' AND G.des_valor= '''||GV_especial||'''';
          sSql := sSql || ' AND cod_trana not in (''' || GV_cod_trana || ''') AND T.cod_tipohorario = cod_thor';
          sSql := sSql || ' AND C.cod_param=cod_llam AND C.cod_tipo= '''|| GV_cod_tipo ||'''';
       END IF;
       --Fin 44760

       OPEN SC_cur_llam FOR sSql;

    ELSIF EN_tip_factura = 1 THEN
       --Obtencion de datos del abonado
       IF NOT ga_datos_basicosabonando_fn(NULL,EN_num_abonado,N_cod_cliente,N_num_abonado,N_cod_ciclo,V_tip_terminal,N_cod_central,V_cod_estado,V_num_serie,V_num_imei,V_cod_tecnologia,V_num_min,V_num_imsi,D_fec_activacion,V_tip_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       --Obtencion del Ciclo de Facturacion para el Periodo Actual
       IF NOT fa_recupera_cicloperactual_fn(N_cod_ciclo, N_cod_ciclfact, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
       IF V_VALOPER ='1' THEN
          V_mod := SUBSTR(TO_CHAR(N_cod_cliente), (length(TO_CHAR(N_cod_cliente))), 1);
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM TA_TIPOHORARIO T, TOL_DETFACTURA_0' || V_mod;
          sSql := sSql || ' , GED_CODIGOS G ';
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND cod_ciclfact = ' || N_cod_ciclfact;
          sSql := sSql || ' AND T.cod_tipohorario = cod_thor';
          sSql := sSql || ' AND cod_llam= G.cod_valor AND G.cod_modulo= '''|| GV_cod_modulo||'''';
          sSql := sSql || ' AND G.nom_tabla= '''|| GV_nom_tabla ||''' AND G.des_valor='''|| GV_especial||'''';
          sSql := sSql || ' AND ind_tabla != '''|| GV_cod_trana||'''';
          sSql := sSql || ' AND cod_sent = '''|| V_cod_sent ||'''';   --Incidencia 43298 (GSA 05/09/2007 Soporte)
          sSql := sSql || '  ORDER BY fec_llamada,horario'; --- RRG 40570 05-06-2007 PAN (DESARROLLO)
       ELSE
          V_mod := SUBSTR(TO_CHAR(N_cod_cliente), (length(TO_CHAR(N_cod_cliente))), 1);
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM TA_TIPOHORARIO T, TOL_DETFACTURA_0' || V_mod;
          sSql := sSql || ' , GED_CODIGOS G ';
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND cod_ciclfact = ' || N_cod_ciclfact;
          sSql := sSql || ' AND T.cod_tipohorario = cod_thor';
          sSql := sSql || ' AND cod_llam= G.cod_valor AND G.cod_modulo= '''|| GV_cod_modulo||'''';
          sSql := sSql || ' AND G.nom_tabla= '''|| GV_nom_tabla ||''' AND G.des_valor='''|| GV_especial||'''';
          sSql := sSql || ' AND ind_tabla != '''|| GV_cod_trana||'''';
       END IF;
       --Fin 44760

       OPEN SC_cur_llam FOR sSql;
    ELSE
       RAISE error_tipfactura;
    END IF;

    RETURN TRUE;

EXCEPTION

    WHEN error_ejecucion THEN
        V_des_error := 'fa_cons_llamadas_especiales_fn('||EN_num_abonado||','||EN_cod_ciclfact||','||EN_tip_factura||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_cons_llamadas_especiales_fn', sSql, SQLCODE, V_des_error );
  RETURN FALSE;

    WHEN error_tipfactura THEN
        SN_cod_retorno := '256';
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error := 'fa_cons_llamadas_especiales_fn('||EN_num_abonado||','||EN_cod_ciclfact||','||EN_tip_factura||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_cons_llamadas_especiales_fn', sSql, SQLCODE, V_des_error );
  RETURN FALSE;

    WHEN OTHERS THEN
        SN_cod_retorno := '156';
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error := 'fa_cons_llamadas_especiales_fn('||EN_num_abonado||','||EN_cod_ciclfact||','||EN_tip_factura||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_cons_llamadas_especiales_fn', sSql, SQLCODE, V_des_error );
  RETURN FALSE;

END fa_cons_llamadas_especiales_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fa_cons_llamadas_interzona_fn (
   EN_num_abonado    IN    ga_abocel.num_abonado%TYPE,
   EN_cod_ciclfact   IN    fa_ciclfact.cod_ciclfact%TYPE,
   EN_tip_factura    IN    NUMBER,
   SC_cur_llam       OUT   NOCOPY refcursor,
   SN_cod_retorno    OUT   NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT   NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "FA_CONS_LLAMADAS_INTERZONA_FN"
      Lenguaje="PL/SQL"
      Fecha="02-05-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H - MArcelo Godoy S"
      Programador="Carlos Navarro H - MArcelo Godoy S"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Recupera llamadas Interzona de un Abonado</Descripción>
      <Parámetros>
       <Entrada>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>
            <param nom="EN_cod_ciclfact" Tipo="NUMERICO">Ciclo de Facturacion</param>
            <param nom="EN_tip_factura" Tipo="NUMERICO">Tipo de Facturacion (0-Historica, 1-Actual)</param>
         </Entrada>
         <Salida>
   <param nom="SC_cur_llam" Tipo="CARACTER">Cursor de Salida</param>
   <param nom="SN_cod_retorno" Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql            ge_errores_pg.vQuery;
   V_fa_detcelular    fa_enlacehist.fa_detcelular%TYPE;
   V_fa_detroaming   fa_enlacehist.fa_detroaming%TYPE;
   V_fa_histdocu   fa_enlacehist.fa_histdocu%TYPE;
   V_fa_histconc   fa_enlacehist.fa_histconc%TYPE;
   N_cod_tipalmac   fa_enlacehist.cod_tipalmac%TYPE;
   N_ind_tasador   fa_enlacehist.ind_tasador%TYPE;
   N_cod_ciclfact     fa_ciclfact.cod_ciclfact%TYPE;

   N_cod_cliente   ga_abocel.cod_cliente%TYPE;
   N_num_abonado   ga_abocel.num_abonado%TYPE;
   N_cod_ciclo    ga_abocel.cod_ciclo%TYPE;
   V_tip_terminal   ga_abocel.tip_terminal%TYPE;
   N_cod_central   ga_abocel.cod_central%TYPE;
   V_cod_estado      ga_abocel.cod_estado%TYPE;
   V_num_serie    ga_abocel.num_serie%TYPE;
   V_num_imei    ga_abocel.num_imei%TYPE;
   V_cod_tecnologia   ga_abocel.cod_tecnologia%TYPE;
   V_num_min    ga_abocel.num_min%TYPE;
   N_cod_actcen    ga_actabo.cod_actcen%TYPE;
   D_fec_activacion   ga_abocel.fec_activacion%TYPE;
   V_num_imsi    VARCHAR2(50);
   V_tip_abonado      VARCHAR2(10);
   V_mod     VARCHAR2(1);
   V_cod_sent VARCHAR2(5);  --Incidencia 43298 (GSA 05/09/2007 Soporte)

   -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
   V_VALOPER   VARCHAR2(2);
   -- Fin homologación 44760

   error_ejecucion   EXCEPTION;
   error_tipfactura    EXCEPTION;

BEGIN

    SN_cod_retorno := '0';
    SN_num_evento :=  0;
    SV_mens_retorno := '0';
    V_cod_sent := 'S'; --Incidencia 43298 (GSA 05/09/2007 Soporte)

    -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
    SELECT VAL_PARAMETRO
    INTO V_VALOPER
    FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO ='VER_SERV_ESPC';
    --Fin 44760

    IF EN_tip_factura = 0 THEN

       IF NOT fa_valida_ciclo_fn (EN_cod_ciclfact,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       -- Obtencion de la Tabla de Historica
       IF NOT fa_cons_tablas_enlacehist_fn(EN_cod_ciclfact, V_fa_detcelular, V_fa_detroaming, V_fa_histdocu, V_fa_histconc, N_cod_tipalmac, N_ind_tasador,SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       --Obtencion de datos del abonado
       IF NOT ga_datos_basicosabonando_fn(NULL,EN_num_abonado,N_cod_cliente,N_num_abonado,N_cod_ciclo,V_tip_terminal,N_cod_central,V_cod_estado,V_num_serie,V_num_imei,V_cod_tecnologia,V_num_min,V_num_imsi,D_fec_activacion,V_tip_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
       IF V_VALOPER ='1' THEN
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM TA_TIPOHORARIO T, ' || V_fa_detcelular;
          sSql := sSql || ' , GED_CODIGOS G, SCH_CODIGOS C ';
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND num_clie= ' || N_cod_cliente;
          sSql := sSql || ' AND cod_llam= G.cod_valor AND G.cod_modulo='''|| GV_cod_modulo||'''';
          sSql := sSql || ' AND G.nom_tabla= '''|| GV_nom_tabla ||'''  AND G.des_valor= '''|| GV_interzona||'''';
          sSql := sSql || ' AND cod_trana != ''' || GV_cod_trana ||''' AND T.cod_tipohorario = cod_thor';
          sSql := sSql || ' AND C.cod_param=cod_llam AND C.cod_tipo= '''|| GV_cod_tipo ||'''';
          sSql := sSql || ' AND cod_sent = '''|| V_cod_sent ||'''';   --Incidencia 43298 (GSA 05/09/2007 Soporte)
          sSql := sSql || '  ORDER BY fec_llamada,horario';    --- RRG 40570 05-06-2007 PAN (DESARROLLO)
       ELSE
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM TA_TIPOHORARIO T, ' || V_fa_detcelular;
          sSql := sSql || ' , GED_CODIGOS G, SCH_CODIGOS C ';
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND cod_llam= G.cod_valor AND G.cod_modulo='''|| GV_cod_modulo||'''';
          sSql := sSql || ' AND G.nom_tabla= '''|| GV_nom_tabla ||'''  AND G.des_valor= '''|| GV_interzona||'''';
          sSql := sSql || ' AND cod_trana != ''' || GV_cod_trana ||''' AND T.cod_tipohorario = cod_thor';
          sSql := sSql || ' AND C.cod_param=cod_llam AND C.cod_tipo= '''|| GV_cod_tipo ||'''';
       END IF;
       --Fin 44760

       OPEN SC_cur_llam FOR sSql;

    ELSIF EN_tip_factura = 1 THEN
       --Obtencion de datos del abonado
       IF NOT ga_datos_basicosabonando_fn(NULL,EN_num_abonado,N_cod_cliente,N_num_abonado,N_cod_ciclo,V_tip_terminal,N_cod_central,V_cod_estado,V_num_serie,V_num_imei,V_cod_tecnologia,V_num_min,V_num_imsi,D_fec_activacion,V_tip_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       --Obtencion del Ciclo de Facturacion para el Periodo Actual
       IF NOT fa_recupera_cicloperactual_fn(N_cod_ciclo, N_cod_ciclfact, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
       IF V_VALOPER ='1' THEN
          V_mod := SUBSTR(TO_CHAR(N_cod_cliente), (length(TO_CHAR(N_cod_cliente))), 1);
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM TA_TIPOHORARIO T, TOL_DETFACTURA_0' || V_mod;
          sSql := sSql || ' , GED_CODIGOS G ';
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND cod_ciclfact = ' || N_cod_ciclfact;
          sSql := sSql || ' AND T.cod_tipohorario = cod_thor ';
          sSql := sSql || ' AND cod_llam= G.cod_valor AND G.cod_modulo= '''|| GV_cod_modulo||'''';
          sSql := sSql || ' AND G.nom_tabla= '''|| GV_nom_tabla ||''' AND G.des_valor= '''|| GV_interzona||'''';
          sSql := sSql || ' AND ind_tabla != ''' || GV_cod_trana ||'''';
          sSql := sSql || ' AND cod_sent = '''|| V_cod_sent ||'''';   --Incidencia 43298 (GSA 05/09/2007 Soporte)
          sSql := sSql || '  ORDER BY fec_llamada,horario';  --- RRG 40570 05-06-2007 PAN (DESARROLLO)
       ELSE
          V_mod := SUBSTR(TO_CHAR(N_cod_cliente), (length(TO_CHAR(N_cod_cliente))), 1);
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM TA_TIPOHORARIO T, TOL_DETFACTURA_0' || V_mod;
          sSql := sSql || ' , GED_CODIGOS G ';
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND cod_ciclfact = ' || N_cod_ciclfact;
          sSql := sSql || ' AND T.cod_tipohorario = cod_thor ';
          sSql := sSql || ' AND cod_llam= G.cod_valor AND G.cod_modulo= '''|| GV_cod_modulo||'''';
          sSql := sSql || ' AND G.nom_tabla= '''|| GV_nom_tabla ||''' AND G.des_valor= '''|| GV_interzona||'''';
          sSql := sSql || ' AND ind_tabla != ''' || GV_cod_trana ||'''';
       END IF;
       --Fin 44760

       OPEN SC_cur_llam FOR sSql;

    ELSE
       RAISE error_tipfactura;
    END IF;

    RETURN TRUE;

EXCEPTION

    WHEN error_ejecucion THEN
        V_des_error := 'fa_cons_llamadas_interzona_fn('||EN_num_abonado||','||EN_cod_ciclfact||','||EN_tip_factura||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_cons_llamadas_interzona_fn', sSql, SQLCODE, V_des_error );
  RETURN FALSE;

    WHEN error_tipfactura THEN
        SN_cod_retorno := '256';
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error := 'fa_cons_llamadas_interzona_fn('||EN_num_abonado||','||EN_cod_ciclfact||','||EN_tip_factura||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_cons_llamadas_interzona_fn', sSql, SQLCODE, V_des_error );
  RETURN FALSE;

    WHEN OTHERS THEN
        SN_cod_retorno := '156';
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error := 'fa_cons_llamadas_interzona_fn('||EN_num_abonado||','||EN_cod_ciclfact||','||EN_tip_factura||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_cons_llamadas_interzona_fn', sSql, SQLCODE, V_des_error );
  RETURN FALSE;

END fa_cons_llamadas_interzona_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fa_cons_llamadas_roaming_fn (
   EN_num_abonado    IN    ga_abocel.num_abonado%TYPE,
   EN_cod_ciclfact   IN    fa_ciclfact.cod_ciclfact%TYPE,
   EN_tip_factura  IN    NUMBER,
   SC_cur_llam       OUT   NOCOPY refcursor,
   SN_cod_retorno    OUT   NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT   NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "FA_CONS_LLAMADAS_ROAMING_FN"
      Lenguaje="PL/SQL"
      Fecha="02-05-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H - MArcelo Godoy S"
      Programador="Carlos Navarro H - MArcelo Godoy S"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Recupera llamadas Roaming de un Abonado</Descripción>
      <Parámetros>
       <Entrada>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>
            <param nom="EN_cod_ciclfact" Tipo="NUMERICO">Ciclo de Facturacion</param>
            <param nom="EN_tip_factura" Tipo="NUMERICO">Tipo de Facturacion (0-Historica, 1-Actual)</param>
         </Entrada>
         <Salida>
   <param nom="SC_cur_llam" Tipo="CARACTER">Cursor de Salida</param>
   <param nom="SN_cod_retorno" Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql            ge_errores_pg.vQuery;
   V_fa_detcelular    fa_enlacehist.fa_detcelular%TYPE;
   V_fa_detroaming   fa_enlacehist.fa_detroaming%TYPE;
   V_fa_histdocu   fa_enlacehist.fa_histdocu%TYPE;
   V_fa_histconc   fa_enlacehist.fa_histconc%TYPE;
   N_cod_tipalmac   fa_enlacehist.cod_tipalmac%TYPE;
   N_ind_tasador   fa_enlacehist.ind_tasador%TYPE;
   N_cod_ciclfact     fa_ciclfact.cod_ciclfact%TYPE;

   N_cod_cliente   ga_abocel.cod_cliente%TYPE;
   N_num_abonado   ga_abocel.num_abonado%TYPE;
   N_cod_ciclo    ga_abocel.cod_ciclo%TYPE;
   V_tip_terminal   ga_abocel.tip_terminal%TYPE;
   N_cod_central   ga_abocel.cod_central%TYPE;
   V_cod_estado      ga_abocel.cod_estado%TYPE;
   V_num_serie    ga_abocel.num_serie%TYPE;
   V_num_imei    ga_abocel.num_imei%TYPE;
   V_cod_tecnologia   ga_abocel.cod_tecnologia%TYPE;
   V_num_min    ga_abocel.num_min%TYPE;
   N_cod_actcen    ga_actabo.cod_actcen%TYPE;
   D_fec_activacion   ga_abocel.fec_activacion%TYPE;
   V_num_imsi    VARCHAR2(50);
   V_tip_abonado      VARCHAR2(10);
   N_num_folio    fa_histdocu.num_folio%TYPE;
   N_ind_ordentotal   fa_histdocu.ind_ordentotal%TYPE;
   N_num_proceso   fa_histdocu.num_proceso%TYPE;
   N_num_secuenci    fa_histdocu.num_secuenci%TYPE;

   V_mod     VARCHAR2(1);
   V_cod_sent VARCHAR2(5);  --Incidencia 43298 (GSA 05/09/2007 Soporte)

   -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
   V_VALOPER   VARCHAR2(2);
   -- Fin homologación 44760

   error_ejecucion   EXCEPTION;
   error_tipfactura    EXCEPTION;

BEGIN

    SN_cod_retorno := '0';
    SN_num_evento :=  0;
    SV_mens_retorno := '0';
    V_cod_sent := 'S'; --Incidencia 43298 (GSA 05/09/2007 Soporte)

    -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
    SELECT VAL_PARAMETRO
    INTO V_VALOPER
    FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO ='VER_SERV_ESPC';
    --Fin 44760

    IF EN_tip_factura = 0 THEN

       IF NOT fa_valida_ciclo_fn (EN_cod_ciclfact,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
         RAISE error_ejecucion;
       END IF;

       -- Obtencion de la Tabla de Historica
       IF NOT fa_cons_tablas_enlacehist_fn(EN_cod_ciclfact, V_fa_detcelular, V_fa_detroaming, V_fa_histdocu, V_fa_histconc, N_cod_tipalmac, N_ind_tasador,SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       --Obtencion de datos del abonado
       IF NOT ga_datos_basicosabonando_fn(NULL,EN_num_abonado,N_cod_cliente,N_num_abonado,N_cod_ciclo,V_tip_terminal,N_cod_central,V_cod_estado,V_num_serie,V_num_imei,V_cod_tecnologia,V_num_min,V_num_imsi,D_fec_activacion,V_tip_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
       IF V_VALOPER ='1' THEN
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM TA_TIPOHORARIO T, ' || V_fa_detcelular;
          sSql := sSql || ' , SCH_CODIGOS C ';
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND num_clie= ' || N_cod_cliente;
          sSql := sSql || ' AND cod_trana in ('''|| GV_cod_trana||''')';
          sSql := sSql || ' AND T.cod_tipohorario = cod_thor';
          sSql := sSql || ' AND C.cod_param = cod_llam AND C.cod_tipo= '''|| GV_cod_tipo||'''';
          sSql := sSql || ' AND cod_sent = '''|| V_cod_sent ||'''';   --Incidencia 43298 (GSA 05/09/2007 Soporte)
          sSql := sSql || '  ORDER BY fec_llamada,horario';    ---- RRG 40570 PAN 05-06-2007 (DESARROLLO)
       ELSE
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM TA_TIPOHORARIO T, ' || V_fa_detcelular;
          sSql := sSql || ' , SCH_CODIGOS C ';
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND cod_trana in ('''|| GV_cod_trana||''')';
          sSql := sSql || ' AND T.cod_tipohorario = cod_thor';
          sSql := sSql || ' AND C.cod_param = cod_llam AND C.cod_tipo= '''|| GV_cod_tipo||'''';
       END IF;
       --Fin 44760

       OPEN SC_cur_llam FOR sSql;

    ELSIF EN_tip_factura = 1 THEN
       --Obtencion de datos del abonado
       IF NOT ga_datos_basicosabonando_fn(NULL,EN_num_abonado,N_cod_cliente,N_num_abonado,N_cod_ciclo,V_tip_terminal,N_cod_central,V_cod_estado,V_num_serie,V_num_imei,V_cod_tecnologia,V_num_min,V_num_imsi,D_fec_activacion,V_tip_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
          RAISE error_ejecucion;
       END IF;

       -- Homologación 44760 unificación workset PAN-NIC [PAAA 11-10-2007, soporte]
       IF V_VALOPER ='1' THEN
          V_mod := SUBSTR(TO_CHAR(N_cod_cliente), (length(TO_CHAR(N_cod_cliente))), 1);
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM TOL_DETFACTURA_0' || V_mod;
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND ind_tabla = '''||GV_cod_trana||'''';
          sSql := sSql || ' AND cod_ciclfact = '||EN_cod_ciclfact;
          sSql := sSql || ' AND cod_sent = '''|| V_cod_sent ||'''';   --Incidencia 43298 (GSA 05/09/2007 Soporte)
          sSql := sSql || '  ORDER BY fec_llamada,horario'; --- RRG 40570 PAN 05-06-2007 (DESARROLLO)
       ELSE
          V_mod := SUBSTR(TO_CHAR(N_cod_cliente), (length(TO_CHAR(N_cod_cliente))), 1);
          sSql := 'SELECT date_start_charg AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          sSql := sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          sSql := sSql || ' FROM TOL_DETFACTURA_0' || V_mod;
          sSql := sSql || ' WHERE num_abon = ' || EN_num_abonado;
          sSql := sSql || ' AND sec_empa > 0 AND sec_cdr > 0';
          sSql := sSql || ' AND ind_tabla = '''||GV_cod_trana||'''';
       END IF;
       --Fin 44760

       OPEN SC_cur_llam FOR sSql;

    ELSE
       RAISE error_tipfactura;
    END IF;

    RETURN TRUE;

EXCEPTION

    WHEN error_ejecucion THEN
        V_des_error := 'fa_cons_llamadas_roaming_fn('||EN_num_abonado||','||EN_cod_ciclfact||','||EN_tip_factura||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_cons_llamadas_roaming_fn', sSql, SQLCODE, V_des_error );
  RETURN FALSE;

    WHEN error_tipfactura THEN
        SN_cod_retorno := '256';
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error := 'fa_cons_llamadas_roaming_fn('||EN_num_abonado||','||EN_cod_ciclfact||','||EN_tip_factura||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_cons_llamadas_roaming_fn', sSql, SQLCODE, V_des_error );
  RETURN FALSE;

    WHEN OTHERS THEN
        SN_cod_retorno := '156';
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error := 'fa_cons_llamadas_roaming_fn('||EN_num_abonado||','||EN_cod_ciclfact||','||EN_tip_factura||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_cons_llamadas_roaming_fn', sSql, SQLCODE, V_des_error );
  RETURN FALSE;

END fa_cons_llamadas_roaming_fn;

----------------------------------------------------------------------------------------------------------------------------

FUNCTION fa_recupera_ciclo_fact_fn(
--    EN_cod_cliente  IN  ga_cliente_pcom.cod_plancom%TYPE,
    SN_cod_ciclfact OUT NOCOPY fa_ciclfact.cod_ciclfact%TYPE,
    SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Función">
   <Elemento
      Nombre = "FA_RECUPERA_CICLO_FACT_FN"
      Lenguaje="PL/SQL"
      Fecha="29-03-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción></Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente"     Tipo="NUMERICO">Codigo de Cliente</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_ciclfact"    Tipo="NUMERICO">Codigo ciclo de facturacion</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS
    V_des_error   ge_errores_pg.DesEvent;
    sSql          ge_errores_pg.vQuery;
BEGIN

    SN_cod_retorno := '0';
    SN_num_evento  := 0;
    SV_mens_retorno:= '0';

    sSql := 'SELECT a.cod_ciclfact'
         || 'INTO N_cod_ciclfact'
         || 'FROM fa_ciclfact a, ge_clientes b'
         || 'WHERE a.cod_ciclo   = b.cod_ciclo'
--         || 'AND b.cod_cliente = '||EN_cod_cliente
         || 'AND '||sysdate||' BETWEEN fec_desdellam AND NVL(fec_hastallam,'|| sysdate||')';

    SELECT a.cod_ciclfact
   INTO SN_cod_ciclfact
      FROM fa_ciclfact a, ge_clientes b
     WHERE a.cod_ciclo = b.cod_ciclo
--       AND b.cod_cliente = EN_cod_cliente
       AND sysdate BETWEEN fec_desdellam AND NVL(fec_hastallam, sysdate);

    RETURN TRUE;

EXCEPTION

    WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '200';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
--       V_des_error := 'fa_recupera_ciclo_fact_fn('||EN_cod_cliente||'); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_general_pg.fa_recupera_ciclo_fact_fn', sSql, SQLCODE, V_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
--       V_des_error := 'fa_recupera_ciclo_fact_fn('||EN_cod_cliente||'); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_general_pg.fa_recupera_ciclo_fact_fn', sSql, SQLCODE, V_des_error );
       RETURN FALSE;

END fa_recupera_ciclo_fact_fn ;

----------------------------------------------------------------------------------------------------------------------------

FUNCTION fa_valida_ciclo_vig_fn(
--    EN_cod_cliente  IN  ga_cliente_pcom.cod_plancom%TYPE,
 EN_num_abonado  IN  ga_abocel.num_abonado%TYPE,
 EN_cod_ciclfact IN  fa_ciclfact.cod_ciclfact%TYPE,
    SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Función">
   <Elemento
      Nombre = "FA_VALIDA_CICLO_VIG_FN"
      Lenguaje="PL/SQL"
      Fecha="29-03-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción></Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente"     Tipo="NUMERICO">Codigo de Cliente</param>
            <param nom="EN_num_abonado"     Tipo="NUMERICO">Numero de Abonado</param>
            <param nom="SN_cod_ciclfact"    Tipo="NUMERICO">Codigo ciclo de facturacion</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS
    V_des_error   ge_errores_pg.DesEvent;
    sSql          ge_errores_pg.vQuery;
    N_can_reg     NUMBER;
 error_can_reg EXCEPTION;
BEGIN

    SN_cod_retorno := '0';
    SN_num_evento  := 0;
    SV_mens_retorno:= '0';

    sSql := 'SELECT COUNT(1)'
        || 'INTO N_can_reg'
           || 'FROM ga_infaccel'
--     || 'WHERE cod_cliente = '|| EN_cod_cliente
     || 'AND num_abonado = ' ||EN_num_abonado
     || 'AND cod_ciclfact = ' ||EN_cod_ciclfact;


 sSql := 'IF N_can_reg > 0 THEN'
         || 'N_can_reg = '||N_can_reg;

 IF N_can_reg > 0 THEN
     RETURN TRUE;
 ELSE
       RAISE error_can_reg;
 END IF;

EXCEPTION

    WHEN error_can_reg THEN
       SN_cod_retorno := '212';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
--       V_des_error := 'fa_valida_ciclo_vig_fn('||EN_cod_cliente||' ,'||EN_num_abonado||' ,'||EN_cod_ciclfact||'); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_valida_ciclo_vig_fn', sSql, SQLCODE, V_des_error );
       RETURN FALSE;

    WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '212';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
--       V_des_error := 'fa_valida_ciclo_vig_fn('||EN_cod_cliente||' ,'||EN_num_abonado||' ,'||EN_cod_ciclfact||'); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_valida_ciclo_vig_fn', sSql, SQLCODE, V_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
--       V_des_error := 'fa_valida_ciclo_vig_fn('||EN_cod_cliente||' ,'||EN_num_abonado||' ,'||EN_cod_ciclfact||'); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'fa_general_pg.fa_valida_ciclo_vig_fn', sSql, SQLCODE, V_des_error );
       RETURN FALSE;

END fa_valida_ciclo_vig_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_datos_basicosabonando_fn (
   EN_num_celular   IN     ga_abocel.num_celular%TYPE,
   EN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
   SN_cod_cliente   OUT    NOCOPY ga_abocel.cod_cliente%TYPE,
   SN_num_abonado   OUT  NOCOPY ga_abocel.num_abonado%TYPE,
   SN_cod_ciclo    OUT  NOCOPY ga_abocel.cod_ciclo%TYPE,
   SV_tip_terminal   OUT  NOCOPY ga_abocel.tip_terminal%TYPE,
   SN_cod_central   OUT  NOCOPY ga_abocel.cod_central%TYPE,
   SV_cod_estado   OUT  NOCOPY ga_abocel.cod_estado%TYPE,
   SV_num_serie    OUT  NOCOPY ga_abocel.num_serie%TYPE,
   SV_num_imei    OUT  NOCOPY ga_abocel.num_imei%TYPE,
   SV_cod_tecnologia  OUT  NOCOPY ga_abocel.cod_tecnologia%TYPE,
   SV_num_min    OUT  NOCOPY ga_abocel.num_min%TYPE,
   SV_num_imsi    OUT  NOCOPY VARCHAR2,
   SD_fec_activacion  OUT    NOCOPY ga_abocel.fec_activacion%TYPE,
   SV_tip_abonado     OUT    NOCOPY VARCHAR2,
   SN_cod_retorno     OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno    OUT    NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento      OUT    NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_DATOS_BASICOSABONANDO_FN"
      Lenguaje="PL/SQL"
      Fecha="19-04-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera informacion basica de un abonado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_cliente" Tipo="NUMERICO">Codigo de Cliente</param>
            <param nom="SN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>
            <param nom="SN_cod_ciclo" Tipo="NUMERICO">Codigo de Ciclo</param>
            <param nom="SV_tip_terminal" Tipo="CARACTER">Tipo Terminal</param>
            <param nom="SN_cod_central" Tipo="NUMERICO">Codigo Central</param>
            <param nom="SV_cod_estado" Tipo="CARACTER">Codigo Estado</param>
            <param nom="SV_num_serie" Tipo="CARACTER">Numero de Serie</param>
            <param nom="SV_num_imei" Tipo="CARACTER">Numero Imei</param>
            <param nom="SV_cod_tecnologia" Tipo="CARACTER">Codigo de Tecnologia</param>
            <param nom="SV_num_min" Tipo="CARACTER">Numero Minimo</param>
            <param nom="SV_num_imsi" Tipo="CARACTER">Numero Imsi</param>
            <param nom="SD_fec_activacion" Tipo="FECHA">Fecha de Activacion</param>
            <param nom="SV_tip_abonado" Tipo="CARACTER">Tipo de Abonado</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS
   V_des_error         ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   V_cod_situacion     ga_abocel.cod_situacion%type;

   error_parametros    EXCEPTION;
BEGIN

    SN_cod_retorno := '0';
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';
 V_cod_situacion := 'BAA';

 IF EN_num_celular IS NOT NULL THEN

  sSql := 'SELECT cod_cliente, num_abonado, cod_ciclo, tip_terminal, cod_central, cod_estado, num_serie, num_imei,';
     sSql := sSql || ' cod_tecnologia, num_min, frecupersimcard_fn (num_serie, ''IMSI'') num_imsi, fec_activacion, ''POST'' tip_abonado';
  sSql := sSql || ' INTO SN_cod_cliente, SN_num_abonado, SN_cod_ciclo, SV_tip_terminal, SN_cod_central, SV_cod_estado, SV_tip_abonado';
     sSql := sSql || ' SV_num_serie, SV_num_imei, SV_cod_tecnologia, SV_num_min, SV_num_imsi, SD_fec_activacion, SV_tip_abonado';
     sSql := sSql || ' FROM ga_abocel';
     sSql := sSql || ' WHERE num_celular = '||EN_num_celular;
     sSql := sSql || ' AND cod_situacion <> '||V_cod_situacion;
     sSql := sSql || ' UNION';
     sSql := sSql || ' SELECT cod_cliente, num_abonado, cod_ciclo, tip_terminal, cod_central, cod_estado, num_serie, num_imei,';
     sSql := sSql || ' cod_tecnologia, num_min, frecupersimcard_fn (num_serie, ''IMSI'') num_imsi,fec_activacion, ''PRE'' tip_abonado';
     sSql := sSql || ' FROM ga_aboamist';
     sSql := sSql || ' WHERE num_celular = '||EN_num_celular;
     sSql := sSql || ' AND cod_situacion <> '||V_cod_situacion;

     SELECT cod_cliente, num_abonado, cod_ciclo, tip_terminal, cod_central, cod_estado, num_serie, num_imei,
            cod_tecnologia, num_min, frecupersimcard_fn (num_serie, 'IMSI') num_imsi, fec_activacion, 'POST' tip_abonado
     INTO   SN_cod_cliente, SN_num_abonado, SN_cod_ciclo, SV_tip_terminal, SN_cod_central, SV_cod_estado,
            SV_num_serie, SV_num_imei, SV_cod_tecnologia, SV_num_min, SV_num_imsi, SD_fec_activacion, SV_tip_abonado
     FROM   ga_abocel
     WHERE  num_celular = EN_num_celular
     AND    cod_situacion <> V_cod_situacion
     UNION
     SELECT cod_cliente, num_abonado, cod_ciclo, tip_terminal, cod_central, cod_estado, num_serie, num_imei,
            cod_tecnologia, num_min, frecupersimcard_fn (num_serie, 'IMSI') num_imsi, fec_activacion, 'PRE' tip_abonado
     FROM   ga_aboamist
     WHERE  num_celular = EN_num_celular
     AND    cod_situacion <> V_cod_situacion;

 ELSIF EN_num_abonado IS NOT NULL THEN

  sSql := 'SELECT cod_cliente, num_abonado, cod_ciclo, tip_terminal, cod_central, cod_estado, num_serie, num_imei,';
     sSql := sSql || ' cod_tecnologia, num_min, frecupersimcard_fn (num_serie, ''IMSI'') num_imsi, fec_activacion, ''POST'' tip_abonado';
  sSql := sSql || ' INTO SN_cod_cliente, SN_num_abonado, SN_cod_ciclo, SV_tip_terminal, SN_cod_central, SV_cod_estado, SV_tip_abonado';
     sSql := sSql || ' SV_num_serie, SV_num_imei, SV_cod_tecnologia, SV_num_min, SV_num_imsi, SD_fec_activacion, SV_tip_abonado';
     sSql := sSql || ' FROM ga_abocel';
     sSql := sSql || ' WHERE num_abonado = '||EN_num_abonado;
     sSql := sSql || ' AND cod_situacion <> '||V_cod_situacion;
     sSql := sSql || ' UNION';
     sSql := sSql || ' SELECT cod_cliente, num_abonado, cod_ciclo, tip_terminal, cod_central, cod_estado, num_serie, num_imei,';
     sSql := sSql || ' cod_tecnologia, num_min, frecupersimcard_fn (num_serie, ''IMSI'') num_imsi, fec_activacion, ''PRE'' tip_abonado';
     sSql := sSql || ' FROM ga_aboamist';
     sSql := sSql || ' WHERE num_abonado = '||EN_num_abonado;
     sSql := sSql || ' AND cod_situacion <> '||V_cod_situacion;

     SELECT cod_cliente, num_abonado, cod_ciclo, tip_terminal, cod_central, cod_estado, num_serie, num_imei,
            cod_tecnologia, num_min, frecupersimcard_fn (num_serie, 'IMSI') num_imsi, fec_activacion, 'POST' tip_abonado
     INTO   SN_cod_cliente, SN_num_abonado, SN_cod_ciclo, SV_tip_terminal, SN_cod_central, SV_cod_estado,
            SV_num_serie, SV_num_imei, SV_cod_tecnologia, SV_num_min, SV_num_imsi, SD_fec_activacion, SV_tip_abonado
     FROM   ga_abocel
     WHERE  num_abonado = EN_num_abonado
     AND    cod_situacion <> V_cod_situacion
     UNION
     SELECT cod_cliente, num_abonado, cod_ciclo, tip_terminal, cod_central, cod_estado, num_serie, num_imei,
            cod_tecnologia, num_min, frecupersimcard_fn (num_serie, 'IMSI') num_imsi, fec_activacion, 'PRE' tip_abonado
     FROM   ga_aboamist
     WHERE  num_abonado = EN_num_abonado
     AND    cod_situacion <> V_cod_situacion;
 ELSE
  RAISE error_parametros;
 END IF;

 RETURN TRUE;

EXCEPTION

   WHEN error_parametros THEN
      SN_cod_retorno := '98';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_datos_basicosabonando_fn('||EN_num_celular||','||EN_num_abonado||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_general_pg.ga_datos_basicosabonando_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := '218';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_datos_basicosabonando_fn('||EN_num_celular||','||EN_num_abonado||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_general_pg.ga_datos_basicosabonando_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := '156';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_datos_basicosabonando_fn('||EN_num_celular||','||EN_num_abonado||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_general_pg.ga_datos_basicosabonando_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

END ga_datos_basicosabonando_fn;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fa_version_fn RETURN VARCHAR2
/*
<Documentación
  TipoDoc = "Función>
   <Elemento
      Nombre = "FA_VERSION_FN"
      Lenguaje="PL/SQL"
      Fecha creación="26-12-2004"
      Creado por="Carlos Navarro H. - Marcelo Godoy S."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Versión y subversión del package</Retorno>
      <Descripción>Mostrar versión y subversión del package</Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
   LV_version   CONSTANT VARCHAR2(5) := ' 1.0 ';
BEGIN
   RETURN('Version : '||LV_version);
END;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END fa_general_pg;
/
SHOW ERRORS