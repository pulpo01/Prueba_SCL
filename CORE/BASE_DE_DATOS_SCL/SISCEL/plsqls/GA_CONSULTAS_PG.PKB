CREATE OR REPLACE PACKAGE BODY GA_CONSULTAS_PG
IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONSULTA_ABONADO_PR (EN_num_celular   IN  ga_abocel.num_celular%TYPE,
          SN_num_abonado   OUT NOCOPY  ga_abocel.num_abonado%TYPE,
          SN_cod_cliente   OUT NOCOPY  ga_abocel.cod_cliente%TYPE,
          SN_cod_producto  OUT NOCOPY  ga_abocel.cod_producto%TYPE,
          SV_cod_situacion OUT NOCOPY  ga_abocel.cod_situacion%TYPE,
           SV_tip_plantarif OUT NOCOPY  ga_abocel.tip_plantarif%TYPE,
          SV_cod_plantarif OUT NOCOPY  ga_abocel.cod_plantarif%TYPE,
          SV_num_serie     OUT NOCOPY  ga_abocel.num_serie%TYPE,
          SN_cod_ciclo    OUT NOCOPY  ga_abocel.cod_ciclo%TYPE,
          SV_tecnologia    OUT NOCOPY  ga_abocel.cod_tecnologia%TYPE,
          SV_num_imei      OUT NOCOPY  ga_abocel.num_imei%TYPE,
          SV_num_min_mdn   OUT NOCOPY  ga_abocel.num_min_mdn%TYPE,
          SV_cod_password  OUT NOCOPY  ga_abocel.cod_password%TYPE,
          SV_num_min       OUT NOCOPY  ga_abocel.num_min%TYPE,
          SV_tip_terminal  OUT NOCOPY  ga_abocel.tip_terminal%TYPE,
          SV_num_seriehex  OUT NOCOPY  ga_abocel.num_seriehex%TYPE,
          SV_num_seriemec  OUT NOCOPY  ga_abocel.num_seriemec%TYPE,
          SV_tipo_abonado  OUT NOCOPY  VARCHAR2,
          SN_cod_cuenta    OUT NOCOPY  ga_abocel.cod_cuenta%TYPE,
            SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
             SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
             SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
          )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTAS_PG"
      Lenguaje="PL/SQL"
      Fecha="27-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar los atributos mas comunmente consultados del abonado ECU-050050</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_num_abonado"     Tipo="NUMERICO">Secuencia nro del abonado</param>
            <param nom="SN_cod_cliente"     Tipo="NUMERICO">Codigo del Cliente</param>
            <param nom="SN_cod_producto"    Tipo="NUMERICO">Codigo de producto</param>
            <param nom="SV_situacion"       Tipo="CARACTER">Codigo de situacion abonado</param>
            <param nom="SV_tip_plantarif"   Tipo="CARACTER">Tipo de plan tarifario</param>
            <param nom="SV_cod_plantarif"   Tipo="CARACTER">Codigo plan tarifario</param>
            <param nom="SV_num_serie"       Tipo="CARACTER">Numero de serie decimal</param>
            <param nom="SN_cod_ciclo"       Tipo="NUMERICO">Codigo ciclo facturacion</param>
            <param nom="SV_tecnologia"      Tipo="CARACTER">Codigo tecnologia</param>
            <param nom="SV_num_imei"        Tipo="CARACTER">Numero de seire terminal GSM</param>
            <param nom="SV_num_min_mdn"     Tipo="CARACTER">Min asociado al nro celular</param>
            <param nom="SV_cod_password "   Tipo="CARACTER">Codigo de situacion abonado</param>
            <param nom="SV_num_min"         Tipo="CARACTER">Prefijo min</param>
            <param nom="SV_tip_terminal"    Tipo="CARACTER">Tipo de terminal</param>
            <param nom="SV_num_seriehex"    Tipo="CARACTER">Numero de serie hexadecimal</param>
            <param nom="SV_num_seriemec"    Tipo="CARACTER">Numero de serie mecanico</param>
      <param nom="SV_tipo_abonado"    Tipo="CARACTER">Tipo de abonado</param>
      <param nom="SN_cod_cuenta"    Tipo="NUMERICO">Codigo de la cuenta</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

  V_des_error     ge_errores_pg.DesEvent;
        sSql               ge_errores_pg.vQuery;
  SV_deserror    ge_errores_pg.DesEvent;
  bexisteregistro   BOOLEAN;

   BEGIN
   SN_cod_retorno := '0';
   SN_num_evento  := 0;

   sSql:=SUBSTR('SELECT postpago.num_celular, postpago.num_abonado, postpago.cod_cliente, postpago.cod_producto, postpago.cod_situacion,'||
        ' postpago.tip_plantarif, postpago.cod_plantarif, postpago.num_serie, postpago.cod_ciclo, postpago.cod_tecnologia,'||
        ' postpago.num_imei, postpago.num_min_mdn, postpago.cod_password, postpago.num_min, postpago.tip_terminal,'||
        ' postpago.num_seriehex,postpago.num_seriemec,''POSTPAGO'' AS tipo_abonado,postpago.cod_cuenta'||
        ' FROM ga_abocel postpago'||
        ' WHERE postpago.num_celular='|| EN_num_celular||
        ' AND postpago.cod_situacion<>BAA'||
        ' UNION'||
        ' SELECT prepago.num_celular, prepago.num_abonado, prepago.cod_cliente, prepago.cod_producto, prepago.cod_situacion,'||
        ' prepago.tip_plantarif, prepago.cod_plantarif, prepago.num_serie, prepago.cod_ciclo, prepago.cod_tecnologia,'||
        ' prepago.num_imei, prepago.num_min_mdn, prepago.cod_password, prepago.num_min, prepago.tip_terminal,'||
        ' prepago.num_seriehex,prepago.num_seriemec,''PREPAGO'' AS tipo_abonado, prepago.cod_cuenta'||
        ' FROM ga_aboamist prepago'||
        ' WHERE prepago.num_celular='|| EN_num_celular||
        ' AND prepago.cod_situacion<>BAA',1,CN_largoquery);

  SELECT postpago.num_abonado, postpago.cod_cliente, postpago.cod_producto, postpago.cod_situacion,
         postpago.tip_plantarif, postpago.cod_plantarif, postpago.num_serie, postpago.cod_ciclo, postpago.cod_tecnologia,
      postpago.num_imei, postpago.num_min_mdn, postpago.cod_password, postpago.num_min, postpago.tip_terminal,
      postpago.num_seriehex,postpago.num_seriemec,'POSTPAGO' AS tipo_abonado,postpago.cod_cuenta
      INTO
      SN_num_abonado,SN_cod_cliente,SN_cod_producto,SV_cod_situacion,
       SV_tip_plantarif,SV_cod_plantarif,SV_num_serie,SN_cod_ciclo,SV_tecnologia,
       SV_num_imei,SV_num_min_mdn,SV_cod_password,SV_num_min,SV_tip_terminal,
       SV_num_seriehex,SV_num_seriemec,SV_tipo_abonado,SN_cod_cuenta
  FROM ga_abocel postpago
  WHERE postpago.num_celular=EN_num_celular
  AND postpago.cod_situacion<>'BAA'
  UNION
  SELECT prepago.num_abonado, prepago.cod_cliente, prepago.cod_producto, prepago.cod_situacion,
         prepago.tip_plantarif,prepago.cod_plantarif, prepago.num_serie, prepago.cod_ciclo, prepago.cod_tecnologia,
      prepago.num_imei, prepago.num_min_mdn, prepago.cod_password, prepago.num_min, prepago.tip_terminal,
      prepago.num_seriehex,prepago.num_seriemec,'PREPAGO'  AS tipo_abonado,prepago.cod_cuenta
  FROM ga_aboamist prepago
  WHERE prepago.num_celular=EN_num_celular
  AND prepago.cod_situacion<>'BAA';

