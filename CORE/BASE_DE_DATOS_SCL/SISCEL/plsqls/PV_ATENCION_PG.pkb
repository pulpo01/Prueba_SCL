CREATE OR REPLACE PACKAGE BODY pv_atencion_pg
AS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_consulta_abonado_pr ( en_num_abonado   IN  ga_abocel.num_abonado%TYPE,
                                   sn_num_celular   OUT NOCOPY ga_abocel.num_celular%TYPE,
                                   sv_nom_usuario   OUT NOCOPY ga_usuarios.nom_usuario%TYPE,
                                   sv_nom_apellido1 OUT NOCOPY ga_usuarios.nom_apellido1%TYPE,
                                   sv_nom_apellido2 OUT NOCOPY ga_usuarios.nom_apellido2%TYPE,
                                   sn_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento    OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_consulta_abonado_pr"
      Lenguaje="PL/SQL"
      Fecha="09-07-2010"
      Versión="1.0"
      Diseñador=""
      Programador="Jorge Gonzalez"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta Abonado</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="en_num_abonado" Tipo="Number">Numero de Abonado</param>
         </Entrada>
         <Salida>
           <param nom="sn_num_celular"  Tipo="Number">Numero de celular</param>
           <param nom="sn_nom_usuario"  Tipo="Varchar2">Nombre de usuario</param>
           <param nom="sv_nom_apellido1"  Tipo="Varchar2">Nombre Apellido 1</param>
           <param nom="sv_nom_apellido2"  Tipo="Varchar2">Nombre Apellido 2</param>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
           <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
           <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_des_error          ge_errores_pg.desevent;
    LV_sSql               ge_errores_pg.vQuery;

BEGIN

    sn_cod_retorno  := 0;
    sv_mens_retorno := 'OK';
    sn_num_evento     := 0;

    LV_sSql := 'SELECT  g1.num_celular, g2.nom_usuario, g2.nom_apellido1, g2.nom_apellido2 '
             ||'FROM    ga_usuamist g2, ga_aboamist g1 '
             ||'WHERE   g1.num_abonado = '||en_num_abonado||' '
             ||'AND     g1.cod_usuario = g2.cod_usuario '
             ||'UNION '
             ||'SELECT  g1.num_celular, g2.nom_usuario, g2.nom_apellido1, g2.nom_apellido2 '
             ||'FROM    ga_usuarios g2, ga_abocel g1 '
             ||'WHERE   g1. num_abonado = '||en_num_abonado||' '
             ||'AND     g1.cod_usuario = g2.cod_usuario '
             ||'AND     g1.cod_uso <> 3';

    SELECT  g1.num_celular, g2.nom_usuario, g2.nom_apellido1, g2.nom_apellido2
    INTO    sn_num_celular, sv_nom_usuario, sv_nom_apellido1, sv_nom_apellido2
    FROM    ga_usuamist g2, ga_aboamist g1
    WHERE   g1.num_abonado = en_num_abonado
    AND     g1.cod_usuario = g2.cod_usuario
--    AND     g1.cod_situacion <> 'BAA'
    UNION
    SELECT  g1.num_celular, g2.nom_usuario, g2.nom_apellido1, g2.nom_apellido2
    FROM    ga_usuarios g2, ga_abocel g1
    WHERE   g1. num_abonado = en_num_abonado
    AND     g1.cod_usuario = g2.cod_usuario
--    AND     g1.cod_situacion <> 'BAA'
    AND     g1.cod_uso <> 3;


EXCEPTION
    WHEN NO_DATA_FOUND THEN
        sn_cod_retorno  := 3;
        sv_mens_retorno := 'El sistema no ha podido cargar los datos del abonado';
        lv_des_error    := SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl(sn_num_evento,GV_COD_MODULO,sv_mens_retorno,'1.0',user,'pv_atencion_pg.pv_consulta_abonado_pr',lv_ssql,sn_cod_retorno,lv_des_error);

    WHEN OTHERS THEN
        sn_cod_retorno  := 4;
        sv_mens_retorno := 'Error en ejecución PL-SQL pv_atencion_pg.pv_consulta_abonado_pr.';
        lv_des_error    := SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl(sn_num_evento,GV_COD_MODULO,sv_mens_retorno,'1.0',user,'pv_atencion_pg.pv_consulta_abonado_pr',lv_ssql,sn_cod_retorno,lv_des_error);

END  pv_consulta_abonado_pr;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_consulta_cliente_pr ( en_cod_cliente   IN  ga_abocel.cod_cliente%TYPE,
                                   sc_cons_cliente  OUT NOCOPY refcursor,
                                   sn_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento    OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_consulta_abonado_pr"
      Lenguaje="PL/SQL"
      Fecha="09-07-2010"
      Versión="1.0"
      Diseñador=""
      Programador="Jorge Gonzalez"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta cliente</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="en_cod_cliente" Tipo="Number">codigo cliente</param>
         </Entrada>
         <Salida>
           <param nom="sc_cons_cliente" Tipo="Cursor">Cursor con Datos</param>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
           <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
           <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    ln_total         NUMBER(5) :=0;
    ln_cantidad_1    NUMBER(5) :=0;
    ln_cantidad_2    NUMBER(5) :=0;
    LV_des_error     ge_errores_pg.desevent;
    LV_sSql          ge_errores_pg.vQuery;
    error_controlado EXCEPTION;

BEGIN

    sn_cod_retorno  := 0;
    sv_mens_retorno := 'OK';
    sn_num_evento     := 0;

    SELECT  count(1)
    INTO    ln_cantidad_1
    FROM    ga_usuamist g2, ga_aboamist g1
    WHERE   g1.cod_cliente = en_cod_cliente
    AND     g1.cod_usuario = g2.cod_usuario
    AND     g1.cod_situacion <> 'BAA';

    SELECT  count(1)
    INTO    ln_cantidad_2
    FROM    ga_usuarios g2, ga_abocel g1
    WHERE   g1.cod_cliente = en_cod_cliente
    AND     g1.cod_usuario = g2.cod_usuario
    AND     g1.cod_situacion <> 'BAA'
    AND     g1.cod_uso <> 3;

    ln_total := ln_cantidad_1 + ln_cantidad_2;

    IF ln_total > 0 THEN

        LV_sSql := 'SELECT  g1.num_abonado,g1.num_celular, g2.nom_usuario, g2.nom_apellido1, g2.nom_apellido2 '
                 ||'FROM    ga_usuamist g2, ga_aboamist g1 '
                 ||'WHERE   g1.cod_cliente = '||en_cod_cliente||' '
                 ||'AND     g1.cod_usuario = g2.cod_usuario '
                 ||'AND     g1.cod_situacion <> "BAA" '
                 ||'UNION '
                 ||'SELECT  g1.num_abonado,g1.num_celular, g2.nom_usuario, g2.nom_apellido1, g2.nom_apellido2 '
                 ||'FROM    ga_usuarios g2, ga_abocel g1 '
                 ||'WHERE   g1.cod_cliente = '||en_cod_cliente||' '
                 ||'AND     g1.cod_usuario = g2.cod_usuario '
                 ||'AND     g1.cod_uso <> 3';

        OPEN sc_cons_cliente FOR
            SELECT  g1.num_abonado ,g1.num_celular, g2.nom_usuario, g2.nom_apellido1, g2.nom_apellido2
            FROM    ga_usuamist g2, ga_aboamist g1
            WHERE   g1.cod_cliente = en_cod_cliente
            AND     g1.cod_usuario = g2.cod_usuario
            AND     g1.cod_situacion <> 'BAA'
            UNION
            SELECT  g1.num_abonado,g1.num_celular, g2.nom_usuario, g2.nom_apellido1, g2.nom_apellido2
            FROM    ga_usuarios g2, ga_abocel g1
            WHERE   g1.cod_cliente = en_cod_cliente
            AND     g1.cod_usuario = g2.cod_usuario
            AND     g1.cod_situacion <> 'BAA'
            AND     g1.cod_uso <> 3;

    ELSE
        sn_cod_retorno  := 1;
        RAISE error_controlado;
    END IF;

EXCEPTION

    WHEN error_controlado THEN
        sv_mens_retorno := 'El sistema no ha podido cargar los datos del cliente';
        lv_des_error    := 'pv_atencion_pg.pv_consulta_cliente_pr; - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl(sn_num_evento,GV_COD_MODULO,sv_mens_retorno,'1.0',USER,'pv_atencion_pg.pv_consulta_cliente_pr',lv_ssql,sn_cod_retorno,lv_des_error);

    WHEN OTHERS THEN
        sn_cod_retorno  := 4;
        sv_mens_retorno := 'Error en ejecución PL-SQL pv_atencion_pg.pv_consulta_abonado_pr.';
        lv_des_error    := SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl(sn_num_evento,GV_COD_MODULO,sv_mens_retorno,'1.0',user,'pv_atencion_pg.pv_consulta_cliente_pr',lv_ssql,sn_cod_retorno,lv_des_error);

END  pv_consulta_cliente_pr;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_consulta_cuenta_pr (  en_cod_cuenta    IN  ga_abocel.cod_cuenta%TYPE,
                                   sc_cons_cuenta   OUT NOCOPY refcursor,
                                   sn_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento    OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_consulta_abonado_pr"
      Lenguaje="PL/SQL"
      Fecha="09-07-2010"
      Versión="1.0"
      Diseñador=""
      Programador="Jorge Gonzalez"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta cliente</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="en_cod_cuenta" Tipo="Number">codigo cuenta</param>
         </Entrada>
         <Salida>
           <param nom="sc_cons_cuenta" Tipo="Cursor">Cursor con Datos</param>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
           <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
           <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    ln_total         NUMBER(5) :=0;
    ln_cantidad_1    NUMBER(5) :=0;
    ln_cantidad_2    NUMBER(5) :=0;
    LV_des_error     ge_errores_pg.desevent;
    LV_sSql          ge_errores_pg.vQuery;
    error_controlado EXCEPTION;

BEGIN

    sn_cod_retorno  := 0;
    sv_mens_retorno := 'OK';
    sn_num_evento     := 0;

    SELECT  count(1)
    INTO    ln_cantidad_1
    FROM    ga_usuamist g2, ga_aboamist g1
    WHERE   g1.cod_cuenta = en_cod_cuenta
    AND     g1.cod_usuario = g2.cod_usuario
    AND     g1.cod_situacion <> 'BAA';

    SELECT  count(1)
    INTO    ln_cantidad_2
    FROM    ga_usuarios g2, ga_abocel g1
    WHERE   g1.cod_cuenta = en_cod_cuenta
    AND     g1.cod_usuario = g2.cod_usuario
    AND     g1.cod_situacion <> 'BAA'
    AND     g1.cod_uso <> 3;

    ln_total := ln_cantidad_1 + ln_cantidad_2;

    IF ln_total > 0 THEN

        LV_sSql := 'SELECT  g1.num_abonado,g1.num_celular, g2.nom_usuario, g2.nom_apellido1, g2.nom_apellido2 '
                 ||'FROM    ga_usuamist g2, ga_aboamist g1 '
                 ||'WHERE   g1.cod_cuenta = '||en_cod_cuenta||' '
                 ||'AND     g1.cod_usuario = g2.cod_usuario '
                 ||'AND     g1.cod_situacion <> "BAA" '
                 ||'UNION '
                 ||'SELECT  g1.num_abonado,g1.num_celular, g2.nom_usuario, g2.nom_apellido1, g2.nom_apellido2 '
                 ||'FROM    ga_usuarios g2, ga_abocel g1 '
                 ||'WHERE   g1.cod_cuenta = '||en_cod_cuenta||' '
                 ||'AND     g1.cod_usuario = g2.cod_usuario '
                 ||'AND     g1.cod_uso <> 3';

        OPEN sc_cons_cuenta FOR
            SELECT  g1.num_abonado ,g1.num_celular, g2.nom_usuario, g2.nom_apellido1, g2.nom_apellido2
            FROM    ga_usuamist g2, ga_aboamist g1
            WHERE   g1.cod_cuenta = en_cod_cuenta
            AND     g1.cod_usuario = g2.cod_usuario
            AND     g1.cod_situacion <> 'BAA'
            UNION
            SELECT  g1.num_abonado,g1.num_celular, g2.nom_usuario, g2.nom_apellido1, g2.nom_apellido2
            FROM    ga_usuarios g2, ga_abocel g1
            WHERE   g1.cod_cuenta = en_cod_cuenta
            AND     g1.cod_usuario = g2.cod_usuario
            AND     g1.cod_situacion <> 'BAA'
            AND     g1.cod_uso <> 3;

    ELSE
        sn_cod_retorno  := 1;
        RAISE error_controlado;
    END IF;

EXCEPTION

    WHEN error_controlado THEN
        sv_mens_retorno := 'El sistema no ha podido cargar los datos de la cuenta';
        lv_des_error    := 'pv_atencion_pg.pv_consulta_cuenta_pr; - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl(sn_num_evento,GV_COD_MODULO,sv_mens_retorno,'1.0',USER,'pv_atencion_pg.pv_consulta_cuenta_pr',lv_ssql,sn_cod_retorno,lv_des_error);

    WHEN OTHERS THEN
        sn_cod_retorno  := 4;
        sv_mens_retorno := 'Error en ejecución PL-SQL pv_atencion_pg.pv_consulta_abonado_pr.';
        lv_des_error    := SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl(sn_num_evento,GV_COD_MODULO,sv_mens_retorno,'1.0',user,'pv_atencion_pg.pv_consulta_cuenta_pr',lv_ssql,sn_cod_retorno,lv_des_error);

END  pv_consulta_cuenta_pr;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_consulta_atencion_pr (sc_cons_aten     OUT NOCOPY refcursor,
                                   sn_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento    OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_consulta_abonado_pr"
      Lenguaje="PL/SQL"
      Fecha="09-07-2010"
      Versión="1.0"
      Diseñador=""
      Programador="Jorge Gonzalez"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta Abonado</Descripción>
      <Parámetros>
         <Entrada>
            <>
         </Entrada>
         <Salida>
           <param nom="sc_cons_aten" Tipo="Cursor">Cursor con Datos Atencion cliente</param>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
           <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
           <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

ln_cantidad      NUMBER(5) :=0;
lv_des_error     ge_errores_pg.desevent;
lv_ssql          ge_errores_pg.vquery;
error_controlado EXCEPTION;

BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := 'OK';
    sn_num_evento     := 0;

    lv_ssql :='SELECT  COUNT(1) '
            ||'FROM    ci_atencion_clientes '
            ||'WHERE   ind_vigente = '||GV_IND_VIGENTE||' '
            ||'AND     grp_atencion = '||GN_GRP_ATENCION||'';

    SELECT  COUNT(1)
    INTO    ln_cantidad
    FROM    ci_atencion_clientes
    WHERE   ind_vigente = GV_IND_VIGENTE
    AND     grp_atencion = GN_GRP_ATENCION;

    IF ln_cantidad > 0 THEN

        OPEN sc_cons_aten FOR
            SELECT  des_atencion,grp_atencion, num_nivel,
                    cod_atencion, ind_observ
            FROM    ci_atencion_clientes
            WHERE   ind_vigente = GV_IND_VIGENTE
            AND     grp_atencion = GN_GRP_ATENCION;
      ELSE
        sn_cod_retorno  := 1;
        RAISE error_controlado;
    END IF;

EXCEPTION
    WHEN error_controlado THEN
        sv_mens_retorno := 'No existe atencion, para la consulta solicitada';
        lv_des_error    := 'pv_atencion_pg.pv_consulta_atencion_pr; - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl(sn_num_evento,GV_COD_MODULO,sv_mens_retorno,'1.0',USER,'pv_atencion_pg.pv_consulta_atencion_pr',lv_ssql,sn_cod_retorno,lv_des_error);

    WHEN OTHERS THEN
        sn_cod_retorno  := 4;
        sv_mens_retorno := 'Error en ejecución PL-SQL pv_atencion_pg.pv_consulta_atencion_pr.';
        lv_des_error    := 'pv_atencion_pg.pv_consulta_atencion_pr; - ' || SQLERRM;
        sn_num_evento:= Ge_Errores_Pg.Grabarpl(sn_num_evento,GV_COD_MODULO,sv_mens_retorno,'1.0',USER,'pv_atencion_pg.pv_consulta_atencion_pr',lv_ssql,sn_cod_retorno,lv_des_error);

END  pv_consulta_atencion_pr;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_ingreso_atencion_pr ( ev_fecha_inicio  IN varchar2,
                                   ev_fecha_fin     IN varchar2,
                                   ev_usuarora      IN ci_reg_atencion_clientes.nom_usuarora%TYPE,
                                   en_num_abonado   IN ci_reg_atencion_clientes.num_abonado%TYPE,
                                   en_cod_atencion  IN ci_reg_atencion_clientes.cod_atencion%TYPE,
                                   ev_observacion   IN ci_reg_atencion_clientes.obs_atencion%TYPE,
                                   sn_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento    OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_ingreso_atencion_pr"
      Lenguaje="PL/SQL"
      Fecha="09-07-2010"
      Versión="1.0"
      Diseñador=""
      Programador="Jorge Gonzalez"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Inserta Atencion</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="ev_fecha_inicio" Tipo="Varchar2">Fecha de Inicio</param>
            <param nom="ev_fecha_fin" Tipo="Varchar2">Fecha de Termino</param>
            <param nom="ev_usuarora" Tipo="Varchar2">Usuario</param>
            <param nom="en_num_abonado" Tipo="Number">numero de abonado</param>
            <param nom="en_cod_atencion" Tipo="Number">codigo de atencion</param>
            <param nom="ev_observacion" Tipo="Varchar2">observacion</param>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
           <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
           <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

lv_des_error     ge_errores_pg.desevent;
lv_ssql          ge_errores_pg.vquery;
ln_numattecli    number;
lv_cod_oficina   ge_seg_usuario.cod_oficina%TYPE;

BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := 'OK';
    sn_num_evento     := 0;

    SELECT ci_seq_numattecli.NEXTVAL INTO ln_numattecli FROM dual;

    lv_ssql := 'SELECT cod_oficina FROM ge_seg_usuario WHERE nom_usuario = '||ev_usuarora||'';

    SELECT cod_oficina
    INTO   lv_cod_oficina
    FROM   ge_seg_usuario
    WHERE  nom_usuario = ev_usuarora;

    /*
     * Modificacion
     * Descripcion: se agrega al INSERT un TO_DATE a ev_fecha_inicio, ev_fecha_fin
     * Developer: Gabriel Moraga L.
     * Fecha: 12/08/2010
     *
     */

    lv_ssql := 'INSERT INTO ci_reg_atencion_clientes '
             ||'(fec_inicio,fec_termino,nom_usuarora,num_abonado,cod_atencion,obs_atencion,num_atencion,cod_oficina) '
             ||'VALUES (TO_DATE('||ev_fecha_inicio||', DD/MM/YYYY HH24:MI:SS), TO_DATE('||ev_fecha_fin||', DD/MM/YYYY HH24:MI:SS),'||ev_usuarora||','||en_num_abonado||','||en_cod_atencion||','
             ||''||ev_observacion||','||ln_numattecli||','||lv_cod_oficina||')';

        INSERT INTO ci_reg_atencion_clientes
           (fec_inicio,fec_termino,nom_usuarora,num_abonado,cod_atencion,obs_atencion,num_atencion,cod_oficina)
    VALUES (TO_DATE(ev_fecha_inicio, 'DD/MM/YYYY HH24:MI:SS'),TO_DATE(ev_fecha_fin, 'DD/MM/YYYY HH24:MI:SS'),ev_usuarora,en_num_abonado,en_cod_atencion,ev_observacion,ln_numattecli,lv_cod_oficina);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        sn_cod_retorno  := 3;
        sv_mens_retorno := 'El sistema no ha podido registrar la atención ingresada';
        lv_des_error    := SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl(sn_num_evento,GV_COD_MODULO,sv_mens_retorno,'1.0',USER,'pv_atencion_pg.pv_ingreso_atencion_pr',lv_ssql,sn_cod_retorno,lv_des_error);

    WHEN OTHERS THEN
        sn_cod_retorno  := 4;
        sv_mens_retorno := 'Error en ejecución PL-SQL pv_atencion_pg.pv_ingreso_atencion_pr.';
        lv_des_error    := 'pv_atencion_pg.pv_consulta_atencion_pr; - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl(sn_num_evento,GV_COD_MODULO,sv_mens_retorno,'1.0',USER,'pv_atencion_pg.pv_ingreso_atencion_pr',lv_ssql,sn_cod_retorno,lv_des_error);

END  pv_ingreso_atencion_pr;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END pv_atencion_pg;
/
SHOW ERRORS