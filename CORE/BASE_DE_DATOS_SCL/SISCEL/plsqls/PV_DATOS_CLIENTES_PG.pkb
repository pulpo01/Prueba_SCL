CREATE OR REPLACE PACKAGE BODY PV_DATOS_CLIENTES_PG AS

-- PV_DATOS_CLIENTES_PG v 1.0 INC-72913; AVC; 12-11-2008

--------------------------------------------------------------------------------------------------------
FUNCTION PV_DETERMINA_MOROCIDAD_FN (EO_Cliente  IN PV_CLIENTE_QT,
                                                                                SN_cod_retorno      OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                                SV_mens_retorno     OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                                SN_num_evento       OUT NOCOPY  ge_errores_pg.evento )
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
LV_sSql            ge_errores_pg.vQuery;
LV_CANT_MOROCIDAD  NUMBER;
ERROR_PARAMETROS   EXCEPTION;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';
        SN_num_evento   := 0;

        IF (EO_CLIENTE.COD_CLIENTE IS NULL) THEN
             RAISE ERROR_PARAMETROS;
        ELSE

                LV_sSql:='SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0)';
                LV_sSql:=LV_sSql || ' FROM CO_CARTERA';
                LV_sSql:=LV_sSql || ' WHERE  cod_cliente = '||EO_CLIENTE.COD_CLIENTE;
                LV_sSql:=LV_sSql || ' AND IND_FACTURADO     = 1';
                LV_sSql:=LV_sSql || ' AND FEC_VENCIMIE      < TRUNC(SYSDATE)';
                LV_sSql:=LV_sSql || ' AND COD_TIPDOCUM NOT IN (SELECT  TO_NUMBER(COD_VALOR)';
                LV_sSql:=LV_sSql || ' FROM    CO_CODIGOS';
                LV_sSql:=LV_sSql || ' WHERE   NOM_TABLA   = ''CO_CARTERA''';
                LV_sSql:=LV_sSql || ' AND     NOM_COLUMNA = ''COD_TIPDOCUM'')';

                SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0)
                 INTO   LV_CANT_MOROCIDAD
                 FROM   CO_CARTERA
                  WHERE  cod_cliente       = EO_CLIENTE.COD_CLIENTE
                                 AND IND_FACTURADO     = 1
                                 AND FEC_VENCIMIE      < TRUNC(SYSDATE)
                                 AND COD_TIPDOCUM NOT IN (SELECT  TO_NUMBER(COD_VALOR)
                                            FROM    CO_CODIGOS
                                            WHERE   NOM_TABLA   = 'CO_CARTERA'
                                            AND     NOM_COLUMNA = 'COD_TIPDOCUM');

                IF LV_CANT_MOROCIDAD > 0 THEN
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
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_DETERMINA_MOROCIDAD_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN '-1';
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_DETERMINA_MOROCIDAD_FN(Cliente); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_DETERMINA_MOROCIDAD_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN '-1';
END;

--------------------------------------------------------------------------------------------------------
FUNCTION PV_DETERMINA_PRIMERA_VENTA_FN (EO_Cliente  IN PV_CLIENTE_QT,
                                                                                SN_cod_retorno      OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                                SV_mens_retorno     OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                                SN_num_evento       OUT NOCOPY  ge_errores_pg.evento )
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
LV_sSql                    ge_errores_pg.vQuery;
LV_VENTAS_POSPAGO  NUMBER;
LV_VENTAS_PREPAGO  NUMBER;
LV_CANT_NUM_VENTA  NUMBER;
ERROR_PARAMETROS   EXCEPTION;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento   := 0;

        IF (EO_CLIENTE IS NULL) or (EO_CLIENTE.COD_CLIENTE IS NULL) THEN
             RAISE ERROR_PARAMETROS;
        ELSE

                LV_sSql := 'SELECT COUNT(DISTINCT NUM_VENTA) ';
                LV_sSql := LV_sSql || ' FROM    GA_ABOCEL ';
                LV_sSql := LV_sSql || ' WHERE  COD_CLIENTE = ' || EO_CLIENTE.COD_CLIENTE;

                SELECT COUNT(DISTINCT NUM_VENTA)
                INTO    LV_VENTAS_POSPAGO
                FROM    GA_ABOCEL
                WHERE  COD_CLIENTE = EO_CLIENTE.COD_CLIENTE;

                LV_sSql := 'SELECT COUNT(DISTINCT NUM_VENTA) ';
                LV_sSql := LV_sSql || ' FROM    GA_ABOAMIST ';
                LV_sSql := LV_sSql || ' WHERE  COD_CLIENTE = ' || EO_CLIENTE.COD_CLIENTE;

                SELECT COUNT(DISTINCT NUM_VENTA)
                INTO    LV_VENTAS_PREPAGO
                FROM    GA_ABOAMIST
                WHERE   COD_CLIENTE = EO_CLIENTE.COD_CLIENTE;

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
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_DETERMINA_PRIMERA_VENTA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN 'N';
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 0;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_DETERMINA_PRIMERA_VENTA_FN(Cliente); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_DETERMINA_PRIMERA_VENTA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN 'N';
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_DETERMINA_PRIMERA_VENTA_FN(Cliente); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_DETERMINA_PRIMERA_VENTA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN 'N';
END;
--------------------------------------------------------------------------------------------------------
        FUNCTION PV_cliente_empresa_FN (
              EN_CodCliente    IN                           ge_clientes.cod_cliente%TYPE,
                  SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY           ge_errores_pg.evento)
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
        LV_sSql                    ge_errores_pg.vQuery;
        LV_ClienteEmpresa  NUMBER;

        BEGIN
            SN_cod_retorno       := 0;
            SV_mens_retorno  := '';
            SN_num_evento        := 0;
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
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_cliente_empresa_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN -1;
        END PV_cliente_empresa_FN;

