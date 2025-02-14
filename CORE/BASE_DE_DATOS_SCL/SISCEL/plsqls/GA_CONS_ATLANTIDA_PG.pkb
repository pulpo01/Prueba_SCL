CREATE OR REPLACE PACKAGE BODY ga_cons_atlantida_pg AS

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_valida_prepago_fn (
   en_num_celular     IN                  ga_abocel.num_celular%TYPE,
   sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
   sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
   sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentacion TipoDoc = "Function">
   <Elemento
      Nombre = "GA_VALIDA_PREPAGO_FN"
      Fecha modificacion=" "
      Fecha creacion="02-06-2006"
      Programador="Carlos Navarro"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Valida la Existencia de un Numero Celular en Prepago</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="en_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
IS
    V_des_error           ge_errores_pg.DesEvent;
    sSql                  ge_errores_pg.vQuery;
    ln_cantidad               NUMBER;
        error_abonado_prepago EXCEPTION;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

    sSql := 'SELECT COUNT(1)'
         || '  FROM ga_aboamist'
         || ' WHERE num_celular = '||EN_num_celular;

    SELECT COUNT(1)
      INTO ln_cantidad
      FROM ga_aboamist
     WHERE num_celular = EN_num_celular
       AND cod_situacion <> cv_situacion_baja;

        IF (ln_cantidad > 0) THEN
        RAISE error_abonado_prepago;
    ELSE
        RETURN TRUE;
    END IF;

EXCEPTION

        WHEN error_abonado_prepago THEN
       SN_cod_retorno := '318';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'ga_valida_abonado_postpago_fn(' || en_num_celular || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_valida_abonado_postpago_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'ga_valida_prepago_fn(' || en_num_celular || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_valida_prepago_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

END ga_valida_prepago_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_valida_abonado_postpago_fn (
   en_num_celular     IN                  ga_abocel.num_celular%TYPE,
   sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
   sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
   sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentacion TipoDoc = "Function">
   <Elemento
      Nombre = "GA_VALIDA_ABONADO_POSTPAGO_FN"
      Fecha modificacion=" "
      Fecha creacion="02-06-2006"
      Programador="Carlos Navarro"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Valida la Existencia de un Numero Celular en Postpago y que ademas que no este de baja</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="en_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
IS
    V_des_error            ge_errores_pg.DesEvent;
    sSql                   ge_errores_pg.vQuery;
    ln_cantidad            NUMBER;
        error_abonado_baja         EXCEPTION;
        error_abonado_noexiste EXCEPTION;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

    sSql := 'SELECT COUNT(1)'
         || '  FROM ga_abocel'
         || '  WHERE num_celular = ' || EN_num_celular
         || '  AND cod_situacion <> ' || cv_situacion_baja;

    SELECT COUNT(1)
      INTO ln_cantidad
      FROM ga_abocel
     WHERE num_celular = EN_num_celular
       AND cod_situacion <> cv_situacion_baja;

        IF (ln_cantidad > 0) THEN
        RETURN TRUE;
    ELSE
                SELECT COUNT(1)
          INTO ln_cantidad
          FROM ga_abocel
         WHERE num_celular = EN_num_celular
           AND cod_situacion = cv_situacion_baja;

                IF (ln_cantidad > 0) THEN
                    RAISE error_abonado_baja;
                ELSE
                        RAISE error_abonado_noexiste;
                END IF;
    END IF;

EXCEPTION

        WHEN error_abonado_noexiste THEN
       SN_cod_retorno := '142';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'ga_valida_abonado_postpago_fn(' || en_num_celular || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_valida_abonado_postpago_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

        WHEN error_abonado_baja THEN
       SN_cod_retorno := '146';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'ga_valida_abonado_postpago_fn(' || en_num_celular || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_valida_abonado_postpago_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'ga_valida_abonado_postpago_fn(' || en_num_celular || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_valida_abonado_postpago_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

END ga_valida_abonado_postpago_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_valida_abonados_cliente_fn (
   en_cod_cliente     IN                  ge_clientes.cod_cliente%TYPE,
   sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
   sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
   sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentacion TipoDoc = "Function">
   <Elemento
      Nombre = "GA_VALIDA_ABONADOS_CLIENTE_FN"
      Fecha modificacion=" "
      Fecha creacion="02-06-2006"
      Programador="Carlos Navarro"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Valida que por lo menos un Abonado de un Cliente este en Alta</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="en_cod_cliente" Tipo="NUMERICO">Codigo de Cliente</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
IS
    V_des_error             ge_errores_pg.DesEvent;
    sSql                    ge_errores_pg.vQuery;
    ln_cantidad                     NUMBER;
        error_ningun_abonado    EXCEPTION;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

    sSql := 'SELECT COUNT(1)'
         || '  FROM ga_abocel'
         || ' WHERE cod_cliente = ' || EN_cod_cliente
                 || ' AND cod_situacion <> ' || cv_situacion_baja;

    SELECT COUNT(1)
          INTO ln_cantidad
      FROM ga_abocel
     WHERE cod_cliente = En_cod_cliente
       AND cod_situacion <> cv_situacion_baja;

        IF (ln_cantidad > 0) THEN
        RETURN TRUE;
    ELSE
        RAISE error_ningun_abonado;
    END IF;

EXCEPTION

    WHEN error_ningun_abonado THEN
       SN_cod_retorno := '757';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'ga_valida_abonados_cliente_fn(' || en_cod_cliente || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_valida_abonados_cliente_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'ga_valida_abonados_cliente_fn(' || en_cod_cliente || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_valida_abonados_cliente_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

END ga_valida_abonados_cliente_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_valida_cliente_fn (
   en_cod_cliente     IN                  ge_clientes.cod_cliente%TYPE,
   sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
   sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
   sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentacion TipoDoc = "Function">
   <Elemento
      Nombre = "GA_VALIDA_CLIENTE_FN"
      Fecha modificacion=" "
      Fecha creacion="02-06-2006"
      Programador="Carlos Navarro"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Valida la Existencia de un Cliente</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="en_cod_cliente" Tipo="NUMERICO">Codigo de Cliente</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
IS
    V_des_error             ge_errores_pg.DesEvent;
    sSql                    ge_errores_pg.vQuery;
    ln_cantidad                     NUMBER;
        error_cliente_noexiste  EXCEPTION;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

    sSql := 'SELECT COUNT(1)'
         || '  FROM ge_clientes'
         || ' WHERE cod_cliente = ' || EN_cod_cliente;

    SELECT COUNT(1)
      INTO ln_cantidad
      FROM ge_clientes
     WHERE cod_cliente = EN_cod_cliente;

        IF (ln_cantidad > 0) THEN
        RETURN TRUE;
    ELSE
        RAISE error_cliente_noexiste;
    END IF;

EXCEPTION

    WHEN error_cliente_noexiste THEN
       SN_cod_retorno := '222';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'ga_valida_cliente_fn(' || en_cod_cliente || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_valida_cliente_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'ga_valida_cliente_fn(' || en_cod_cliente || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_valida_cliente_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

END ga_valida_cliente_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_valida_cliente_empresa_fn (
   en_cod_cliente     IN                  ge_clientes.cod_cliente%TYPE,
   sv_tipo                        OUT NOCOPY      VARCHAR2,
   sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
   sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
   sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentacion TipoDoc = "Function">
   <Elemento
      Nombre = "GA_VALIDA_CLIENTE_EMPRESA_FN"
      Fecha modificacion=" "
      Fecha creacion="02-06-2006"
      Programador="Carlos Navarro"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Valida la Existencia de un Cliente como Empresa</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="en_cod_cliente" Tipo="NUMERICO">Codigo de Cliente</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
IS
    V_des_error      ge_errores_pg.DesEvent;
    sSql             ge_errores_pg.vQuery;
    ln_cantidad                  NUMBER;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

    sSql := 'SELECT COUNT(1)'
         || '  FROM ga_empresa'
         || ' WHERE cod_cliente = ' || EN_cod_cliente;

    SELECT COUNT(1)
      INTO ln_cantidad
      FROM ga_empresa
     WHERE cod_cliente = EN_cod_cliente;

    IF (ln_cantidad > 0) THEN
                sv_tipo := 'EMPRESA';
        RETURN TRUE;
    ELSE
                sv_tipo := 'INDIVIDUAL';
        RETURN TRUE;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'ga_valida_cliente_empresa_fn(' || en_cod_cliente || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_valida_cliente_empresa_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

END ga_valida_cliente_empresa_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_cons_atlantida_abonado_pr (
        en_num_celular       IN                  ga_abocel.num_celular%TYPE,
        sv_servicio                      OUT NOCOPY      VARCHAR2,
        sv_cod_servicio          OUT NOCOPY      ga_servsupl.cod_servicio%TYPE,
        sv_des_servicio      OUT NOCOPY      ga_servsupl.des_servicio%TYPE,
        sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
        sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "GA_CONS_ATLANTIDA_ABONADO_PR"
      Fecha modificacion=" "
      Fecha creacion="02-06-2006"
      Programador="Carlos Navarro"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Valida si un Abonado tiene Servicios de la Plataforma Atlantida</Descripcion>
      <Parametros>
         <Entrada>
                                     <param nom="en_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
             <param nom="sv_servicio" Tipo="CARACTER">Indica si el abonado tiene servios de Atlántida Activos (SI-NO)</param>
             <param nom="sv_cod_servicio" Tipo="CARACTER">Código de Servicio</param>
             <param nom="sv_des_servicio" Tipo="CARACTER">Descripción del Servicio</param>
             <param nom="sn_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
             <param nom="sv_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="sn_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
AS
    V_des_error      ge_errores_pg.DesEvent;
    sSql             ge_errores_pg.vQuery;
        error_ejecucion  EXCEPTION;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';
        sv_cod_servicio:= '';
    sv_des_servicio:= '';
        sv_servicio    := 'TRUE';

        IF ga_valida_prepago_fn (en_num_celular, sn_cod_retorno, sv_mens_retorno, sn_num_evento) THEN
           IF ga_valida_abonado_postpago_fn (en_num_celular, sn_cod_retorno, sv_mens_retorno, sn_num_evento) THEN

                  sSql := 'SELECT c.cod_servicio, c.des_servicio'
               || '  FROM ga_abocel a, gad_servsup_plan b, ga_servsupl c'
               || ' WHERE a.num_celular = ' || EN_num_celular
                   || '   AND a.cod_producto = ' || cn_cod_producto
                           || '   AND b.tip_relacion = ' || cv_tip_relacion
                   || '   AND b.cod_plantarif = a.cod_plantarif'
                   || '   AND b.cod_producto = a.cod_producto'
                   || '   AND c.cod_servicio = b.cod_servicio'
                   || '   AND c.cod_producto = b.cod_producto'
                   || '   AND b.cod_servicio IN (SELECT cod_valor FROM ged_codigos WHERE nom_tabla = '||cv_nom_tabla||' AND nom_columna = '||cv_nom_columna||' AND cod_modulo = '||cv_cod_modulo||');'
                   || '   AND ROWNUM = ' || cn_cantidad_reg;

                  SELECT c.cod_servicio, c.des_servicio
                    INTO sv_cod_servicio, sv_des_servicio
            FROM ga_abocel a, gad_servsup_plan b, ga_servsupl c
           WHERE a.num_celular = EN_num_celular
             AND a.cod_producto = cn_cod_producto
                         AND b.tip_relacion = cv_tip_relacion
             AND b.cod_plantarif = a.cod_plantarif
             AND b.cod_producto = a.cod_producto
             AND c.cod_servicio = b.cod_servicio
             AND c.cod_producto = b.cod_producto
             AND b.cod_servicio IN (SELECT cod_valor FROM ged_codigos WHERE nom_tabla = cv_nom_tabla AND nom_columna = cv_nom_columna AND cod_modulo = cv_cod_modulo)
                     AND ROWNUM = cn_cantidad_reg;
                ELSE
                        RAISE error_ejecucion;
                END IF;
        ELSE
                RAISE error_ejecucion;
    END IF;

EXCEPTION

   WHEN error_ejecucion THEN
          sv_servicio    := 'FALSE';
      V_des_error := 'ga_cons_atlantida_abonado_pr('|| en_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_cons_atlantida_abonado_pr', sSql, SQLCODE, V_des_error );

   WHEN NO_DATA_FOUND THEN
          sv_servicio    := 'FALSE';
      SN_cod_retorno := '756';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_cons_atlantida_abonado_pr('|| en_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_cons_atlantida_abonado_pr', sSql, SQLCODE, V_des_error );

   WHEN OTHERS THEN
          sv_servicio    := 'FALSE';
      SN_cod_retorno := '156';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_cons_atlantida_abonado_pr('|| en_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_cons_atlantida_abonado_pr', sSql, SQLCODE, V_des_error );

END ga_cons_atlantida_abonado_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_cons_atlantida_cliente_pr (
        en_cod_cliente       IN              ge_clientes.cod_cliente%TYPE,
        sv_servicio                      OUT NOCOPY      VARCHAR2,
        sv_cod_servicio          OUT NOCOPY      ga_servsupl.cod_servicio%TYPE,
        sv_des_servicio          OUT NOCOPY      ga_servsupl.des_servicio%TYPE,
        sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
        sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "GA_CONS_ATLANTIDA_CLIENTE_PR"
      Fecha modificacion=" "
      Fecha creacion="02-06-2006"
      Programador="Carlos Navarro"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Valida si un Cliente tiene Servicios de la Plataforma Atlantida</Descripcion>
      <Parametros>
         <Entrada>
                                     <param nom="en_cod_cliente" Tipo="NUMERICO">Codigo de Cliente</param>
         </Entrada>
         <Salida>
                         <param nom="sv_servicio" Tipo="CARACTER">Indica si el abonado tiene servios de Atlántida Activos (SI-NO)</param>
             <param nom="sv_cod_servicio" Tipo="CARACTER">Código de Servicio</param>
             <param nom="sv_des_servicio" Tipo="CARACTER">Descripción del Servicio</param>
             <param nom="sn_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
             <param nom="sv_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="sn_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
AS
    V_des_error      ge_errores_pg.DesEvent;
    sSql             ge_errores_pg.vQuery;
        lv_tipo_cliente  VARCHAR2(15);
        error_ejecucion  EXCEPTION;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';
        sv_cod_servicio:= '';
    sv_des_servicio:= '';
        sv_servicio    := 'TRUE';

        IF ga_valida_cliente_fn (en_cod_cliente, sn_cod_retorno, sv_mens_retorno, sn_num_evento) THEN
            IF ga_valida_cliente_empresa_fn (en_cod_cliente, lv_tipo_cliente, sn_cod_retorno, sv_mens_retorno, sn_num_evento) THEN
                    IF (lv_tipo_cliente = 'INDIVIDUAL') THEN
                            IF ga_valida_abonados_cliente_fn (en_cod_cliente, sn_cod_retorno, sv_mens_retorno, sn_num_evento) THEN

                                    sSql := 'SELECT c.cod_servicio, c.des_servicio'
                             || '  FROM ga_abocel a, gad_servsup_plan b, ga_servsupl c'
                             || ' WHERE a.cod_cliente = '||EN_cod_cliente
                             || '   AND a.cod_producto = '||cn_cod_producto
                             || '   AND a.cod_situacion <> '||cv_situacion_baja
                             || '   AND a.fec_alta = (SELECT MIN(fec_alta) FROM ga_abocel WHERE cod_cliente = '||EN_cod_cliente||' AND cod_producto = '||cn_cod_producto||' AND cod_situacion <> '||cv_situacion_baja||')'
                                                 || '   AND b.tip_relacion = '||cv_tip_relacion
                             || '   AND b.cod_plantarif = a.cod_plantarif'
                             || '   AND b.cod_producto = a.cod_producto'
                             || '   AND c.cod_servicio = b.cod_servicio'
                             || '   AND c.cod_producto = b.cod_producto'
                             || '   AND b.cod_servicio IN (SELECT cod_valor FROM ged_codigos WHERE nom_tabla = '||cv_nom_tabla||' AND nom_columna = '||cv_nom_columna||' AND cod_modulo = '||cv_cod_modulo||');'
                                                 || '   AND ROWNUM = ' || cn_cantidad_reg;

                                        SELECT c.cod_servicio, c.des_servicio
                                          INTO sv_cod_servicio, sv_des_servicio
                          FROM ga_abocel a, gad_servsup_plan b, ga_servsupl c
                         WHERE a.cod_cliente = EN_cod_cliente
                           AND a.cod_producto = cn_cod_producto
                           AND a.cod_situacion <> cv_situacion_baja
                           AND a.fec_alta = (SELECT MIN(fec_alta) FROM ga_abocel WHERE cod_cliente = EN_cod_cliente AND cod_producto = cn_cod_producto AND cod_situacion <> cv_situacion_baja)
                                           AND b.tip_relacion = cv_tip_relacion
                           AND b.cod_plantarif = a.cod_plantarif
                           AND b.cod_producto = a.cod_producto
                           AND c.cod_servicio = b.cod_servicio
                           AND c.cod_producto = b.cod_producto
                           AND b.cod_servicio IN (SELECT cod_valor FROM ged_codigos WHERE nom_tabla = cv_nom_tabla AND nom_columna = cv_nom_columna AND cod_modulo = cv_cod_modulo)
                                           AND ROWNUM = cn_cantidad_reg;
                            ELSE
                                        RAISE error_ejecucion;
                                END IF;
                        ELSE
                            IF (lv_tipo_cliente = 'EMPRESA') THEN
                                    IF ga_valida_abonados_cliente_fn (en_cod_cliente, sn_cod_retorno, sv_mens_retorno, sn_num_evento) THEN

                                    sSql := 'SELECT c.cod_servicio, c.des_servicio'
                             || '  FROM ga_empresa a, gad_servsup_plan b, ga_servsupl c'
                             || ' WHERE a.cod_cliente = '||EN_cod_cliente
                             || '   AND a.cod_producto = '||cn_cod_producto
                                                         || '   AND b.tip_relacion = '||cv_tip_relacion
                             || '   AND b.cod_plantarif = a.cod_plantarif'
                             || '   AND b.cod_producto = a.cod_producto'
                             || '   AND c.cod_servicio = b.cod_servicio'
                             || '   AND c.cod_producto = b.cod_producto'
                             || '   AND b.cod_servicio IN (SELECT cod_valor FROM ged_codigos WHERE nom_tabla = '||cv_nom_tabla||' AND nom_columna = '||cv_nom_columna||' AND cod_modulo = '||cv_cod_modulo||');'
                                                         || '   AND ROWNUM = ' || cn_cantidad_reg;

                                    SELECT c.cod_servicio, c.des_servicio
                                          INTO sv_cod_servicio, sv_des_servicio
                          FROM ga_empresa a, gad_servsup_plan b, ga_servsupl c
                         WHERE a.cod_cliente = EN_cod_cliente
                           AND a.cod_producto = cn_cod_producto
                                                   AND b.tip_relacion = cv_tip_relacion
                           AND b.cod_plantarif = a.cod_plantarif
                           AND b.cod_producto = a.cod_producto
                           AND c.cod_servicio = b.cod_servicio
                           AND c.cod_producto = b.cod_producto
                           AND b.cod_servicio IN (SELECT cod_valor FROM ged_codigos WHERE nom_tabla = cv_nom_tabla AND nom_columna = cv_nom_columna AND cod_modulo = cv_cod_modulo)
                                                   AND ROWNUM = cn_cantidad_reg;
                                    ELSE
                                                RAISE error_ejecucion;
                                        END IF;
                                END IF;
                        END IF;
                ELSE
                        RAISE error_ejecucion;
                END IF;
        ELSE
                RAISE error_ejecucion;
        END IF;

EXCEPTION

   WHEN error_ejecucion THEN
          sv_servicio := 'FALSE';
      V_des_error := 'ga_cons_atlantida_cliente_pr('|| en_cod_cliente ||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_cons_atlantida_cliente_pr', sSql, SQLCODE, V_des_error );

   WHEN NO_DATA_FOUND THEN
          sv_servicio := 'FALSE';
      SN_cod_retorno := '756';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
          sv_servicio := 'FALSE';
      V_des_error := 'ga_cons_atlantida_cliente_pr('|| en_cod_cliente ||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_cons_atlantida_cliente_pr', sSql, SQLCODE, V_des_error );

   WHEN OTHERS THEN
          sv_servicio := 'FALSE';
      SN_cod_retorno := '156';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_cons_atlantida_cliente_pr('|| en_cod_cliente ||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_atlantida_pg.ga_cons_atlantida_cliente_pr', sSql, SQLCODE, V_des_error );

END ga_cons_atlantida_cliente_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END ga_cons_atlantida_pg;
/
SHOW ERRORS
