CREATE OR REPLACE PACKAGE BODY PV_DATOS_CLIENTES2_PG AS
--------------------------------------------------------------------------------------------------------
FUNCTION PV_DETERMINA_MOROCIDAD_FN (EO_Cliente  IN PV_CLIENTE2_QT,
                                        SN_cod_retorno      OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                        SV_mens_retorno     OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                        SN_num_evento       OUT NOCOPY    ge_errores_pg.evento )
RETURN NUMBER IS
/*
<Documentacion TipoDoc = "Funcion">
    <Elemento Nombre = "PV_DETERMINA_MOROCIDAD_FN"
    Lenguaje="PL/SQL" Fecha="07-11-2007"
    Versión"1.0.0" Diseñador"Orlando Cabezas"
    Programador="Orlando Cabezas" Ambiente="BD">
        <Retorno>VARCHAR2</Retorno>
        <Descripcion>Verifica morocidad del cliente</Descripcion>
        <Parametros>
            <Entrada>
                <param nom="GE_CLIENTES_QT" Tipo="estructura">estructura de cliente</param>
            </Entrada>
            <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
            </Salida>
        </Parametros>
    </Elemento>
</Documentacion>
*/
LV_des_error       ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;
LV_CANT_MOROCIDAD  NUMBER;
ERROR_PARAMETROS   EXCEPTION;

BEGIN
    SN_cod_retorno     := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

    IF (EO_CLIENTE.COD_TIPIDENT IS NULL) or (EO_CLIENTE.NUM_IDENT IS NULL) THEN
         RAISE ERROR_PARAMETROS;
    ELSE

            LV_sSql:='SELECT COUNT(1)';
            LV_sSql:=LV_sSql || 'FROM  co_cartera c, ge_tipdocumen t,ge_clientes g WHERE ';
                        LV_sSql:=LV_sSql || ' c.cod_cliente = g.cod_cliente';
                        LV_sSql:=LV_sSql || ' AND TRUNC(c.fec_vencimie) < TRUNC(SYSDATE)';
                        LV_sSql:=LV_sSql || ' AND c.ind_facturado = 1';
                        LV_sSql:=LV_sSql || ' AND c.cod_tipdocum  <> 39';
                        LV_sSql:=LV_sSql || ' AND c.cod_tipdocum  = t.cod_tipdocum';
                        LV_sSql:=LV_sSql || ' AND c.importe_debe  > c.importe_haber';
                        LV_sSql:=LV_sSql || ' AND g.cod_tipident  = '|| EO_CLIENTE.COD_TIPIDENT;
                        LV_sSql:=LV_sSql || ' AND g.num_ident     = '|| EO_CLIENTE.NUM_IDENT;

            SELECT COUNT(1)
            INTO LV_CANT_MOROCIDAD
                        FROM  co_cartera c, ge_tipdocumen t,
                                ge_clientes g
                        WHERE
                        c.cod_cliente = g.cod_cliente
                        AND TRUNC(c.fec_vencimie) < TRUNC(SYSDATE)
                        AND c.ind_facturado = 1
                        AND c.cod_tipdocum  <> 39
                        AND c.cod_tipdocum  = t.cod_tipdocum
                        AND c.importe_debe  > c.importe_haber
                        AND g.cod_tipident  = EO_CLIENTE.COD_TIPIDENT
                        AND g.num_ident     = EO_CLIENTE.NUM_IDENT;

        IF (LV_CANT_MOROCIDAD > 0) THEN
               RETURN 1;
        ELSE
            RETURN 0;
        END IF;

     END IF;

EXCEPTION
  WHEN ERROR_PARAMETROS THEN
          SN_cod_retorno := 98;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PV_DETERMINA_MOROCIDAD_FN(Cliente); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES2_PG.PV_DETERMINA_MOROCIDAD_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
          RETURN '-1';
    WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PV_DETERMINA_MOROCIDAD_FN(Cliente); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES2_PG.PV_DETERMINA_MOROCIDAD_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
          RETURN '-1';
END;

--------------------------------------------------------------------------------------------------------
FUNCTION PV_DETERMINA_PRIMERA_VENTA_FN (EO_Cliente  IN PV_CLIENTE2_QT,
                                        SN_cod_retorno      OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                        SV_mens_retorno     OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                        SN_num_evento       OUT NOCOPY    ge_errores_pg.evento )