--------------------------------------------------------------------------------------------------------
        FUNCTION PV_cliente_es_empresa_FN(
                  SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE_QT,
                  SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY           ge_errores_pg.evento)
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
        LV_sSql                       ge_errores_pg.vQuery;

        BEGIN
            SN_cod_retorno      := 0;
            SV_mens_retorno := '';
            SN_num_evento       := 0;

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
                lv_ssql := lv_ssql || ' AND SYSDATE BETWEEN d.fec_desde AND d.fec_hasta ';
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
                                AND b.cod_limconsumo = h.cod_limconsumo;
                                --AND a.cod_cliente IN (SELECT a.COD_CLIENTE from ga_abocel e where a.cod_cliente = e.cod_cliente and c.cod_plantarif = e.cod_plantarif and rownum = 1);

                                RETURN TRUE;

        EXCEPTION

        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_cliente_es_empresa_FN('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_cliente_es_empresa_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_cliente_es_empresa_FN('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_cliente_es_empresa_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
        END PV_cliente_es_empresa_FN;

--------------------------------------------------------------------------------------------------------
        FUNCTION PV_cliente_no_empresa_FN(
                  SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE_QT,
                  SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY           ge_errores_pg.evento)
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
        LV_sSql                       ge_errores_pg.vQuery;
        LV_Cod_cliente            NUMBER;
        LN_CANTPLANABOC   NUMBER;
        LN_CANTPLANABOM   NUMBER;

        BEGIN
            SN_cod_retorno       := 0;
            SV_mens_retorno  := '';
            SN_num_evento        := 0;
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

                IF (LN_CANTPLANABOC = 0) AND (LN_CANTPLANABOM = 0) THEN
                --       RAISE NO_DATA_FOUND;

                 lv_ssql := 'SELECT DISTINCT a.nom_cliente||a.nom_apeclien1||a.nom_apeclien2 as nom_cliente,';
                        lv_ssql := lv_ssql || 'a.cod_ciclo,';
                        lv_ssql := lv_ssql || 'a.cod_cuenta,';
                        lv_ssql := lv_ssql || 'b.des_cuenta,';
                        lv_ssql := lv_ssql || '''I'' AS tip_plantarif,';
                        lv_ssql := lv_ssql || '''INDIVIDUAL'' AS des_tiplantarif,';
                        lv_ssql := lv_ssql || 'a.cod_tipident,';
                        lv_ssql := lv_ssql || 'a.num_ident,';
                        lv_ssql := lv_ssql || 'b.tip_cuenta,';
                        lv_ssql := lv_ssql || ' FROM ge_clientes a,ga_cuentas b';
                        lv_ssql := lv_ssql || ' WHERE a.cod_cliente  = '||SO_Cliente.cod_cliente;
                        lv_ssql := lv_ssql || ' AND a.cod_cuenta = b.cod_cuenta';

                        SELECT DISTINCT a.nom_cliente||' '||a.nom_apeclien1||' '||a.nom_apeclien2 as nom_cliente,
                                 a.cod_ciclo,
                                 a.cod_cuenta,
                                 b.des_cuenta,
                                 'I' AS tip_plantarif,
                             'INDIVIDUAL' AS des_tipplantarif,
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
                                          ga_cuentas b
                            WHERE a.cod_cliente  = SO_Cliente.cod_cliente
                                      AND a.cod_cuenta = b.cod_cuenta;

                END IF;

                IF ((LN_CANTPLANABOC > 1) OR (LN_CANTPLANABOM > 1)) THEN
                        lv_ssql := 'SELECT DISTINCT a.nom_cliente||a.nom_apeclien1||a.nom_apeclien2 as nom_cliente,';
                        lv_ssql := lv_ssql || 'a.cod_ciclo,';
                        lv_ssql := lv_ssql || 'a.cod_cuenta,';
                        lv_ssql := lv_ssql || 'b.des_cuenta,';
                        lv_ssql := lv_ssql || '''I'' AS tip_plantarif,';
                        lv_ssql := lv_ssql || '''INDIVIDUAL'' AS des_tiplantarif,';
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
                        lv_ssql := lv_ssql || ' AND a.cod_cuenta = b.cod_cuenta';

                        SELECT DISTINCT a.nom_cliente||' '||a.nom_apeclien1||' '||a.nom_apeclien2 as nom_cliente,
                         a.cod_ciclo,
                         a.cod_cuenta,
                         b.des_cuenta,
                         'I' AS tip_plantarif,
                         'INDIVIDUAL' AS des_tipplantarif,
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
                                  ga_cuentas b
                    WHERE a.cod_cliente  = SO_Cliente.cod_cliente
                              AND a.cod_cuenta = b.cod_cuenta
                   UNION
                        SELECT DISTINCT a.nom_cliente||' '||a.nom_apeclien1||' '||a.nom_apeclien2 AS nom_cliente,
                                 a.cod_ciclo,
                                 a.cod_cuenta,
                                 b.des_cuenta,
                                 'I' AS tip_plantarif,
                                 'INDIVIDUAL' AS des_tipplantarif,
                                 a.cod_tipident,
                                 a.num_ident,
                             b.tip_cuenta
                   FROM   ge_clientes a,
                                  ga_cuentas b
                    WHERE a.cod_cliente  = SO_Cliente.cod_cliente
                              AND a.cod_cuenta = b.cod_cuenta;

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


                /*
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
                        lv_ssql := lv_ssql || 'b.tip_cuenta     ';
                        lv_ssql := lv_ssql || ' FROM ge_clientes a,ga_cuentas b,ga_abocel c,ta_plantarif d,al_tipos_terminales e,ged_codigos f,ta_cargosbasico g,ta_limconsumo h';
                        lv_ssql := lv_ssql || ' WHERE a.cod_cliente  = '||SO_Cliente.cod_cliente;
                        lv_ssql := lv_ssql || ' AND a.cod_cliente = c.cod_cliente';
                        lv_ssql := lv_ssql || ' AND a.cod_cuenta = b.cod_cuenta';
                        lv_ssql := lv_ssql || ' AND c.cod_plantarif = d.cod_plantarif';
                        lv_ssql := lv_ssql || ' AND f.nom_columna = ''COD_TIPLAN''';
                        lv_ssql := lv_ssql || ' AND f.nom_tabla = ''TA_PLANTARIF''';
                        lv_ssql := lv_ssql || ' AND SYSDATE BETWEEN g.fec_desde AND g.fec_hasta';
                        lv_ssql := lv_ssql || ' AND f.cod_valor = d.cod_tiplan';
                        -- lv_ssql := lv_ssql || ' AND d.tip_terminal = e.tip_terminal'; -- INC-72913; AVC; 12-11-2008
                        lv_ssql := lv_ssql || ' AND c.tip_terminal = e.tip_terminal';    -- INC-72913; AVC; 12-11-2008
                        lv_ssql := lv_ssql || ' AND d.cod_cargobasico = g.cod_cargobasico';
                        lv_ssql := lv_ssql || ' AND d.cod_limconsumo = h.cod_limconsumo';


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
                                          -- AND d.tip_terminal = e.tip_terminal  -- INC-72913; AVC; 12-11-2008
                                          AND c.tip_terminal = e.tip_terminal -- INC-72913; AVC; 12-11-2008
                                          AND d.cod_cargobasico = g.cod_cargobasico
                                          AND d.cod_limconsumo = h.cod_limconsumo
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
                                          -- AND d.tip_terminal = e.tip_terminal -- INC-72913; AVC; 12-11-2008
                                          AND c.tip_terminal = e.tip_terminal    -- INC-72913; AVC; 12-11-2008
                                          AND d.cod_cargobasico = g.cod_cargobasico
                                          AND d.cod_limconsumo = h.cod_limconsumo;
                                          */



                                      SELECT DISTINCT a.nom_cliente||' '||a.nom_apeclien1||' '||a.nom_apeclien2 as nom_cliente,
                                      a.cod_ciclo,
                                      a.cod_cuenta,
                                      b.des_cuenta,
                                      'I' AS tip_plantarif,
                                      'INDIVIDUAL' AS des_tipplantarif,
                                      a.cod_tipident,
                                      a.num_ident,
                                      b.tip_cuenta
                                      INTO                        SO_Cliente.nom_cliente,
                                                                  SO_Cliente.cod_ciclo,
                                                                  SO_Cliente.cod_cuenta,
                                                                  SO_Cliente.des_cuenta,
                                                                  SO_Cliente.tip_plantarif,
                                                                  so_cliente.des_tipplantarif,
                                                                  SO_Cliente.cod_tipident,
                                                                  SO_Cliente.num_ident,
                                                                  SO_Cliente.tip_cuenta
                                      FROM   ge_clientes a,
                                             ga_cuentas b
                                      WHERE a.cod_cliente  = SO_Cliente.cod_cliente
                                      AND a.cod_cuenta     = b.cod_cuenta;

                                     SO_Cliente.cod_plantarif:= '';         SO_Cliente.des_plantarif:= '';
                                     SO_Cliente.cod_cargobasico:= '';       SO_Cliente.des_cargobasico:= '';
                                     SO_Cliente.cod_limconsumo:= '';        SO_Cliente.des_limconsumo:= '';
                                     SO_Cliente.imp_cargobasico:= '';       SO_Cliente.cod_tiplan:= '';
                                     SO_Cliente.des_tiplan:= '';            SO_Cliente.tip_terminal:= '';
                                     SO_Cliente.des_terminal:= '';          SO_Cliente.ind_familiar:= '';
                                     SO_Cliente.cod_empresa := 0;           SO_Cliente.flg_rango:='';


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
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_cliente_no_empresa_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_cliente_no_empresa_FN('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_cliente_no_empresa_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
        END PV_cliente_no_empresa_FN;




FUNCTION PV_cliente_no_empresa2_FN(
                  SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE_QT,
                  SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY           ge_errores_pg.evento)
        RETURN BOOLEAN
        AS
         /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_cliente_no_empresa2_FN"
              Lenguaje="PL/SQL"
              Fecha="31-05-2007"
              Versión="La del package"
              Diseñador="OCB"
              Programador="OCB"
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
        LV_sSql                       ge_errores_pg.vQuery;
        LV_Cod_cliente            NUMBER;
        LN_CANTPLANABOC   NUMBER;
        LN_CANTPLANABOM   NUMBER;

        BEGIN
            SN_cod_retorno       := 0;
            SV_mens_retorno  := '';
            SN_num_evento        := 0;
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

                IF (LN_CANTPLANABOC = 0) AND (LN_CANTPLANABOM = 0) THEN
                --       RAISE NO_DATA_FOUND;

                 lv_ssql := 'SELECT DISTINCT a.nom_cliente||a.nom_apeclien1||a.nom_apeclien2 as nom_cliente,';
                        lv_ssql := lv_ssql || 'a.cod_ciclo,';
                        lv_ssql := lv_ssql || 'a.cod_cuenta,';
                        lv_ssql := lv_ssql || 'b.des_cuenta,';
                        lv_ssql := lv_ssql || '''I'' AS tip_plantarif,';
                        lv_ssql := lv_ssql || '''INDIVIDUAL'' AS des_tiplantarif,';
                        lv_ssql := lv_ssql || 'a.cod_tipident,';
                        lv_ssql := lv_ssql || 'a.num_ident,';
                        lv_ssql := lv_ssql || 'b.tip_cuenta,';
                        lv_ssql := lv_ssql || ' FROM ge_clientes a,ga_cuentas b';
                        lv_ssql := lv_ssql || ' WHERE a.cod_cliente  = '||SO_Cliente.cod_cliente;
                        lv_ssql := lv_ssql || ' AND a.cod_cuenta = b.cod_cuenta';


                END IF;

                IF ((LN_CANTPLANABOC > 1) OR (LN_CANTPLANABOM > 1)) THEN

                        SELECT DISTINCT a.nom_cliente||' '||a.nom_apeclien1||' '||a.nom_apeclien2 as nom_cliente,
                         a.cod_ciclo,
                         a.cod_cuenta,
                         b.des_cuenta,
                         'I' AS tip_plantarif,
                         'INDIVIDUAL' AS des_tipplantarif,
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
                                  ga_cuentas b
                    WHERE a.cod_cliente  = SO_Cliente.cod_cliente
                              AND a.cod_cuenta = b.cod_cuenta
                   UNION
                        SELECT DISTINCT a.nom_cliente||' '||a.nom_apeclien1||' '||a.nom_apeclien2 AS nom_cliente,
                                 a.cod_ciclo,
                                 a.cod_cuenta,
                                 b.des_cuenta,
                                 'I' AS tip_plantarif,
                                 'INDIVIDUAL' AS des_tipplantarif,
                                 a.cod_tipident,
                                 a.num_ident,
                             b.tip_cuenta
                   FROM   ge_clientes a,
                                  ga_cuentas b
                    WHERE a.cod_cliente  = SO_Cliente.cod_cliente
                              AND a.cod_cuenta = b.cod_cuenta;

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

           	             SELECT DISTINCT a.nom_cliente||' '||a.nom_apeclien1||' '||a.nom_apeclien2 as nom_cliente,
		                         a.cod_ciclo,
		                         a.cod_cuenta,
		                         b.des_cuenta,
		                         'I' AS tip_plantarif,
		                         'INDIVIDUAL' AS des_tipplantarif,
		                         a.cod_tipident,
		                         a.num_ident,
		                         b.tip_cuenta
		               INTO                      SO_Cliente.nom_cliente,
		                                         SO_Cliente.cod_ciclo,
		                                         SO_Cliente.cod_cuenta,
		                                         SO_Cliente.des_cuenta,
		                                         SO_Cliente.tip_plantarif,
		                                         so_cliente.des_tipplantarif,
		                                         SO_Cliente.cod_tipident,
		                                         SO_Cliente.num_ident,
		                                         SO_Cliente.tip_cuenta
		               FROM   ge_clientes a,
		                      ga_cuentas b
		               WHERE a.cod_cliente  = SO_Cliente.cod_cliente
		               AND a.cod_cuenta = b.cod_cuenta;

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

           END IF;

        END IF;

                  RETURN TRUE;

        EXCEPTION

        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_cliente_no_empresa2_FN('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_cliente_no_empresa2_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_cliente_no_empresa2_FN('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_cliente_no_empresa2_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
        END PV_cliente_no_empresa2_FN;



PROCEDURE PV_OBTIENE_DATOS_CLIENTE2_PR(
                  SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE_QT,
                  SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY           ge_errores_pg.evento)

          IS
         /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_DATOS_CLIENTE2_PG
              Lenguaje="PL/SQL"
              Fecha="31-05-2007"
              Versión="La del package"
              Diseñador="OCB"
              Programador="OCB"
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
        LV_sSql                       ge_errores_pg.vQuery;
        ERROR_EJECUCION       EXCEPTION;
        LV_Cod_cliente            NUMBER;
        LV_CliEmpresa             NUMBER;
        LV_PRIMERAVENTA           VARCHAR2(2);

        BEGIN
            SN_cod_retorno      := 0;
            SV_mens_retorno := NULL;
            SN_num_evento       := 0;

                LV_cod_cliente:=SO_Cliente.cod_cliente;
                LV_Ssql := 'PV_cliente_empresa_FN ('||LV_Cod_cliente||',' ||SN_cod_retorno||','||SV_mens_retorno||',' ||SN_num_evento||')';

                LV_CliEmpresa := PV_cliente_empresa_FN (LV_Cod_cliente, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                --Verifica si cliente es Empresa
                IF LV_CliEmpresa < 0 THEN
                   RAISE ERROR_EJECUCION;
                END IF;


                LV_Ssql := 'PV_cliente_no_empresa2_FN('||SO_Cliente.cod_cliente||',' ||SN_cod_retorno||','||SV_mens_retorno||',' ||SN_num_evento||')';
                IF NOT PV_cliente_no_empresa2_FN(SO_Cliente, SN_cod_retorno, SV_mens_retorno, SN_num_evento)  THEN
                                RAISE ERROR_EJECUCION;
                END IF;


                LV_PRIMERAVENTA := PV_DETERMINA_PRIMERA_VENTA_FN (SO_Cliente, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                LV_Ssql := LV_Ssql || 'PV_DETERMINA_PRIMERA_VENTA_FN('||SO_Cliente.cod_cliente||',' ||SN_cod_retorno||','||SV_mens_retorno||',' ||SN_num_evento||')';

                IF (SN_cod_retorno = 0) THEN
                   SO_Cliente.IND_PRIMERAVENTA := LV_PRIMERAVENTA;
                ELSE
                        RAISE ERROR_EJECUCION;
                END IF;


        EXCEPTION

        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := ' PV_OBTIENE_DATOS_CLIENTE2_PR('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_CLIENTE2_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_DATOS_CLIENTE2_PR('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_CLIENTE2_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_OBTIENE_DATOS_CLIENTE2_PR;



PROCEDURE PV_OBTIENE_DATOS_ABOCLIE2_PR(
  		EN_num_abonado    IN              ga_abocel.num_abonado%TYPE,
                SO_Cliente       IN OUT NOCOPY       PV_CLIENTE_QT,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY       ge_errores_pg.evento)

          IS
         /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_DATOS_ABOCLIE2_PR
              Lenguaje="PL/SQL"
              Fecha="31-05-2007"
              Versión="La del package"
              Diseñador="OCB"
              Programador="OCB"
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
        LV_sSql                       ge_errores_pg.vQuery;
        ERROR_EJECUCION       EXCEPTION;
        LV_Cod_cliente            NUMBER;
        LV_CliEmpresa             NUMBER;
        LV_PRIMERAVENTA           VARCHAR2(2);

        BEGIN
            SN_cod_retorno      := 0;
            SV_mens_retorno := NULL;
            SN_num_evento       := 0;

            SELECT c.cod_plantarif,
                d.des_plantarif  , c.tip_terminal   , e.des_terminal,
                d.cod_cargobasico, g.des_cargobasico, d.cod_limconsumo,
                h.des_limconsumo , d.cod_tiplan     , f.des_valor AS des_tiplan,
                g.imp_cargobasico, d.ind_familiar
            INTO
            SO_Cliente.cod_plantarif  ,
            SO_Cliente.des_plantarif  , SO_Cliente.tip_terminal   ,SO_Cliente.des_terminal,
            SO_Cliente.cod_cargobasico, SO_Cliente.des_cargobasico,SO_Cliente.cod_limconsumo,
            SO_Cliente.des_limconsumo , SO_Cliente.cod_tiplan,SO_Cliente.des_tiplan,
            SO_Cliente.imp_cargobasico, SO_Cliente.ind_familiar
            FROM ge_clientes a,
                ga_cuentas b,
                ga_abocel c,
                ta_plantarif d,
                al_tipos_terminales e,
                ged_codigos f,
                ta_cargosbasico g,
                ta_limconsumo h
            WHERE a.cod_cliente = SO_Cliente.cod_cliente
            AND a.cod_cliente = c.cod_cliente
            AND C.NUM_ABONADO = EN_num_abonado
            AND a.cod_cuenta = b.cod_cuenta
            AND c.cod_plantarif = d.cod_plantarif
            AND f.nom_columna = 'COD_TIPLAN'
            AND f.nom_tabla = 'TA_PLANTARIF'
            AND SYSDATE BETWEEN g.fec_desde AND g.fec_hasta
            AND f.cod_valor = d.cod_tiplan
            AND c.tip_terminal = e.tip_terminal
            AND d.cod_cargobasico = g.cod_cargobasico
            AND d.cod_limconsumo = h.cod_limconsumo
            UNION
            SELECT c.cod_plantarif,
                d.des_plantarif  , c.tip_terminal   , e.des_terminal,
                d.cod_cargobasico, g.des_cargobasico, d.cod_limconsumo,
                h.des_limconsumo , d.cod_tiplan     , f.des_valor AS des_tiplan,
                g.imp_cargobasico, d.ind_familiar
            FROM ge_clientes a,
                ga_cuentas b,
                ga_aboamist c,
                ta_plantarif d,
                al_tipos_terminales e,
                ged_codigos f,
                ta_cargosbasico g,
                ta_limconsumo h
            WHERE a.cod_cliente = SO_Cliente.cod_cliente
            AND a.cod_cliente = c.cod_cliente
            AND C.NUM_ABONADO = EN_num_abonado
            AND a.cod_cuenta = b.cod_cuenta
            AND c.cod_plantarif = d.cod_plantarif
            AND f.nom_columna = 'COD_TIPLAN'
            AND f.nom_tabla = 'TA_PLANTARIF'
            AND SYSDATE BETWEEN g.fec_desde AND g.fec_hasta
            AND f.cod_valor = d.cod_tiplan
            AND c.tip_terminal = e.tip_terminal
            AND d.cod_cargobasico = g.cod_cargobasico
            AND d.cod_limconsumo = h.cod_limconsumo;



            SO_Cliente.cod_empresa := 0;
            SO_Cliente.flg_rango:='';
            SO_Cliente.cod_ciclo:='';
            SO_Cliente.cod_cuenta:='';
            SO_Cliente.des_cuenta:='';
            SO_Cliente.tip_plantarif:='';
            so_cliente.des_tipplantarif:='';
            SO_Cliente.cod_tipident:='';
            SO_Cliente.num_ident:='';
            SO_Cliente.tip_cuenta:='';




        EXCEPTION

        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := ' PV_OBTIENE_DATOS_CLIENTE2_PR('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_ABOCLIE2_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_DATOS_CLIENTE2_PR('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_ABOCLIE2_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_OBTIENE_DATOS_ABOCLIE2_PR;




--------------------------------------------------------------------------------------------------------
--1.- Metodo obtenerDatos   (PL nueva)
        PROCEDURE PV_OBTIENE_DATOS_CLIENTE_PR(
                  SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE_QT,
                  SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY           ge_errores_pg.evento)

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
        LV_sSql                       ge_errores_pg.vQuery;
        ERROR_EJECUCION       EXCEPTION;
        LV_Cod_cliente            NUMBER;
        LV_CliEmpresa             NUMBER;
        LV_PRIMERAVENTA           VARCHAR2(2);

        BEGIN
            SN_cod_retorno      := 0;
            SV_mens_retorno := NULL;
            SN_num_evento       := 0;

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
                --                RAISE ERROR_EJECUCION;
                --   END IF;
                --END IF;

                --IF LV_CliEmpresa = 0 THEN
               LV_Ssql := 'PV_cliente_no_empresa_FN('||SO_Cliente.cod_cliente||',' ||SN_cod_retorno||','||SV_mens_retorno||',' ||SN_num_evento||')';
                   IF NOT PV_cliente_no_empresa_FN(SO_Cliente, SN_cod_retorno, SV_mens_retorno, SN_num_evento)  THEN
                                RAISE ERROR_EJECUCION;
                   END IF;
               -- END IF;

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
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_CLIENTE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_DATOS_CLIENTE_PR('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_CLIENTE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_OBTIENE_DATOS_CLIENTE_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------
--      2.1    Metodo :  ActualizaCantAboCliente
        PROCEDURE PV_ACTUA_CANT_CLITE_PR (Reg_GE_CLIENTES       IN                              PV_TIPOS_PG.R_GE_CLIENTES,
                                                                                    SN_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                                                    SV_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                                                    SN_num_evento       OUT NOCOPY              ge_errores_pg.evento)
    IS
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;
        BEGIN

                LV_sSql:= 'UPDATE GE_CLIENTES SET NUM_ABOROAMING = NUM_ABOROAMING + ' || Reg_GE_CLIENTES(1).NUM_ABOROAMING || ' ';
                LV_sSql:= LV_sSql || ' WHERE COD_CLIENTE = ' || Reg_GE_CLIENTES(1).COD_CLIENTE || ' ';

                UPDATE GE_CLIENTES SET NUM_ABOROAMING = NUM_ABOROAMING + Reg_GE_CLIENTES(1).NUM_ABOROAMING
                WHERE COD_CLIENTE = Reg_GE_CLIENTES(1).COD_CLIENTE;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_ACTUA_CANT_CLITE_PR ('||Reg_GE_CLIENTES(1).COD_CLIENTE||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_INSERT_ACTUA_CANT_CLITE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_ACTUA_CANT_CLITE_PR ('||Reg_GE_CLIENTES(1).COD_CLIENTE||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_INSERT_ACTUA_CANT_CLITE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

     END PV_ACTUA_CANT_CLITE_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------
--2.-   Metodo :  ActualizaCantAboCliente
PROCEDURE PV_ACTUA_CANT_ABOCLIENTE_PR(EO_GE_CLIENTES       IN                           GE_CLIENTES_QT,
                                                                     SN_cod_retorno        OUT    NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                     SV_mens_retorno       OUT    NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                     SN_num_evento         OUT    NOCOPY        ge_errores_pg.evento)
IS
--  Este metodo esta asociado para actualizar actualizar la cantidad de abonados en la tabla ge_clientes
        LV_des_error                            ge_errores_pg.DesEvent;
        LV_sSql                                         ge_errores_pg.vQuery;
        ERROR_EJECUCION                 EXCEPTION;
        Reg_GE_CLIENTES                         PV_TIPOS_PG.R_GE_CLIENTES;
        i                                                       NUMBER(9);
BEGIN
        SN_cod_retorno  := 0;
        SN_num_evento   := 0;
        SV_mens_retorno := NULL;

                BEGIN
                SN_cod_retorno  := 0;
                        Reg_GE_CLIENTES(1).COD_CLIENTE    := EO_GE_CLIENTES.COD_CLIENTE;
                        Reg_GE_CLIENTES(1).NUM_ABOROAMING := EO_GE_CLIENTES.CANTIDAD;
                        PV_DATOS_CLIENTES_PG.PV_ACTUA_CANT_CLITE_PR (Reg_GE_CLIENTES,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                EXCEPTION
                WHEN OTHERS THEN
                        RAISE ERROR_EJECUCION;
                END;
        EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := ' PV_ACTUA_CANT_ABOCLIENTE_PR('||EO_GE_CLIENTES.COD_CLIENTE||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_ACTUA_CANT_ABOCLIENTE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_ACTUA_CANT_ABOCLIENTE_PR('||EO_GE_CLIENTES.COD_CLIENTE||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_ACTUA_CANT_ABOCLIENTE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_ACTUA_CANT_ABOCLIENTE_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------
--3.- Metodo : obtenerCargoBasicoActual ( pv_bolsas_dinamicas_pg.pv_cnslta_carbasicoclte_fn )
PROCEDURE  PV_Obt_CargoBasico_Actual_PR (SO_CLIENTE  IN OUT NOCOPY PV_BOLSAS_DINAMICAS_QT,
                                    SN_cod_retorno   OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno  OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento    OUT NOCOPY    ge_errores_pg.evento
)
        is
        /*
        <Documentacion TipoDoc = "Funcion">
        <Elemento Nombre = "PV_Obt_CargoBasico_Actual_fn"
         Lenguaje="PL/SQL" Fecha="04-07-2007"
         Versión"1.0.0" Diseñador"****"
         Programador="" Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripcion>Obtiene el cargo basico actual de un cliente
        <Parametros>
        <Entrada>
                        <param nom="EN_cod_cliente Tipo="String">codigo del cliente/param>>
                        <param nom="ED_fecha Tipo="Date">fecha de la consulta /param>>
        </Entrada>
        <Salida>
           <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
           <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
           <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>*/

                LV_des_error                    ge_errores_pg.DesEvent;
                LV_sSql                                 ge_errores_pg.vQuery;
                EN_cod_cliente              ge_clientes.cod_cliente%TYPE;
                EN_Fecha                                Date;
                LV_EfectuaCargo                 NUMBER;
                ERROR_CONTROLADO        EXCEPTION;
                ERROR_EJECUCION         EXCEPTION;
                LN_RETORNO                              NUMBER;
                EO_GED_PARAMETROS       PV_GED_PARAMETROS_QT;

        BEGIN

                SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento       := 0;
                EN_Fecha            := SO_CLIENTE.FECHA;
                EN_cod_cliente  := SO_CLIENTE.COD_CLIENTE;

                BEGIN
                LV_sSql:='SELECT VALOR_NUMERICO FROM VE_PARAMETROS_SIMPLES_VW WHERE NOM_PARAMETRO  = ''CARGO_ABONADO_0'' AND COD_MODULO = ''VE''';

                 SELECT VALOR_NUMERICO
                 INTO LV_EfectuaCargo
                  FROM   VE_PARAMETROS_SIMPLES_VW
                   WHERE NOM_PARAMETRO  = 'CARGO_ABONADO_0'
                             AND COD_MODULO = 'VE';

                EXCEPTION
                WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 215;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_Obt_CargoBasico_Actual_PR('||EN_cod_cliente||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_Obt_CargoBasico_Actual_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

                END;

                IF LV_EfectuaCargo = 1 THEN
                        SELECT VE_ABONADO_0_PG.VE_VALIDA_ABONADO_FN(EN_cod_cliente)
                        INTO LN_RETORNO
                        FROM DUAL;

                        IF LN_RETORNO < 0 THEN
                           SN_cod_retorno := 1537;
                           RAISE ERROR_CONTROLADO;
                        END IF;

                        IF LN_RETORNO > 0 THEN
                                SO_CLIENTE.IMP_CARGO := PV_BOLSAS_DINAMICAS_PG.PV_CNSLTA_CARBASICOCLTE_FN(EN_cod_cliente ,EN_Fecha);
                                IF SO_CLIENTE.IMP_CARGO < 0  Then
                                    SN_cod_retorno := 1537;
                                        RAISE ERROR_CONTROLADO;
                                END IF;
                        END IF;
                END IF;

        EXCEPTION
          WHEN ERROR_EJECUCION THEN
          LV_des_error   := 'PV_Obt_CargoBasico_Actual_PR('||EN_cod_cliente||'); '||SQLERRM;
          WHEN ERROR_CONTROLADO THEN
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_Obt_CargoBasico_Actual_PR('||EN_cod_cliente||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_Obt_CargoBasico_Actual_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  SV_mens_retorno   := 'PV_Obt_CargoBasico_Actual_fn('||EN_cod_cliente||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_Obt_CargoBasico_Actual_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_Obt_CargoBasico_Actual_PR ;

--------------------------------------------------------------------------------------------------------------------------------------------------
--4.- Metodo : obtenerCargoBasico
PROCEDURE PV_OBTENER_CARGO_BASICO_PR(
          SO_CARGOS_BA                    OUT NOCOPY                    refcursor,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTENER_CARGO_BASICO_PR'
              Lenguaje="PL/SQL"
              Fecha="28-06-2007"
              Versión="La del package"
              Diseñador=
              Programador="Elizabeth Vera"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Obtiene impuestos</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_PRESUPUESTO" Tipo="estructura"></param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */

        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql                    ge_errores_pg.vQuery;

        BEGIN

                SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento       := 0;

                OPEN SO_CARGOS_BA FOR
                 SELECT  DES_CARGOBASICO, COD_CARGOBASICO, IMP_CARGOBASICO
         FROM TA_CARGOSBASICO
         WHERE COD_PRODUCTO = 1
         ORDER BY DES_CARGOBASICO;


        EXCEPTION
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTENER_CARGO_BASICO_PR((''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_OBTENER_CARGO_BASICO_PR(', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTENER_CARGO_BASICO_PR;

--------------------------------------------------------------------------------------------------------
--5.-  Metodo  :  validarTipoPlanCliente
FUNCTION PV_VALIDAR_TIPO_PLANCLIENTE_FN(  EN_Cod_Cliente    IN          ge_clientes.cod_cliente%TYPE,
                                          En_Tip_Plan       IN          ta_plantarif.cod_tiplan%TYPE,
                                          SN_cod_retorno    OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                          SV_mens_retorno   OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                          SN_num_evento     OUT NOCOPY  ge_errores_pg.evento)
 RETURN BOOLEAN
        AS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTENER_CARGO_BASICO_PR'
              Lenguaje="PL/SQL"
              Fecha="28-06-2007"
              Versión="La del package"
              Diseñador=
              Programador="Elizabeth Vera"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Obtiene impuestos</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_PRESUPUESTO" Tipo="estructura"></param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */

        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql                    ge_errores_pg.vQuery;
        LN_cod_cliente     ge_clientes.cod_cliente%TYPE;

        BEGIN

                SN_cod_retorno    := 0;
            SV_mens_retorno   := NULL;
            SN_num_evento         := 0;

                SELECT DISTINCT a.cod_cliente
                INTO LN_cod_cliente
                 FROM ge_clientes a,
                           ga_abocel b,
                       ta_plantarif c
                 WHERE a.cod_cliente = EN_Cod_Cliente
                           AND a.cod_cliente = b.cod_cliente
                           AND b.cod_plantarif = c.cod_plantarif
                           AND c.cod_tiplan = En_Tip_Plan
        UNION
                SELECT DISTINCT a.cod_cliente
                 FROM ge_clientes a,
                           ga_aboamist b,
                           ta_plantarif c
                 WHERE a.cod_cliente = EN_Cod_Cliente
                           AND a.cod_cliente = b.cod_cliente
                           AND b.cod_plantarif = c.cod_plantarif
                           AND c.cod_tiplan = En_Tip_Plan;

                   RETURN TRUE;


EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_VALIDAR_TIPO_PLANCLIENTE_FN('||EN_COD_CLIENTE||','||EN_TIP_PLAN||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_VALIDAR_TIPO_PLANCLIENTE_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
    WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_VALIDAR_TIPO_PLANCLIENTE_FN('||EN_COD_CLIENTE||','||EN_TIP_PLAN||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_VALIDAR_TIPO_PLANCLIENTE_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;

END PV_VALIDAR_TIPO_PLANCLIENTE_FN;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VALIDAR_TIPO_PLANCLIENTE_PR(SO_CLIENTE IN PV_CLIENTE_QT,
          SN_retorno              OUT NOCOPY  VARCHAR,
              SN_cod_retorno          OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
          SV_mens_retorno         OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
          SN_num_evento           OUT NOCOPY  ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTENER_CARGO_BASICO_PR'
              Lenguaje="PL/SQL"
              Fecha="09-07-2007"
              Versión="La del package"
              Diseñador=
              Programador="Alejandro Díaz"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Obtiene impuestos</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_PRESUPUESTO" Tipo="estructura"></param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */

        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql                    ge_errores_pg.vQuery;
        En_Cod_Cliente     ge_clientes.cod_cliente%TYPE;
    En_Tip_Plan        ta_plantarif.cod_tiplan%TYPE;

        BEGIN
                SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento       := 0;
                EN_Cod_Cliente  := SO_CLIENTE.COD_CLIENTE;
                EN_Tip_Plan     := SO_CLIENTE.COD_TIPLAN;
                SN_retorno      := 0;


    IF  PV_VALIDAR_TIPO_PLANCLIENTE_FN (EN_Cod_Cliente, EN_Tip_Plan, SN_cod_retorno, SV_mens_retorno, SN_num_evento) then
                 SN_retorno :='TRUE';
        ELSE
             SN_retorno :='FALSE';
    END IF;

        EXCEPTION
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := '  PV_VALIDAR_TIPO_PLANCLIENTE_PR((''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG. PV_VALIDAR_TIPO_PLANCLIENTE_PR(', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_VALIDAR_TIPO_PLANCLIENTE_PR;

--------------------------------------------------------------------------------------------------------
--6.- Metodo obtenerCategoriaCliente
PROCEDURE PV_OBTENER_CATEG_CLIENTE_PR(
                  SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE_QT,
                  SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY           ge_errores_pg.evento)

          IS
         /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTENER_CATEG_CLIENTE_PR
              Lenguaje="PL/SQL"
              Fecha="11-07-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Elizabeth Ver
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Obtiene la categoria del cliente</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="PV_Cliente_QT" Tipo="estructura">estructura de cliente</param>>
                 </Entrada>
                 <Salida>
                    <param nom="PV_Cliente_QT" Tipo="estructura">estructura de cliente</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */

        LV_des_error          ge_errores_pg.DesEvent;
        LV_sSql                       ge_errores_pg.vQuery;
        ERROR_EJECUCION       EXCEPTION;
        SV_cat_trib_cliente       VARCHAR2(1);

        BEGIN
                        SN_num_evento:= 0;
                        SN_cod_retorno:=0;
                        SV_mens_retorno:='';

                        VE_servicios_venta_PG.VE_obtiene_cat_trib_cliente_PR ( SO_Cliente.COD_CLIENTE  --in
                                                                                                                           ,SV_cat_trib_cliente  --out
                                                                                                                                   ,SN_cod_retorno
                                                                                                                                   ,SV_mens_retorno
                                                                                                                                   ,SN_num_evento );

                        SO_CLIENTE.COD_CATEGORIA := SV_cat_trib_cliente;


        EXCEPTION

          WHEN ERROR_EJECUCION THEN
                  LV_des_error   := ' PV_OBTENER_CATEG_CLIENTE_PR('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_CLIENTE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTENER_CATEG_CLIENTE_PR('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
                   SV_mens_retorno :=  SV_mens_retorno ||LV_des_error ;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_CLIENTE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTENER_CATEG_CLIENTE_PR;

-------------------------------------------------------------------------------------
PROCEDURE PV_cliente_Busqueda_PR(
                  EO_Cliente           IN     PV_CLIENTE_QT,
                          SO_Cliente_Cur     OUT NOCOPY       refcursor,
                  SN_cod_retorno    OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno   OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY           ge_errores_pg.evento)

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
        LV_sSql                       ge_errores_pg.vQuery;
        LV_Cod_cliente            NUMBER;
        iNum_celular   ge_clientes.NUM_CELULAR%type;

        BEGIN
            SN_cod_retorno      := 0;
            SV_mens_retorno := '';
            SN_num_evento       := 0;
                iNum_celular := EO_Cliente.NUM_CELULAR;

                        IF EO_Cliente IS NULL THEN
                           SN_cod_retorno       := CN_LISTA_NULA;
                           SV_mens_retorno  := 'Lista Busqueda Cliente';
                        END IF;

        IF  NVL(iNum_celular,-1)<>-1 THEN

                OPEN SO_Cliente_Cur FOR

                  SELECT DISTINCT a.COD_CLIENTE,
                                          a.nom_cliente,
                                          a.nom_apeclien1,
                                                                  a.nom_apeclien2
                  FROM   ge_clientes a,
                                  ga_cuentas b,
                                  ga_abocel c
                  WHERE  a.cod_cliente = c.cod_cliente
                  AND    a.cod_cuenta = b.cod_cuenta
                  AND   c.NUM_CELULAR  = EO_Cliente.NUM_CELULAR
                UNION
                  SELECT DISTINCT a.COD_CLIENTE,
                                          a.nom_cliente,
                                          a.nom_apeclien1,
                                              a.nom_apeclien2
                  FROM   ge_clientes a,
                                  ga_cuentas b,
                                  ga_aboamist c
                  WHERE  a.cod_cliente = c.cod_cliente
                  AND    a.cod_cuenta = b.cod_cuenta
                  AND   c.NUM_CELULAR  = EO_Cliente.NUM_CELULAR;

                else
                open SO_Cliente_Cur for
                  SELECT DISTINCT a.COD_CLIENTE,
                                           a.nom_cliente,
                                          a.nom_apeclien1,
                                                                  a.nom_apeclien2
                  FROM   ge_clientes a,
                                  ga_cuentas b,
                                  ga_abocel c
                  WHERE  a.cod_cliente = c.cod_cliente
                  AND    a.cod_cuenta = b.cod_cuenta
                  AND   a.NUM_IDENT  = EO_Cliente.NUM_IDENT
                 AND   a.COD_TIPIDENT  = EO_Cliente.COD_TIPIDENT
                UNION
                  SELECT DISTINCT a.COD_CLIENTE,
                                          a.nom_cliente,
                                          a.nom_apeclien1,
                                              a.nom_apeclien2
                  FROM   ge_clientes a,
                                  ga_cuentas b,
                                  ga_aboamist c
                  WHERE  a.cod_cliente = c.cod_cliente
                  AND    a.cod_cuenta = b.cod_cuenta
                  AND   a.NUM_IDENT  = EO_Cliente.NUM_IDENT
                 AND   a.COD_TIPIDENT  = EO_Cliente.COD_TIPIDENT;

        END IF;

        EXCEPTION

          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_cliente_Busqueda_FN('||EO_Cliente.NUM_CELULAR||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_cliente_no_empresa_FN', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_cliente_Busqueda_PR;

--------------------------------------------------------------------------------------------------------
FUNCTION PV_OBTIENE_LIMITELINEAS_FN (
              SO_Cliente       IN     PV_CLIENTE_QT,
                  SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY           ge_errores_pg.evento)
        RETURN VARCHAR2
        AS
         /*
        <Documentación
          TipoDoc = "Function">>
           <Elemento
              Nombre = "PV_OBTENER_VALOR_CALC_PR"
              Lenguaje="PL/SQL"
              Fecha="17-08-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Daniel Sagredo"
              Ambiente Desarrollo="BD">
              <Retorno>Varchar2</Retorno>>
              <Descripción>Obtiene el límite de líneas</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_Cliente" Tipo="estructura">estructura de cliente</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_sSql                       ge_errores_pg.vQuery;
        LV_des_error          ge_errores_pg.DesEvent;
        RetVal VARCHAR2(200);

        BEGIN

        LV_sSql := 'VE_CTRL_LINEAS_PREPAGO_PG.VE_SUPERA_LIMITE_FN ('||SO_Cliente.COD_CLIENTE||','||SO_Cliente.COD_TIPIDENT||','||SO_Cliente.NUM_IDENT||','||SO_Cliente.COD_CUENTA||')';

    RetVal := VE_CTRL_LINEAS_PREPAGO_PG.VE_SUPERA_LIMITE_FN ( SO_Cliente.COD_CLIENTE, SO_Cliente.COD_TIPIDENT, SO_Cliente.NUM_IDENT, SO_Cliente.COD_CUENTA );

        RETURN RetVal;

  EXCEPTION

          WHEN OTHERS THEN
          SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_LIMITELINEAS_FN('||SO_Cliente.COD_CLIENTE||','|| SO_Cliente.COD_TIPIDENT||','|| SO_Cliente.NUM_IDENT||','|| SO_Cliente.COD_CUENTA||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_OBTIENE_LIMITELINEAS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_LIMITELINEAS_FN;

--------------------------------------------------------------------------------------------------------
--8.- Metodo obtenerValorCalculado
PROCEDURE PV_OBTENER_VALOR_CALC_PR(
                  SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE_QT,
                  SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY           ge_errores_pg.evento)

          IS
         /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTENER_VALOR_CALC_PR"
              Lenguaje="PL/SQL"
              Fecha="17-08-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Elizabeth Ver
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Obtiene valor calculado cliente</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_Cliente" Tipo="estructura">estructura de cliente</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SO_Cliente" Tipo="estructura">estructura de cliente</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */

        LV_des_error          ge_errores_pg.DesEvent;
        LV_sSql                       ge_errores_pg.vQuery;
        ERROR_EJECUCION       EXCEPTION;
        SV_cat_trib_cliente       VARCHAR(1);

        BEGIN
                        SN_num_evento:= 0;
                        SN_cod_retorno:=0;
                        SV_mens_retorno:='';

                LV_sSql := 'SELECT COD_VALOR FROM GA_VALOR_CLI';
                LV_sSql := LV_sSql || '  WHERE COD_CLIENTE = '||SO_CLIENTE.COD_CLIENTE;

        SELECT COD_VALOR
                           INTO SO_CLIENTE.COD_VALOR
        FROM GA_VALOR_CLI
        WHERE COD_CLIENTE = SO_CLIENTE.COD_CLIENTE;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
                 SO_CLIENTE.COD_VALOR := 0;
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTENER_VALOR_CALC_PR('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_OBTENER_VALOR_CALC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTENER_VALOR_CALC_PR;

------------------------------------------------------------------------------------------------
FUNCTION PV_CLIENTE_CANTLINEAS_FN (
              EN_CodCliente    IN                           ge_clientes.cod_cliente%TYPE,
                  SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY           ge_errores_pg.evento)
        RETURN NUMBER
        AS
        /*
        <Documentacion TipoDoc = "Funcion">
        <Elemento Nombre = "PV_CLIENTE_CANTLINEAS_FN"
         Lenguaje="PL/SQL" Fecha="31-10-2007"
         Versión"1.0.0" Diseñador"****"
         Programador="" Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripcion>Chequea la cantidad de lineas para la Evaluación Crediticia</Descripcion>
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
        LV_sSql                    ge_errores_pg.vQuery;
        LN_CANTIDAD_LINEAS_PRE  NUMBER;
        LN_CANTIDAD_LINEAS_POS  NUMBER;
        LN_CANTIDAD_LINEAS_TOT  NUMBER;


        BEGIN
            SN_cod_retorno       := 0;
            SV_mens_retorno  := '';
            SN_num_evento        := 0;
                LN_CANTIDAD_LINEAS_POS:=0;
                LN_CANTIDAD_LINEAS_PRE:=0;
                LN_CANTIDAD_LINEAS_TOT:=0;

                LV_sSQL := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE cod_cliente  = ' ||EN_CodCliente;
                LV_sSQL := LV_sSQL || ' AND COD_SITUACION NOT IN ("BAA" , "BAP")';

                SELECT COUNT(1)
                INTO LN_CANTIDAD_LINEAS_POS
                FROM GA_ABOCEL
                WHERE cod_cliente  = EN_CodCliente AND COD_SITUACION NOT IN ('BAA','BAP');

                LV_sSQL := 'SELECT COUNT(1) FROM GA_ABOAMIST WHERE cod_cliente  = ' ||EN_CodCliente;
                LV_sSQL := LV_sSQL || ' AND COD_SITUACION NOT IN ("BAA" , "BAP")';

                SELECT COUNT(1)
                INTO LN_CANTIDAD_LINEAS_PRE
                FROM GA_ABOAMIST
                WHERE cod_cliente  = EN_CodCliente AND COD_SITUACION NOT IN ('BAA','BAP');


                LN_CANTIDAD_LINEAS_TOT:=LN_CANTIDAD_LINEAS_PRE + LN_CANTIDAD_LINEAS_POS ;

            RETURN LN_CANTIDAD_LINEAS_TOT;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
                  RETURN 0;
    WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_CLIENTE_CANTLINEAS_FN('||EN_CodCliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_CLIENTE_CANTLINEAS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN -1;
END PV_CLIENTE_CANTLINEAS_FN;

-----------------------------------------------------------------------------------------------------

PROCEDURE VALIDAR_CLIENTE_NPW_PR (
              EO_Cliente      IN                            PV_CLIENTE_QT,
                  SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY           ge_errores_pg.evento)
        AS
        /*
        <Documentacion TipoDoc = "Procedure">
        <Elemento Nombre = "VALIDAR_CLIENTE_NPW_PR"
         Lenguaje="PL/SQL" Fecha="30-01-2008"
         Versión"1.0.0" Diseñador"****"
         Programador="" Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripcion> Pl que valida si el cliente pertenece a NPW (cliente ya que pertenece a un agente comercial) </Descripcion>
        <Parametros>
        <Entrada>
                        <param nom="EO_Cliente" Tipo="estructura">estructura de cliente</param>>
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
        LV_sSql                    ge_errores_pg.vQuery;
        LN_UsuCli                  NPT_USUARIO_CLIENTE.COD_CLIENTE%type;

        NO_EXISTE_REGISTRO EXCEPTION;

        BEGIN
            SN_cod_retorno       := 0;
            SV_mens_retorno  := '';
            SN_num_evento        := 0;

                LV_sSQL := 'SELECT COUNT(1) FROM NPT_USUARIO_CLIENTE WHERE COD_CLIENTE =' ||EO_Cliente.cod_cliente;

                SELECT COUNT(1)
                INTO LN_UsuCli
                FROM NPT_USUARIO_CLIENTE
                WHERE COD_CLIENTE= EO_Cliente.cod_cliente;

                If LN_UsuCli > 0 Then
                   Raise NO_EXISTE_REGISTRO;
                END IF;

    EXCEPTION

        WHEN NO_EXISTE_REGISTRO THEN
                 SN_cod_retorno:=1702;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
         END IF;
         LV_des_error   := 'VALIDAR_CLIENTE_NPW_PR('||EO_Cliente.cod_cliente||'); - ' || SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.VALIDAR_CLIENTE_NPW_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

          WHEN NO_DATA_FOUND THEN
                 SN_cod_retorno:=149;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
         END IF;
         LV_des_error   := 'VALIDAR_CLIENTE_NPW_PR('||EO_Cliente.cod_cliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.VALIDAR_CLIENTE_NPW_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'VALIDAR_CLIENTE_NPW_PR('||EO_Cliente.cod_cliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.VALIDAR_CLIENTE_NPW_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END VALIDAR_CLIENTE_NPW_PR;

-----------------------------------------------------------------------------------------------------
--método obtenerNumAbonadosCliente
PROCEDURE PV_OBTIENE_NUMABO_CLIENTE_PR (
              SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE_QT,
                  SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY           ge_errores_pg.evento)

          IS
         /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_NUMABO_CLIENTE_PR
              Lenguaje="PL/SQL"
              Fecha="04-02-2008"
              Versión="La del package"
              Diseñador="Elizabeth Vera"
              Programador="Elizabeth Vera"
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
        LV_sSql                       ge_errores_pg.vQuery;
        ERROR_EJECUCION       EXCEPTION;
        LV_Cod_cliente            NUMBER;
        LV_CliEmpresa             NUMBER;
        LV_PRIMERAVENTA           VARCHAR2(2);

        BEGIN
            SN_cod_retorno      := 0;
            SV_mens_retorno := NULL;
            SN_num_evento       := 0;

        SELECT count(num_abonado)
                INTO  SO_Cliente.NUM_ABONADOS
            FROM ga_abocel
                WHERE cod_cliente= SO_Cliente.COD_CLIENTE
                        AND cod_cuenta= SO_Cliente.COD_CUENTA
                AND cod_producto=1
                AND COD_SITUACION NOT IN ('BAA','BAP');

        EXCEPTION

          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_NUMABO_CLIENTE_PR('||SO_Cliente.cod_cliente||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_CLIENTE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_OBTIENE_NUMABO_CLIENTE_PR;

------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE VALIDAR_SITU_CLIEMP_PR (
              EO_Cliente           IN            PV_CLIENTE_QT,
                  SN_cod_retorno   OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno  OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY    ge_errores_pg.evento)
        AS
        /*
        <Documentacion TipoDoc = "Procedure">
        <Elemento Nombre = "VALIDAR_SITU_CLIEMP_PR"
         Lenguaje="PL/SQL" Fecha="30-01-2008"
         Versión"1.0.0" Diseñador"****"
         Programador="" Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripcion> PL que valida si existe un cliente con situacion distinta a los estados ['AAA'],['AOP'],['ATP']y si es cliente empresa</Descripcion>
        <Parametros>
        <Entrada>
                        <param nom="EO_Abonado" Tipo="estructura">estructura de abonado</param>>
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
        LV_sSql                    ge_errores_pg.vQuery;
        LN_COUNT                   NUMBER;
        LN_COUNT2                  NUMBER;

        ABONADO_EN_PROCESO EXCEPTION;

        BEGIN
            SN_cod_retorno       := 0;
            SV_mens_retorno  := '';
            SN_num_evento        := 0;


                   LV_sSQL := 'SELECT COUNT(1) FROM GA_ABOCEL' ;
                   LV_sSQL := LV_sSQL || ' WHERE COD_SITUACION = TVP';
                   LV_sSQL := LV_sSQL || ' AND A.COD_CLIENTE ='|| EO_Cliente.COD_CLIENTE;

           SELECT COUNT(1)
                   INTO LN_COUNT
                   FROM GA_ABOCEL A
           WHERE A.COD_SITUACION= 'TVP'
                   AND A.COD_CLIENTE = EO_Cliente.COD_CLIENTE;

                   IF LN_COUNT > 0 THEN
                          RAISE ABONADO_EN_PROCESO;
                   END IF;

    EXCEPTION
        WHEN ABONADO_EN_PROCESO THEN
                 SN_cod_retorno:=1703;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
         END IF;
         LV_des_error   := 'VALIDAR_SITU_CLIEMP_PR('||EO_Cliente.COD_CLIENTE||'); - ' || SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.VALIDAR_SITU_CLIEMP_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

          WHEN NO_DATA_FOUND THEN
                 SN_cod_retorno:=149;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
         END IF;
         LV_des_error   := 'VALIDAR_SITU_CLIEMP_PR('||EO_Cliente.COD_CLIENTE||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.VALIDAR_SITU_CLIEMP_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'VALIDAR_SITU_CLIEMP_PR('||EO_Cliente.COD_CLIENTE||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.VALIDAR_SITU_CLIEMP_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END VALIDAR_SITU_CLIEMP_PR ;

---------------------------------------------------------------------------------------------

PROCEDURE TRASPASAR_CUOTAS_ABONADO_PR (
                  EO_Cliente               IN            PV_REG_REORD_PLAN_QT,
                  SN_cod_retorno   OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno  OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY    ge_errores_pg.evento)
        AS
        /*
        <Documentacion TipoDoc = "Procedure">
        <Elemento Nombre = "TRASPASAR_CUOTAS_ABONADO_PR"
         Lenguaje="PL/SQL" Fecha="21-02-2008"
         Versión"1.0.0" Diseñador"****"
         Programador="" Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripcion> Traspasa cuotas de un clientes a otro en un traspaso de abonados</Descripcion>
        <Parametros>
        <Entrada>
                        <param nom="EO_Cliente" Tipo="estructura">Cliente origen</param>>
                        <param nom="EO_Num_Abonado" Tipo="estructura">Abonado a traspasar</param>>
                        <param nom="EO_Cliente_Nuevo" Tipo="estructura">cliente nuevo</param>>
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
        LV_sSql            ge_errores_pg.vQuery;
        VP_TRANSACCION     VARCHAR2(09);
        VP_ABONADO         VARCHAR2(08);
        VP_CLIENTE         VARCHAR2(08);
        VP_CLIENTE_NUEVO   VARCHAR2(08);
        param_opera        VARCHAR2(250);

        EO_SECUENCIA       PV_SECUENCIA_QT;

        ERROR_EJECUCION EXCEPTION;

        BEGIN
         VP_TRANSACCION := NULL;

         EO_SECUENCIA:=PV_INICIA_ESTRUCTURAS_PG.PV_SECUENCIA_QT_FN;
         EO_SECUENCIA.NOM_SECUENCIA:= 'GA_SEQ_TRANSACABO';
         EO_SECUENCIA.NUM_SECUENCIA:= NULL;

         LV_sSql:= 'EO_SECUENCIA:=PV_INICIA_ESTRUCTURAS_PG.PV_SECUENCIA_QT_FN; ';
         LV_sSql:= LV_sSql||'EO_SECUENCIA.NOM_SECUENCIA:='|| 'GA_SEQ_TRANSACABO'||'; ';
         LV_sSql:= LV_sSql||'PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR  (EO_SECUENCIA,'||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';

         PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR (EO_SECUENCIA, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
         VP_TRANSACCION:= to_char(EO_SECUENCIA.NUM_SECUENCIA);



         VP_CLIENTE      :=TO_CHAR(EO_Cliente.COD_CLIENTE_ORI);
         VP_CLIENTE_NUEVO:=TO_CHAR(EO_Cliente.COD_CLIENTE_DES);
         VP_ABONADO      :=TO_CHAR(EO_Cliente.NUM_ABONADO);




        SELECT  valor_texto
        INTO      param_opera
        FROM  ge_parametros_sistema_vw
        WHERE  nom_parametro = 'COD_OPERADORA_LOCAL'
        AND    cod_modulo    = 'GE';

        If Trim(param_opera) = 'TMG' Then

         LV_sSql:='ga_p_intercuotas ('||VP_TRANSACCION||','||VP_CLIENTE||','||VP_ABONADO||','||VP_CLIENTE_NUEVO||','||VP_ABONADO||'); ';
         ga_p_intercuotas (VP_TRANSACCION,VP_CLIENTE,VP_ABONADO,VP_CLIENTE_NUEVO,VP_ABONADO);

         LV_sSql:='SELECT COD_RETORNO,DES_CADENA INTO SN_cod_retorno,SV_mens_retorno FROM GA_TRANSACABO WHERE NUM_TRANSACCION ='|| VP_TRANSACCION||'; ';
         SELECT COD_RETORNO,DES_CADENA
          INTO SN_cod_retorno,SV_mens_retorno
         FROM GA_TRANSACABO
         WHERE NUM_TRANSACCION = VP_TRANSACCION;

         IF ((SN_cod_retorno>0) AND (SN_cod_retorno IS NOT NULL)) THEN
                RAISE ERROR_EJECUCION;
         END IF;

       ELSE
         SN_cod_retorno:=0;
         SV_mens_retorno:='OK';
       END IF;

    EXCEPTION
        WHEN ERROR_EJECUCION THEN
                 SN_cod_retorno:=1703;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                 END IF;
                 LV_des_error   := 'TRASPASAR_CUOTAS_ABONADO_PR('||VP_TRANSACCION||','||VP_CLIENTE||','||VP_ABONADO||','||VP_CLIENTE_NUEVO||','||VP_ABONADO||'); - ' || SQLERRM;
                 SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.TRASPASAR_CUOTAS_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

          WHEN NO_DATA_FOUND THEN
                 SN_cod_retorno:=149;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                 END IF;
                 LV_des_error   := 'TRASPASAR_CUOTAS_ABONADO_PR('||VP_TRANSACCION||','||VP_CLIENTE||','||VP_ABONADO||','||VP_CLIENTE_NUEVO||','||VP_ABONADO||'); - ' || SQLERRM;
                 SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.TRASPASAR_CUOTAS_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

         WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_error_no_clasif;
                END IF;
                   LV_des_error   := 'TRASPASAR_CUOTAS_ABONADO_PR('||VP_TRANSACCION||','||VP_CLIENTE||','||VP_ABONADO||','||VP_CLIENTE_NUEVO||','||VP_ABONADO||'); - ' || SQLERRM;
                   SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.TRASPASAR_CUOTAS_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END TRASPASAR_CUOTAS_ABONADO_PR;


PROCEDURE PV_VALIDA_ABOACTIVOCLIDEST_PR(
                   EN_cod_cliente   IN     ge_clientes.COD_CLIENTE%TYPE,
              EN_num_abonado     IN      ga_abocel.num_abonado%TYPE,
              SN_retorno          OUT         NUMBER,
                SN_cod_retorno   OUT NOCOPY        ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY        ge_errores_td.det_msgerror%TYPE,
                SN_num_evento   OUT NOCOPY        ge_errores_pg.evento)

      IS
     /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PV_DATOS_CLIENTE_PG
          Lenguaje="PL/SQL"
          Fecha="06-01-2008"
          Versión="La del package"
          Diseñador="rlozano "
          Programador="rlozano"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción></Descripción>>
          <Parámetros>
             <Entrada>
                <param nom=" EN_cod_cliente" Tipo="numeric">codigo Cliente</param>>
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
        SV_mens_retorno := NULL;
        SN_num_evento     := 0;

         LV_sSql:= 'SELECT COUNT(1) FROM GA_ABOCEL '||
                           'WHERE COD_CLIENTE ='||EN_cod_cliente||
                       ' AND COD_SITUACION <> ''BAA'''||
                       'AND NUM_ABONADO  <> '||EN_num_abonado ;

        SELECT COUNT(1)
        INTO  SN_retorno
        FROM GA_ABOCEL
        WHERE COD_CLIENTE =EN_cod_cliente -- Este campo puede asumir el valor del cliente origen o clientes destino
        AND COD_SITUACION <> 'BAA'
        AND NUM_ABONADO  <> EN_num_abonado;

    EXCEPTION
      WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := ' PV_VALIDA_ABOACTIVOCLIDEST_PR('||EN_cod_cliente||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES2_PG.PV_VALIDA_ABOACTIVOCLIDEST_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PV_VALIDA_ABOACTIVOCLIDEST_PR;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

PROCEDURE PV_OBTIENE_TIPOPLAN_CLIE_PR (
              EN_COD_CLIENTE   IN    ga_abocel.cod_cliente%TYPE,
              SN_PREPAGOS       OUT NOCOPY    NUMBER,
              SN_POSPAGOS       OUT NOCOPY    NUMBER,
              SN_HIBRIDOS       OUT NOCOPY    NUMBER,
              SN_cod_retorno   OUT NOCOPY    ge_errores_pg.coderror,
                SV_mens_retorno  OUT NOCOPY    ge_errores_pg.msgerror,
                SN_num_evento    OUT NOCOPY     ge_errores_pg.evento)
       IS
/*
<Documentacion TipoDoc = "Procedure">
<Elemento Nombre = "PV_OBTIENE_TIPOPLAN_CLIE_PR"
Lenguaje="PL/SQL" Fecha="21-02-2008"
Versión"1.0.0" Diseñador"Andrés Osorio"
Programador="" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripcion> Cuenta las cantidades de abonados por tipo de plan tarifario para un cliente</Descripcion>
<Parametros>
<Entrada>
              <param nom="EO_Cliente" Tipo="estructura">Cliente origen</param>>
              <param nom="EO_Num_Abonado" Tipo="estructura">Abonado a traspasar</param>>
              <param nom="EO_Cliente_Nuevo" Tipo="estructura">cliente nuevo</param>>
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
LV_sSql            ge_errores_pg.vQuery;

ERROR_EJECUCION EXCEPTION;

BEGIN

    SN_cod_retorno := 0;
    SV_mens_retorno := '';
    SN_num_evento := 0;

    LV_sSQL :=     'SELECT COUNT(0) FROM GA_ABOAMIST WHERE COD_CLIENTE = '||EN_COD_CLIENTE;
    LV_sSQL := LV_sSQL || ' AND cod_situacion IN (''AAA'', ''AOP'', ''TVP'', ''ATP'')';

    SELECT COUNT(0)
    INTO SN_PREPAGOS
    FROM ga_aboamist
    WHERE cod_cliente = EN_COD_CLIENTE
    AND cod_situacion IN ('AAA', 'AOP', 'TVP', 'ATP');

    LV_sSQL :=     'SELECT COUNT(0) FROM GA_ABOCEL WHERE COD_CLIENTE = '||EN_COD_CLIENTE||' AND COD_USO = '||CN_USOPOSPAGO;
    LV_sSQL := LV_sSQL || ' AND cod_situacion IN (''AAA'', ''AOP'', ''TVP'', ''ATP'')';

    SELECT COUNT(0)
    INTO SN_POSPAGOS
    FROM ga_abocel
    WHERE cod_cliente = EN_COD_CLIENTE
    AND cod_uso = CN_USOPOSPAGO
    AND cod_situacion IN ('AAA', 'AOP', 'TVP', 'ATP');

    LV_sSQL :=     'SELECT COUNT(0) FROM GA_ABOCEL WHERE COD_CLIENTE = '||EN_COD_CLIENTE||' AND COD_USO = '||CN_USOHIBRIDO;
    LV_sSQL := LV_sSQL || ' AND cod_situacion IN (''AAA'', ''AOP'', ''TVP'', ''ATP'')';

    SELECT COUNT(0)
    INTO SN_HIBRIDOS
    FROM ga_abocel
    WHERE cod_cliente = EN_COD_CLIENTE
    AND cod_uso = CN_USOHIBRIDO
    AND cod_situacion IN ('AAA', 'AOP', 'TVP', 'ATP');

EXCEPTION
     WHEN OTHERS THEN
            SN_cod_retorno := 156;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno := CV_error_no_clasif;
            END IF;
               LV_des_error   := 'PV_OBTIENE_TIPOPLAN_CLIE_PR('||EN_COD_CLIENTE||'); - ' || SQLERRM;
               SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_OBTIENE_TIPOPLAN_CLIE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_TIPOPLAN_CLIE_PR;

--------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_DATOSADIC_CLIE_PR (
              EN_COD_CLIENTE   IN    ga_abocel.cod_cliente%TYPE,
              SV_DES_COLOR     OUT NOCOPY   VARCHAR2,
              SV_DES_SEGMENTO  OUT NOCOPY   VARCHAR2,
              SN_cod_retorno   OUT NOCOPY    ge_errores_pg.coderror,
              SV_mens_retorno  OUT NOCOPY    ge_errores_pg.msgerror,
              SN_num_evento    OUT NOCOPY     ge_errores_pg.evento)
       IS
/*
<Documentacion TipoDoc = "Procedure">
<Elemento Nombre = "PV_OBTIENE_DATOSADIC_CLIE_PR"
Lenguaje="PL/SQL" Fecha="16-02-2010"
Versión"1.0.0" Diseñador"Elizabeth Vera"
Programador="" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripcion> Obtiene informacion del cliente</Descripcion>
<Parametros>
<Entrada>
              <param nom="EN_COD_CLIENTE" Tipo="NUMBER">Cliente </param>>
</Entrada>
<Salida>
 <param nom="SV_DES_COLOR" Tipo="NUMERICO">Codigo de Retorno</param>>
  <param nom="SV_DES_SEGMENTO" Tipo="NUMERICO">Codigo de Retorno</param>>
 <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
 <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
 <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
</Salida>
</Parametros>
</Elemento>
</Documentacion>
*/

LV_des_error       ge_errores_pg.DesEvent;
LV_sSQL            ge_errores_pg.vQuery;

ERROR_EJECUCION EXCEPTION;
VP_TIPO_CLIENTE  VARCHAR2(05);
VP_COD_COLOR    VARCHAR2(05);
VP_COD_SEGMENTO VARCHAR2(05);

BEGIN

    SN_cod_retorno := 0;
    SV_mens_retorno := '';
    SN_num_evento := 0;

    LV_sSQL :=     'SELECT cod_tipo, cod_color, cod_segmento  FROM ge_clientes WHERE COD_CLIENTE = ' || EN_COD_CLIENTE;

    SELECT cod_tipo, cod_color, cod_segmento
    INTO VP_TIPO_CLIENTE, VP_COD_COLOR, VP_COD_SEGMENTO
    FROM ge_clientes
    WHERE cod_cliente=EN_COD_CLIENTE;

    LV_sSQL :=     'SELECT DES_COLOR FROM GE_COLOR_TD WHERE COD_COLOR = '|| VP_COD_COLOR;

    SELECT DES_COLOR
    INTO SV_DES_COLOR
    FROM GE_COLOR_TD
    WHERE COD_COLOR = VP_COD_COLOR;

    SELECT DES_SEGMENTO
    INTO  SV_DES_SEGMENTO
    FROM GE_SEGMENTACION_CLIENTES_TD
    WHERE COD_SEGMENTO = VP_COD_SEGMENTO AND COD_TIPO = VP_TIPO_CLIENTE;

EXCEPTION
     WHEN OTHERS THEN
            SN_cod_retorno := 156;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno := CV_error_no_clasif;
            END IF;
               LV_des_error   := 'PV_OBTIENE_DATOSADIC_CLIE_PR('||EN_COD_CLIENTE||'); - ' || SQLERRM;
               SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOSADIC_CLIE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_DATOSADIC_CLIE_PR;


END PV_DATOS_CLIENTES_PG;
/
SHOW ERRORS