EXCEPTION
WHEN NO_DATA_FOUND THEN
  NULL;
WHEN OTHERS THEN
                SN_cod_retorno := '302'; -- Nuevo Error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('Others: GA_CONSULTA_ABONADO_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
     SV_mens_retorno:=SUBSTR(SN_cod_retorno||' -- '||SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento,CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR', sSql, SQLCODE, V_des_error );
END GA_CONSULTA_ABONADO_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONSULTA_CLIENTE_PR (EN_cod_cliente   IN ga_abocel.cod_cliente%TYPE,
          SN_cod_cuenta    OUT NOCOPY  ge_clientes.cod_cuenta%TYPE,
          SN_cod_categoria OUT NOCOPY  ge_clientes.cod_categoria%TYPE,
           SV_cod_tipident  OUT NOCOPY  ge_clientes.cod_tipident%TYPE,
          SV_num_ident     OUT NOCOPY  ge_clientes.num_ident%TYPE,
          SV_des_tipident  OUT NOCOPY  ge_tipident.des_tipident%TYPE,
            SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
             SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
             SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_CLIENTE_PR"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar los atributos mas comunmente consultados del cliente ECU-050050</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo del cliente</param>
         </Entrada>
         <Salida>
            <param nom="SN_num_abonado"     Tipo="NUMERICO">Secuencia nro del abonado</param>
            <param nom="SN_cod_cliente"     Tipo="NUMERICO">Codigo de la cuenta</param>
            <param nom="SN_cod_categoria"   Tipo="NUMERICO">Categoria del Cliente</param>
            <param nom="SV_cod_tipident"    Tipo="CARACTER">Tipo de identificacion del cliente</param>
            <param nom="SV_num_ident"       Tipo="CARACTER">Numero de identificacion del cliente</param>
            <param nom="SV_des_tipident"    Tipo="CARACTER">Descripcion del tipo de identificacion</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
  V_des_error     ge_errores_pg.DesEvent;
        sSql               ge_errores_pg.vQuery;
  SV_deserror    ge_errores_pg.DesEvent;

   BEGIN

   SN_cod_retorno := '0';
   SN_num_evento  := 0;
   SN_cod_categoria:=NULL;
   SV_cod_tipident:=NULL;
   SV_num_ident:=NULL;
   SV_des_tipident:=NULL;
   SN_cod_cuenta:=NULL;

   sSql :=NULL;
   sSql := 'SELECT cli.cod_categoria, cli.cod_tipident, cli.num_ident, tipident.des_tipident';
   sSql := sSql || ' ,cli.cod_cuenta ';
   sSql := sSql || ' FROM ge_clientes cli, ge_tipident tipident';
   sSql := sSql || ' WHERE cli.cod_cliente = ' || EN_cod_cliente;
   sSql := sSql || ' AND cli.cod_tipident = tipident.cod_tipident;';

   SELECT cli.cod_categoria, cli.cod_tipident, cli.num_ident, tipident.des_tipident,
       cli.cod_cuenta
     INTO SN_cod_categoria,SV_cod_tipident,SV_num_ident,SV_des_tipident,
     SN_cod_cuenta
  FROM ge_clientes cli, ge_tipident tipident
 WHERE cli.cod_cliente = EN_cod_cliente
   AND cli.cod_tipident = tipident.cod_tipident;

EXCEPTION
WHEN NO_DATA_FOUND THEN
     NULL;
WHEN OTHERS THEN
                SN_cod_retorno := '302'; -- Nuevo Error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('Others: GA_CONSULTA_CLIENTE_PR('||EN_cod_cliente||'); - ' || SQLERRM,1,CN_largoerrtec);
     SV_mens_retorno:=SUBSTR(SN_cod_retorno||' -- '||SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento,CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'GA_CONSULTAS_PG.GA_CONSULTA_CLIENTE_PR', sSql, SQLCODE, V_des_error );
END GA_CONSULTA_CLIENTE_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONSULTA_CUENTA_PR (EN_cod_cuenta    IN  ga_cuentas.cod_cuenta%TYPE,
          SV_cod_catribut  OUT NOCOPY  ga_cuentas.cod_catribut%TYPE,
           SV_tip_cuenta    OUT NOCOPY  ga_cuentas.tip_cuenta%TYPE,
            SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
             SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
             SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_CUENTA_PR"
      Lenguaje="PL/SQL"
      Fecha="30-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar los atributos mas comunmente de una cuenta</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cuenta" Tipo="NUMERICO">Codigo de la cuenta</param>
         </Entrada>
         <Salida>
            <param nom="SV_cod_catribut"    Tipo="CARACTER">Categoria tributaria</param>
            <param nom="SV_tip_cuenta"    Tipo="CARACTER">Tipo de cuenta</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
  V_des_error     ge_errores_pg.DesEvent;
        sSql               ge_errores_pg.vQuery;
  SV_deserror    ge_errores_pg.DesEvent;

   BEGIN

   SN_cod_retorno := '0';
   SN_num_evento  := 0;
   SV_cod_catribut:=NULL;
   SV_tip_cuenta:=NULL;
   sSql := 'SELECT cuen.cod_catribut, cuen.tip_cuenta';
   sSql := sSql || ' INTO SV_cod_catribut,SV_tip_cuenta';
   sSql := sSql || ' FROM ga_cuentas cuen';
   sSql := sSql || ' WHERE cuen.cod_cuenta = ' || EN_cod_cuenta;

   SELECT cuen.cod_catribut, cuen.tip_cuenta
   INTO SV_cod_catribut,SV_tip_cuenta
   FROM ga_cuentas cuen
   WHERE cuen.cod_cuenta=EN_cod_cuenta;


EXCEPTION
WHEN NO_DATA_FOUND THEN
     NULL;

WHEN OTHERS THEN
                SN_cod_retorno := '302'; -- Nuevo Error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('Others: GA_CONSULTA_CUENTA_PR('||EN_cod_cuenta||'); - ' || SQLERRM,1,CN_largoerrtec);
     SV_mens_retorno:=SUBSTR(SN_cod_retorno||' -- '||SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'GA_CONSULTAS_PG.GA_CONSULTA_CUENTA_PR', sSql, SQLCODE, V_des_error );
END GA_CONSULTA_CUENTA_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONSULTA_CUENTA_PR (EN_cod_cuenta       IN         ga_cuentas.cod_cuenta%TYPE,
              SV_cod_tipident     OUT NOCOPY ga_cuentas.cod_tipident%TYPE,
                  SV_num_ident        OUT NOCOPY ga_cuentas.num_ident%TYPE,
                  SV_nom_responsable  OUT NOCOPY ga_cuentas.nom_responsable%TYPE,
                  SN_cod_direccion    OUT NOCOPY ga_cuentas.cod_direccion%TYPE,
                  SV_tip_cuenta       OUT NOCOPY ga_cuentas.tip_cuenta%TYPE,
           SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
            SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
            SN_num_evento       OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_CUENTA_PR"
      Lenguaje="PL/SQL"
      Fecha="26-08-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Obtiene los datos del responsable de una cuenta</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cuenta"       Tipo="NUMERICO">Codigo de la cuenta</param>
         </Entrada>
         <Salida>
            <param nom="SV_cod_tipident"     Tipo="CARACTER">Tipo de identificación</param>
            <param nom="SV_num_ident"       Tipo="CARACTER">Nro de identificación</param>
            <param nom="SV_nom_responsable" Tipo="CARACTER">Nombre del responsable</param>
            <param nom="SN_cod_direccion"   Tipo="NUMERICO">Codigo de la dirección</param>
            <param nom="SV_tip_cuenta     Tipo="CARACTER">Tipo de la cuenta</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        V_des_error     ge_errores_pg.DesEvent;
        sSql            ge_errores_pg.vQuery;

BEGIN

        --Inicializar variables
  SN_cod_retorno:=0;
        SN_num_evento:=0;
  SV_cod_tipident:=NULL;
  SV_num_ident:=NULL;
  SV_nom_responsable:=NULL;
  SN_cod_direccion:=NULL;
  SV_tip_cuenta:=NULL;

        sSql:='SELECT cuentas.COD_TIPIDENT,cuentas.NUM_IDENT,cuentas.NOM_RESPONSABLE, '||
        'cuentas.COD_DIRECCION,cuentas.TIP_CUENTA ' ||
        'INTO SV_cod_tipident,SV_num_ident,SV_nom_responsable, '||
     'SN_cod_direccion,SV_tip_cuenta '||
           'FROM GA_CUENTAS cuentas '||
           'WHERE cuentas.COD_CUENTA='||EN_cod_cuenta;

        SELECT cuentas.COD_TIPIDENT,cuentas.NUM_IDENT,cuentas.NOM_RESPONSABLE,
         cuentas.COD_DIRECCION,cuentas.TIP_CUENTA
    INTO SV_cod_tipident,SV_num_ident,SV_nom_responsable,
      SN_cod_direccion,SV_tip_cuenta
       FROM GA_CUENTAS cuentas
      WHERE cuentas.COD_CUENTA=EN_cod_cuenta;

EXCEPTION
WHEN  NO_DATA_FOUND THEN
      SN_cod_retorno:=156;
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno:=CV_error_no_clasIF;
      END  IF;
      V_des_error:='no_data_found: GA_CONSULTA_CUENTA_PR('||EN_cod_cuenta||'); - ' || SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'GA_CONSULTA_CUENTA_PR', sSql, SQLCODE, V_des_error );

WHEN  OTHERS   THEN
      SN_cod_retorno:=156;
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno:=CV_error_no_clasIF;
      END IF;
      V_des_error:='others: GA_CONSULTA_CUENTA_PR('||EN_cod_cuenta||'); - ' || SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'GA_CONSULTA_CUENTA_PR', sSql, SQLCODE, V_des_error );
END GA_CONSULTA_CUENTA_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONSULTA_COMPOR_CLIENTE_PR (EN_cod_cliente   IN ga_abocel.cod_cliente%TYPE,
           SV_cod_valor     OUT NOCOPY  ge_valores_cli.cod_valor%TYPE,
           SV_des_valor     OUT NOCOPY  ge_valores_cli.des_valor%TYPE,
            SN_cod_retorno   OUT NOCOPY  ge_errores_pg.CodError,
             SV_mens_retorno  OUT NOCOPY  ge_errores_pg.MsgError,
             SN_num_evento    OUT NOCOPY  ge_errores_pg.Evento
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_COMPOR_CLIENTE_PR"
      Lenguaje="PL/SQL"
      Fecha="03-06-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar los atributos de segmentación (clasificacion) del cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo del cliente</param>
         </Entrada>
         <Salida>
            <param nom="SV_cod_valor"    Tipo="CARACTER">Código del valor de comportamiento del cliente</param>
            <param nom="SV_des_valor"    Tipo="CARACTER">Descripción del código del valor de comportamiento del cliente</param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"   Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
  V_des_error     ge_errores_pg.DesEvent;
        sSql               ge_errores_pg.vQuery;
  SV_deserror    ge_errores_pg.DesEvent;

   BEGIN

   SN_cod_retorno:=0;
   SN_num_evento:= 0;
   SV_cod_valor:=NULL;
   SV_des_valor:=NULL;
   sSql:='SELECT valcli.cod_valor,valcli.DES_VALOR '||
         ' FROM GA_VALOR_CLI valcomporcli, GE_VALORES_CLI valcli '||
      ' WHERE valcomporcli.COD_CLIENTE='||EN_cod_cliente||
         ' AND valcomporcli.COD_VALOR=valcli.COD_VALOR; ';

   SELECT valcli.cod_valor,valcli.DES_VALOR
     INTO SV_cod_valor,SV_des_valor
     FROM GA_VALOR_CLI valcomporcli, GE_VALORES_CLI valcli
    WHERE valcomporcli.COD_CLIENTE=EN_cod_cliente
      AND valcomporcli.COD_VALOR=valcli.COD_VALOR;


EXCEPTION
WHEN NO_DATA_FOUND THEN
                NULL;
WHEN OTHERS THEN
                SN_cod_retorno := '302'; -- Nuevo Error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('Others: GA_CONSULTA_COMPOR_CLIENTE_PR('||EN_cod_cliente||'); - ' || SQLERRM,1,CN_largoerrtec);
     SV_mens_retorno:=SUBSTR(SN_cod_retorno||' -- '||SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento,CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'GA_CONSULTAS_PG.GA_CONSULTA_COMPOR_CLIENTE_PR', sSql, SQLCODE, V_des_error );
END GA_CONSULTA_COMPOR_CLIENTE_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONSULTA_TIPO_PRODUCTO_PR  (EV_cod_plantarif IN          ga_abocel.cod_plantarif%TYPE,
                SV_cod_tiplan    OUT NOCOPY  ged_codigos.cod_valor%TYPE,
             SV_des_tiplan    OUT NOCOPY  ged_codigos.des_valor%TYPE,
              SN_cod_retorno   OUT NOCOPY  ge_errores_pg.CodError,
               SV_mens_retorno  OUT NOCOPY  ge_errores_pg.MsgError,
               SN_num_evento    OUT NOCOPY  ge_errores_pg.Evento
                                    )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_TIPO_PRODUCTO_PR"
      Lenguaje="PL/SQL"
      Fecha="29-06-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite del tipo de producto a partir del plan tarifario</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo del cliente</param>
         </Entrada>
         <Salida>
            <param nom="SV_cod_tiplan"    Tipo="CARACTER">Código del tipo de producto</param>
            <param nom="SV_des_tiplan"    Tipo="CARACTER">Descripción del tipo de producto</param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"   Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
  V_des_error     ge_errores_pg.DesEvent;
        sSql               ge_errores_pg.vQuery;
  SV_deserror    ge_errores_pg.DesEvent;

   BEGIN

   SN_cod_retorno:=0;
   SN_num_evento:= 0;
   SV_cod_tiplan:=NULL;
   SV_des_tiplan:=NULL;

   sSql:='SELECT codigos.COD_VALOR,codigos.DES_VALOR '||
         ' INTO SV_cod_tiplan,SV_des_tiplan'||
         ' FROM GED_CODIGOS codigos, TA_PLANTARIF tarifas '||
      ' WHERE codigos.COD_MODULO='||CV_cod_modulo_ge||
         ' AND codigos.NOM_TABLA='||CV_nom_tabla||
   ' AND codigos.NOM_COLUMNA='||CV_nom_columna||
   ' AND codigos.COD_VALOR=tarifas.cod_tiplan'||
   ' AND tarifas.COD_PRODUCTO='||CN_cod_producto||
   ' AND tarifas.COD_PLANTARIF='||EV_cod_plantarif;

   SELECT codigos.COD_VALOR,codigos.DES_VALOR
     INTO SV_cod_tiplan,SV_des_tiplan
     FROM GED_CODIGOS codigos, TA_PLANTARIF tarifas
    WHERE codigos.COD_MODULO=CV_cod_modulo_ge
   AND codigos.NOM_TABLA=CV_nom_tabla
   AND codigos.NOM_COLUMNA=CV_nom_columna
   AND codigos.COD_VALOR=tarifas.cod_tiplan
   AND tarifas.COD_PRODUCTO=CN_cod_producto
   AND tarifas.COD_PLANTARIF=EV_cod_plantarif;


EXCEPTION
WHEN NO_DATA_FOUND THEN
                NULL;
WHEN OTHERS THEN
                SN_cod_retorno := '302'; -- Nuevo Error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('Others: GA_CONSULTA_TIPO_PRODUCTO_PR('||EV_cod_plantarif||'); - ' || SQLERRM,1,CN_largoerrtec);
     SV_mens_retorno:=SUBSTR(SN_cod_retorno||' -- '||SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento,CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'GA_CONSULTAS_PG.GA_CONSULTA_TIPO_PRODUCTO_PR', sSql, SQLCODE, V_des_error );
END GA_CONSULTA_TIPO_PRODUCTO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_version_fn RETURN VARCHAR2
/*
<Documentación
  TipoDoc = "Función>
   <Elemento
      Nombre = "GA_VERSION_FN"
      Lenguaje="PL/SQL"
      Fecha="26-12-2004"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
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
BEGIN
   RETURN('Version : '||CV_version||' <--> SubVersion : '||CV_subversion);
END;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONSULTA_ABONADO_PR (EN_num_abonado      IN          ga_abocel.num_abonado%TYPE,
								  SV_clase_servicio   OUT NOCOPY  ga_abocel.clase_servicio%TYPE,
								  SV_perfil_abonado   OUT NOCOPY  ga_abocel.perfil_abonado%TYPE,
								  SV_cod_planserv     OUT NOCOPY  ga_abocel.cod_planserv%TYPE,
								  SN_num_venta        OUT NOCOPY ga_ventas.num_venta%TYPE,
  								  SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
   								  SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
   								  SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_ABONADO_PR"
      Lenguaje="PL/SQL"
      Fecha="16-11-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar los atributos mas comunmente consultados del abonado ECU-050050</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de abonado</param>
         </Entrada>
         <Salida>
            <param nom="SV_clase_servicio"      Tipo="CARACTER">Clase de servicio</param>
            <param nom="SV_perfil_abonado"      Tipo="CARACTER">Perfil servicios del abonado</param>
            <param nom="SV_cod_planserv"      Tipo="CARACTER">Plan de servicios</param>
            <param nom="SN_num_venta"       Tipo="NUMERICO">Nro de la venta</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

		LV_des_error		 ge_errores_pg.DesEvent;
        LV_Sql             	 ge_errores_pg.vQuery;

   BEGIN
       SN_cod_retorno:=0;
       SN_num_evento:= 0;
	   SV_clase_servicio:=NULL;
	   SV_perfil_abonado:=NULL;
	   SV_cod_planserv:=NULL;
	   SN_num_venta:=NULL;
	   SV_mens_retorno:=NULL;

	   LV_Sql:='SELECT postpago.clase_servicio, postpago.perfil_abonado,'||
		       'postpago.cod_planserv, postpago.num_venta '||
		       ' INTO '||
			   ' SV_clase_servicio,SV_perfil_abonado,'||
			   ' SV_cod_planserv,SN_num_venta'||
		       ' FROM ga_abocel postpago '||
		 	   ' WHERE postpago.num_abonado='||EN_num_abonado||
	   		   ' UNION '||
	   		   ' SELECT prepago.clase_servicio, prepago.perfil_abonado,'||
		       ' prepago.cod_planserv, prepago.num_venta '||
		  	   ' FROM ga_aboamist prepago '||
		 	   ' WHERE prepago.num_abonado='||EN_num_abonado;

	   SELECT postpago.clase_servicio, postpago.perfil_abonado,
		       postpago.cod_planserv, postpago.num_venta
		  INTO
			   SV_clase_servicio,SV_perfil_abonado,
			   SV_cod_planserv,SN_num_venta
		  FROM ga_abocel postpago
		 WHERE postpago.num_abonado=EN_num_abonado
	   UNION
	   SELECT prepago.clase_servicio, prepago.perfil_abonado,
		       prepago.cod_planserv, prepago.num_venta
		  FROM ga_aboamist prepago
		 WHERE prepago.num_abonado=EN_num_abonado;


EXCEPTION
WHEN OTHERS THEN
                SN_cod_retorno := '302'; -- Nuevo Error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error :='Others: GA_CONSULTA_ABONADO_PR('||EN_num_abonado||')';
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento,CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR', LV_Sql, SQLCODE, LV_des_error );
END GA_CONSULTA_ABONADO_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END GA_CONSULTAS_PG;
/
SHOW ERRORS