RETURN VARCHAR2 IS
/*
<Documentacion TipoDoc = "Funcion">
    <Elemento Nombre = "PV_DETERMINA_PRIMERA_VENTA_FN"
    Lenguaje="PL/SQL" Fecha="16-08-2007"
    Versión"1.0.0" Diseñador"Andrés Osorio"
    Programador="Alejandro Díaz" Ambiente="BD">
        <Retorno>VARCHAR2</Retorno>
        <Descripcion>Verifica si el Cliente sólo tiene una venta</Descripcion>
        <Parametros>
            <Entrada>
                <param nom="GE_CLIENTES_QT" Tipo="estructura">estructura de cliente</param>
            </Entrada>
            <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
            </Salida>
        </Parametros>
    </Elemento>
</Documentacion>
*/
LV_des_error       ge_errores_pg.DesEvent;
LV_sSql               ge_errores_pg.vQuery;
LV_VENTAS_POSPAGO  NUMBER;
LV_VENTAS_PREPAGO  NUMBER;
LV_CANT_NUM_VENTA  NUMBER;
ERROR_PARAMETROS   EXCEPTION;

BEGIN
    SN_cod_retorno     := 0;
    SV_mens_retorno := ' ';
    SN_num_evento     := 0;

    IF (EO_CLIENTE IS NULL) or (EO_CLIENTE.COD_CLIENTE IS NULL) THEN
         RAISE ERROR_PARAMETROS;
    ELSE

        LV_sSql := 'SELECT COUNT(DISTINCT NUM_VENTA) ';
        LV_sSql := LV_sSql || ' FROM     GA_ABOCEL ';
        LV_sSql := LV_sSql || ' WHERE  COD_CLIENTE = ' || EO_CLIENTE.COD_CLIENTE;

        SELECT COUNT(DISTINCT NUM_VENTA)
        INTO     LV_VENTAS_POSPAGO
        FROM     GA_ABOCEL
        WHERE  COD_CLIENTE = EO_CLIENTE.COD_CLIENTE;

        LV_sSql := 'SELECT COUNT(DISTINCT NUM_VENTA) ';
        LV_sSql := LV_sSql || ' FROM     GA_ABOAMIST ';
        LV_sSql := LV_sSql || ' WHERE  COD_CLIENTE = ' || EO_CLIENTE.COD_CLIENTE;

        SELECT COUNT(DISTINCT NUM_VENTA)
        INTO     LV_VENTAS_PREPAGO
        FROM     GA_ABOAMIST
        WHERE     COD_CLIENTE = EO_CLIENTE.COD_CLIENTE;

        LV_CANT_NUM_VENTA := LV_VENTAS_PREPAGO + LV_VENTAS_POSPAGO;

        IF (LV_CANT_NUM_VENTA = 1) THEN
               RETURN 'S';
        ELSE
            RETURN 'N';
        END IF;

     END IF;

EXCEPTION
  WHEN ERROR_PARAMETROS THEN
          SN_cod_retorno := 98;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PV_DETERMINA_PRIMERA_VENTA_FN(Cliente); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES2_PG.PV_DETERMINA_PRIMERA_VENTA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
          RETURN 'N';
    WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 0;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PV_DETERMINA_PRIMERA_VENTA_FN(Cliente); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES2_PG.PV_DETERMINA_PRIMERA_VENTA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
          RETURN 'N';
    WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PV_DETERMINA_PRIMERA_VENTA_FN(Cliente); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES2_PG.PV_DETERMINA_PRIMERA_VENTA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
          RETURN 'N';
