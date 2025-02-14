CREATE OR REPLACE PACKAGE BODY GA_Extra_Tiempo_PG
AS

--GA_Extra_Tiempo_PG v1.1/RA-200602170800: German Espinoza Z; 02/05/2006
--GA_Extra_Tiempo_PG v1.2/RA-200603070877: L. Alejandro Hott; 05/05/2006
--GA_Extra_Tiempo_PG v1.3/COL-72560: Jose Jara Rojas; 06/11/2008
-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Carga_Minutos_Central_FN
(
        EN_num_abonado IN NUMBER,
        EN_cod_cliente IN NUMBER,
        EN_carga IN NUMBER,
        EV_tip_terminal IN VARCHAR2,
        EN_num_celular IN NUMBER,
        EV_num_serie IN VARCHAR2,
        EV_tip_tecnologia IN VARCHAR2,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
)
/*
<Documentación
 TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_Carga_Minutos_Central_PR"
      Lenguaje="PL/SQL"
      Fecha="29-03-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy"
      Programador="Carlos Navarro H. - Marcelo Godoy"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>carga minutos a celulares hibridos y prepago</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_abonado" Tipo="NUMERO">numero de abonado</param>
            <param nom="EN_cod_cliente" Tipo="NUMERO">codigo de cliente</param>
            <param nom="EN_carga"   Tipo="NUMERO">carga a celular</param>
            <param nom="EV_tip_terminal" Tipo="NUMERO">tipo de terminal</param>
            <param nom="EN_num_celular" Tipo="NUMERO">numero de celular</param>
            <param nom="EV_num_serie" Tipo="NUMERO">numero de serire</param>
            <param nom="EV_tip_tecnologia" Tipo="NUMERO">tipo de tecnologia</param>
         </Entrada>
         <Salida>
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
        error_control EXCEPTION;
        error_ejecucion EXCEPTION;
        LN_cod_atencion NUMBER(3):= 501;
        LN_cod_central icc_movimiento.cod_central%TYPE;
        LN_cod_vendedor ge_seg_usuario.cod_vendedor%TYPE;
        LN_ind_bloqueo icc_movimiento.ind_bloqueo%TYPE:= 0;
        LN_num_transaccion  ga_transacabo.num_transaccion%TYPE;

        LV_cod_oficina ge_oficinas.cod_oficina%TYPE;
        LV_fec_ingreso icc_movimiento.fec_ingreso%TYPE:= SYSDATE;
        LV_ind_estado pv_recargaprepago_to.ind_estado%TYPE:='1';
        LV_nom_usuarora ci_reg_atencion_clientes.nom_usuarora%TYPE:= USER;
        LV_num_secuencia icc_movimiento.num_movimiento%TYPE;

        LV_falso VARCHAR2(5):='FALSO';
        LV_errorsev VARCHAR2(100);
        LV_errordes VARCHAR2(500);
        LN_nevento NUMBER(9);

BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := '';
        SN_num_evento := 0;
        GV_sSql := '';

        -- Valida que la cantidad de minutos no sea cero, ni blanco.
        IF EN_carga = CV_null OR EN_carga <= 0 THEN
                RAISE error_control;
        END IF;

        -- Busca codigo de central
        GV_sSql := 'SELECT a.cod_central';
        GV_sSql := GV_sSql || ' FROM ga_abocel a';
        GV_sSql := GV_sSql || ' WHERE a.num_abonado = ' || EN_num_abonado;
        GV_sSql := GV_sSql || ' AND a.num_celular = ' || EN_num_celular;
        GV_sSql := GV_sSql || ' UNION';
        GV_sSql := GV_sSql || ' SELECT a.cod_central';
        GV_sSql := GV_sSql || ' FROM ga_aboamist a';
        GV_sSql := GV_sSql || ' WHERE a.num_abonado = ' || EN_num_abonado;
        GV_sSql := GV_sSql || ' AND a.num_celular = ' || EN_num_celular;

        SELECT
                a.cod_central
        INTO
                LN_cod_central
        FROM
                ga_abocel a
        WHERE
                a.num_abonado = EN_num_abonado
                AND a.num_celular = EN_num_celular
        UNION
        SELECT
                a.cod_central
        FROM
                ga_aboamist a
        WHERE
                a.num_abonado = EN_num_abonado
                AND a.num_celular = EN_num_celular;

        GV_sSql := 'SELECT icc_seq_nummov.nextval INTO LV_num_secuencia FROM dual';

        SELECT
                icc_seq_nummov.nextval
        INTO
                LV_num_secuencia
        FROM
                dual;

        -- Inicio Modificación - GBM/Soporte - RA-200512020241 - 02-12-2005
        GV_sSql := SUBSTR('GA_Aprovisionar_Central_PG.GA_Aprovisionar_Srv_PR('||LV_num_secuencia||','||EN_num_abonado||','
                                   ||CN_cod_estado||','||CV_cod_actabo||','||CV_cod_modulo||','||LV_nom_usuarora||','||LV_fec_ingreso||','
                                   ||EV_tip_terminal||','||LN_cod_central||','||LN_ind_bloqueo||','||CV_null||','||EN_num_celular||','
                                   ||EV_num_serie||','||CV_null||','||CV_null||','||CV_null||','||CV_null||','||CV_null||','
                                   ||CV_null||','||EV_tip_tecnologia||','||CV_null||','||CV_null||','||CV_null||','||EV_num_serie||','
                                   ||CV_null||','||EN_carga||','||CV_null||','||CV_null||','||CV_null||','||CV_null||','
                                   ||LV_errorsev||','||LN_nevento||','||LV_errordes||');-',1,CN_largoquery);

        GA_Aprovisionar_Central_PG.GA_Aprovisionar_Srv_PR
                (
                        LV_num_secuencia, EN_num_abonado, CN_cod_estado, CV_cod_actabo, CV_cod_modulo, LV_nom_usuarora,
                        LV_fec_ingreso, EV_tip_terminal, LN_cod_central, LN_ind_bloqueo, CV_null, EN_num_celular,
                        EV_num_serie, CV_null, CV_null, CV_null, CV_null, CV_null, CV_null, EV_tip_tecnologia, CV_null,
                        CV_null, CV_null, EV_num_serie, CV_null, EN_carga, CV_null, CV_null, CV_null, CV_null, LV_errorsev,
                        LN_nevento, LV_errordes
                );
        -- Fin Modificación - GBM/Soporte - RA-200512020241 - 02-12-2005

        IF UPPER(LV_errorsev) = LV_falso THEN
                RAISE error_ejecucion;
        END IF;

        GV_sSql := 'SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';

        SELECT GA_SEQ_TRANSACABO.NEXTVAL
        INTO LN_num_transaccion
        FROM DUAL;


        GV_sSql := 'INSERT INTO pv_recargaprepago_to ( num_movimiento, num_abonado, num_celular, cod_cliente, ';
        GV_sSql := GV_sSql || 'cod_recarga, val_recarga, num_tarjeta, cod_apliorigen, ind_estado, fec_ejecentral, fec_recarga, ';
        GV_sSql := GV_sSql || 'nom_usuario ) ';
        GV_sSql := GV_sSql || 'VALUES (' || LV_num_secuencia|| ',' || EN_num_abonado|| ',' || EN_num_celular|| ',';
        GV_sSql := GV_sSql || EN_cod_cliente|| ',' || CV_cod_actabo|| ',' || EN_carga|| ',' || CV_null|| ',' || CV_cod_modulo;
        GV_sSql := GV_sSql || ',' || LV_ind_estado|| ',' || CV_null|| ',' || SYSDATE|| ',' || LV_nom_usuarora|| ')';

        INSERT INTO
                pv_recargaprepago_to
                        (
                                num_movimiento, num_abonado, num_celular, cod_cliente, cod_recarga, val_recarga, num_tarjeta,
                                cod_apliorigen, ind_estado, fec_ejecentral, fec_recarga, nom_usuario
                        )
                VALUES
                        (
                                LV_num_secuencia, EN_num_abonado, EN_num_celular, EN_cod_cliente, CV_cod_actabo, EN_carga, CV_null,
                                CV_cod_modulo, LV_ind_estado, CV_null, SYSDATE, LV_nom_usuarora
                        );

        RETURN TRUE;

EXCEPTION
        WHEN error_ejecucion THEN
                GV_des_error :='GA_Carga_Minutos_Central_PR('||EN_num_abonado||','||EN_cod_cliente||','||EN_carga||',';
                GV_des_error := GV_des_error ||EV_tip_terminal||','||EN_num_celular||','||EV_num_serie||','||EV_tip_tecnologia||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Carga_Minutos_Central_PR', GV_sSql, SQLCODE, GV_des_error
                        );
                RETURN FALSE;

        WHEN error_control THEN
                SN_cod_retorno := 92;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                GV_des_error :='GA_Carga_Minutos_Central_PR('||EN_num_abonado||','||EN_cod_cliente||','||EN_carga||',';
                GV_des_error := GV_des_error ||EV_tip_terminal||','||EN_num_celular||','||EV_num_serie||','||EV_tip_tecnologia||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Carga_Minutos_Central_PR', GV_sSql, SQLCODE, GV_des_error
                        );
                RETURN FALSE;

        WHEN VALUE_ERROR THEN
                SN_cod_retorno := 303;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                GV_des_error :='GA_Carga_Minutos_Central_PR('||EN_num_abonado||','||EN_cod_cliente||','||EN_carga||',';
                GV_des_error := GV_des_error ||EV_tip_terminal||','||EN_num_celular||','||EV_num_serie||','||EV_tip_tecnologia||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Carga_Minutos_Central_PR', GV_sSql, SQLCODE, GV_des_error
                        );
                RETURN FALSE;

        WHEN OTHERS THEN
                SN_cod_retorno := 302;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                GV_des_error :='GA_Carga_Minutos_Central_PR('||EN_num_abonado||','||EN_cod_cliente||','||EN_carga||',';
                GV_des_error := GV_des_error ||EV_tip_terminal||','||EN_num_celular||','||EV_num_serie||','||EV_tip_tecnologia||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Carga_Minutos_Central_PR', GV_sSql, SQLCODE, GV_des_error
                        );
                RETURN FALSE;

END GA_Carga_Minutos_Central_FN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Recupera_Plan_Comercial_FN
(
        EN_cod_cliente IN ga_cliente_pcom.cod_plancom%TYPE,
        SV_cod_plancom OUT NOCOPY ga_cliente_pcom.cod_plancom%TYPE,
        SN_cod_retorno OUT NOCOPY GE_Errores_PG.CodError,
        SV_mens_retorno OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
        SN_num_evento OUT NOCOPY GE_Errores_PG.Evento
)
/*
<Documentación
 TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_Recupera_Plan_Comercial_FN"
      Lenguaje="PL/SQL"
      Fecha="29-03-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy"
      Programador="Carlos Navarro H. - Marcelo Godoy"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera Plan Comercial de un Cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERO">Codigo de Cliente</param>
         </Entrada>
         <Salida>
            <param nom="SV_cod_plancom" Tipo="CARACTER">Codigo de Plan Comercial</param>
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
        V_des_error GE_Errores_PG.DesEvent;
        LV_sSql GE_Errores_PG.vQuery;

BEGIN
        SN_cod_retorno := '0';
        SN_num_evento := 0;
        SV_mens_retorno:= '0';

        LV_sSql := 'SELECT cod_plancom';
        LV_sSql := LV_sSql || ' INTO SV_cod_plancom';
        LV_sSql := LV_sSql || ' FROM ga_cliente_pcom';
        LV_sSql := LV_sSql || ' WHERE cod_cliente = ' || EN_cod_cliente;
        LV_sSql := LV_sSql || ' AND ' || SYSDATE || ' BETWEEN fec_desde AND NVL(fec_hasta, ' || SYSDATE || ')';

        SELECT
                cod_plancom
        INTO
                SV_cod_plancom
        FROM
               ga_cliente_pcom
        WHERE
                cod_cliente = EN_cod_cliente
                AND SYSDATE BETWEEN fec_desde AND NVL(fec_hasta, SYSDATE);

        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SV_cod_plancom := 0;
                RETURN TRUE;

        WHEN OTHERS THEN
                SV_cod_plancom := 0;
                RETURN TRUE;

END GA_Recupera_Plan_Comercial_FN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Inserta_Cargos_FN
(
        EN_cod_cliente IN ga_abocel.cod_cliente%TYPE,
        EN_cod_producto IN ga_abocel.cod_producto%TYPE,
        EN_num_abonado IN ga_abocel.num_abonado%TYPE,
        EN_num_terminal IN ga_abocel.num_celular%TYPE,
        ED_fec_alta IN ga_abocel.fec_alta%TYPE,
        EN_cod_ciclfact IN fa_ciclfact.cod_ciclfact%TYPE,
        EV_cod_concepto IN ge_cargos.cod_concepto%TYPE,
        EN_imp_cargo IN ge_cargos.imp_cargo%TYPE,
        EV_cod_moneda IN ge_cargos.cod_moneda%TYPE,
        EV_usuario IN ge_cargos.nom_usuarora%TYPE,
        SN_cod_retorno OUT NOCOPY GE_Errores_PG.CodError,
        SV_mens_retorno OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
        SN_num_evento OUT NOCOPY GE_Errores_PG.Evento
)
/*
<Documentación
 TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_Inserta_Cargos_FN"
      Lenguaje="PL/SQL"
      Fecha="29-03-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H."
      Programador="Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Inserta Datos en la tabla pv_movimientos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERO">Código de Cliente</param>
            <param nom="EN_cod_producto" Tipo="NUMERO">Código de Producto</param>
            <param nom="EN_num_abonado" Tipo="NUMERO">Numero de Abonado</param>
            <param nom="EN_num_terminal" Tipo="NUMERO">Tipo de Terminal</param>
            <param nom="EV_cod_plancom" Tipo="STRING">Código de Plan Comercial</param>
            <param nom="ED_fec_alta" Tipo="FECHA">Fecha de Alta</param>
            <param nom="EN_cod_ciclfact" Tipo="NUMERO">Ciclo de Facturacion</param>
            <param nom="EV_cod_concepto" Tipo="STRING">Código de Concepto</param>
            <param nom="EN_imp_cargo" Tipo="NUMERO">Importe Cargo</param>
            <param nom="EV_cod_moneda" Tipo="STRING">Código de Moneda</param>
            <param nom="EV_usuario" Tipo="STRING">Usuario</param>
         </Entrada>
         <Salida>
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
        V_des_error GE_Errores_PG.DesEvent;
        sSql GE_Errores_PG.vQuery;
        LV_cod_plancom ga_cliente_pcom.cod_plancom%TYPE;
        error_ejecucion EXCEPTION;

BEGIN
        SN_cod_retorno := '0';
        SN_num_evento := 0;
        SV_mens_retorno := '0';

        IF NOT GA_Recupera_Plan_Comercial_FN(EN_cod_cliente,LV_cod_plancom ,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                RAISE error_ejecucion;
        END IF;

        sSql := 'INSERT INTO ge_cargos (num_cargo, cod_cliente, cod_producto, num_abonado, num_terminal, cod_plancom,';
        sSql := sSql || ' cod_ciclfact, ind_factur, fec_alta, cod_concepto, num_unidades, imp_cargo, cod_moneda, ind_cuota,';
        sSql := sSql || ' nom_usuarora)';
        sSql := sSql || ' VALUES (ge_seq_cargos.nextval, '||EN_cod_cliente||','||EN_cod_producto||','||EN_num_abonado||',';
        sSql := sSql || EN_num_terminal||','||LV_cod_plancom||','||EN_cod_ciclfact||',1,'||ED_fec_alta||','||EV_cod_concepto;
        sSql := sSql || ',1,'||EN_imp_cargo||','||EV_cod_moneda||','||CV_null||','||EV_usuario||');';

        INSERT INTO
                ge_cargos
                        (
                                num_cargo, cod_cliente, cod_producto, num_abonado, num_terminal, cod_plancom, cod_ciclfact,
                                ind_factur, fec_alta, cod_concepto, num_unidades, imp_cargo, cod_moneda, ind_cuota, nom_usuarora
                        )
        VALUES
                        (
                                ge_seq_cargos.nextval, EN_cod_cliente, EN_cod_producto, EN_num_abonado, EN_num_terminal,
                                LV_cod_plancom, EN_cod_ciclfact, 1, ED_fec_alta, EV_cod_concepto, 1, EN_imp_cargo, EV_cod_moneda,
                                CV_null, EV_usuario
                        );

        RETURN TRUE;

EXCEPTION
        WHEN error_ejecucion THEN
                V_des_error := 'GA_Inserta_Cargos_FN('||EN_cod_cliente||','||EN_cod_producto||','||EN_num_abonado||',';
                V_des_error := V_des_error ||EN_num_terminal||','||ED_fec_alta||','||EN_cod_ciclfact||','||EV_cod_concepto||','||EN_imp_cargo;
                V_des_error := V_des_error ||','||EV_cod_moneda||','||EV_usuario||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, 'PV', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER,
                                'GA_Extra_Tiempo_PG.GA_Inserta_Cargos_FN', sSql, SQLCODE, V_des_error
                        );
                RETURN FALSE;

        WHEN OTHERS THEN
                SN_cod_retorno := '156';
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'GA_Inserta_Cargos_FN('||EN_cod_cliente||','||EN_cod_producto||','||EN_num_abonado||',';
                V_des_error := V_des_error ||EN_num_terminal||','||ED_fec_alta||','||EN_cod_ciclfact||','||EV_cod_concepto||','||EN_imp_cargo;
                V_des_error := V_des_error ||','||EV_cod_moneda||','||EV_usuario||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, 'PV', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER,
                                'GA_Extra_Tiempo_PG.GA_Inserta_Cargos_FN', sSql, SQLCODE, V_des_error
                        );
                RETURN FALSE;

END GA_Inserta_Cargos_FN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Recupera_Cicloperactual_FN
(
        EN_ciclo IN fa_ciclfact.cod_ciclo%TYPE,
        SN_cod_ciclfact OUT NOCOPY fa_ciclfact.cod_ciclfact%TYPE,
        SD_fec_hastallam OUT NOCOPY fa_ciclfact.fec_desdellam%TYPE,
        SN_cod_retorno OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
        SN_num_evento OUT NOCOPY GE_Errores_PG.Evento
)
/*
<Documentación
 TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_Recupera_Cicloperactual_FN"
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
        V_des_error GE_Errores_PG.DesEvent;
        sSql GE_Errores_PG.vQuery;

BEGIN
        SN_cod_retorno := '0';
        SN_num_evento :=  0;
        SV_mens_retorno:= '0';

        sSql := 'SELECT cod_ciclfact, fec_hastallam';
        sSql := sSql || ' INTO SN_cod_ciclfact, SD_fec_hastallam';
        sSql := sSql || ' FROM fa_ciclfact';
        sSql := sSql || ' WHERE cod_ciclo = ' || EN_ciclo;
        sSql := sSql || ' AND '||SYSDATE||' BETWEEN fec_desdellam AND fec_hastallam';

        SELECT
                cod_ciclfact, fec_hastallam
        INTO
                SN_cod_ciclfact, SD_fec_hastallam
        FROM
             fa_ciclfact
        WHERE
                cod_ciclo = EN_ciclo
                AND SYSDATE BETWEEN fec_desdellam AND fec_hastallam;

        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := '200';
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'GA_Recupera_Cicloperactual_FN('||EN_ciclo||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER,
                                'GA_Extra_Tiempo_PG.GA_Recupera_Cicloperactual_FN', sSql, SQLCODE, V_des_error
                        );
                RETURN FALSE;

        WHEN OTHERS THEN
                SN_cod_retorno := '156';
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'GA_Recupera_Cicloperactual_FN('||EN_ciclo||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER,
                                'GA_Extra_Tiempo_PG.GA_Recupera_Cicloperactual_FN', sSql, SQLCODE, V_des_error
                        );
                RETURN FALSE;

END GA_Recupera_Cicloperactual_FN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Rec_Cod_Moneda_FN
(
        EN_cod_concepto IN fa_conceptos.cod_concepto%TYPE,
        SV_cod_moneda OUT NOCOPY fa_conceptos.cod_moneda%TYPE,
        SN_cod_retorno OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
        SN_num_evento OUT NOCOPY GE_Errores_PG.Evento
)
/*
<Documentacion
 TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_Rec_Cod_Moneda_FN"
      Fecha modificacion=" "
      Fecha creacion="26-12-2004"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador=" "
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Recuperar codigo de moneda</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_cod_concepto" Tipo="CARACTER">Codigo del Concepto</param>
         </Entrada>
         <Salida>
            <param nom="SV_cod_moneda" Tipo="CARACTER">Codigo de Moneda</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Código de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
        LV_des_error GE_Errores_PG.DesEvent;
        LV_sSql GE_Errores_PG.vQuery;
        LN_can_reg NUMBER;
        error_concepto EXCEPTION;

BEGIN
        SN_cod_retorno := 0;
        SN_num_evento := 0;
        SV_mens_retorno := '';

        LV_sSql := ' SELECT cod_moneda';
        LV_sSql := LV_sSql || ' INTO SV_cod_moneda';
        LV_sSql := LV_sSql || ' FROM fa_conceptos';
        LV_sSql := LV_sSql || ' WHERE cod_concepto = ' || EN_cod_concepto;

        SELECT
                cod_moneda
        INTO
                SV_cod_moneda
        FROM
                fa_conceptos
        WHERE
                cod_concepto = EN_cod_concepto;

        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 71;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'GA_Rec_Cod_Moneda_FN('||EN_cod_concepto||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, 'Error no clasificado', CV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Rec_Cod_Moneda_FN', LV_sSql, SN_cod_retorno, LV_des_error
                        );
                RETURN FALSE;

        WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'GA_Rec_Cod_Moneda_FN('||EN_cod_concepto||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, 'Error no clasificado', CV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Rec_Cod_Moneda_FN', LV_sSql, SN_cod_retorno, LV_des_error
                        );
                RETURN FALSE;

END GA_Rec_Cod_Moneda_FN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Rec_Plan_Beneficio_FN
(
        EN_cod_plan IN bpd_planes.cod_plan%TYPE,
        EN_cod_tiplan IN bpd_planes.cod_tiplan%TYPE,
        SN_cnt_minadic OUT NOCOPY bpd_planes.cnt_minadic%TYPE, --ahott RA-200603070877 05-05-2006
        SN_mto_cargadic OUT NOCOPY bpd_planes.mto_cargadic%TYPE,
        SV_tip_dcto OUT NOCOPY bpd_planes.tip_dcto%TYPE,
        SV_cod_dcto OUT NOCOPY bpd_planes.cod_dcto%TYPE,
        SN_cod_retorno OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
        SN_num_evento OUT NOCOPY GE_Errores_PG.Evento
)
/*
<Documentacion
 TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_Rec_Plan_Beneficio_FN"
      Fecha modificacion=" "
      Fecha creacion="26-12-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador=" "
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Recupera Informacion Promocion</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_cod_plan" Tipo="NUMERICO">Codigo de plan</param>
            <param nom="EN_cod_tiplan" Tipo="NUMERICO">Codigo de Tipo de plan</param>
         </Entrada>
         <Salida>
            <param nom="SN_mto_cargadic" Tipo="NUMERICO">Monto Carga</param>
            <param nom="SV_tip_dcto" Tipo="NUMERICO">Tipo de documento</param>
            <param nom="SV_cod_dcto " Tipo="CARACTER">codigo de documento</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Código de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
        LV_des_error GE_Errores_PG.DesEvent;
        LV_sSql GE_Errores_PG.vQuery;
        LV_cod_plan bpd_planes.cod_plan%TYPE;
BEGIN
        SN_cod_retorno := 0;
        SN_num_evento := 0;
        SV_mens_retorno:= '';

        --RA-200602170800: German Espinoza Z; 02/05/2006
        --LV_sSql := ' SELECT cod_plan, mto_cargadic, tip_dcto, cod_dcto'
        LV_sSql := ' SELECT cod_plan, DECODE(cod_tiplan,2,cnt_minadic,mto_cargadic), tip_dcto, cod_dcto';
        --RA-200602170800: German Espinoza Z; 02/05/2006
        LV_sSql := LV_sSql || ' INTO LV_cod_plan, SN_mto_cargadic, SV_tip_dcto, SV_cod_dcto';
        LV_sSql := LV_sSql || ' FROM bpd_planes';
        LV_sSql := LV_sSql || ' WHERE cod_plan = '||EN_cod_plan;
        LV_sSql := LV_sSql || ' AND fec_desdeapli <= '||SYSDATE;
        LV_sSql := LV_sSql || ' AND fec_hastaapli >= '||SYSDATE;
        LV_sSql := LV_sSql || ' AND cod_tiplan = '||EN_cod_tiplan;
        LV_sSql := LV_sSql || ' AND cod_estado = ''V''';
        LV_sSql := LV_sSql || ' AND cod_asignacion = ''PV''';

        --RA-200602170800: German Espinoza Z; 02/05/2006
        --SELECT cod_plan, mto_cargadic, tip_dcto, cod_dcto
        --SELECT cod_plan, DECODE(cod_tiplan,2,cnt_minadic,mto_cargadic), tip_dcto, cod_dcto -- ahott RA-200603070877 05-05-2006
        SELECT
                cod_plan, cnt_minadic, mto_cargadic, tip_dcto, cod_dcto -- ahott RA-200603070877 05-05-2006
        --RA-200602170800: German Espinoza Z; 02/05/2006
        INTO
                LV_cod_plan, SN_cnt_minadic, SN_mto_cargadic, SV_tip_dcto, SV_cod_dcto -- ahott RA-877 04-05-2006
        FROM
           bpd_planes
        WHERE
                cod_plan = EN_cod_plan
                AND fec_desdeapli <= SYSDATE
                AND fec_hastaapli >= SYSDATE
                AND cod_tiplan = EN_cod_tiplan
                AND cod_estado = 'V'
                AND cod_asignacion = 'PV';

        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 244;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'GA_Rec_Plan_Beneficio_FN('||EN_cod_plan||','||EN_cod_tiplan||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, 'Error no clasificado', CV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Rec_Plan_Beneficio_FN', LV_sSql, SN_cod_retorno, LV_des_error
                        );
                RETURN FALSE;

        WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'GA_Rec_Plan_Beneficio_FN('||EN_cod_plan||','||EN_cod_tiplan||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, 'Error no clasificado', CV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Rec_Plan_Beneficio_FN', LV_sSql, SN_cod_retorno, LV_des_error
                        );
                RETURN FALSE;

END GA_Rec_Plan_Beneficio_FN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Agrega_Plan_Tol_FN
(
        EN_cod_tiplan IN bpd_planes.cod_tiplan%TYPE,
        EV_tip_dcto IN bpd_planes.tip_dcto%TYPE,
        EV_cod_dcto IN bpd_planes.cod_dcto%TYPE,
        EN_cod_cliente IN ga_abocel.cod_cliente%TYPE,
        EN_num_abonado IN ga_abocel.num_abonado%TYPE,
        ED_fin_vigencia IN fa_ciclfact.fec_hastallam%TYPE,
        SN_mto_cargadic OUT NOCOPY bpd_planes.mto_cargadic%TYPE,
        SN_cod_retorno OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
        SN_num_evento OUT NOCOPY GE_Errores_PG.Evento
)
/*
<Documentacion
 TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_Recupera_Parametros_FN"
      Fecha modificacion=" "
      Fecha creacion="26-12-2004"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador=" "
      Ambiente Desarrollo="DEIMOS_TMC">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Recuperar parametros de sistema</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_nom_parametro" Tipo="CARACTER">Nombre del Parametro</param>
            <param nom="EV_cod_modulo" Tipo="CARACTER">Codigo de Modulo</param>
            <param nom="EN_cod_producto" Tipo="NUMERICO">Codigo de Producto</param>
         </Entrada>
         <Salida>
            <param nom="SV_val_parametro" Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Código de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
        LN_num_sec NUMBER := 1; --Secuencia para 1 vez
        LC_ind_inmediato CHAR := 'A'; --Ejecución inmediata
        LV_des_error GE_Errores_PG.DesEvent;
        LV_sSql  GE_Errores_PG.vQuery;

BEGIN
        SN_cod_retorno := 0;
        SN_num_evento := 0;
        SV_mens_retorno := '';

        LV_sSql := 'TOL_Descuentos_PG.TOL_Registra_Descuentos_PR ('||EV_tip_dcto||','||EV_cod_dcto||','||EN_cod_cliente;
        LV_sSql := LV_sSql ||','||EN_num_abonado||','||LN_num_sec||','||LC_ind_inmediato||','||ED_fin_vigencia||','||USER||' )';

        TOL_Descuentos_PG.TOL_Registra_Descuentos_PR ( EV_tip_dcto, EV_cod_dcto, EN_cod_cliente, EN_num_abonado, LN_num_sec, LC_ind_inmediato, ED_fin_vigencia, USER );

        RETURN TRUE;

EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'GA_Agrega_Plan_Tol_FN('||EN_cod_tiplan||','||EV_tip_dcto||','||EV_cod_dcto||','||EN_cod_cliente||',';
                LV_des_error := LV_des_error ||EN_num_abonado||','||ED_fin_vigencia||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, 'Error no clasificado', CV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Agrega_Plan_Tol_FN', LV_sSql, SN_cod_retorno, LV_des_error
                        );
                RETURN FALSE;

END GA_Agrega_Plan_Tol_FN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Registra_Ooss_FN
(
        EN_cod_os IN ci_orserv.cod_os%TYPE,
        EV_producto IN ci_orserv.producto%TYPE,
        EN_cod_inter IN ci_orserv.cod_inter%TYPE,
        EV_usuario  IN ci_orserv.usuario%TYPE,
        EV_comentario IN ci_orserv.comentario%TYPE,
        EN_num_cargo IN ci_orserv.num_cargo%TYPE,
        EV_cod_modulo IN ci_orserv.cod_modulo%TYPE,
        EN_id_gestor IN ci_orserv.id_gestor%TYPE,
        EN_num_movimiento IN ci_orserv.num_movimiento%TYPE,
        EN_cod_estado IN ci_orserv.cod_estado%TYPE,
        SN_numooss OUT NOCOPY ci_orserv.num_os%TYPE,
        SN_cod_retorno OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
        SN_num_evento OUT NOCOPY GE_Errores_PG.Evento
)
/*
<Documentación
 TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_Registra_Ooss_FN"
      Lenguaje="PL/SQL"
      Fecha="20-04-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>GENERA UNA OOSS PARA CAMBIO DE DIRECCION</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_os"  Tipo="NUMERICO">Código de OOSS</param>
            <param nom="EV_producto" Tipo="NUMERICO">Código de producto</param>
            <param nom="EN_tip_inter" Tipo="NUMERICO"></param>
            <param nom="EN_cod_inter" Tipo="NUMERICO"></param>
            <param nom="EV_usuario" Tipo="NUMERICO">codigo de usuario</param>
            <param nom="EV_comentario" Tipo="NUMERICO">Comentario</param>
            <param nom="EN_num_cargo" Tipo="NUMERICO">numero de cargo</param>
            <param nom="EV_cod_modulo" Tipo="NUMERICO">Código de modulo</param>
            <param nom="EN_id_gestor" Tipo="NUMERICO">Identificador de Gestro</param>
            <param nom="EN_num_movimiento" Tipo="NUMERICO">Numero de Movimineto</param>
            <param nom="EN_cod_estado" Tipo="NUMERICO">Código de Estado</param>
         </Entrada>
         <Salida>
            <param nom="SN_numooss" Tipo="NUMERICO">Numero de Orden de Servicio</param>
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
        V_des_error GE_Errores_PG.DesEvent;
        sSql  GE_Errores_PG.vQuery;
        N_tip_inter ci_tiporserv.grupo%TYPE;

BEGIN
        SN_cod_retorno := '0';
        SN_num_evento :=  0;
        SV_mens_retorno := '0';

        sSql := 'SELECT grupo INTO N_tip_inter FROM ci_tiporserv WHERE cod_os = '||EN_cod_os;

        SELECT
                grupo
        INTO
                N_tip_inter
        FROM
                ci_tiporserv
        WHERE
                cod_os = to_char(EN_cod_os);

        sSql := 'SELECT ci_seq_numos.nextval INTO SN_numooss FROM dual;';

        SELECT
                ci_seq_numos.nextval
        INTO
                SN_numooss
        FROM
                dual;

        sSql := 'INSERT INTO ci_orserv (num_os, cod_os, producto, tip_inter, cod_inter, usuario, fecha, comentario,';
        sSql := sSql ||' num_cargo, cod_modulo, id_gestor, num_movimiento, cod_estado)';
        sSql := sSql ||' VALUES ('||SN_numooss||','||EN_cod_os||','||EV_producto||','||EN_cod_inter||','||EV_usuario;
        sSql := sSql ||',SYSDATE,'||EV_comentario||','||EN_num_cargo||','||EV_cod_modulo||','||EN_id_gestor||',';
        sSql := sSql ||EN_num_movimiento||','||EN_cod_estado||');';

        INSERT INTO
        ci_orserv
                        (
                                num_os, cod_os, producto, tip_inter, cod_inter, usuario, fecha, comentario, num_cargo, cod_modulo, id_gestor, num_movimiento, cod_estado
                        )
        VALUES
                        (
                                SN_numooss, EN_cod_os, EV_producto, N_tip_inter, EN_cod_inter, EV_usuario, SYSDATE, EV_comentario,
                                EN_num_cargo, EV_cod_modulo, EN_id_gestor, EN_num_movimiento, EN_cod_estado
                        );

        RETURN TRUE;

EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno := '156';
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'GA_Registra_Ooss_FN('||EN_cod_os||','||EV_producto||','||EN_cod_inter||','||EV_usuario||',';
                V_des_error := V_des_error ||EV_comentario||','||EN_num_cargo||','||EV_cod_modulo||','||EN_id_gestor||','||EN_num_movimiento||',';
                V_des_error := V_des_error ||EN_cod_estado||','||SN_numooss||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento;
                V_des_error := V_des_error ||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER,
                                'GA_Extra_Tiempo_PG.GA_Registra_Ooss_FN', sSql, SQLCODE, V_des_error
                        );
                RETURN FALSE;

END GA_Registra_Ooss_FN;
-----------------------------------------------------------------------------------------------------------------

PROCEDURE GA_Obtiene_tipo_Plan_PR
(
        EN_cod_plan IN VARCHAR2,
        SN_cod_retorno OUT NOCOPY VARCHAR2
)
IS
BEGIN
-- Cuerpo deL PROCEDIMIENTO
-- 5-11-2008|72560-COL|JJR

        SELECT a.tip_valor
        INTO  SN_cod_retorno
        FROM  bpd_planes a, sch_codigos b
        WHERE a.cod_plan = EN_cod_plan
        and a.tip_valor = b.cod_param
        and b.cod_tipo = 'INDUNIDAD';
EXCEPTION
   WHEN OTHERS THEN
        SN_cod_retorno:='';
END GA_Obtiene_tipo_Plan_PR;

-----------------------------------------------------------------------------------------------------------------
PROCEDURE GA_Carga_Prepago_A_Postpago_PR
(
        EN_num_celular_origen IN NUMBER,
        EN_num_celular_destino IN NUMBER,
        EN_valor_recarga IN NUMBER,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
)
/*
<Documentación
 TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_Carga_Prepago_A_Postpago_PR"
      Lenguaje="PL/SQL"
      Fecha="05-07-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Realiza una carga desde un prepago a postpago</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular_origen" Tipo="NUMERICO">Celular de Origen</param>
            <param nom="EN_num_celular_destino" Tipo="NUMERICO">Celular de Destino</param>
            <param nom="EN_valor_recarga" Tipo="NUMERICO">Valor de la Carga</param>
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
IS
        -- Estructura de Datos Abonado Destino
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LN_cod_cliente ga_abocel.cod_cliente%TYPE;
        LV_nom_abocli VARCHAR2(91);
        LV_cod_situacion ga_abocel.cod_situacion%TYPE;
        LN_cod_cuenta ga_abocel.cod_cuenta%TYPE;
        LV_cod_clave VARCHAR2(7);
        LV_tip_plantarif ga_abocel.tip_plantarif%TYPE;
        LV_cod_plantarif ga_abocel.cod_plantarif%TYPE;
        LV_cod_tecnologia ga_abocel.cod_tecnologia%TYPE;
        LV_cod_perfil ge_valores_cli.des_valor%TYPE;
        LN_cod_ciclo ga_abocel.cod_ciclo%TYPE;
        LN_fono_contacto VARCHAR2(15);
        LV_num_serie ga_abocel.num_serie%TYPE;
        LV_num_imei ga_abocel.num_imei%TYPE;
        LV_num_min_mdn ga_abocel.num_min_mdn%TYPE;
        LV_num_min ga_abocel.num_min%TYPE;
        LV_num_seriehex ga_abocel.num_seriehex%TYPE;
        LV_num_seriemec ga_abocel.num_seriemec%TYPE;
        LV_tip_terminal ga_abocel.tip_terminal%TYPE;
        LV_tip_abonado ta_plantarif.cod_tiplan%TYPE;
        LV_des_plantarif ta_plantarif.des_plantarif%TYPE;
        LV_cod_estado ga_abocel.cod_estado%TYPE;
        LN_cod_producto ga_abocel.cod_producto%TYPE;
        LV_nom_responsable VARCHAR2(91);
        LV_cod_concepto ged_parametros.val_parametro%TYPE;
        LV_cod_moneda fa_conceptos.cod_moneda%TYPE;
        LN_cod_ciclfact fa_ciclfact.cod_ciclfact%TYPE;
        LD_fec_hastallam fa_ciclfact.fec_hastallam%TYPE;
        N_numooss ci_orserv.num_os%TYPE;

        error_ejecucion EXCEPTION;
        error_parametros EXCEPTION;
        error_pospago EXCEPTION;
        error_prepago EXCEPTION;

BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := '';
        SN_num_evento := 0;
        GV_sSql := '';

        -- Valida que la cantidad de minutos no sea cero, ni blanco.
        IF EN_valor_recarga = CV_null OR EN_valor_recarga < 1 THEN
                RAISE error_parametros;
        END IF;

        -- Obtenemos los datos del Cliente Origen
        IF NOT GA_Segmentacion_PG.GA_Origen_Cliente_FN
                (
                        EN_num_celular_origen, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion,
                        GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
                        GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min,
                        GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado, GN_cod_producto,
                        GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento
                )
        THEN
                RAISE error_ejecucion;
        END IF;

        -- Obtenemos los datos del Cliente Destino
        IF NOT GA_Segmentacion_PG.GA_Origen_Cliente_FN
                (
                        EN_num_celular_destino, LN_num_abonado, LN_cod_cliente,LV_nom_abocli, LV_cod_situacion,
                        LN_cod_cuenta, LV_cod_clave, LV_tip_plantarif, LV_cod_plantarif, LV_cod_tecnologia, LV_cod_perfil,
                        LN_cod_ciclo, LN_fono_contacto, LV_num_serie, LV_num_imei, LV_num_min_mdn, LV_num_min,
                        LV_num_seriehex, LV_num_seriemec, LV_tip_terminal, LV_tip_abonado, LV_cod_estado, LN_cod_producto,
                        LV_nom_responsable, LV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento
                )
        THEN
                RAISE error_ejecucion;
        END IF;

        -- Valida que abonado origen sea postpago o híbrido y que abonado destino sea prepago
        IF NOT (GV_tip_abonado = CN_abonado_pospago OR GV_tip_abonado = CN_abonado_hibrido) THEN
                RAISE  error_pospago;
        END IF;

        IF NOT LV_tip_abonado = CN_abonado_prepago THEN
                RAISE error_prepago;
        END IF;

        IF NOT GA_Segmentacion_PG.GA_Recupera_Parametros_FN
                (
                        'CONCEPTO_CARGA_SALDO', 'GA', CN_cod_producto, LV_cod_concepto, SN_cod_retorno, SV_mens_retorno,
                        SN_num_evento
                )
        THEN
                RAISE error_ejecucion;
        END IF;

        IF NOT GA_Rec_Cod_Moneda_FN(LV_cod_concepto, LV_cod_moneda, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                RAISE error_ejecucion;
        END IF;

        IF NOT GA_Recupera_Cicloperactual_FN(GN_cod_ciclo, LN_cod_ciclfact, LD_fec_hastallam, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                RAISE error_ejecucion;
        END IF;

        IF NOT GA_Carga_Minutos_Central_FN
                (
                        LN_num_abonado,LN_cod_cliente,EN_valor_recarga,LV_tip_terminal,EN_num_celular_destino,LV_num_serie,
                        LV_cod_tecnologia,SN_cod_retorno,SV_mens_retorno,SN_num_evento
                )
        THEN
                RAISE error_ejecucion;
        END IF;

        IF NOT GA_Inserta_Cargos_FN
                (
                        GN_cod_cliente,CN_cod_producto,GN_num_abonado,EN_num_celular_origen,SYSDATE,LN_cod_ciclfact,
                        LV_cod_concepto,EN_valor_recarga,LV_cod_moneda,USER,SN_cod_retorno,SV_mens_retorno,SN_num_evento
                )
        THEN
                RAISE error_ejecucion;
        END IF;

        IF NOT GA_Registra_Ooss_FN
                (
                        CV_cod_os_Pos_Pre, CN_cod_producto, GN_num_abonado, USER,
                        CV_comment_ci||EN_num_celular_origen||' fue: '||EN_valor_recarga, CV_null, CV_null, CV_null, CV_null,
                        CV_null, N_numooss, SN_cod_retorno, SV_mens_retorno, SN_num_evento
                )
        THEN
                RAISE error_ejecucion;
        END IF;

        COMMIT;

EXCEPTION
        WHEN error_parametros THEN
                SN_cod_retorno := 98;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                GV_des_error := 'GA_Carga_Prepago_A_Postpago_PR('||EN_num_celular_origen||','||EN_num_celular_destino||',';
                GV_des_error := GV_des_error ||EN_valor_recarga||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Carga_Prepago_A_Postpago_PR', GV_sSql, SQLCODE, GV_des_error
                        );
                ROLLBACK;

        WHEN error_ejecucion THEN
                GV_des_error := 'GA_Carga_Prepago_A_Postpago_PR('||EN_num_celular_origen||','||EN_num_celular_destino||',';
                GV_des_error := GV_des_error ||EN_valor_recarga||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Carga_Prepago_A_Postpago_PR', GV_sSql, SQLCODE, GV_des_error
                        );
                ROLLBACK;

        WHEN error_prepago THEN
                SN_cod_retorno := 408;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                GV_des_error := 'GA_Carga_Prepago_A_Postpago_PR('||EN_num_celular_origen||','||EN_num_celular_destino||',';
                GV_des_error := GV_des_error ||EN_valor_recarga||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Carga_Prepago_A_Postpago_PR', GV_sSql, SQLCODE, GV_des_error
                        );
                ROLLBACK;

        WHEN error_pospago THEN
                SN_cod_retorno := 409;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                GV_des_error := 'GA_Carga_Prepago_A_Postpago_PR('||EN_num_celular_origen||','||EN_num_celular_destino||',';
                GV_des_error := GV_des_error ||EN_valor_recarga||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Carga_Prepago_A_Postpago_PR', GV_sSql, SQLCODE, GV_des_error
                        );
                ROLLBACK;

        WHEN VALUE_ERROR THEN
                SN_cod_retorno := 303;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                GV_des_error := 'GA_Carga_Prepago_A_Postpago_PR('||EN_num_celular_origen||','||EN_num_celular_destino||',';
                GV_des_error := GV_des_error ||EN_valor_recarga||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Carga_Prepago_A_Postpago_PR', GV_sSql, SQLCODE, GV_des_error
                        );
                ROLLBACK;

        WHEN OTHERS THEN
                SN_cod_retorno := 302;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                GV_des_error := 'GA_Carga_Prepago_A_Postpago_PR('||EN_num_celular_origen||','||EN_num_celular_destino||',';
                GV_des_error := GV_des_error ||EN_valor_recarga||'); - ' || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Carga_Prepago_A_Postpago_PR', GV_sSql, SQLCODE, GV_des_error
                        );
                ROLLBACK;

END GA_Carga_Prepago_A_Postpago_PR;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Obtiene_Concepto_PorPlan_FN
(
        EN_cod_plan IN VARCHAR2,
        SN_cod_retorno OUT NOCOPY NUMBER
)
RETURN BOOLEAN
IS
LV_cod_concepto ged_parametros.val_parametro%TYPE;
BEGIN
-- Cuerpo de la funcion
-- 15-01-2007 11:14 O.V.T 36135
     SELECT TO_NUMBER(DES_VALOR)
     INTO SN_cod_retorno
     FROM GED_CODIGOS
     WHERE COD_VALOR = EN_cod_plan AND
            NOM_TABLA = 'EXTRA_TIEMPO' AND
           NOM_COLUMNA = 'BENEF_CONCEPTO' AND
           COD_MODULO = 'GA';
   RETURN TRUE;
EXCEPTION
   WHEN OTHERS THEN
   RETURN FALSE;
END GA_Obtiene_Concepto_PorPlan_FN;

-----------------------------------------------------------------------------------------------------------------
PROCEDURE GA_Extratiempo_Contrato_PR
(
        EN_num_celular IN NUMBER,
        EN_valor_recarga IN NUMBER,
        EN_cod_plan IN VARCHAR2,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER,
        EV_sis_origen IN VARCHAR2 DEFAULT 'XX' -- JGC MACOL-34287 25/09/2006 (Parametro opcional)
)
/*
<Documentación
 TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_Extratiempo_Contrato_PR"
      Lenguaje="PL/SQL"
      Fecha="15-06-2005"
      Versión="1.0"
      Diseñador=""Karem Fernandez Ayala"
      Programador="DIEGO MEJIAS"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Genera abono minutos para postpago o carga monto para híbrido
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EN_valor_recarga" Tipo="NUMERICO>Carga puede ser minutos o monto</param>
            <param nom="EN_cod_plan" Tipo="NUMERICO>Codigo de Plan</param>
            <param nom="EV_sis_origen" Tipo="VARCHAR>Sistema de Origen (IC u otro)</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO" >Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento" Tipo="NUMERICO" >Número de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

IS
        error_parametros EXCEPTION;
        error_control EXCEPTION;
        error_ejecucion EXCEPTION;
        LV_cod_oficina ge_oficinas.cod_oficina%TYPE;
        LV_cod_concepto ged_parametros.val_parametro%TYPE;
        LV_cod_conceptoplan ged_parametros.val_parametro%TYPE;
        N_cnt_minadic bpd_planes.cnt_minadic%TYPE; -- ahott RA-200603070877 05-05-2006
        N_mto_cargadic bpd_planes.mto_cargadic%TYPE;
        LV_tip_dcto bpd_planes.tip_dcto%TYPE;
        LV_cod_dcto bpd_planes.cod_dcto%TYPE;
        N_numooss ci_orserv.num_os%TYPE;
        LN_cod_ciclfact fa_ciclfact.cod_ciclfact%TYPE;
        LD_fec_hastallam fa_ciclfact.fec_hastallam%TYPE;
        LV_cod_moneda fa_conceptos.cod_moneda%TYPE;

        LN_mtomin_cargadic bpd_planes.mto_cargadic%TYPE; --RA-200602170800: German Espinoza Z; 02/05/2006
        LN_mto_cargadic bpd_planes.mto_cargadic%TYPE; -- ahott RA-200603070877 05-05-2006

        LV_cod_extradato ged_parametros.val_parametro%TYPE; --Inc. 72560|COL|05/11/2008|jjr.-
        LV_cod_tipo_plan ged_parametros.val_parametro%TYPE; --Inc. 72560|COL|05/11/2008|jjr.-

BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := '';
        SN_num_evento := 0;
        GV_sSql := '';

        -- Valida que la cantidad de minutos no sea cero, ni blanco.
        -- JGC MACOL-34287 25/09/2006
        --IF EN_valor_recarga = CV_null OR EN_valor_recarga < 1 THEN
        IF (EN_valor_recarga = CV_null OR EN_valor_recarga < 1) AND EV_sis_origen <> 'IC' THEN
        -- Fin JGC MACOL-34287 25/09/2006
                RAISE  error_parametros;
        END IF;

        IF NOT GA_Segmentacion_PG.GA_Origen_Cliente_FN
                (
                        EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta,
                        GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil, GN_cod_ciclo,
                        GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex,
                        GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado, GN_cod_producto,
                        GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento
                )
        THEN
                RAISE error_ejecucion;
        END IF;

        IF GV_tip_abonado = CN_abonado_pospago THEN

--        Inicio Inc.72560|COL|05/11/2008|jjr.-
                 IF NOT GA_Segmentacion_PG.GA_Recupera_Parametros_FN
                        (
                           'PLAN_EXTRADATOS', 'GA', CN_cod_producto, LV_cod_concepto, SN_cod_retorno, SV_mens_retorno,SN_num_evento
                        )
                 THEN
                        RAISE error_ejecucion;
                 END IF;

                LV_cod_extradato := LV_cod_concepto;

                 GA_Extra_Tiempo_PG.GA_Obtiene_tipo_Plan_PR(EN_cod_plan, LV_cod_tipo_plan);


                IF LV_cod_extradato = LV_cod_tipo_plan THEN
                    --OBTIENE CONCEPTO EXTRADATOS

                         IF NOT GA_Segmentacion_PG.GA_Recupera_Parametros_FN
                                (
                                        'CONCEPTO_EXTRADATOS', 'GA', CN_cod_producto, LV_cod_concepto, SN_cod_retorno, SV_mens_retorno,
                                        SN_num_evento
                                )
                        THEN
                                RAISE error_ejecucion;
                        END IF;


                ELSE
--        Fin Inc.72560|COL|05/11/2008|jjr.-

                        IF NOT GA_Segmentacion_PG.GA_Recupera_Parametros_FN
                                (
                                        'CONCEPTO_EXTRATIEMPO', 'GA', CN_cod_producto, LV_cod_concepto, SN_cod_retorno, SV_mens_retorno,
                                        SN_num_evento
                                )
                        THEN
                                RAISE error_ejecucion;
                        END IF;

                END IF; --Inc.72560|COL|05/11/2008|jjr.-

                -- 12-01-2007 15:42 O.V:T
                IF GA_Extra_Tiempo_PG.GA_Obtiene_Concepto_PorPlan_FN
                        (
                            EN_cod_plan,
                            LV_cod_conceptoplan
                        )
                THEN
                    LV_cod_concepto := LV_cod_conceptoplan;
                END IF;

                -- Fin anexo

                IF NOT GA_Rec_Cod_Moneda_FN(LV_cod_concepto, LV_cod_moneda, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                        RAISE error_ejecucion;
                END IF;

                -- Inicio Ahott RA-200603070877 05-05-2006
                --IF NOT GA_Rec_Plan_Beneficio_FN(EN_cod_plan, GV_tip_abonado, N_mto_cargadic, LV_tip_dcto, LV_cod_dcto, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                IF NOT GA_Rec_Plan_Beneficio_FN
                        (
                                EN_cod_plan, GV_tip_abonado, N_cnt_minadic, N_mto_cargadic, LV_tip_dcto, LV_cod_dcto, SN_cod_retorno,
                                SV_mens_retorno, SN_num_evento
                        )
                THEN
                -- Fin Ahott RA-200603070877 05-05-2006
                        RAISE error_ejecucion;
                END IF;

                LN_mtomin_cargadic:=N_cnt_minadic;--RA-200602170800: German Espinoza Z; 02/05/2006
                LN_mto_cargadic:=N_mto_cargadic; -- Ahott RA-200603070877 05-05-2006

                IF NOT GA_Recupera_Cicloperactual_FN(GN_cod_ciclo, LN_cod_ciclfact, LD_fec_hastallam, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                        RAISE error_ejecucion;
                END IF;

                IF NOT GA_Agrega_Plan_Tol_FN
                        (
                                GV_tip_abonado, LV_tip_dcto, LV_cod_dcto, GN_cod_cliente, GN_num_abonado, LD_fec_hastallam,
                                N_mto_cargadic, SN_cod_retorno, SV_mens_retorno, SN_num_evento
                        )
                THEN
                        RAISE error_ejecucion;
                END IF;

                -- Inicio Ahott RA-200603070877 05-05-2006
                --IF NOT GA_Inserta_Cargos_FN(GN_cod_cliente,CN_cod_producto,GN_num_abonado,EN_num_celular,SYSDATE,LN_cod_ciclfact,LV_cod_concepto,EN_valor_recarga,LV_cod_moneda,USER,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                IF NOT GA_Inserta_Cargos_FN
                        (
                                GN_cod_cliente,CN_cod_producto,GN_num_abonado,EN_num_celular,SYSDATE,LN_cod_ciclfact,LV_cod_concepto,
                                LN_mto_cargadic,LV_cod_moneda,USER,SN_cod_retorno,SV_mens_retorno,SN_num_evento
                        )
                THEN
                -- Fin Ahott RA-200603070877 05-05-2006
                        RAISE error_ejecucion;
                END IF;

                --RA-200602170800: German Espinoza Z; 02/05/2006
                --IF NOT GA_Registra_Ooss_FN(CV_cod_os_Pos_Hib, CN_cod_producto, GN_num_abonado, USER, CV_comment_ci_orv||EN_valor_recarga, CV_null, CV_null, CV_null, CV_null, CV_null, N_numooss, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                IF NOT GA_Registra_Ooss_FN
                        (
                                CV_cod_os_Pos_Hib, CN_cod_producto, GN_num_abonado, USER,
--                                'Minutos Contratados: '||LN_mtomin_cargadic||' - Codigo Extra Tiempo: '||EN_cod_plan, CV_null, --inc. 72560|COL|06/11/2008|jjr.-
                                'Unidades Contratadas: '||LN_mtomin_cargadic||' - Codigo Beneficio: '||EN_cod_plan, CV_null,     --inc. 72560|COL|06/11/2008|jjr.-
                                CV_null, CV_null, CV_null, CV_null, N_numooss, SN_cod_retorno, SV_mens_retorno, SN_num_evento
                        )
                THEN
                --FIN/RA-200602170800: German Espinoza Z; 02/05/2006
                        RAISE error_ejecucion;
                END IF;
        ELSIF GV_tip_abonado = CN_abonado_hibrido THEN

--        Inicio Inc.72560|COL|05/11/2008|jjr.-
                 IF NOT GA_Segmentacion_PG.GA_Recupera_Parametros_FN
                        (
                           'PLAN_EXTRADATOS', 'GA', CN_cod_producto, LV_cod_concepto, SN_cod_retorno, SV_mens_retorno,SN_num_evento
                        )
                 THEN
                        RAISE error_ejecucion;
                 END IF;

                LV_cod_extradato := LV_cod_concepto;

                 GA_Extra_Tiempo_PG.GA_Obtiene_tipo_Plan_PR(EN_cod_plan, LV_cod_tipo_plan);


                IF LV_cod_extradato = LV_cod_tipo_plan THEN
                    --OBTIENE CONCEPTO EXTRADATOS

                         IF NOT GA_Segmentacion_PG.GA_Recupera_Parametros_FN
                                (
                                        'CONCEPTO_EXTRADATOS', 'GA', CN_cod_producto, LV_cod_concepto, SN_cod_retorno, SV_mens_retorno,
                                        SN_num_evento
                                )
                        THEN
                                RAISE error_ejecucion;
                        END IF;


                ELSE
--        Fin Inc.72560|COL|05/11/2008|jjr.-

                        IF NOT GA_Segmentacion_PG.GA_Recupera_Parametros_FN
                                (
                                        'CONCEPTO_EXTRATIEMPO', 'GA', CN_cod_producto, LV_cod_concepto, SN_cod_retorno, SV_mens_retorno,
                                        SN_num_evento
                                )
                        THEN
                                RAISE error_ejecucion;
                        END IF;

                END IF; --Inc.72560|COL|05/11/2008|jjr.-

                IF NOT GA_Rec_Cod_Moneda_FN(LV_cod_concepto, LV_cod_moneda, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                        RAISE error_ejecucion;
                END IF;

                -- Inicio Ahott RA-200603070877 05-05-2006
                --IF NOT GA_Rec_Plan_Beneficio_FN(EN_cod_plan, GV_tip_abonado, N_mto_cargadic, LV_tip_dcto, LV_cod_dcto, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                IF NOT GA_Rec_Plan_Beneficio_FN
                        (
                                EN_cod_plan, GV_tip_abonado, N_cnt_minadic, N_mto_cargadic, LV_tip_dcto, LV_cod_dcto, SN_cod_retorno,
                                SV_mens_retorno, SN_num_evento
                        )
                THEN
                -- Fin Ahott RA-200603070877 05-05-2006
                        RAISE error_ejecucion;
                END IF;

                IF NOT GA_Recupera_Cicloperactual_FN(GN_cod_ciclo, LN_cod_ciclfact, LD_fec_hastallam, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                        RAISE error_ejecucion;
                END IF;

                IF NOT GA_Carga_Minutos_Central_FN
                        (
                                GN_num_abonado,GN_cod_cliente,N_mto_cargadic,GV_tip_terminal,EN_num_celular,GV_num_serie,
                                GV_cod_tecnologia,SN_cod_retorno,SV_mens_retorno,SN_num_evento
                        )
                THEN
                        RAISE error_ejecucion;
                END IF;

                IF NOT GA_Inserta_Cargos_FN
                        (
                                GN_cod_cliente,CN_cod_producto,GN_num_abonado,EN_num_celular,SYSDATE,LN_cod_ciclfact,LV_cod_concepto,
                                EN_valor_recarga,LV_cod_moneda,USER,SN_cod_retorno,SV_mens_retorno,SN_num_evento
                        )
                THEN
                        RAISE error_ejecucion;
                END IF;

                --RA-200602170800: German Espinoza Z; 02/05/2006
                --IF NOT GA_Registra_Ooss_FN(CV_cod_os_Pos_Hib, CN_cod_producto, GN_num_abonado, USER, CV_comment_ci_orv||N_mto_cargadic, CV_null, CV_null, CV_null, CV_null, CV_null, N_numooss, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      IF NOT GA_Registra_Ooss_FN
                        (
                                CV_cod_os_Pos_Hib, CN_cod_producto, GN_num_abonado, USER,
--                                'Monto Contratado: '||N_mto_cargadic||' - Codigo Extra Tiempo: '||EN_cod_plan, CV_null, CV_null, --inc. 72560|COL|06/11/2008|jjr.-
                            'Unidades Contratadas: '||N_mto_cargadic||' - Codigo Beneficio: '   ||EN_cod_plan, CV_null, CV_null,      --inc. 72560|COL|06/11/2008|jjr.-
                                CV_null, CV_null, CV_null, N_numooss, SN_cod_retorno, SV_mens_retorno, SN_num_evento
                        )
                THEN
                --FIN/RA-200602170800: German Espinoza Z; 02/05/2006
                        RAISE error_ejecucion;
                END IF;
        ELSE
                RAISE  error_control;
        END IF;

        COMMIT;

EXCEPTION
        WHEN error_parametros THEN
                SN_cod_retorno := 98;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                GV_des_error := 'GA_Extratiempo_Contrato_PR('||EN_num_celular||','||EN_valor_recarga||','||EN_cod_plan||'); - ';
                GV_des_error := GV_des_error || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Extratiempo_Contrato_PR', GV_sSql, SQLCODE, GV_des_error
                        );
                ROLLBACK;

        WHEN error_ejecucion THEN
                GV_des_error := 'GA_Extratiempo_Contrato_PR('||EN_num_celular||','||EN_valor_recarga||','||EN_cod_plan||'); - ';
                GV_des_error := GV_des_error || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Extratiempo_Contrato_PR', GV_sSql, SQLCODE, GV_des_error
                        );
                ROLLBACK;

        WHEN error_control THEN
                SN_cod_retorno := 318;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                GV_des_error := 'GA_Extratiempo_Contrato_PR('||EN_num_celular||','||EN_valor_recarga||','||EN_cod_plan||'); - ';
                GV_des_error := GV_des_error || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Extratiempo_Contrato_PR', GV_sSql, SQLCODE, GV_des_error
                        );
                ROLLBACK;

        WHEN VALUE_ERROR THEN
                SN_cod_retorno := 303;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                GV_des_error := 'GA_Extratiempo_Contrato_PR('||EN_num_celular||','||EN_valor_recarga||','||EN_cod_plan||'); - ';
                GV_des_error := GV_des_error || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Extratiempo_Contrato_PR', GV_sSql, SQLCODE, GV_des_error
                        );
                ROLLBACK;

        WHEN OTHERS THEN
                SN_cod_retorno := 302;
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                GV_des_error := 'GA_Extratiempo_Contrato_PR('||EN_num_celular||','||EN_valor_recarga||','||EN_cod_plan||'); - ';
                GV_des_error := GV_des_error || SQLERRM;
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER,
                                'GA_Extra_Tiempo_PG.GA_Extratiempo_Contrato_PR', GV_sSql, SQLCODE, GV_des_error
                        );
                ROLLBACK;
END GA_Extratiempo_Contrato_PR;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Obtiene_Prefijo_FN
(
        SV_Prefijox OUT NOCOPY VARCHAR2,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
)
RETURN BOOLEAN IS
/*
<Documentación
 TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_Obtiene_Prefijo_FN"
      Lenguaje="PL/SQL"
      Fecha="31-10-2005"
      Versión="1.0"
      Diseñador="Andrés Osorio Gallardo"
      Programador="Andrés Osorio Gallardo"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Extrae desde la base de datos el prefijo de los planes de extratiempo. Devuelve TRUE si se ejecuta con exito, FALSE en caso contrario</Descripción>
      <Parámetros>
         <Salida>
            <param nom="SV_Prefijox" Tipo="VARCHAR">Prefijo de los planes extratiempo</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR">Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Número de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
        N_codretorno ge_errores_td.cod_msgerror%TYPE;
        V_des_error GE_Errores_PG.DesEvent;
        sSql GE_Errores_PG.vQuery;
        V_val_parametro ged_parametros.val_parametro%TYPE;
        V_mens_retorno ge_errores_td.det_msgerror%TYPE;

BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := CV_null;
        SN_num_evento := 0;

        sSql := 'SELECT parametro.val_parametro';
        sSql := sSql || ' INTO SV_Prefijox';
        sSql := sSql || ' FROM ged_parametros parametro';
        sSql := sSql || ' WHERE parametro.nom_parametro = '''||'PREFIJO_EXTRATIEMPO'||'''';
        sSql := sSql || ' AND parametro.cod_modulo = '''||'GA'||'''';
        sSql := sSql || ' AND parametro.cod_producto =  1';

        SELECT
                parametro.val_parametro
        INTO
                SV_Prefijox
        FROM
               ged_parametros parametro
        WHERE
                parametro.nom_parametro = 'PREFIJO_EXTRATIEMPO'
        AND
                parametro.cod_modulo = 'GA'
        AND
                parametro.cod_producto =  1;

        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := '215';
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;
                V_des_error := SUBSTR('NO_DATA_FOUND: GA_Obtiene_Prefijo_FN(); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Valida_Prefijo_FN', sSql, SQLCODE, V_des_error
                        );
                RETURN  FALSE;

        WHEN OTHERS THEN
                SN_cod_retorno := '302';
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;
                V_des_error := SUBSTR('OTHERS: GA_Obtiene_Prefijo_FN(''); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Valida_Prefijo_FN', sSql, SQLCODE, V_des_error
                        );
                RETURN  FALSE;
END GA_Obtiene_Prefijo_FN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Valida_Prefijo_FN
(
        EV_cod_plan IN VARCHAR2,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
)
RETURN BOOLEAN IS
/*
<Documentación
 TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_Valida_Prefijo_FN"
      Lenguaje="PL/SQL"
      Fecha="26-10-2005"
      Versión="1.0"
      Diseñador="Andrés Osorio Gallardo"
      Programador="Andrés Osorio Gallardo"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Comprueba que el plan entregado contenga el prefijo correspondiente a los planes de
         extratiempo. Regresa falso al no contenerlo, verdadero si corresponde a un plan extratiempo</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_plan" Tipo="VARCHAR">Codigo de Plan</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR">Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Número de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
        error_prefijo EXCEPTION;
        error_obtencion_prefijo EXCEPTION;
        LV_prefijo_extratiempo VARCHAR2(4);
        N_codretorno ge_errores_td.cod_msgerror%TYPE;
        V_des_error GE_Errores_PG.DesEvent;
        sSql GE_Errores_PG.vQuery;
        V_val_parametro ged_parametros.val_parametro%TYPE;
        V_mens_retorno ge_errores_td.det_msgerror%TYPE;

BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := CV_null;
        SN_num_evento := 0;

        -- Se obtiene el prefijo que identifica a los planes de extratiempo
        IF NOT GA_Obtiene_Prefijo_FN(LV_prefijo_extratiempo,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                sSql := 'IF NOT GA_Obtiene_Prefijo_FN(LV_prefijo_extratiempo,SN_cod_retorno,';
                sSql := sSql ||'SV_mens_retorno,SN_num_evento)';
                RAISE error_obtencion_prefijo;
        END IF;

        -- Se verifica que el plan entregado contenga este prefijo en su dos primeras posiciones
        IF SUBSTR(EV_cod_plan,1,LENGTH(LV_prefijo_extratiempo)) != LV_prefijo_extratiempo THEN
                sSql := 'IF SUBSTR(EV_cod_plan,1,LENGTH(LV_prefijo_extratiempo)) != LV_prefijo_extratiempo';
                RAISE error_prefijo;
        END IF;

        RETURN TRUE;

EXCEPTION
        WHEN error_obtencion_prefijo THEN
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;
                V_des_error := SUBSTR('error_prefijo: GA_Valida_Prefijo_FN('||EV_cod_plan||'); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Valida_Prefijo_FN', sSql, SQLCODE, V_des_error
                        );
                RETURN  FALSE;

        WHEN error_prefijo THEN
                SN_cod_retorno := '526';
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;
                V_des_error := SUBSTR('error_prefijo: GA_Valida_Prefijo_FN('||EV_cod_plan||'); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Valida_Prefijo_FN', sSql, SQLCODE, V_des_error
                        );
                RETURN  FALSE;

        WHEN OTHERS THEN
                SN_cod_retorno := '302';
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;
                V_des_error := SUBSTR('OTHERS: GA_Valida_Prefijo_FN('||EV_cod_plan||'); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Valida_Prefijo_FN', sSql, SQLCODE, V_des_error
                        );
                RETURN  FALSE;
END GA_Valida_Prefijo_FN;

-----------------------------------------------------------------------------------------------------------------
function GA_Valida_Planex_FN
(
        EV_cod_plan IN VARCHAR2,
        SV_tip_dcto OUT NOCOPY VARCHAR2,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
)
RETURN BOOLEAN IS
/*
<Documentación
 TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_Valida_Planex_FN"
      Lenguaje="PL/SQL"
      Fecha="27-10-2005"
      Versión="1.0"
      Diseñador="Andrés Osorio Gallardo"
      Programador="Andrés Osorio Gallardo"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Comprueba que el plan entregado exista y de ser así entrega su Tipo de descuento,
         Entrega TRUE si el plan existe y no cumple con las condiciones mencionadas,
         entrega FALSE en caso contrario</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_plan" Tipo="VARCHAR">Codigo de Plan</param>
         </Entrada>
         <Salida>
            <param nom="SV_tip_dcto" Tipo="VARCHAR2">Tipo de Descuento del plan de extratiempo</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR">Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Número de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
        error_codplan EXCEPTION;
        LN_tip_dcto VARCHAR2(3);
        N_codretorno ge_errores_td.cod_msgerror%TYPE;
        V_des_error GE_Errores_PG.DesEvent;
        sSql GE_Errores_PG.vQuery;
        V_val_parametro ged_parametros.val_parametro%TYPE;
        V_mens_retorno ge_errores_td.det_msgerror%TYPE;

BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := CV_null;
        SN_num_evento := 0;

        sSql := 'SELECT planes.tip_dcto ';
        sSql := sSql ||' INTO SV_tip_dcto ' ;
        sSql := sSql ||' FROM bpd_planes planes ';
        sSql := sSql ||' WHERE planes.cod_plan = '''||EV_cod_plan||'''';

        SELECT
                planes.tip_dcto
        INTO
                SV_tip_dcto
        FROM
                bpd_planes planes
        WHERE
                planes.cod_plan = EV_cod_plan;

        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := '526';
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;
                V_des_error := SUBSTR('error_codplan: GA_Valida_Planex_FN('||EV_cod_plan||'); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Valida_Planex_FN', sSql, SQLCODE, V_des_error
                        );
                RETURN  FALSE;

        WHEN OTHERS THEN
                SN_cod_retorno := '302';
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;
                V_des_error := SUBSTR('OTHERS: GA_Valida_Planex_FN('||EV_cod_plan||'); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Valida_Planex_FN', sSql, SQLCODE, V_des_error
                        );
                RETURN  FALSE;
END GA_Valida_Planex_FN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Minutos_Extra_FN
(
        EN_tip_dcto IN VARCHAR2,
        EV_cod_plan IN VARCHAR2,
        EN_cod_cliente IN ga_abocel.cod_cliente%TYPE,
        EN_num_abonado IN NUMBER,
        EN_cod_ciclo IN ga_abocel.cod_ciclo%TYPE,
        SN_val_mintotal OUT NUMBER,
        SN_val_usado OUT NUMBER,
        SN_val_disponible OUT NUMBER,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
)
RETURN BOOLEAN IS
/*
<Documentación
 TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_Minutos_Extra_FN"
      Lenguaje="PL/SQL"
      Fecha="26-10-2005"
      Versión="1.0"
      Diseñador="Andrés Osorio Gallardo"
      Programador="Andrés Osorio Gallardo"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera los minutos totales, usados y disponibles de un abonado para un plan de extratiempo
         especifico. Regresa verdadero si se ejecuto conexito, falso en caso contrario</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_tip_dcto" Tipo="VARCHAR2">Tipo de descuento del plan de extratiempo</param>
            <param nom="EV_cod_plan" Tipo="VARCHAR">Codigo de Plan</param>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Numero de cliente realizando la consulta de extratiempo</param>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>
            <param nom="EN_cod_ciclo" Tipo="NUMERICO">Numero del ciclo de facturacion del abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_val_mintotal" Tipo="NUMERICO">Cantidad de Minutos de Extratiempo contratado</param>
            <param nom="SN_val_usado" Tipo="NUMERICO">Cantidad de Minutos Usados en extratiempo</param>
            <param nom="SN_val_disponible" Tipo="NUMERICO">Cantidad de Minutos disponible en extratiempo</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR">Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Número de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
        N_codretorno ge_errores_td.cod_msgerror%TYPE;
        V_des_error GE_Errores_PG.DesEvent;
        sSql GE_Errores_PG.vQuery;
        V_val_parametro ged_parametros.val_parametro%TYPE;
        V_mens_retorno ge_errores_td.det_msgerror%TYPE;

BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := CV_null;
        SN_num_evento := 0;

        /* Inicio modificacion by SAQL/Soporte 17/03/2006 - RA-200603140913 */
        /* sSql := 'SELECT a.val_disponible_total + a.val_consumido_total AS val_contratado_total, val_consumido_total, val_disponible_total' */
        sSql := 'SELECT a.val_consumido_total, a.val_disponible_total, a.val_contratado_total';
        /* Fin modificacion by SAQL/Soporte 17/03/2006 - RA-200603140913 */
        sSql := sSql ||' INTO SN_val_mintotal, SN_val_usado, SN_val_disponible' ;
        sSql := sSql ||' FROM tol_cliedcto_det a';
        sSql := sSql ||' WHERE a.cod_abonado = EN_num_abonado';
        sSql := sSql ||' AND a.tip_dcto = EN_tip_dcto';
        sSql := sSql ||' AND a.cod_dcto = EV_cod_plan';
        sSql := sSql ||' AND a.cod_cliente = EN_cod_cliente' ;
        sSql := sSql ||' AND a.cod_ciclo = EN_cod_ciclo';

        /* Inicio modificacion by SAQL/Soporte 17/03/2006 - RA-200603140913 */
        /*
        SELECT a.val_disponible_total + a.val_consumido_total AS val_contratado_total, val_consumido_total, val_disponible_total
        INTO   SN_val_mintotal, SN_val_usado, SN_val_disponible
        FROM   tol_cliedcto_det a
        WHERE  a.cod_abonado = EN_num_abonado
        AND    a.tip_dcto = EN_tip_dcto
        AND    a.cod_dcto = EV_cod_plan
        AND    a.cod_cliente = EN_cod_cliente
        AND    a.cod_ciclo = EN_cod_ciclo;
        */
        /*  Fin modificacion by SAQL/Soporte 17/03/2006 - RA-200603140913 */

        SELECT
                NVL(SUM(a.val_consumido_total),0) val_consumido_total,
                NVL(SUM(a.val_disponible_total),0) val_disponible_total,
                NVL(SUM(a.val_contratado_total),0) val_contratado_total
        INTO
                SN_val_mintotal, SN_val_usado, SN_val_disponible
        FROM
                tol_cliedcto_det A, tol_cliedcto_to B
        WHERE
                A.tip_dcto = B.tip_dcto
                AND A.cod_dcto = B.cod_dcto
                AND A.cod_cliente = B.cod_cliente
                AND SYSDATE BETWEEN B.fec_ini_vig AND B.fec_ter_vig
                AND b.fec_ini_vig=a.fec_ini_vig --COL-35849|06-12-2006|GEZ
                AND A.cod_abonado = EN_num_abonado
                AND A.tip_dcto = EN_tip_dcto
                AND A.cod_dcto = EV_cod_plan
                AND A.cod_cliente = EN_cod_cliente
                AND A.cod_ciclo = EN_cod_ciclo;
                RETURN TRUE;

        if SN_val_mintotal = 0  then
                  select
                0 val_consumido_total,
                  a.cnt_valor val_disponible_total,
               a.cnt_valor  val_contratado_total
               INTO
                SN_val_mintotal, SN_val_usado, SN_val_disponible
               from tol_detdescuento_td a, tol_cliedcto_to b
               where  a.cod_dcto = b.cod_dcto
               and b.cod_cliente = EN_cod_cliente
               AND SYSDATE BETWEEN B.fec_ini_vig AND B.fec_ter_vig
               and a.COD_DCTO = EV_cod_plan
               and a.tip_dcto = EN_tip_dcto
               and rownum = 1;

        end if;