END;
--------------------------------------------------------------------------------------------------------
    FUNCTION PV_cliente_empresa_FN (
              EN_CodCliente    IN                  ge_clientes.cod_cliente%TYPE,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY        ge_errores_pg.evento)
    RETURN NUMBER
    AS
    /*
    <Documentacion TipoDoc = "Funcion">
    <Elemento Nombre = "PV_cliente_empresa_FN"
     Lenguaje="PL/SQL" Fecha="12-04-2005"
     Versión"1.0.0" Diseñador"****"
     Programador="" Ambiente="BD">
    <Retorno>NA</Retorno>
    <Descripcion>Chequea si el Clientes es empresa</Descripcion>
    <Parametros>
    <Entrada>
            <param nom="PV_Cliente_QT" Tipo="estructura">estructura de cliente</param>>
    </Entrada>
    <Salida>
           <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
           <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
           <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentacion>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    LV_ClienteEmpresa  NUMBER;

    BEGIN
        SN_cod_retorno      := 0;
        SV_mens_retorno  := '';
        SN_num_evento      := 0;
        LV_ClienteEmpresa:= 0 ;

        LV_sSQL := 'SELECT COUNT(1) FROM GA_EMPRESA WHERE cod_cliente  = ' ||EN_CodCliente;

        SELECT COUNT(1)
         INTO LV_ClienteEmpresa
         FROM GA_EMPRESA
          WHERE cod_cliente  = EN_CodCliente;

          RETURN LV_ClienteEmpresa;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
          RETURN 0;
    WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PV_cliente_empresa_FN('||EN_CodCliente||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES2_PG.PV_cliente_empresa_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN -1;
    END PV_cliente_empresa_FN;

--------------------------------------------------------------------------------------------------------
    FUNCTION PV_cliente_es_empresa_FN(
                   SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE2_QT,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY        ge_errores_pg.evento)
    RETURN BOOLEAN
    AS
     /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PV_cliente_es_empresa_FN"
          Lenguaje="PL/SQL"
          Fecha="31-05-2007"
          Versión="La del package"
          Diseñador="Matías Guajardo"
          Programador="Matías Guajardo"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción>Obtiene Datos de Cliente Empresa</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="PV_Cliente_QT" Tipo="estructura">estructura de cliente</param>>
             </Entrada>
             <Salida>
                <param nom="" Tipo=""></param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error          ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;

    BEGIN
        SN_cod_retorno     := 0;
        SV_mens_retorno := '';
        SN_num_evento     := 0;

        SELECT  a.cod_plantarif,
               A.cod_empresa
        INTO  SO_Cliente.cod_plantarif,
              SO_Cliente.cod_empresa
        FROM ga_empresa a
        WHERE
        a.cod_cliente   = SO_Cliente.cod_cliente;

        if (SO_Cliente.cod_plantarif is null or SO_Cliente.cod_plantarif= '')  then
            RETURN TRUE;
        else
        lv_ssql := 'SELECT a.nom_cliente||a.nom_apeclien1||a.nom_apeclien2 as nom_cliente,';
        lv_ssql := lv_ssql || ' b.cod_plantarif,b.des_plantarif,b.TIP_TERMINAL,e.DES_TERMINAL,b.TIP_PLANTARIF,';
        lv_ssql := lv_ssql || ' DECODE(b.TIP_PLANTARIF,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'',''F'', ''FAMILIAR'') AS DES_TIP_PLANTARIF,';
        lv_ssql := lv_ssql || ' b.COD_CARGOBASICO,d.DES_CARGOBASICO,b.COD_TIPLAN,f.DES_VALOR  as des_tiplan,';
        lv_ssql := lv_ssql || ' a.COD_CICLO,a.COD_CUENTA,g.DES_CUENTA,';
        lv_ssql := lv_ssql || ' b.COD_LIMCONSUMO,h.des_LIMCONSUMO,d.imp_cargobasico,a.cod_tipident,';
        lv_ssql := lv_ssql || ' a.num_ident,b.ind_familiar,b.cod_prod_padre,g.tip_cuenta,b.flg_rango, c.cod_empresa';
        lv_ssql := lv_ssql || ' FROM ge_clientes a,ta_plantarif b,ta_cargosbasico d,';
        lv_ssql := lv_ssql || ' al_tipos_terminales e,ged_codigos f,ga_cuentas g,ta_limconsumo h';
            lv_ssql := lv_ssql || ' WHERE ';
        lv_ssql := lv_ssql || ' a.cod_cliente = c.cod_cliente(+)';
        lv_ssql := lv_ssql || ' AND b.cod_plantarif(+) = c.cod_plantarif';
        lv_ssql := lv_ssql || ' AND a.cod_cliente  = '||SO_Cliente.cod_cliente;
        lv_ssql := lv_ssql || ' AND b.COD_CARGOBASICO = d.COD_CARGOBASICO';
        lv_ssql := lv_ssql || ' AND f.NOM_COLUMNA = ''COD_TIPLAN''';
        lv_ssql := lv_ssql || ' AND f.nom_tabla = ''TA_PLANTARIF''';
        lv_ssql := lv_ssql || ' AND SYSDATE BETWEEN d.fec_desde AND d.fec_hasta    ';
        lv_ssql := lv_ssql || ' AND f.cod_valor = b.COD_TIPLAN';
        lv_ssql := lv_ssql || ' AND b.TIP_TERMINAL = e.TIP_TERMINAL';
        lv_ssql := lv_ssql || ' AND a.COD_CUENTA = g.COD_CUENTA';
        lv_ssql := lv_ssql || ' AND b.cod_limconsumo = h.cod_limconsumo';
        --lv_ssql := lv_ssql || ' AND a.cod_cliente IN (SELECT a.COD_CLIENTE from ga_abocel e where a.cod_cliente = e.cod_cliente and c.cod_plantarif = e.cod_plantarif and rownum = 1)';


        SELECT DISTINCT a.nom_cliente||' '||a.nom_apeclien1||' '||a.nom_apeclien2 as nom_cliente,
                b.cod_plantarif,
                b.des_plantarif,
                b.tip_terminal,
                e.des_terminal,
                b.tip_plantarif,
                DECODE(b.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL','F', 'FAMILIAR') AS des_tipplantarif,
                b.cod_cargobasico,
                d.des_cargobasico,
                b.cod_tiplan,
                DECODE(b.cod_tiplan,'1','PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO') AS des_tiplan,
                a.cod_ciclo,
                a.cod_cuenta,
                g.des_cuenta,
                b.cod_limconsumo,
                h.des_limconsumo,
                d.imp_cargobasico,
                  a.cod_tipident,
                 a.num_ident,
                b.ind_familiar,
                b.cod_prod_padre,
                g.tip_cuenta,
                b.flg_rango,
                c.cod_empresa
        INTO SO_Cliente.nom_cliente,
             SO_Cliente.cod_plantarif,
             SO_Cliente.des_plantarif,
             SO_Cliente.tip_terminal,
             SO_Cliente.des_terminal,
             SO_Cliente.tip_plantarif,
             SO_Cliente.des_tipplantarif,
             SO_Cliente.cod_cargobasico,
             SO_Cliente.des_cargobasico,
             SO_Cliente.cod_tiplan,
             SO_Cliente.des_tiplan,
             SO_Cliente.cod_ciclo,
             SO_Cliente.cod_cuenta,
             SO_Cliente.des_cuenta,
             SO_Cliente.cod_limconsumo,
             SO_Cliente.des_limconsumo,
             SO_Cliente.imp_cargobasico,
              SO_Cliente.cod_tipident,
              SO_Cliente.num_ident,
             SO_Cliente.ind_familiar,
             SO_Cliente.cod_prod_padre,
             SO_Cliente.tip_cuenta,
             SO_Cliente.flg_rango,
             SO_Cliente.cod_empresa
        FROM ge_clientes a,
                ta_plantarif b,
                ga_empresa c,
                ta_cargosbasico d,
                al_tipos_terminales e,
                ged_codigos f,
                ga_cuentas g,
                ta_limconsumo h
        WHERE
                a.cod_cliente = c.cod_cliente(+)
                AND b.cod_plantarif(+) = c.cod_plantarif
                AND a.cod_cliente   = SO_Cliente.cod_cliente
                AND b.cod_cargobasico = d.cod_cargobasico
                AND f.nom_columna = 'COD_TIPLAN'
                AND f.nom_tabla = 'TA_PLANTARIF'
                AND SYSDATE BETWEEN d.fec_desde AND d.fec_hasta
                AND f.cod_valor = b.cod_tiplan
                AND b.tip_terminal = e.tip_terminal
                AND a.cod_cuenta = g.cod_cuenta
                AND b.cod_limconsumo = h.cod_limconsumo
                AND ROWNUM=1;
                --AND a.cod_cliente IN (SELECT a.COD_CLIENTE from ga_abocel e where a.cod_cliente = e.cod_cliente and c.cod_plantarif = e.cod_plantarif and rownum = 1);

                RETURN TRUE;
    end if;

    EXCEPTION

    WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 149;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PV_cliente_es_empresa_FN('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES2_PG.PV_cliente_es_empresa_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
          RETURN FALSE;
      WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PV_cliente_es_empresa_FN('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES2_PG.PV_cliente_es_empresa_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
          RETURN FALSE;
    END PV_cliente_es_empresa_FN;

--------------------------------------------------------------------------------------------------------
    FUNCTION PV_cliente_no_empresa_FN(
                   SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE2_QT,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY        ge_errores_pg.evento)
    RETURN BOOLEAN
    AS
     /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PV_cliente_no_empresa_FN"
          Lenguaje="PL/SQL"
          Fecha="31-05-2007"
          Versión="La del package"
          Diseñador="Matías Guajardo"
          Programador="Matías Guajardo"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción>Obtiene Datosd de cliente Individual</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="PV_Cliente_QT" Tipo="estructura">estructura de cliente</param>>
             </Entrada>
             <Salida>
                <param nom="" Tipo=""></param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error          ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    LV_Cod_cliente          NUMBER;
    LN_CANTPLANABOC      NUMBER;
    LN_CANTPLANABOM      NUMBER;

    BEGIN
        SN_cod_retorno      := 0;
        SV_mens_retorno  := '';
        SN_num_evento      := 0;
        LN_CANTPLANABOC  := 0;
        LN_CANTPLANABOM  := 0;

        lv_ssql := 'SELECT COUNT(DISTINCT(cod_plantarif))';
        lv_ssql := lv_ssql || ' INTO LN_CANTPLANTARIF';
        lv_ssql := lv_ssql || ' FROM GA_ABOAMIST WHERE COD_CLIENTE = '||SO_Cliente.cod_cliente;
        lv_ssql := lv_ssql || ' UNION';
        lv_ssql := lv_ssql || '  SELECT COUNT(DISTINCT(cod_plantarif))';
        lv_ssql := lv_ssql || '  FROM GA_ABOCEL';
        lv_ssql := lv_ssql || ' WHERE COD_CLIENTE = '||SO_Cliente.cod_cliente;

        SELECT COUNT(DISTINCT(cod_plantarif))
          INTO LN_CANTPLANABOC
         FROM GA_ABOAMIST
          WHERE COD_CLIENTE = SO_Cliente.cod_cliente;

         SELECT COUNT(DISTINCT(cod_plantarif))
          INTO LN_CANTPLANABOM
         FROM GA_ABOCEL
          WHERE COD_CLIENTE = SO_Cliente.cod_cliente;


        IF ((LN_CANTPLANABOC > 1) OR (LN_CANTPLANABOM > 1)) THEN
            lv_ssql := 'SELECT DISTINCT a.nom_cliente||a.nom_apeclien1||a.nom_apeclien2 as nom_cliente,';
            lv_ssql := lv_ssql || 'a.cod_ciclo,';
            lv_ssql := lv_ssql || 'a.cod_cuenta,';
            lv_ssql := lv_ssql || 'b.des_cuenta,';
            lv_ssql := lv_ssql || 'c.tip_plantarif,';
            lv_ssql := lv_ssql || 'DECODE(c.tip_plantarif,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'',''F'', ''FAMILIAR'') AS des_tipplantarif,';
            lv_ssql := lv_ssql || 'a.cod_tipident,';
            lv_ssql := lv_ssql || 'a.num_ident,';
            lv_ssql := lv_ssql || 'b.tip_cuenta,';
            lv_ssql := lv_ssql || ' FROM ge_clientes a,ga_cuentas b,ga_abocel c';
            lv_ssql := lv_ssql || ' WHERE a.cod_cliente  = '||SO_Cliente.cod_cliente;
            lv_ssql := lv_ssql || ' AND a.cod_cliente = c.cod_cliente';
            lv_ssql := lv_ssql || ' AND a.cod_cuenta = b.cod_cuenta';
            lv_ssql := lv_ssql || ' UNION';
            lv_ssql := lv_ssql || ' SELECT DISTINCT a.nom_cliente||a.nom_apeclien1||a.nom_apeclien2 as nom_cliente,';
            lv_ssql := lv_ssql || 'a.cod_ciclo,';
            lv_ssql := lv_ssql || 'a.cod_cuenta,';
            lv_ssql := lv_ssql || 'b.des_cuenta,';
            lv_ssql := lv_ssql || 'c.tip_plantarif,';
            lv_ssql := lv_ssql || 'DECODE(c.tip_plantarif,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'',''F'', ''FAMILIAR'') AS des_tipplantarif,';
            lv_ssql := lv_ssql || 'a.cod_tipident,';
            lv_ssql := lv_ssql || 'a.num_ident,';
            lv_ssql := lv_ssql || 'b.tip_cuenta,';
            lv_ssql := lv_ssql || ' FROM ge_clientes a,ga_cuentas b,ga_aboamist c';
            lv_ssql := lv_ssql || ' WHERE a.cod_cliente  = '||SO_Cliente.cod_cliente;
            lv_ssql := lv_ssql || ' AND a.cod_cliente = c.cod_cliente';
            lv_ssql := lv_ssql || ' AND a.cod_cuenta = b.cod_cuenta AND ROWNUM=1';

            SELECT DISTINCT a.nom_cliente||' '||a.nom_apeclien1||' '||a.nom_apeclien2 as nom_cliente,
             a.cod_ciclo,
             a.cod_cuenta,
             b.des_cuenta,
             c.tip_plantarif,
             DECODE(c.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL','F', 'FAMILIAR') AS des_tipplantarif,
              a.cod_tipident,
             a.num_ident,
             b.tip_cuenta
             INTO    SO_Cliente.nom_cliente,
                     SO_Cliente.cod_ciclo,
                     SO_Cliente.cod_cuenta,
                     SO_Cliente.des_cuenta,
                     SO_Cliente.tip_plantarif,
                     so_cliente.des_tipplantarif,
                     SO_Cliente.cod_tipident,
                     SO_Cliente.num_ident,
                     SO_Cliente.tip_cuenta
           FROM   ge_clientes a,
                     ga_cuentas b,
                  ga_abocel c
            WHERE a.cod_cliente  = SO_Cliente.cod_cliente
                  AND a.cod_cliente = c.cod_cliente
                  AND a.cod_cuenta = b.cod_cuenta
                  AND ROWNUM=1
           UNION
            SELECT DISTINCT a.nom_cliente||' '||a.nom_apeclien1||' '||a.nom_apeclien2 AS nom_cliente,
                   a.cod_ciclo,
                 a.cod_cuenta,
                 b.des_cuenta,
                 c.tip_plantarif,
                 DECODE(c.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL','F', 'FAMILIAR') AS des_tipplantarif,
                 a.cod_tipident,
                 a.num_ident,
                 b.tip_cuenta
           FROM   ge_clientes a,
                     ga_cuentas b,
                  ga_aboamist c
            WHERE a.cod_cliente  = SO_Cliente.cod_cliente
                  AND a.cod_cliente = c.cod_cliente
                  AND a.cod_cuenta = b.cod_cuenta
                  AND ROWNUM=1;

                 SO_Cliente.cod_plantarif:= '';
                 SO_Cliente.des_plantarif:= '';
                 SO_Cliente.cod_cargobasico:= '';
                 SO_Cliente.des_cargobasico:= '';
                 SO_Cliente.cod_limconsumo:= '';
                 SO_Cliente.des_limconsumo:= '';
                 SO_Cliente.imp_cargobasico:= '';
                 SO_Cliente.cod_tiplan:= '';
                 SO_Cliente.des_tiplan:= '';
                 SO_Cliente.tip_terminal:= '';
                 SO_Cliente.des_terminal:= '';
                 SO_Cliente.ind_familiar:= '';
                 SO_Cliente.cod_empresa := 0;
                 SO_Cliente.flg_rango:='';
    ELSE
       IF ((LN_CANTPLANABOC = 1) OR (LN_CANTPLANABOM  = 1)) THEN

            lv_ssql := 'SELECT DISTINCT a.nom_cliente||a.nom_apeclien1||a.nom_apeclien2 as nom_cliente,';
            lv_ssql := lv_ssql || 'a.cod_ciclo,';
            lv_ssql := lv_ssql || 'a.cod_cuenta,';
            lv_ssql := lv_ssql || 'b.des_cuenta,';
            lv_ssql := lv_ssql || 'c.cod_plantarif,';
            lv_ssql := lv_ssql || 'd.des_plantarif,';
            lv_ssql := lv_ssql || 'c.tip_terminal,';
            lv_ssql := lv_ssql || 'e.des_terminal,';
            lv_ssql := lv_ssql || 'c.tip_plantarif,';
            lv_ssql := lv_ssql || 'DECODE(c.tip_plantarif,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'',''F'', ''FAMILIAR'') AS des_tipplantarif,';
            lv_ssql := lv_ssql || 'd.cod_cargobasico,';
            lv_ssql := lv_ssql || 'g.des_cargobasico,';
            lv_ssql := lv_ssql || 'd.cod_limconsumo,';
            lv_ssql := lv_ssql || 'h.des_limconsumo,';
            lv_ssql := lv_ssql || 'd.cod_tiplan,';
            lv_ssql := lv_ssql || 'f.des_valor AS des_tiplan,';
            lv_ssql := lv_ssql || 'g.imp_cargobasico,';
            lv_ssql := lv_ssql || 'a.cod_tipident,';
            lv_ssql := lv_ssql || 'a.num_ident,';
            lv_ssql := lv_ssql || 'd.ind_familiar';
            lv_ssql := lv_ssql || 'b.tip_cuenta    ';
            lv_ssql := lv_ssql || ' FROM ge_clientes a,ga_cuentas b,ga_abocel c,ta_plantarif d,al_tipos_terminales e,ged_codigos f,ta_cargosbasico g,ta_limconsumo h';
            lv_ssql := lv_ssql || ' WHERE a.cod_cliente  = '||SO_Cliente.cod_cliente;
            lv_ssql := lv_ssql || ' AND a.cod_cliente = c.cod_cliente';
            lv_ssql := lv_ssql || ' AND a.cod_cuenta = b.cod_cuenta';
            lv_ssql := lv_ssql || ' AND c.cod_plantarif = d.cod_plantarif';
            lv_ssql := lv_ssql || ' AND f.nom_columna = ''COD_TIPLAN''';
            lv_ssql := lv_ssql || ' AND f.nom_tabla = ''TA_PLANTARIF''';
            lv_ssql := lv_ssql || ' AND SYSDATE BETWEEN g.fec_desde AND g.fec_hasta';
            lv_ssql := lv_ssql || ' AND f.cod_valor = d.cod_tiplan';
            lv_ssql := lv_ssql || ' AND d.tip_terminal = e.tip_terminal';
            lv_ssql := lv_ssql || ' AND d.cod_cargobasico = g.cod_cargobasico';
            lv_ssql := lv_ssql || ' AND d.cod_limconsumo = h.cod_limconsumo AND ROWNUM=1';


              SELECT DISTINCT a.nom_cliente||' '||a.nom_apeclien1||' '||a.nom_apeclien2 AS nom_cliente,
                     a.cod_ciclo,
                     a.cod_cuenta,
                     b.des_cuenta,
                     c.cod_plantarif,
                     d.des_plantarif,
                     c.tip_terminal,
                     e.des_terminal,
                     c.tip_plantarif,
                     DECODE(c.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL','F', 'FAMILIAR') AS des_tipplantarif,
                     d.cod_cargobasico,
                     g.des_cargobasico,
                     d.cod_limconsumo,
                     h.des_limconsumo,
                     d.cod_tiplan,
                     DECODE(d.cod_tiplan,'1','PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO') AS des_tiplan,
                     g.imp_cargobasico,
                      a.cod_tipident,
                     a.num_ident,
                      d.ind_familiar,
                     b.tip_cuenta,
                     d.flg_rango
              INTO   SO_Cliente.nom_cliente,
                     SO_Cliente.cod_ciclo,
                     SO_Cliente.cod_cuenta,
                     SO_Cliente.des_cuenta,
                     SO_Cliente.cod_plantarif,
                     SO_Cliente.des_plantarif,
                     SO_Cliente.tip_terminal,
                     SO_Cliente.des_terminal,
                     SO_Cliente.tip_plantarif,
                     so_cliente.des_tipplantarif,
                     SO_Cliente.cod_cargobasico,
                     SO_Cliente.des_cargobasico,
                     SO_Cliente.cod_limconsumo,
                     SO_Cliente.des_limconsumo,
                     SO_Cliente.cod_tiplan,
                     SO_Cliente.des_tiplan,
                     SO_Cliente.imp_cargobasico,
                     SO_Cliente.cod_tipident,
                     SO_Cliente.num_ident,
                     SO_Cliente.ind_familiar,
                     SO_Cliente.tip_cuenta,
                     SO_Cliente.flg_rango
               FROM   ge_clientes a,
                         ga_cuentas b,
                      ga_abocel c,
                      ta_plantarif d,
                      al_tipos_terminales e,
                      ged_codigos f,
                      ta_cargosbasico g,
                      ta_limconsumo h
                WHERE a.cod_cliente  = SO_Cliente.cod_cliente
                      AND a.cod_cliente = c.cod_cliente
                      AND a.cod_cuenta = b.cod_cuenta
                      AND c.cod_plantarif = d.cod_plantarif
                      AND f.nom_columna = 'COD_TIPLAN'
                      AND f.nom_tabla = 'TA_PLANTARIF'
                      AND SYSDATE BETWEEN g.fec_desde AND g.fec_hasta
                      AND f.cod_valor = d.cod_tiplan
                      AND d.tip_terminal = e.tip_terminal
                      AND d.cod_cargobasico = g.cod_cargobasico
                      AND d.cod_limconsumo = h.cod_limconsumo
                      AND ROWNUM=1
                UNION
                  SELECT DISTINCT a.nom_cliente||' '||a.nom_apeclien1||' '||a.nom_apeclien2 AS nom_cliente,
                     a.cod_ciclo,
                     a.cod_cuenta,
                     b.des_cuenta,
                     c.cod_plantarif,
                     d.des_plantarif,
                     c.tip_terminal,
                     e.des_terminal,
                     c.tip_plantarif,
                     DECODE(c.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL','F', 'FAMILIAR') AS des_tipplantarif,
                     d.cod_cargobasico,
                     g.des_cargobasico,
                     d.cod_limconsumo,
                     h.des_limconsumo,
                     d.cod_tiplan,
                     DECODE(d.cod_tiplan,'1','PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO') AS des_tiplan,
                     g.imp_cargobasico,
                     a.cod_tipident,
                     a.num_ident,
                      d.ind_familiar,
                     b.tip_cuenta,
                     d.flg_rango
               FROM   ge_clientes a,
                         ga_cuentas b,
                      ga_aboamist c,
                      ta_plantarif d,
                      al_tipos_terminales e,
                      ged_codigos f,
                      ta_cargosbasico g,
                      ta_limconsumo h
                WHERE a.cod_cliente  = SO_Cliente.cod_cliente
                      AND a.cod_cliente = c.cod_cliente
                      AND a.cod_cuenta = b.cod_cuenta
                      AND c.cod_plantarif = d.cod_plantarif
                      AND f.nom_columna = 'COD_TIPLAN'
                      AND f.nom_tabla = 'TA_PLANTARIF'
                      AND SYSDATE BETWEEN g.fec_desde AND g.fec_hasta
                      AND f.cod_valor = d.cod_tiplan
                      AND d.tip_terminal = e.tip_terminal
                      AND d.cod_cargobasico = g.cod_cargobasico
                      AND d.cod_limconsumo = h.cod_limconsumo
                      AND ROWNUM=1;

                      SO_Cliente.cod_empresa := 0;
        END IF;
    END IF;

          RETURN TRUE;

    EXCEPTION

    WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 149;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PV_cliente_no_empresa_FN('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES2_PG.PV_cliente_no_empresa_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
          RETURN FALSE;
      WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PV_cliente_no_empresa_FN('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES2_PG.PV_cliente_no_empresa_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
          RETURN FALSE;
    END PV_cliente_no_empresa_FN;

--------------------------------------------------------------------------------------------------------
--1.- Metodo obtenerDatos   (PL nueva)
    PROCEDURE PV_OBTIENE_DATOS_CLIENTE_PR(
                   SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE2_QT,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY        ge_errores_pg.evento)

      IS
     /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PV_DATOS_CLIENTE_PG
          Lenguaje="PL/SQL"
          Fecha="31-05-2007"
          Versión="La del package"
          Diseñador="Matías Guajardo"
          Programador="Matías Guajardo"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción></Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="PV_Cliente_QT" Tipo="estructura">estructura de cliente</param>>
             </Entrada>
             <Salida>
                <param nom="" Tipo=""></param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error          ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    ERROR_EJECUCION       EXCEPTION;
    LV_Cod_cliente          NUMBER;
    LV_CliEmpresa          NUMBER;
    LV_PRIMERAVENTA          VARCHAR2(2);

    BEGIN
        SN_cod_retorno     := 0;
        SV_mens_retorno := NULL;
        SN_num_evento     := 0;

        LV_cod_cliente:=SO_Cliente.cod_cliente;
        LV_Ssql := 'PV_cliente_empresa_FN ('||LV_Cod_cliente||',' ||SN_cod_retorno||','||SV_mens_retorno||',' ||SN_num_evento||')';

        LV_CliEmpresa := PV_cliente_empresa_FN (LV_Cod_cliente, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

        --Verifica si cliente es Empresa
        IF LV_CliEmpresa < 0 THEN
           RAISE ERROR_EJECUCION;
        END IF;

        --Verifica si cliente es Empresa
        --IF LV_CliEmpresa >= 1 THEN
        --   LV_Ssql :='PV_cliente_es_empresa_FN('||SO_Cliente.cod_cliente||',' ||SN_cod_retorno||','||SV_mens_retorno||',' ||SN_num_evento||')';
        --   IF NOT PV_cliente_es_empresa_FN(SO_Cliente, SN_cod_retorno, SV_mens_retorno, SN_num_evento)  THEN
        --           RAISE ERROR_EJECUCION;
        --   END IF;
        --END IF;

        --IF LV_CliEmpresa = 0 THEN
        --   LV_Ssql := 'PV_cliente_no_empresa_FN('||SO_Cliente.cod_cliente||',' ||SN_cod_retorno||','||SV_mens_retorno||',' ||SN_num_evento||')';
           IF NOT PV_cliente_no_empresa_FN(SO_Cliente, SN_cod_retorno, SV_mens_retorno, SN_num_evento)  THEN
                   RAISE ERROR_EJECUCION;
           END IF;
        --END IF;

        LV_PRIMERAVENTA := PV_DETERMINA_PRIMERA_VENTA_FN (SO_Cliente, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

        LV_Ssql := LV_Ssql || 'PV_DETERMINA_PRIMERA_VENTA_FN('||SO_Cliente.cod_cliente||',' ||SN_cod_retorno||','||SV_mens_retorno||',' ||SN_num_evento||')';

        IF (SN_cod_retorno = 0) THEN
           SO_Cliente.IND_PRIMERAVENTA := LV_PRIMERAVENTA;
        ELSE
            RAISE ERROR_EJECUCION;
        END IF;


    EXCEPTION

    WHEN ERROR_EJECUCION THEN
          LV_des_error   := ' PV_OBTIENE_DATOS_CLIENTE_PR('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES2_PG.PV_OBTIENE_DATOS_CLIENTE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

      WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := ' PV_OBTIENE_DATOS_CLIENTE_PR('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES2_PG.PV_OBTIENE_DATOS_CLIENTE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PV_OBTIENE_DATOS_CLIENTE_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------

END PV_DATOS_CLIENTES2_PG;
/
SHOW ERRORS