EXCEPTION

        WHEN NO_DATA_FOUND THEN
                SN_val_mintotal := 0;
                SN_val_usado := 0;
                SN_val_disponible := 0;
                RETURN  TRUE;

        WHEN OTHERS THEN
                SN_cod_retorno := '302';
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;
                V_des_error := SUBSTR('OTHERS: GA_Minutos_Extra_FN('||EN_num_abonado||','||EV_cod_plan||'); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Minutos_Extra_FN', sSql, SQLCODE, V_des_error
                        );
                RETURN  FALSE;
END GA_Minutos_Extra_FN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Minutos_Bolsa_FN
(
        EN_cod_ciclfact IN tol_acumbolsa_gral.fec_tasa%TYPE,
        EN_num_abonado IN NUMBER,
        SN_usado_bolsa OUT NUMBER,
        SN_disponible_bolsa OUT NUMBER,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
)
RETURN BOOLEAN IS
/*
<Documentación
 TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_Minutos_Bolsa_FN"
      Lenguaje="PL/SQL"
      Fecha="28-10-2005"
      Versión="1.0"
      Diseñador="Andrés Osorio Gallardo"
      Programador="Andrés Osorio Gallardo"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera los minutos totales, usados y disponibles de un abonado en su correspondiente bolsa.
         Regresa verdadero si se ejecuto conexito, falso en caso contrario</Descripción>
      <Parámetros>
         <Entrada>*//*
            <param nom="EN_cod_ciclfact Tipo="VARCHAR2">Codigo de ciclo de facturacion</param>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_val_usado_BOLSA" Tipo="NUMERICO">Cantidad de Minutos Usados en bolsa</param>
            <param nom="SN_val_disponible_BOLSA" Tipo="NUMERICO">Cantidad de Minutos disponible en bolsa</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR">Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Número de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
        N_codretorno ge_errores_td.cod_msgerror%TYPE;
        V_des_error GE_Errores_PG.DesEvent;
        sSql GE_Errores_PG.vQuery;
        V_val_parametro ged_parametros.val_parametro%TYPE;
        V_mens_retorno ge_errores_td.det_msgerror%TYPE;

        --INI COL-35849|06-12-2006|GEZ
        LN_NUMABONADO         GA_ABOCEL.NUM_ABONADO%TYPE;
        LN_CODCLIENTE         GA_ABOCEL.COD_CLIENTE%TYPE;
        LN_CODCICLO           GA_ABOCEL.COD_CICLO%TYPE;
        LV_CODPLAN            GA_ABOCEL.COD_PLANTARIF%TYPE;
        --FIN COL-35849|06-12-2006|GEZ

BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := CV_null;
        SN_num_evento := 0;

        --INI COL-35849|06-12-2006|GEZ

        /*
        sSql := 'SELECT SUM(bolsa.val_consumido), SUM(bolsa.val_disponible)';
        sSql := sSql ||' INTO SN_usado_bolsa, SN_disponible_bolsa';
        sSql := sSql ||' FROM tol_acumbolsa_gral bolsa';
        sSql := sSql ||' WHERE bolsa.fec_tasa ='|| EN_cod_ciclfact;
        sSql := sSql ||' AND bolsa.cod_abonado ='|| EN_num_abonado;

        SELECT
                SUM(bolsa.val_consumido), SUM(bolsa.val_disponible)
        INTO
                SN_usado_bolsa, SN_disponible_bolsa
        FROM
                tol_acumbolsa_gral bolsa
        WHERE
                bolsa.fec_tasa = EN_cod_ciclfact
                AND bolsa.cod_abonado = EN_num_abonado;
        */

        BEGIN

              sSql := 'SELECT';
              sSql := sSql || ' COD_CLIENTE, COD_CICLO, COD_PLANTARIF';
              sSql := sSql || ' DECODE(TIP_PLANTARIF, ''I'', EN_num_abonado, ''E'', 0)';
              sSql := sSql || ' INTO LN_CODCLIENTE, LN_CODCICLO, LV_CODPLAN, LN_NUMABONADO';
              sSql := sSql || ' FROM GA_ABOCEL';
              sSql := sSql || ' WHERE NUM_ABONADO = ' || EN_num_abonado;

              SELECT COD_CLIENTE,COD_CICLO,COD_PLANTARIF,DECODE(TIP_PLANTARIF, 'I', EN_num_abonado, 'E', 0)
              INTO     LN_CODCLIENTE,LN_CODCICLO,LV_CODPLAN,LN_NUMABONADO
              FROM   GA_ABOCEL
              WHERE  NUM_ABONADO = EN_num_abonado;

              IF  (LN_CODCLIENTE IS NULL) OR (LN_CODCICLO IS NULL) OR (LN_NUMABONADO IS NULL) THEN
                    SN_cod_retorno := '203';

                    IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                            SV_mens_retorno := CV_error_no_clasIF;
                    END  IF;

                    V_des_error := SUBSTR('NULL: GA_Minutos_Bolsa_FN('||EN_num_abonado||'); - ' || SQLERRM,1,CN_largoerrtec);
                    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                    SN_num_evento := GE_Errores_PG.GrabarPL(SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                                             'GA_Extratiempo_PG.GA_Minutos_Bolsa_FN', sSql, SQLCODE, V_des_error);

                    RETURN  FALSE;

              END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := '218';

                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;

                V_des_error := SUBSTR('NO_DATA_FOUND: GA_Minutos_Bolsa_FN('||EN_num_abonado||'); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL(SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                                         'GA_Extratiempo_PG.GA_Minutos_Bolsa_FN', sSql, SQLCODE, V_des_error);

                RETURN  FALSE;

        END;

        sSql :=        ' SELECT SUM(val_consumido),SUM(val_disponible)';
        sSql := sSql ||' FROM   tol_acumbolsa_gral ';
        sSql := sSql ||' WHERE  cod_cliente = '||LN_CODCLIENTE;
        sSql := sSql ||' AND    cod_abonado = '||LN_NUMABONADO;
        sSql := sSql ||' AND    cod_ciclo = '||LN_CODCICLO;
        sSql := sSql ||' AND    fec_tasa = '||EN_cod_ciclfact;
        sSql := sSql ||' AND    cod_plan = '''||LV_CODPLAN||'''';

        SELECT SUM(val_consumido),SUM(val_disponible)
        INTO   SN_usado_bolsa,SN_disponible_bolsa
        FROM   tol_acumbolsa_gral
        WHERE  cod_cliente = LN_CODCLIENTE
        AND    cod_abonado = LN_NUMABONADO
        AND    cod_ciclo = LN_CODCICLO
        AND    fec_tasa = EN_cod_ciclfact
        AND    cod_plan = LV_CODPLAN;

        --FIN COL-35849|06-12-2006|GEZ

        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_usado_bolsa := 0;
                SN_disponible_bolsa := 0;
                RETURN  TRUE;

        WHEN OTHERS THEN
                SN_cod_retorno := '302';

                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;

                V_des_error := SUBSTR('OTHERS: GA_Minutos_Bolsa_FN('||EN_num_abonado||'); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Minutos_Bolsa_FN', sSql, SQLCODE, V_des_error
                        );
                RETURN  FALSE;
END GA_Minutos_Bolsa_FN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Obtiene_Datos_Tol_FN
(
        EN_tip_dcto IN VARCHAR2,
        EV_cod_plan IN VARCHAR2,
        EN_cod_cliente IN ga_abocel.cod_cliente%TYPE,
        EN_num_abonado IN NUMBER,
        EN_cod_ciclo IN ga_abocel.cod_ciclo%TYPE,
        EN_cod_ciclfact IN tol_acumbolsa_gral.fec_tasa%TYPE,
        SN_val_mintotal OUT NUMBER,
        SN_val_usado OUT NUMBER,
        SN_val_disponible OUT NUMBER,
        SN_usado_bolsa OUT NUMBER,
        SN_disponible_bolsa OUT NUMBER,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
)
RETURN BOOLEAN IS
/*
<Documentación
 TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_Obtiene_Datos_Tol_FN"
      Lenguaje="PL/SQL"
      Fecha="27-10-2005"
      Versión="1.0"
      Diseñador="Andrés Osorio Gallardo"
      Programador="Andrés Osorio Gallardo"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Realiza la consulta en la vistas materializadas de tol por los datos en minutos de los extratiempos contratados
         por un abonado. Regresa verdadero si se ejecuto con exito, falso en caso contrario</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_tip_dcto" Tipo="VARCHAR2">Tipo de descuento del plan de extratiempo</param>
            <param nom="EV_cod_plan" Tipo="VARCHAR">Codigo de Plan</param>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Numero de cliente realizando la consulta de extratiempo</param>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>
            <param nom="EN_cod_ciclo" Tipo="NUMERICO">Numero del ciclo del abonado</param>
            <param nom="EN_cod_ciclfact Tipo="VARCHAR2">Numero del ciclo de facturacion del abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_val_mintotal" Tipo="NUMERICO">Cantidad de Minutos de Extratiempo contratado</param>
            <param nom="SN_val_usado" Tipo="NUMERICO">Cantidad de Minutos Usados en extratiempo</param>
            <param nom="SN_val_disponible" Tipo="NUMERICO">Cantidad de Minutos disponible en extratiempo</param>
            <param nom="SN_usado_bolsa" Tipo="NUMERICO">Cantidad de Minutos Usados en bolsa</param>
            <param nom="SN_disponible_bolsa" Tipo="NUMERICO">Cantidad de Minutos Disponibles en bolsa</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR">Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Número de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
        error_consulta EXCEPTION;
        N_codretorno ge_errores_td.cod_msgerror%TYPE;
        V_des_error GE_Errores_PG.DesEvent;
        sSql GE_Errores_PG.vQuery;
        V_val_parametro ged_parametros.val_parametro%TYPE;
        V_mens_retorno ge_errores_td.det_msgerror%TYPE;

BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := CV_null;
        SN_num_evento := 0;

        -- Se obtienen los minutos totales, consumidos y dispopnibles del plan de extratiempo
        IF NOT GA_Minutos_Extra_FN(EN_tip_dcto,EV_cod_plan,EN_cod_cliente,EN_num_abonado,EN_cod_ciclo,SN_val_mintotal,SN_val_usado,SN_val_disponible,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                sSql := 'IF NOT GA_Minutos_Extra_FN(EN_num_abonado,EV_cod_plan,SN_val_mintotal,SN_val_usado,';
                sSql := sSql || 'SN_val_disponible,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                RAISE error_consulta;
        END IF;

        -- Se obtienen los minutos consumidos y dispopnibles en bolsa para el abonado y un plan
        IF NOT GA_Minutos_Bolsa_FN
                (
                        EN_cod_ciclfact,EN_num_abonado,SN_usado_bolsa,SN_disponible_bolsa,SN_cod_retorno,SV_mens_retorno,
                        SN_num_evento
                )
        THEN
                sSql := 'IF NOT GA_Minutos_Bolsa_FN(EN_num_abonado,SN_usado_bolsa,SN_disponible_bolsa,SN_cod_retorno,';
                sSql := sSql || 'SV_mens_retorno,SN_num_evento)';
                RAISE error_consulta;
        END IF;

        RETURN TRUE;

EXCEPTION
        WHEN error_consulta THEN
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;
                V_des_error := SUBSTR('Error_Consulta: GA_Extratiempo_Consulta_PR('||EN_num_abonado||','||EV_cod_plan||'); - '|| SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Extratiempo_Consulta_PR', sSql, SQLCODE, V_des_error
                        );
                RETURN FALSE;

        WHEN OTHERS THEN
                SN_cod_retorno := '302';
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;
                V_des_error := SUBSTR('OTHERS: GA_Valida_Planex_FN('||EN_num_abonado||','||EV_cod_plan||'); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Extratiempo_Consulta_PR', sSql, SQLCODE, V_des_error
                        );
                RETURN FALSE;
END GA_Obtiene_Datos_Tol_FN;

-----------------------------------------------------------------------------------------------------------------
PROCEDURE GA_Extratiempo_Consulta_PR
(
        EN_num_celular IN NUMBER,
        EV_cod_plan IN VARCHAR2,
        EN_ind_registro IN BOOLEAN DEFAULT TRUE,
        SN_val_mintotal OUT NUMBER,
        SN_val_usado OUT NUMBER,
        SN_val_disponible OUT NUMBER,
        SN_usado_bolsa OUT NUMBER,
        SN_disponible_bolsa OUT NUMBER,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
)
IS
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_Extratiempo_Consulta_PR"
      Lenguaje="PL/SQL"
      Fecha="24-10-2005"
      Versión="1.0"
      Diseñador="Andrés Osorio Gallardo"
      Programador="Andrés Osorio Gallardo"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Retorna los valores en minutos del abonado, en cuanto a su saldo de extratimepo, asi como el valor total del
         contrato y lo consumido.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EV_cod_plan" Tipo="VARCHAR">Codigo de Plan</param>
            <param nom="EN_ind_registro" Tipo="BOOLEAN">Indicador de Registro, señala si se debe registar la consulta en SAC</param>
         </Entrada>
         <Salida>
            <param nom="SN_val_mintotal" Tipo="NUMERICO">Cantidad de Minutos de Extratiempo contratado</param>
            <param nom="SN_val_usado" Tipo="NUMERICO">Cantidad de Minutos Usados en extratiempo</param>
            <param nom="SN_val_disponible" Tipo="NUMERICO">Cantidad de Minutos disponible en extratiempo</param>
            <param nom="SN_usado_bolsa" Tipo="NUMERICO">Cantidad de Minutos Usados en bolsa</param>
            <param nom="SN_disponible_bolsa" Tipo="NUMERICO">Cantidad de Minutos Disponibles en bolsa</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR">Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Número de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
        error_validacion EXCEPTION;
        error_consulta EXCEPTION;
        error_registro EXCEPTION;
        error_situacion EXCEPTION;
        N_codretorno ge_errores_td.cod_msgerror%TYPE;
        V_des_error GE_Errores_PG.DesEvent;
        sSql GE_Errores_PG.vQuery;
        V_val_parametro ged_parametros.val_parametro%TYPE;
        V_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_tip_dcto bpd_planes.tip_dcto%TYPE;
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LN_cod_cliente ga_abocel.cod_cliente%TYPE;
        LN_cod_producto ga_abocel.cod_producto%TYPE;
        LV_cod_situacion ga_abocel.cod_situacion%TYPE;
        LV_tip_plantarif ga_abocel.tip_plantarif%TYPE;
        LV_cod_plantarif ga_abocel.cod_plantarif%TYPE;
        LV_num_serie ga_abocel.num_serie%TYPE;
        LN_cod_ciclo ga_abocel.cod_ciclo%TYPE;
        LN_cod_ciclfact tol_acumbolsa_gral.fec_tasa%TYPE;
        LV_tecnologia ga_abocel.cod_tecnologia%TYPE;
        LV_num_imei ga_abocel.num_imei%TYPE;
        LV_num_min_mdn ga_abocel.num_min_mdn%TYPE;
        LV_cod_password ga_abocel.cod_password%TYPE;
        LV_num_min  ga_abocel.num_min%TYPE;
        LV_tip_terminal ga_abocel.tip_terminal%TYPE;
        LV_num_seriehex ga_abocel.num_seriehex%TYPE;
        LV_num_seriemec ga_abocel.num_seriemec%TYPE;
        LV_tipo_abonado VARCHAR2(8);
        LN_cod_cuenta ga_abocel.cod_cuenta%TYPE;
        LN_cod_atencion NUMBER(3):= 525; -- Codigo de Atencion en SAC
        CV_param_usuario CONSTANT ged_parametros.nom_parametro%TYPE:='USUARIO_SERV_PL_SQL';
        LV_usuario ged_parametros.val_parametro%TYPE;
        CN_cod_producto CONSTANT NUMBER(1):=1;
BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := CV_null;
        SN_num_evento := 0;

        -- Se valida Largo del celular
        IF NOT GE_Validaciones_PG.GE_Valida_Num_Celular_FN(EN_num_celular, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                sSql := 'IF NOT GE_Validaciones_PG.GE_Valida_Num_Celular_FN('||EN_num_celular||', SN_cod_retorno,';
                sSql := sSql || 'SV_mens_retorno, SN_num_evento)';
                RAISE error_validacion;
        END IF;

        -- Se Verifica que Abonado no se encuentre BAA
        IF GE_Validaciones_PG.GE_Valida_Situacion_Abo_FN(EN_num_celular, 'BAA', SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                SN_cod_retorno := '323';
                sSql := 'IF NOT GE_Validaciones_PG.GE_Valida_Situacion_Abo_FN('||EN_num_celular||', BAA, SN_cod_retorno,';
                sSql := sSql || 'SV_mens_retorno, SN_num_evento)';
                RAISE error_situacion;
        ELSE
                IF (SN_cod_retorno != 0) THEN
                        sSql := 'IF NOT GE_Validaciones_PG.GE_Valida_Situacion_Abo_FN('||EN_num_celular||', BAA, SN_cod_retorno,';
                        sSql := sSql || 'SV_mens_retorno, SN_num_evento)';
                        RAISE error_situacion;
                END IF;
        END IF;

        -- Se Verifica que Abonado no se encuentre BAP
        IF GE_Validaciones_PG.GE_Valida_Situacion_Abo_FN(EN_num_celular, 'BAP', SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                SN_cod_retorno := '323';
                sSql := 'IF NOT GE_Validaciones_PG.GE_Valida_Situacion_Abo_FN('||EN_num_celular||', BAP, SN_cod_retorno, ';
                sSql := sSql || 'SV_mens_retorno, SN_num_evento)';
                RAISE error_situacion;
        ELSE
                IF (SN_cod_retorno != 0) THEN
                        sSql := 'IF NOT GE_Validaciones_PG.GE_Valida_Situacion_Abo_FN('||EN_num_celular||', BAP, SN_cod_retorno,';
                        sSql := sSql || 'SV_mens_retorno, SN_num_evento)';
                        RAISE error_situacion;
                END IF;
        END IF;

        -- Se verifica que el plan sea de extratiempo a través de su prefijo
        IF NOT GA_Valida_Prefijo_FN(EV_cod_plan, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                sSql := 'IF NOT GA_Valida_Prefijo_FN('||EV_cod_plan||', SN_cod_retorno, SV_mens_retorno, SN_num_evento)';
                RAISE error_validacion;
        END IF;

        -- Se verifica la existencia del plan
        IF NOT GA_Valida_Planex_FN(EV_cod_plan,LN_tip_dcto, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                sSql := 'IF NOT GA_Valida_Planex_FN('||EV_cod_plan||', SN_cod_retorno, SV_mens_retorno, SN_num_evento)';
                RAISE error_validacion;
        END IF;

        -- Se obtienen los datos del abonado
        GA_Consultas_PG.GA_Consulta_Abonado_PR
                (
                        EN_num_celular,LN_num_abonado,LN_cod_cliente,LN_cod_producto,LV_cod_situacion,LV_tip_plantarif,
                        LV_cod_plantarif,LV_num_serie,LN_cod_ciclo,LV_tecnologia,LV_num_imei,LV_num_min_mdn,LV_cod_password,
                        LV_num_min,LV_tip_terminal,LV_num_seriehex,LV_num_seriemec,LV_tipo_abonado,LN_cod_cuenta,
                        SN_cod_retorno,SV_mens_retorno,SN_num_evento
                );

        IF SN_cod_retorno != 0  THEN
                sSql := 'GA_Consultas_PG.GA_Consulta_Abonado_PR('||EN_num_celular||',LN_num_abonado,LN_cod_cliente,';
                sSql := sSql || 'LN_cod_producto,LV_cod_situacion,LV_tip_plantarif,LV_cod_plantarif,LV_num_serie,LN_cod_ciclo,';
                sSql := sSql || 'LV_tecnologia,LV_num_imei,LV_num_min_mdn,LV_cod_password,LV_num_min,LV_tip_terminal,LV_num_seriehex,';
                sSql := sSql || 'LV_num_seriemec,LV_tipo_abonado,LN_cod_cuenta,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                RAISE error_validacion;
        END IF;

        -- Se obtiene el Codigo de Ciclo de Facturacion
        IF NOT GE_Validaciones_PG.GE_Obtiene_CicloFact_FN (LN_cod_ciclo,LN_cod_ciclfact,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                sSql := 'IF NOT GE_Obtiene_CicloFact_FN ('||LN_cod_ciclo||',SN_cod_ciclfact,SN_cod_retorno,SV_mens_retorno,';
                sSql := sSql || 'SN_num_evento)';
                RAISE error_validacion;
        END IF;

        -- Si el abonado no es pospago se aborta la consulta
        IF LV_tipo_abonado <> CV_postpago then
                sSql := 'IF '||LV_tipo_abonado||' <> '||CV_postpago;
                SN_cod_retorno := '156';
                RAISE error_validacion;
        END IF;

        -- Se obtienen los datos desde una vista materializada de TOL
        IF NOT GA_Obtiene_Datos_Tol_FN
                (
                        LN_tip_dcto,EV_cod_plan,LN_cod_cliente,LN_num_abonado,LN_cod_ciclo,LN_cod_ciclfact,SN_val_mintotal,
                        SN_val_usado,SN_val_disponible,SN_usado_bolsa,SN_disponible_bolsa,SN_cod_retorno,SV_mens_retorno,
                        SN_num_evento
                )
        THEN
                sSql := 'IF NOT GA_Obtiene_Datos_Tol_FN('||LN_num_abonado||','||EV_cod_plan||',SN_val_mintotal,SN_val_usado,';
                sSql := sSql || 'SN_val_disponible,SN_usado_bolsa,SN_disponible_bolsa,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                RAISE error_consulta;
        END IF;

        -- Se registra la Atencion en SAC si EN_ind_registro posee el valor TRUE
        IF EN_ind_registro THEN
                -- Registro de atención del Cliente
                LV_usuario:= CV_null;
                sSql:='GE_Validaciones_PG.GE_Obtiene_GedParametros_FN('||CV_param_usuario||','||'GE'||','||CN_cod_producto||');';
                IF NOT GE_Validaciones_PG.GE_Obtiene_GedParametros_FN(CV_param_usuario,'GE',CN_cod_producto,LV_usuario,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                        SN_cod_retorno:=215;
                        RAISE  error_registro;
                END IF;
                GA_Segmentacion_PG.ga_reg_atencion_cliente_pr(EN_num_celular, LN_cod_atencion, CV_mens_atendido, LV_usuario, SN_cod_retorno , SV_mens_retorno, SN_num_evento );
                IF SN_cod_retorno <> 0 THEN
                        RAISE error_registro;
                END IF;
        END IF;

EXCEPTION
        WHEN error_validacion THEN
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;
                V_des_error := SUBSTR('error_validacion: GA_Extratiempo_Consulta_PR('||EN_num_celular||','||EV_cod_plan||'); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Extratiempo_Consulta_PR', sSql, SQLCODE, V_des_error
                        );

        WHEN error_situacion THEN
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;
                V_des_error := SUBSTR('error_situacion: GA_Extratiempo_Consulta_PR('||EN_num_celular||','||EV_cod_plan||'); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Extratiempo_Consulta_PR', sSql, SQLCODE, V_des_error
                        );
        WHEN error_consulta THEN
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;
                V_des_error := SUBSTR('error_consulta: GA_Extratiempo_Consulta_PR('||EN_num_celular||','||EV_cod_plan||'); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Extratiempo_Consulta_PR', sSql, SQLCODE, V_des_error
                        );

        WHEN error_registro THEN
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;
                V_des_error := SUBSTR('error_registro: GA_Extratiempo_Consulta_PR('||EN_num_celular||','||EV_cod_plan||'); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Extratiempo_Consulta_PR', sSql, SQLCODE, V_des_error
                        );

        WHEN OTHERS THEN
                SN_cod_retorno := '302';
                IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                END  IF;
                V_des_error := SUBSTR('OTHERS: GA_Valida_Planex_FN('||EN_num_celular||','||EV_cod_plan||'); - ' || SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := GE_Errores_PG.GrabarPL
                        (
                                SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                                'GA_Extratiempo_PG.GA_Extratiempo_Consulta_PR', sSql, SQLCODE, V_des_error
                        );
END GA_Extratiempo_Consulta_PR;

-----------------------------------------------------------------------------------------------------------------
END GA_Extra_Tiempo_PG;
/
SHOW ERRORS
