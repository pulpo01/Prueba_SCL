CREATE OR REPLACE PACKAGE BODY IC_PARAMPROVISION_PG AS

/*
<NOMBRE>       : IC_PARAMPROVISION_PG</NOMBRE>
<FECHACREA>    : <FECHACREA/>
<MODULO >      : IC</MODULO >
<AUTOR >       : Carlos Sellao H.</AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Parametros Interfaz con Centrales para Generacion de comandos</DESCRIPCION>
<FECHAMOD >    : </FECHAMOD>
<DESCMOD >     : </DESCMOD>
*/


PROCEDURE IC_DATAIPFIJA_PR(
                           EN_num_mov      IN  icc_movimiento.num_movimiento%TYPE,
                           EN_ind_estado   IN  ga_servsuplabo.ind_estado%TYPE,
                           SV_cad_ip       OUT NOCOPY varchar2,
                           SV_cad_apn      OUT NOCOPY varchar2,
                           SV_cad_qosid    OUT NOCOPY varchar2,
                           SN_COD_RETORNO  OUT NOCOPY ge_errores_pg.coderror,
                           SV_MENS_RETORNO OUT NOCOPY ge_errores_pg.msgerror,
                           SN_NUM_EVENTO   OUT NOCOPY ge_errores_pg.evento
                           ) IS
/*
<Documentación
        TipoDoc = "Procedure">
        <Elemento
                Nombre = "IC_DATAIPFIJA_PR"
                Lenguaje="PL/SQL"
                Fecha creación="05-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Procedure para identificar los datos de IP fija.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                                <param nom="EN_ind_estado" Tipo="NUMERICO">Indicador de Estado en ga_servsuplabo</param>
                        </Entrada>
                        <Salida>
                                <param nom="SV_cad_ip" Tipo="STRING">Cadena con numeros ip.</param>
                                <param nom="SV_cad_apn" Tipo="STRING">Cadena con apn's</param>
                                <param nom="SV_cad_qosid" Tipo="STRING">Cadena con qosid's</param>
                                <param nom="SN_cod_retorno" Tipo="NUMERICO" Descripcion ="Codigo de error de Negocio. Valor cero indica ausencia de error"></param>
                                <param nom="SV_mens_retorno" Tipo="CARACTER" Descripcion ="Descripcion del error de Negocio. Un texto vacio indica aunsencia de error"></param>
                                <param nom="SN_num_evento" Tipo="NUMERICO" Descripcion="Identificador asociado al detalle tecnico del error"></param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/

        LN_num_abonado   ga_abocel.num_abonado%TYPE;
        LV_cad_ip        varchar2(512);
        LV_cad_apn       varchar2(512);
        LV_cad_qosid     varchar2(512);
        LV_num_ip        pv_ipservsuplabo_to.num_ip%TYPE;
        LV_apn           pv_ipservsuplabo_to.cod_apn%TYPE;
        LV_qosid         pv_ipservsuplabo_to.cod_qos_id%TYPE;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;

 CURSOR C_BuscaServIP(LN_num_abonado icc_movimiento.num_abonado%TYPE)  IS
     SELECT a.cod_servsupl, a.cod_nivel, a.fec_altabd
     FROM ga_servsuplabo a, ga_servsupl b
     WHERE a.num_abonado = LN_num_abonado
     AND a.cod_servicio = b.cod_servicio
     AND a.cod_servsupl = b.cod_servsupl
     AND a.cod_nivel = b.cod_nivel
     AND a.ind_estado =   EN_ind_estado -- solo los que tienen un estado determinado.-
     AND b.cod_producto = CN_Producto
     AND b.ind_ip =       CN_ind_ipfija
     AND b.ind_comerc =   CN_ind_no_comerc;

BEGIN

        SN_NUM_EVENTO:= 0;
        SN_COD_RETORNO:=0;
        SV_MENS_RETORNO:='';
                   
        -- Datos basicos desde el movimiento.-
        sSql := 'SELECT icc.num_abonado';
        sSql := sSql||' INTO LN_num_abonado';
        sSql := sSql||' FROM icc_movimiento icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_Num_Mov;

        SELECT  icc.num_abonado
        INTO    LN_num_abonado
        FROM    icc_movimiento icc
        WHERE   icc.num_movimiento = EN_Num_Mov;


        LV_cad_ip := NULL;
        LV_cad_apn := NULL;
        LV_cad_qosid := NULL;
        FOR C1 IN C_BuscaServIP(LN_num_abonado) LOOP
            BEGIN

                LV_num_ip := NULL;
                LV_apn    := NULL;
                LV_qosid  := NULL;

                sSql := 'SELECT num_ip, TO_CHAR(cod_apn), TO_CHAR(cod_qos_id)';
                sSql := sSql||' INTO LV_num_ip, LV_apn, LV_qosid';
                sSql := sSql||' FROM pv_ipservsuplabo_to';
                sSql := sSql||' WHERE num_abonado ='|| to_char(LN_num_abonado);
                sSql := sSql||' AND cod_servsupl ='|| to_char(C1.cod_servsupl);
                sSql := sSql||' AND fec_altabd = '|| to_char(C1.fec_altabd);

                SELECT num_ip, TO_CHAR(cod_apn), TO_CHAR(cod_qos_id)
                INTO LV_num_ip, LV_apn, LV_qosid
                FROM pv_ipservsuplabo_to
                WHERE num_abonado = LN_num_abonado
                AND cod_servsupl = C1.cod_servsupl
                AND fec_altabd = C1.fec_altabd;        

                IF LV_cad_ip IS NULL THEN
                    LV_cad_ip   := LV_num_ip;
                    LV_cad_apn  := LV_apn;
                    LV_cad_qosid:= LV_qosid;
                ELSE
                    LV_cad_ip    := LV_cad_ip || '$' || LV_num_ip;  --las ip se agrupan en una cadena.-
                    LV_cad_apn   := LV_cad_apn || '$' || LV_apn;  --los apn se agrupan en una cadena.-
                    LV_cad_qosid := LV_cad_qosid || '$' || LV_qosid;  --los qos se agrupan en una cadena.-
                END IF;
            END;
        END LOOP;

        IF LV_cad_ip IS NULL THEN
             SV_cad_ip := NULL;
             SV_cad_apn := NULL;
             SV_cad_qosid := NULL;
        ELSE
             SV_cad_ip := LV_cad_ip;
             SV_cad_apn := LV_cad_apn;
             SV_cad_qosid := LV_cad_qosid;
        END IF;
        
EXCEPTION
        WHEN OTHERS THEN
            SN_COD_RETORNO := CN_Err_Usuario;
            IF NOT GE_Errores_PG.MensajeError(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_MENS_RETORNO := CV_Err_NoClasif;
            END IF;
            LV_des_error := 'IC_PARAMPROVISION_PG.IC_DATAIPFIJA_PR('||EN_num_mov||'); - ' || SQLERRM;
            SN_num_evento := GE_Errores_PG.GrabarPL(SN_num_evento,'IC',SV_MENS_RETORNO,'1.0',USER,'IC_PARAMPROVISION_PG.IC_DATAIPFIJA_PR',sSql,SQLCODE,LV_des_error);
END;


FUNCTION IC_ALTADATAIPFIJA_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ALTADATAIPFIJA_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener los datos relacionados con activaciones de IP Fija.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LV_cad_ip        varchar2(512);
        LV_cad_apn       varchar2(512);
        LV_cad_qosid     varchar2(512);
        LV_num_ip        pv_ipservsuplabo_to.num_ip%TYPE;
        LV_apn           pv_ipservsuplabo_to.cod_apn%TYPE;
        LV_qosid         pv_ipservsuplabo_to.cod_qos_id%TYPE;
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;

BEGIN

        -- Solo los que está solicitando dar de alta en Centrales).-
        IC_DATAIPFIJA_PR(EN_num_mov,CN_altaservIC,LV_cad_ip,LV_cad_apn,LV_cad_qosid,LN_cod_retorno,LV_mens_retorno,LN_num_evento);               

        IF LN_cod_retorno<>0 THEN
             RETURN  'FALSE: NO SE PUDO OBTENER DATOS DE IP FIJA';
        END IF;


        IF LV_cad_ip IS NULL THEN
             return '0';
        ELSE
             return LV_cad_ip||',codapn_activa='||LV_cad_apn||',qosid_activa='||LV_cad_qosid;
        END IF;
        
EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_ALTADATAIPFIJA_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_ALTADATAIPFIJA_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE ACTIVACION DE IP FIJA-' || SQLERRM;
END;


FUNCTION IC_BAJADATAIPFIJA_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_BAJADATAIPFIJA_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener los datos relacionados con desactivaciones de IP Fija.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LV_cad_ip        varchar2(512);
        LV_cad_apn       varchar2(512);
        LV_cad_qosid     varchar2(512);
        LV_num_ip        pv_ipservsuplabo_to.num_ip%TYPE;
        LV_apn           pv_ipservsuplabo_to.cod_apn%TYPE;
        LV_qosid         pv_ipservsuplabo_to.cod_qos_id%TYPE;
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;

BEGIN

        -- Solo los que está solicitando dar de baja en Centrales).-
        IC_DATAIPFIJA_PR(EN_num_mov,CN_bajaservBD,LV_cad_ip,LV_cad_apn,LV_cad_qosid,LN_cod_retorno,LV_mens_retorno,LN_num_evento);               

        IF LN_cod_retorno<>0 THEN
             RETURN  'FALSE: NO SE PUDO OBTENER DATOS DE IP FIJA';
        END IF;


        IF LV_cad_ip IS NULL THEN
             return '0';
        ELSE
             return LV_cad_ip||',codapn_baja='||LV_cad_apn||',qosid_baja='||LV_cad_qosid;
        END IF;
        
EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_DATAIPFIJA_PR('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_DATAIPFIJA_PR',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE DESACTIVACION DE IP FIJA-' || SQLERRM;
END;


FUNCTION IC_MODIFDATAIPFIJA_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_MODIFDATAIPFIJA_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener los datos relacionados con modificaciones de IP Fija.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LV_cad_ip        varchar2(512);
        LV_cad_apn       varchar2(512);
        LV_cad_qosid     varchar2(512);
        LV_num_ip        pv_ipservsuplabo_to.num_ip%TYPE;
        LV_apn           pv_ipservsuplabo_to.cod_apn%TYPE;
        LV_qosid         pv_ipservsuplabo_to.cod_qos_id%TYPE;
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;

BEGIN

        -- Solo los que están contratados actualmente o de alta en Centrales).-
        IC_DATAIPFIJA_PR(EN_num_mov,CN_altaservIC,LV_cad_ip,LV_cad_apn,LV_cad_qosid,LN_cod_retorno,LV_mens_retorno,LN_num_evento);               

        IF LN_cod_retorno<>0 THEN
             RETURN  'FALSE: NO SE PUDO OBTENER DATOS DE IP FIJA';
        END IF;


        IF LV_cad_ip IS NULL THEN
             return '0';
        ELSE
             return LV_cad_ip||',codapn_mod='||LV_cad_apn||',qosid_mod='||LV_cad_qosid;
        END IF;
        
EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_MODIFDATAIPFIJA_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_MODIFDATAIPFIJA_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE MODIFICACION DE IP FIJA-' || SQLERRM;
END;


FUNCTION IC_NUMMOV_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_NUMMOV_FN"
                Lenguaje="PL/SQL"
                Fecha creación="07-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para hacer visible el numero de movimiento como parametro en Centrales.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LV_out           varchar2(512);
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;

BEGIN

        LV_out := TO_CHAR(EN_num_mov);
        
        return LV_out;
        
EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_NUMMOV_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_NUMMOV_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO RETORNAR NUMERO DE MOVIMIENTO-' || SQLERRM;
END;


FUNCTION IC_CLICODCLIANT_FN(EN_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_CLICODCLIANT_FN"
                Lenguaje="PL/SQL"
                Fecha creación="07-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener los datos del cliente antiguo.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_out" Tipo="STRING">codigo del cliente antiguo</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
        LV_out           STRING(512);
        LN_cod_cli       ge_clientes.cod_cliente%TYPE;
        LN_num_abonado   icc_movimiento.num_abonado%TYPE;
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;
BEGIN

    sSql := 'SELECT num_abonado';
    sSql := sSql||' INTO LN_num_abonado';
    sSql := sSql||' FROM icc_movimiento';
    sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;

    SELECT NUM_ABONADO
    INTO LN_num_abonado
    FROM ICC_MOVIMIENTO
    WHERE num_movimiento = EN_num_mov;


    BEGIN
        sSql := 'SELECT NVL(TO_CHAR(cod_cliente), CHR(0))';
        sSql := sSql||' INTO LN_cod_cli';
        sSql := sSql||' FROM GA_ABOCEL';
        sSql := sSql||' WHERE NUM_ABONADO = '||LN_num_abonado;
        
        SELECT NVL(TO_CHAR(cod_cliente), CHR(0))
        INTO LN_cod_cli
        FROM GA_ABOCEL
        WHERE NUM_ABONADO =  LN_num_abonado;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN

            BEGIN
                sSql := 'SELECT NVL(TO_CHAR(cod_cliente), CHR(0))';
                sSql := sSql||' INTO LN_cod_cli';
                sSql := sSql||' FROM GA_ABOAMIST';
                sSql := sSql||' WHERE NUM_ABONADO = '||LN_num_abonado;
        
                SELECT NVL(TO_CHAR(cod_cliente), CHR(0)) 
                INTO LN_cod_cli
                FROM GA_ABOAMIST
                WHERE NUM_ABONADO =  LN_num_abonado;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    LN_cod_retorno := CN_Err_Abo;
                    IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                            LV_mens_retorno := CV_Err_NoClasif;
                    END IF;
                    LV_des_error := 'IC_PARAMPROVISION_PG.IC_CLICODCLIANT_FN('||EN_num_mov||'); - ' || SQLERRM;
                    LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_CLICODCLIANT_FN',sSql,SQLCODE,LV_des_error);
                    RETURN 'FALSE: NO SE PUDO OBTENER CLIENTE-' || SQLERRM;
            END;
    END;

    sSql := 'SELECT NVL(TO_CHAR(cod_clienant), CHR(0))';
    sSql := sSql||' INTO LV_out';
    sSql := sSql||' FROM GA_TRASPABO';
    sSql := sSql||' WHERE num_abonado = '||LN_num_abonado;
    sSql := sSql||' AND cod_cliennue  = '||LN_cod_cli;
    sSql := sSql||' AND fec_modifica = (SELECT MAX(fec_modifica)';
    sSql := sSql||'     FROM GA_TRASPABO';
    sSql := sSql||'     WHERE num_abonado = '||LN_num_abonado;
    sSql := sSql||'     AND cod_cliennue  = '||LN_cod_cli;
    sSql := sSql||'     AND ind_traspaso IS NULL)';
    
    SELECT NVL(TO_CHAR(cod_clienant), CHR(0))
    INTO LV_out
    FROM GA_TRASPABO
    WHERE num_abonado = LN_num_abonado
    AND cod_cliennue =  LN_cod_cli
    AND fec_modifica = (SELECT MAX(fec_modifica)
                        FROM GA_TRASPABO
                        WHERE num_abonado = LN_num_abonado
                        AND cod_cliennue  = LN_cod_cli
                        AND ind_traspaso IS NULL);

    RETURN LV_out;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Abo;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_CLICODCLIANT_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_CLICODCLIANT_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER CLIENTE-' || SQLERRM;

END;


FUNCTION IC_CODCTAANT_FN(EN_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_CODCTAANT_FN"
                Lenguaje="PL/SQL"
                Fecha creación="07-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener datos del cliente antiguo para el traspaso de propiedad (abonado se va a otra cuenta y cliente).</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_out" Tipo="STRING">Cuenta antigua de cliente</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
        LV_out           STRING(512);
        LN_cod_cta       GA_CUENTAS.cod_cuenta%TYPE;
        LN_cod_cli       GE_CLIENTES.cod_cliente%TYPE;
        LN_num_abonado   ICC_MOVIMIENTO.num_abonado%TYPE;
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;

BEGIN

    sSql := 'SELECT num_abonado';
    sSql := sSql||' INTO LN_num_abonado';
    sSql := sSql||' FROM icc_movimiento';
    sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;
    
    SELECT NUM_ABONADO
    INTO LN_num_abonado
    FROM ICC_MOVIMIENTO
    WHERE num_movimiento = EN_num_mov;

    BEGIN
    
        sSql := 'SELECT NVL(TO_CHAR(cod_cuenta), CHR(0)) , NVL(TO_CHAR(cod_cliente), CHR(0))';
        sSql := sSql||' INTO LN_cod_cta, LN_cod_cli';
        sSql := sSql||' FROM GA_ABOCEL';
        sSql := sSql||' WHERE NUM_ABONADO = '||LN_num_abonado;
          
        SELECT NVL(TO_CHAR(cod_cuenta), CHR(0)) , NVL(TO_CHAR(cod_cliente), CHR(0))
        INTO LN_cod_cta, LN_cod_cli
        FROM GA_ABOCEL
        WHERE NUM_ABONADO =  LN_num_abonado;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            BEGIN
            
                 sSql := 'SELECT NVL(TO_CHAR(cod_cuenta), CHR(0)) , NVL(TO_CHAR(cod_cliente), CHR(0))';
                 sSql := sSql||' INTO LN_cod_cta, LN_cod_cli';
                 sSql := sSql||' FROM GA_ABOAMIST';
                 sSql := sSql||' WHERE NUM_ABONADO = '||LN_num_abonado;
        
                 SELECT NVL(TO_CHAR(cod_cuenta), CHR(0)) , NVL(TO_CHAR(cod_cliente), CHR(0))
                 INTO LN_cod_cta, LN_cod_cli
                 FROM GA_ABOAMIST
                 WHERE NUM_ABONADO =  LN_num_abonado;

            EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                    LN_cod_retorno := CN_Err_Abo;
                    IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                            LV_mens_retorno := CV_Err_NoClasif;
                    END IF;
                    LV_des_error := 'IC_PARAMPROVISION_PG.IC_CODCTAANT_FN('||EN_num_mov||'); - ' || SQLERRM;
                    LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_CODCTAANT_FN',sSql,SQLCODE,LV_des_error);
                    RETURN 'FALSE: NO SE PUDO OBTENER CUENTA-' || SQLERRM;
            END;
    END;

    sSql := 'SELECT NVL(TO_CHAR(COD_CUENTAANT), CHR(0))';
    sSql := sSql||' INTO LV_out';
    sSql := sSql||' FROM GA_TRASPABO';
    sSql := sSql||' WHERE num_abonado = '||LN_num_abonado;
    sSql := sSql||' AND cod_cuentanue = '||LN_cod_cta;
    sSql := sSql||' AND cod_cliennue  = '||LN_cod_cli;
    sSql := sSql||' AND fec_modifica = (SELECT MAX(fec_modifica)';
    sSql := sSql||'     FROM GA_TRASPABO';
    sSql := sSql||'     WHERE num_abonado = '||LN_num_abonado;
    sSql := sSql||'     AND cod_cuentanue = '||LN_cod_cta;
    sSql := sSql||'     AND cod_cliennue  = '||LN_cod_cli;
    sSql := sSql||'     AND ind_traspaso IS NULL)';
        
    SELECT NVL(TO_CHAR(COD_CUENTAANT), CHR(0))
    INTO LV_out
    FROM GA_TRASPABO
    WHERE num_abonado = LN_num_abonado
    AND cod_cuentanue = LN_cod_cta
    AND cod_cliennue  = LN_cod_cli
    AND fec_modifica = (SELECT MAX(fec_modifica)
                      FROM GA_TRASPABO
                      WHERE num_abonado = LN_num_abonado
                      AND cod_cuentanue = LN_cod_cta
                      AND cod_cliennue  = LN_cod_cli
                      AND ind_traspaso IS NULL);

    RETURN LV_out;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_CODCTAANT_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_CODCTAANT_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER CUENTA-' || SQLERRM;

END;


FUNCTION IC_PLAN_ACTUAL_FN(EN_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_PLAN_ACTUAL_FN"
                Lenguaje="PL/SQL"
                Fecha creación="07-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el plan antiguo o actual desde tabla de abonado.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_cod_plantarif" Tipo="STRING">Codigo de plan tarifario actual</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
        LN_num_abonado   ga_abocel.num_abonado%TYPE;
        LV_cod_plantarif ga_abocel.cod_plantarif%TYPE;
        error_proceso    EXCEPTION;
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;

BEGIN

       sSql := 'SELECT icc.num_abonado';
       sSql := sSql||' INTO LN_num_abonado';
       sSql := sSql||' FROM icc_movimiento';
       sSql := sSql||' WHERE icc.num_movimiento = '||EN_num_mov;
    
       SELECT icc.num_abonado
       INTO   LN_num_abonado
       FROM   icc_movimiento icc
       WHERE  icc.num_movimiento = EN_num_mov;

       BEGIN
       
          sSql := 'SELECT abo.cod_plantarif';
          sSql := sSql||' INTO LV_cod_plantarif';
          sSql := sSql||' FROM ga_abocel abo';
          sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

          SELECT  abo.cod_plantarif
          INTO  LV_cod_plantarif
          FROM  ga_abocel abo
          WHERE  abo.num_abonado = LN_num_abonado;

          EXCEPTION
              WHEN NO_DATA_FOUND THEN
                 BEGIN
                     sSql := 'SELECT abo.cod_plantarif';
                     sSql := sSql||' INTO LV_cod_plantarif';
                     sSql := sSql||' FROM ga_aboamist abo';
                     sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;
          
                     SELECT abo.cod_plantarif
                     INTO LV_cod_plantarif
                     FROM ga_aboamist abo
                     WHERE abo.num_abonado = LN_num_abonado;
                 EXCEPTION
                    WHEN OTHERS THEN
                        LN_cod_retorno := CN_Err_Abo;
                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                LV_mens_retorno := CV_Err_NoClasif;
                        END IF;
                        LV_des_error := 'IC_PARAMPROVISION_PG.IC_PLAN_ACTUAL_FN('||EN_num_mov||'); - ' || SQLERRM;
                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_PLAN_ACTUAL_FN',sSql,SQLCODE,LV_des_error);
                        RETURN 'FALSE: NO SE PUDO OBTENER PLAN DEL ABONADO-' || SQLERRM;                    
              END;
       END;

       RETURN LV_cod_plantarif;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Abo;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_PLAN_ACTUAL_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_PLAN_ACTUAL_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER PLAN ACTUAL-' || SQLERRM;

END;


FUNCTION IC_CICLO_FN(EN_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_CICLO_FN"
                Lenguaje="PL/SQL"
                Fecha creación="07-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el dia de inicio correspondiente al ciclo actual.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_dia_ciclo" Tipo="STRING">Dia de inicio del ciclo</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
        LV_cod_ciclo     ga_abocel.cod_ciclo%TYPE;
        LV_num_abonado   ga_abocel.num_abonado%TYPE;
        LV_dia_ciclo     VARCHAR2(4);
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;
BEGIN

       sSql := 'SELECT icc.num_abonado';
       sSql := sSql||' INTO LN_num_abonado';
       sSql := sSql||' FROM icc_movimiento';
       sSql := sSql||' WHERE icc.num_movimiento = '||EN_num_mov;
    
       SELECT icc.num_abonado
       INTO LV_num_abonado
       FROM icc_movimiento icc
       WHERE icc.num_movimiento = EN_num_mov;

       BEGIN
          sSql := 'SELECT abo.cod_ciclo';
          sSql := sSql||' INTO LV_cod_ciclo';
          sSql := sSql||' FROM ga_abocel abo';
          sSql := sSql||' WHERE abo.num_abonado = '||LV_num_abonado;

          SELECT abo.cod_ciclo
          INTO LV_cod_ciclo
          FROM ga_abocel abo
          WHERE abo.num_abonado = LV_num_abonado;

       EXCEPTION
          WHEN NO_DATA_FOUND THEN

              BEGIN
                  sSql := 'SELECT abo.cod_ciclo';
                  sSql := sSql||' INTO LV_cod_ciclo';
                  sSql := sSql||' FROM ga_aboamist abo';
                  sSql := sSql||' WHERE abo.num_abonado = '||LV_num_abonado;

                  SELECT abo.cod_ciclo
                  INTO LV_cod_ciclo
                  FROM ga_aboamist abo
                  WHERE abo.num_abonado = LV_num_abonado;
              EXCEPTION
                  WHEN OTHERS THEN
                      LN_cod_retorno := CN_Err_Abo;
                      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                              LV_mens_retorno := CV_Err_NoClasif;
                      END IF;
                      LV_des_error := 'IC_PARAMPROVISION_PG.IC_CICLO_FN('||EN_num_mov||'); - ' || SQLERRM;
                      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_CICLO_FN',sSql,SQLCODE,LV_des_error);
                      RETURN 'FALSE: NO SE PUDO OBTENER ABONADO-' || SQLERRM;
              END;
       END;

        sSql := 'SELECT to_char(fac.fec_desdellam,''dd'') dia';
        sSql := sSql||' INTO LV_dia_ciclo';
        sSql := sSql||' FROM fa_ciclfact fac';
        sSql := sSql||' WHERE fac.cod_ciclo = '||LV_cod_ciclo;
        sSql := sSql||' AND sysdate BETWEEN fac.fec_desdellam AND fac.fec_hastallam;';

        SELECT to_char(fac.fec_desdellam,'dd') dia
        INTO LV_dia_ciclo
        FROM fa_ciclfact fac
        WHERE fac.cod_ciclo = LV_cod_ciclo
        AND sysdate BETWEEN fac.fec_desdellam AND fac.fec_hastallam;

        RETURN LV_dia_ciclo;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_CICLO_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_CICLO_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER CICLO-' || SQLERRM;

END;

FUNCTION IC_SMSPROMOBLOQ_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_SMSPROMOBLOQ_FN"
                Lenguaje="PL/SQL"
                Fecha creación="08-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener indicador de si aplica o no sms promocional en bloque/desbloqueo.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado    icc_movimiento.num_abonado%TYPE;
        LV_cod_suspreha   icc_movimiento.cod_suspreha%TYPE;
        LN_ind_smspromo   pv_causablodesq_to.ind_smspromo%TYPE;
        LN_tip_suspencion pv_causablodesq_to.tip_suspencion%TYPE;
        LN_ind_susreh     number(1);
        LN_cod_retorno    GE_Errores_PG.coderror;
        LV_mens_retorno   GE_Errores_PG.msgerror;
        LN_num_evento     GE_Errores_PG.evento;
        LV_des_error      VARCHAR2(512);
        sSql              GE_Errores_PG.vQuery;

BEGIN

        sSql := 'SELECT num_abonado, NVL(cod_suspreha,CHR(0))';
        sSql := sSql||' INTO LN_num_abonado, LV_cod_suspreha';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;
       
        SELECT num_abonado, NVL(cod_suspreha,CHR(0))
        INTO LN_num_abonado, LV_cod_suspreha
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_mov;

        -- si no hay cod_suspreha, no aplica, pero no es error.
        IF LV_cod_suspreha = CHR(0) THEN
            RETURN '0';
        END IF;


        BEGIN
        
            sSql := 'SELECT tip_suspencion';
            sSql := sSql||' INTO LN_tip_suspencion';
            sSql := sSql||' FROM pv_causablodesq_to';
            sSql := sSql||' WHERE cod_producto = 1';
            sSql := sSql||' AND cod_causablodes = '||LV_cod_suspreha;
            sSql := sSql||' AND sysdate BETWEEN fec_ini_vigencia AND fec_fin_vigencia';
            sSql := sSql||' AND ind_smspromo = 1';
                                                                
            SELECT tip_suspencion
            INTO LN_tip_suspencion
            FROM pv_causablodesq_to
            WHERE cod_producto = 1
            AND cod_causablodes = LV_cod_suspreha
            AND sysdate BETWEEN fec_ini_vigencia AND fec_fin_vigencia
            AND ind_smspromo = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN -- no aplica, si no encuentra data con esas condiciones.(no es error).-
                RETURN '0';
        END;


        IF LN_tip_suspencion = 1 THEN 
            LN_ind_susreh := 1; --- Unidireccional.
        ELSE
            LN_ind_susreh := 2; --- Bidireccional.
        END IF;
        
        RETURN TO_CHAR(LN_ind_susreh);
--BQ
--IF tip_suspencion = 1  bloquea UNIdireccional
--else  bloquea BIdireccional
--DQ
--activar

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_SMSPROMOBLOQ_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_SMSPROMOBLOQ_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE SMS PROMOCIONAL-' || SQLERRM;
END;


FUNCTION IC_SMSPROMOSUSP_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_SMSPROMOSUSP_FN"
                Lenguaje="PL/SQL"
                Fecha creación="08-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener indicador de si aplica o no sms promocional en suspension/rehabilitacion.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado    icc_movimiento.num_abonado%TYPE;
        LV_cod_modulo     icc_movimiento.cod_modulo%TYPE;
        LV_cod_suspreha   icc_movimiento.cod_suspreha%TYPE;
        LD_fec_ingreso    icc_movimiento.fec_ingreso%TYPE;
        LV_cod_caususpabo ga_susprehabo.cod_caususp%TYPE;
        LN_ind_smspromo   ga_caususp.ind_smspromo%TYPE;
        LN_tip_suspencion ga_caususp.tip_suspencion%TYPE;
        LN_ind_susreh     number(1);
        LN_cod_retorno    GE_Errores_PG.coderror;
        LV_mens_retorno   GE_Errores_PG.msgerror;
        LN_num_evento     GE_Errores_PG.evento;
        LV_des_error      VARCHAR2(512);
        sSql              GE_Errores_PG.vQuery;

BEGIN

        sSql := 'SELECT num_abonado, cod_modulo, NVL(cod_suspreha,CHR(0)), TRUNC(fec_ingreso)';
        sSql := sSql||' INTO LN_num_abonado, LV_cod_modulo, LV_cod_suspreha, LD_fec_ingreso';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;
        
        SELECT num_abonado, cod_modulo, NVL(cod_suspreha,CHR(0)), TRUNC(fec_ingreso)
        INTO LN_num_abonado, LV_cod_modulo, LV_cod_suspreha, LD_fec_ingreso
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_mov;

        -- si no hay cod_suspreha, no aplica, pero no es error.
        IF LV_cod_suspreha = CHR(0) THEN
            RETURN '0';
        END IF;

        BEGIN

            sSql := 'SELECT cod_caususp';
            sSql := sSql||' INTO LV_cod_caususpabo';
            sSql := sSql||' FROM ga_susprehabo';
            sSql := sSql||' WHERE num_abonado = '||LN_num_abonado;
            sSql := sSql||' AND cod_servicio = '||LV_cod_suspreha;
            sSql := sSql||' AND trunc(fec_suspbd) = '||TO_CHAR(LD_fec_ingreso,'ddmmyyyy');
                                        
            SELECT cod_caususp
            INTO LV_cod_caususpabo
            FROM ga_susprehabo
            WHERE num_abonado = LN_num_abonado
            AND cod_servicio = LV_cod_suspreha
            AND trunc(fec_suspbd) = LD_fec_ingreso;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN  -- no aplica, si no encuentra data con esas condiciones.(no es error).-
                RETURN '0';
            WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_SMSPROMOSUSP_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_SMSPROMOSUSP_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE SUSP/REHAB DEL ABONADO-' || SQLERRM;
        END;


        BEGIN
        
            sSql := 'SELECT tip_suspencion';
            sSql := sSql||' INTO LN_tip_suspencion';
            sSql := sSql||' FROM ga_caususp';
            sSql := sSql||' WHERE cod_producto = 1';
            sSql := sSql||' AND cod_modulo = '||LV_cod_modulo;
            sSql := sSql||' AND cod_caususp = '||LV_cod_caususpabo;
            sSql := sSql||' AND sysdate BETWEEN fec_desde AND fec_hasta';
            sSql := sSql||' AND ind_smspromo = 1';
                               
            SELECT tip_suspencion
            INTO LN_tip_suspencion
            FROM ga_caususp
            WHERE cod_producto = 1
            AND cod_modulo = LV_cod_modulo
            AND cod_caususp = LV_cod_caususpabo
            AND sysdate BETWEEN fec_desde AND fec_hasta
            AND ind_smspromo = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN  -- no aplica, si no encuentra data con esas condiciones.(no es error).-
                RETURN'0';
        END;


        IF LN_tip_suspencion = 1 THEN 
            LN_ind_susreh := 1; --- Unidireccional.
        ELSE
            LN_ind_susreh := 2; --- Bidireccional.
        END IF;
        
        RETURN TO_CHAR(LN_ind_susreh);
--SUSPENSION
--IF tip_suspencion = 1  suspension UNIdireccional
--else  suspension BIdireccional
--REHABILITACION
--activar

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_SMSPROMOSUSP_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_SMSPROMOSUSP_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE SMS PROMOCIONAL-' || SQLERRM;
END;


FUNCTION IC_SMSPROMOSINIESTRO_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_SMSPROMOSINIESTRO_FN"
                Lenguaje="PL/SQL"
                Fecha creación="08-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener indicador de si aplica o no sms promocional en aviso/anulacion de siniestro.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado    icc_movimiento.num_abonado%TYPE;
        LV_cod_modulo     icc_movimiento.cod_modulo%TYPE;
        LD_fec_siniestro  ga_siniestros.fec_siniestro%TYPE;
        LV_cod_caususpabo ga_susprehabo.cod_caususp%TYPE;
        LN_ind_smspromo   ga_caususp.ind_smspromo%TYPE;
        LN_tip_suspencion ga_caususp.tip_suspencion%TYPE;
        LN_ind_susreh     number(1);
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;
        error_proceso EXCEPTION;

BEGIN

        sSql := 'SELECT num_abonado, cod_modulo';
        sSql := sSql||' INTO LN_num_abonado, LV_cod_modulo';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;
        
        SELECT num_abonado, cod_modulo
        INTO LN_num_abonado, LV_cod_modulo
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_mov;

        IF SQLCODE <> 0 THEN
            RAISE error_proceso;
        END IF;

        sSql := 'SELECT TRUNC(MAX(fec_siniestro))';
        sSql := sSql||' INTO LD_fec_siniestro';
        sSql := sSql||' FROM ga_siniestros';
        sSql := sSql||' WHERE num_abonado = '||LN_num_abonado;
        
        SELECT TRUNC(MAX(fec_siniestro)) 
        INTO  LD_fec_siniestro
        FROM ga_siniestros
        WHERE num_abonado = LN_num_abonado;

        -- si no hay siniestro, no aplica, pero no es error. Aunque la funcion es aplicable solo en contexto de siniestro.
        IF LD_fec_siniestro IS NULL THEN
            RETURN '0';
        END IF;

        sSql := 'SELECT cod_caususp';
        sSql := sSql||' INTO LV_cod_caususpabo';
        sSql := sSql||' FROM ga_susprehabo';
        sSql := sSql||' WHERE num_abonado = '||LN_num_abonado;
        sSql := sSql||' AND cod_modulo = '||LV_cod_modulo;
        sSql := sSql||' AND tip_susp    = ''T'' ';
        sSql := sSql||' AND tip_registro < 3';
        sSql := sSql||' AND TRUNC(fec_suspbd) = '||TO_CHAR(LD_fec_siniestro,'ddmmyyyy');
                                        
        SELECT cod_caususp
        INTO LV_cod_caususpabo
        FROM ga_susprehabo
        WHERE num_abonado = LN_num_abonado
        AND cod_modulo  = LV_cod_modulo
        AND tip_susp    = 'T'  
        AND tip_registro < 3 
        AND TRUNC(fec_suspbd) = LD_fec_siniestro;

        -- si no_data_found es error. si hay siniestro, deberia estar el abonado.
        IF SQLCODE <> 0 THEN
            RAISE error_proceso;
        END IF;

        BEGIN
        
            sSql := 'SELECT tip_suspencion';
            sSql := sSql||' INTO LN_tip_suspencion';
            sSql := sSql||' FROM ga_caususp';
            sSql := sSql||' WHERE cod_producto = 1';
            sSql := sSql||' AND cod_modulo = '||LV_cod_modulo;
            sSql := sSql||' AND cod_caususp = '||LV_cod_caususpabo;
            sSql := sSql||' AND sysdate BETWEEN fec_desde AND fec_hasta';
            sSql := sSql||' AND ind_smspromo = 1';
            
            SELECT tip_suspencion
            INTO LN_tip_suspencion
            FROM ga_caususp
            WHERE cod_producto = 1
            AND cod_modulo = LV_cod_modulo
            AND cod_caususp = LV_cod_caususpabo
            AND sysdate BETWEEN fec_desde AND fec_hasta
            AND ind_smspromo = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN  -- no aplica, si no encuentra data con esas condiciones.(no es error).-
                RETURN'0';
        END;

        
        IF LN_tip_suspencion = 1 THEN 
            LN_ind_susreh := 1; --- Unidireccional.
        ELSE
            LN_ind_susreh := 2; --- Bidireccional.
        END IF;
        
        RETURN TO_CHAR(LN_ind_susreh);

--AVISO DE SINIESTRO
--IF tip_suspencion = 1  suspension UNIdireccional
--else  suspension BIdireccional
--ANULACION SINIESTRO
--activar   
EXCEPTION
        WHEN error_proceso THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_SMSPROMOSINIESTRO_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_SMSPROMOSINIESTRO_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE SMS PROMOCIONAL-' || SQLERRM;
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_SMSPROMOSINIESTRO_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_SMSPROMOSINIESTRO_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE SMS PROMOCIONAL-' || SQLERRM;
END;


FUNCTION IC_IDPROMO_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_IDPROMO_FN"
                Lenguaje="PL/SQL"
                Fecha creación="08-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el id de Promocion SMS700 desde el movimiento.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS

        LN_id            number;
        LV_idpromocion   icc_movimiento.cod_servicios%TYPE;
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;

BEGIN

        sSql := 'SELECT NVL(cod_servicios,CHR(0))';
        sSql := sSql||' INTO LV_idpromocion';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;
        
        SELECT NVL(cod_servicios,CHR(0))
        INTO LV_idpromocion
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_mov;

        IF LV_idpromocion = CHR(0) THEN
            RETURN 'NOTID'; -- no hay id de promocion informado. Si es baja, quita todo.-
        END IF;

        LN_id := TO_NUMBER(LV_idpromocion);  -- elimina los 0.-
        
        RETURN TO_CHAR(LN_id);
        
EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_IDPROMO_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_IDPROMO_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO RETORNAR ID DE PROMOCION-' || SQLERRM;
END;


FUNCTION IC_NUMEROSFF_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_NUMEROSFF_FN"
                Lenguaje="PL/SQL"
                Fecha creación="08-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener la lista de numeros frecuente F-F del abonado.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LV_listaFF       varchar2(512);
        LV_idpromocion   icc_movimiento.cod_servicios%TYPE;        
        LN_num_abonado   icc_movimiento.num_abonado%TYPE;
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;

BEGIN
       
        sSql := 'SELECT num_abonado, NVL(cod_servicios,CHR(0))';
        sSql := sSql||' INTO LN_num_abonado';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;
        
        SELECT num_abonado, NVL(cod_servicios,CHR(0))
        INTO LN_num_abonado, LV_idpromocion
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_mov;

        IF LV_idpromocion = CHR(0) THEN
            RETURN 'FALSE: NO SE ENCONTRO ID DE PROMOCION';
        END IF;

        sSql := 'SELECT num_ffoduo_01,num_ffoduo_10';
        sSql := sSql||' INTO LV_listaFF';
        sSql := sSql||' FROM PV_ABON_BENEF_PREPAGOS_TD';
        sSql := sSql||' WHERE num_abonado = '||LN_num_abonado;

        SELECT '$'||num_ffoduo_01||'$'||num_ffoduo_02||'$'||num_ffoduo_03||'$'||num_ffoduo_04||
               '$'||num_ffoduo_05||'$'||num_ffoduo_06||'$'||num_ffoduo_07||'$'||num_ffoduo_08||
               '$'||num_ffoduo_09||'$'||num_ffoduo_10||'$'
        INTO LV_listaFF
        FROM PV_ABON_BENEF_PREPAGOS_TD
        WHERE ide_promocion = TO_NUMBER(LV_idpromocion)
        AND num_abonado = LN_num_abonado;

        RETURN LV_listaFF;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_NUMEROSFF_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_NUMEROSFF_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO RETORNAR ID DE PROMOCION-' || SQLERRM;
END;


FUNCTION IC_SERVICIOVPN_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_SERVICIOVPN_FN"
                Lenguaje="PL/SQL"
                Fecha creación="08-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener servicios VPN informados en mov.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado    icc_movimiento.num_abonado%TYPE;
        LV_cad_servIC     icc_movimiento.cod_servicios%TYPE;
        LV_cadserv        icc_movimiento.cod_servicios%TYPE;
        LV_serv           icc_movimiento.cod_servicios%TYPE;
        LV_nivel          icc_movimiento.cod_servicios%TYPE;
        LN_servicioVPN    icg_servicio.cod_servicio%TYPE;
        LN_nivelVPN       icg_nivelservicio.cod_nivel%TYPE;
        LN_Found          number(2);
        LN_pos            number:=0;
        LV_cad_servVPN    VARCHAR2(512);
        LN_cod_retorno    GE_Errores_PG.coderror;
        LV_mens_retorno   GE_Errores_PG.msgerror;
        LN_num_evento     GE_Errores_PG.evento;
        LV_des_error      VARCHAR2(512);
        sSql              GE_Errores_PG.vQuery;

-- Cursor para buscar los servicios VPN.-        
 CURSOR C_ServicioVPN  IS
     SELECT cod_servsupl, cod_nivel
     FROM ga_servsupl a
     WHERE a.cod_servicio in 
     (SELECT v.valor FROM  GE_VALORES_DOMINIOS_VW v 
     WHERE v.COD_DOMINIO  = 'CLIENTEVPN');

BEGIN

        sSql := 'SELECT num_abonado, NVL(cod_suspreha,CHR(0))';
        sSql := sSql||' INTO LN_num_abonado, LV_cad_servIC';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;
       
        SELECT num_abonado, NVL(cod_servicios,CHR(0))
        INTO LN_num_abonado, LV_cad_servIC
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_mov;

        -- si no hay cod_servicios, no aplica, pero no es error.
        IF LV_cad_servIC = CHR(0) THEN
            RETURN '0';
        END IF;

        -- Revisa los servicios de la cadena de servicios por si hay servicios VPN informados.
        LN_Found := 0;
        LN_pos :=1;
        -- Revisa servicio por servicio informado, para identificar si viene un servicio SDP.-
        WHILE (LN_pos< NVL(length(LV_cad_servIC),0)) LOOP
                LV_cadserv :=substr(LV_cad_servIC,LN_pos,6);
                LV_serv := substr(LV_cadserv,1,2);
                LV_nivel := substr(LV_cadserv,3,4);

                LN_Found := 0;
                -- Compara el servicio con los servicios SDP configurados en ged_codigos.
                OPEN C_ServicioVPN;
                LOOP
                    FETCH C_ServicioVPN INTO LN_servicioVPN, LN_nivelVPN;
                    EXIT WHEN C_ServicioVPN%NOTFOUND;
                    
                    IF TO_NUMBER(LV_serv) = LN_servicioVPN AND TO_NUMBER(LV_nivel) = LN_nivelVPN THEN
                        LN_Found := 1;  -- El servicio informado es un servicio VPN.-
                        EXIT;
                    END IF;
                  
                END LOOP;
                CLOSE C_ServicioVPN;


                IF LN_Found = 1 THEN -- Encontro uno.-
                    IF NVL(length(LV_cad_servVPN),0) = 0 THEN
                        LV_cad_servVPN := LV_cadserv;
                    ELSE
                        LV_cad_servVPN := LV_cad_servVPN || '$' || LV_cadserv;  --se agrupan en una cadena.-
                    END IF;
                    --EXIT;
                END IF;


                LN_pos:=LN_pos+6;

        END LOOP;

        -- No se encontró servicios VPN en la cadena del movimiento.-
        IF NVL(length(LV_cad_servVPN),0) = 0 THEN
              RETURN '0';   --no aplica, pero no es error.-
        END IF;

        RETURN LV_cad_servVPN;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_SERVICIOVPN_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_SERVICIOVPN_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE SERVICIO VPN-' || SQLERRM;
END;



FUNCTION IC_CODPRESTACION_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_CODPRESTACION_FN"
                Lenguaje="PL/SQL"
                Fecha creación="11-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener codigo de prestacion del abonado.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS

        LN_num_abonado    ga_abocel.num_abonado%TYPE;
        LV_cod_prestacion ga_abocel.cod_prestacion%TYPE;
        LN_cod_retorno    GE_Errores_PG.coderror;
        LV_mens_retorno   GE_Errores_PG.msgerror;
        LN_num_evento     GE_Errores_PG.evento;
        LV_des_error      VARCHAR2(512);
        sSql              GE_Errores_PG.vQuery;

BEGIN

       sSql := 'SELECT icc.num_abonado';
       sSql := sSql||' INTO LN_num_abonado';
       sSql := sSql||' FROM icc_movimiento';
       sSql := sSql||' WHERE icc.num_movimiento = '||EN_num_mov;
    
       SELECT icc.num_abonado
       INTO   LN_num_abonado
       FROM   icc_movimiento icc
       WHERE  icc.num_movimiento = EN_num_mov;

       BEGIN
       
          sSql := 'SELECT NVL(abo.cod_prestacion,CHR(0))';
          sSql := sSql||' INTO LV_cod_prestacion';
          sSql := sSql||' FROM ga_abocel abo';
          sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

          SELECT  NVL(abo.cod_prestacion,CHR(0))
          INTO  LV_cod_prestacion
          FROM  ga_abocel abo
          WHERE  abo.num_abonado = LN_num_abonado;

          EXCEPTION
              WHEN NO_DATA_FOUND THEN
                 BEGIN
                     sSql := 'SELECT NVL(abo.cod_prestacion,CHR(0))';
                     sSql := sSql||' INTO LV_cod_prestacion';
                     sSql := sSql||' FROM ga_aboamist abo';
                     sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;
          
                     SELECT NVL(abo.cod_prestacion,CHR(0))
                     INTO LV_cod_prestacion
                     FROM ga_aboamist abo
                     WHERE abo.num_abonado = LN_num_abonado;
                 EXCEPTION
                    WHEN OTHERS THEN
                        LN_cod_retorno := CN_Err_Abo;
                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                LV_mens_retorno := CV_Err_NoClasif;
                        END IF;
                        LV_des_error := 'IC_PARAMPROVISION_PG.IC_CODPRESTACION_FN('||EN_num_mov||'); - ' || SQLERRM;
                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_CODPRESTACION_FN',sSql,SQLCODE,LV_des_error);
                        RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE CODIGO DE PRESTACION-' || SQLERRM;                    
              END;
       END;

       RETURN LV_cod_prestacion;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Abo;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_CODPRESTACION_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_CODPRESTACION_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE ABONADO Y CODIGO DE PRESTACION-' || SQLERRM;
END;


FUNCTION IC_PRESTACION_ART_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_PRESTACION_ART_FN"
                Lenguaje="PL/SQL"
                Fecha creación="02-2010"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener atributo articulo Prestacion.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS

        LN_num_abonado    ga_abocel.num_abonado%TYPE;
        LV_icc            icc_movimiento.icc%TYPE;
        LV_prestacion     al_atributos_articulos.val_atributo%TYPE;
        LN_cod_retorno    GE_Errores_PG.coderror;
        LV_mens_retorno   GE_Errores_PG.msgerror;
        LN_num_evento     GE_Errores_PG.evento;
        LV_des_error      VARCHAR2(512);
        sSql              GE_Errores_PG.vQuery;

BEGIN

       sSql := 'SELECT icc.num_abonado, icc.icc';
       sSql := sSql||' INTO LN_num_abonado, LV_icc';
       sSql := sSql||' FROM icc_movimiento';
       sSql := sSql||' WHERE icc.num_movimiento = '||EN_num_mov;
    
       SELECT icc.num_abonado, icc.icc
       INTO   LN_num_abonado, LV_icc
       FROM   icc_movimiento icc
       WHERE  icc.num_movimiento = EN_num_mov;

/*    Modificado 03/05/2010 GDSF INC.132696
       sSql := 'SELECT NVL(b.val_atributo,CHR(0))';
       sSql := sSql||' INTO LV_prestacion';
       sSql := sSql||' FROM al_series a, al_atributos_articulos b';
       sSql := sSql||' WHERE a.cod_articulo = b.cod_articulo';
       sSql := sSql||' AND a.num_serie = '||LV_icc;

       SELECT  NVL(b.val_atributo,CHR(0))
       INTO  LV_prestacion
       FROM  al_series a, al_atributos_articulos b
       WHERE  a.cod_articulo = b.cod_articulo
       AND a.num_serie = LV_icc;
*/
       
       sSql := 'SELECT UNIQUE NVL(b.val_atributo,CHR(0))';
       sSql := sSql||' INTO LV_prestacion';
       sSql := sSql||' FROM al_movimientos a, al_atributos_articulos b';
       sSql := sSql||' WHERE a.cod_articulo = b.cod_articulo';
       sSql := sSql||' AND a.num_serie = '||LV_icc;

       SELECT UNIQUE NVL(b.val_atributo,CHR(0))
       INTO  LV_prestacion
       FROM  al_movimientos a, al_atributos_articulos b
       WHERE  a.cod_articulo = b.cod_articulo
       AND a.num_serie = LV_icc;

       RETURN LV_prestacion;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Abo;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_PRESTACION_ART_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_PRESTACION_ART_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DEL ARTICULO Y DE PRESTACION-' || SQLERRM;
END;


FUNCTION IC_OPERADOR_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_OPERADOR_FN"
                Lenguaje="PL/SQL"
                Fecha creación="11-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para operador origen para ingresar en Lista de series.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LV_oper_origen    icc_movimiento.des_origen_pin%TYPE;
        LN_cod_retorno    GE_Errores_PG.coderror;
        LV_mens_retorno   GE_Errores_PG.msgerror;
        LN_num_evento     GE_Errores_PG.evento;
        LV_des_error      VARCHAR2(512);
        sSql              GE_Errores_PG.vQuery;

BEGIN

        -- Lee el operador origen para la Lista que se informa en el movimiento.-        
        sSql := 'SELECT NVL(des_origen_pin,CHR(0))';
        sSql := sSql||' INTO LV_oper_origen';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;
       
        SELECT NVL(des_origen_pin,CHR(0))
        INTO LV_oper_origen
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_mov;

        IF LV_oper_origen = CHR(0) THEN
           RETURN 'FALSE: NO HAY OPERADOR INFORMADO';
        END IF;
        
        RETURN  LV_oper_origen;      

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_OPERADOR_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_OPERADOR_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE OPERADOR-' || SQLERRM;
END;


FUNCTION IC_LISTA_OPERMOTIVO_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_LISTA_OPERMOTIVO_FN"
                Lenguaje="PL/SQL"
                Fecha creación="02-2010"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para operador origen y motivo para ingresar en Lista de series.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LV_oper_origen    icc_movimiento.des_origen_pin%TYPE;
        LV_motivo         icc_movimiento.param1_mens%TYPE;        
        LN_cod_retorno    GE_Errores_PG.coderror;
        LV_mens_retorno   GE_Errores_PG.msgerror;
        LN_num_evento     GE_Errores_PG.evento;
        LV_des_error      VARCHAR2(512);
        sSql              GE_Errores_PG.vQuery;

BEGIN

        -- Lee el operador origen para la Lista que se informa en el movimiento.-        
        sSql := 'SELECT NVL(des_origen_pin,CHR(0)), NVL(param1_mens,CHR(0))';
        sSql := sSql||' INTO LV_oper_origen, LV_motivo';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;
       
        SELECT NVL(des_origen_pin,CHR(0)), NVL(param1_mens,CHR(0))
        INTO LV_oper_origen, LV_motivo
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_mov;

        IF LV_oper_origen = CHR(0) THEN
           RETURN 'FALSE: NO HAY OPERADOR INFORMADO';
        END IF;

        IF LV_motivo = CHR(0) THEN
           RETURN 'FALSE: NO HAY MOTIVO INFORMADO';
        END IF;
        
        RETURN LV_oper_origen||',motivo='||LV_motivo;      

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_LISTA_OPERMOTIVO_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_LISTA_OPERMOTIVO_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE OPERADOR-' || SQLERRM;
END;


FUNCTION IC_DISPOSITIVOAVL_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_DISPOSITIVOAVL_FN"
                Lenguaje="PL/SQL"
                Fecha creación="11-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener los datos del dispositivo AVL en ALTA.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado    icc_movimiento.num_abonado%TYPE;
        LV_num_imei       ga_abocel.num_imei%TYPE;
        LV_pin            al_seriesavl_to.device_pin%TYPE;
        LN_cantAVL        number(2);
        LN_cod_retorno    GE_Errores_PG.coderror;
        LV_mens_retorno   GE_Errores_PG.msgerror;
        LN_num_evento     GE_Errores_PG.evento;
        LV_des_error      VARCHAR2(512);
        sSql              GE_Errores_PG.vQuery;

BEGIN

        LV_num_imei := CHR(0);

        -- Lee el numero de abonado informado.-        
        sSql := 'SELECT num_abonado';
        sSql := sSql||' INTO LN_num_abonado';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;
       
        SELECT num_abonado
        INTO LN_num_abonado
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_mov;

        -- Revisa si hay un servicio AVL en ALTA en BD para el abonado.-
        sSql := 'SELECT count(1)';
        sSql := sSql||' INTO LN_cantAVL';
        sSql := sSql||' FROM ga_servsuplabo';
        sSql := sSql||' WHERE num_abonado = '||TO_CHAR(LN_num_abonado);
        sSql := sSql||' AND cod_servsupl in(SELECT TO_NUMBER(v.valor)';
        sSql := sSql||'   FROM GE_VALORES_DOMINIOS_VW v';
        sSql := sSql||'   WHERE v.COD_DOMINIO  = ''CLIENTEAVL'')';
        sSql := sSql||' AND ind_estado = 1;';
        
        SELECT count(1)
        INTO LN_cantAVL
        FROM ga_servsuplabo
        WHERE num_abonado = LN_num_abonado
        AND  cod_servsupl in(SELECT TO_NUMBER(v.valor) 
                             FROM  GE_VALORES_DOMINIOS_VW v
                             WHERE v.COD_DOMINIO  = 'CLIENTEAVL')
        AND ind_estado = CN_altaservBD;

        --Si NO hay servicios AVL en ALTA implica que no aplica. No es Error.-
        IF LN_cantAVL = 0 THEN
            RETURN LV_num_imei;
        END IF;


        -- Busca IMEI del dispositivo AVL.-
        BEGIN
           sSql := 'SELECT NVL(abo.num_imei,CHR(0))';
           sSql := sSql||' INTO LV_num_imei';
           sSql := sSql||' FROM ga_abocel abo';
           sSql := sSql||' WHERE abo.num_abonado = '||TO_CHAR(LN_num_abonado);

           SELECT  NVL(abo.num_imei,CHR(0))
           INTO  LV_num_imei
           FROM  ga_abocel abo
           WHERE  abo.num_abonado = LN_num_abonado;

           EXCEPTION
               WHEN NO_DATA_FOUND THEN
                  BEGIN
                      sSql := 'SELECT NVL(abo.num_imei,CHR(0))';
                      sSql := sSql||' INTO LV_num_imei';
                      sSql := sSql||' FROM ga_aboamist abo';
                      sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;
           
                      SELECT NVL(abo.num_imei,CHR(0))
                      INTO LV_num_imei
                      FROM ga_aboamist abo
                      WHERE abo.num_abonado = LN_num_abonado;
                  EXCEPTION
                     WHEN OTHERS THEN
                         LN_cod_retorno := CN_Err_Abo;
                         IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                 LV_mens_retorno := CV_Err_NoClasif;
                         END IF;
                         LV_des_error := 'IC_PARAMPROVISION_PG.IC_DISPOSITIVOAVL_FN('||EN_num_mov||'); - ' || SQLERRM;
                         LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_DISPOSITIVOAVL_FN',sSql,SQLCODE,LV_des_error);
                         RETURN 'FALSE: NO SE PUDO OBTENER IMEI DE DISPOSITIVO AVL-' || SQLERRM;                    
               END;
        END;

        -- Busca PIN del dispositivo AVL.-
        BEGIN
           sSql := 'SELECT device_pin';
           sSql := sSql||' INTO LV_pin';
           sSql := sSql||' FROM AL_SERIESAVL_TO';
           sSql := sSql||' WHERE device_code_imei = '||LV_num_imei;
           sSql := sSql||'   AND ind_provision = '||CN_ind_avlini;
           
           SELECT device_pin
           INTO LV_pin
           FROM AL_SERIESAVL_TO
           WHERE device_code_imei = LV_num_imei
            AND ind_provision = CN_ind_avlini;
           
           EXCEPTION
               WHEN OTHERS THEN
                    LN_cod_retorno := CN_Err_Abo;
                    IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                            LV_mens_retorno := CV_Err_NoClasif;
                    END IF;
                    LV_des_error := 'IC_PARAMPROVISION_PG.IC_DISPOSITIVOAVL_FN('||EN_num_mov||'); - ' || SQLERRM;
                    LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_DISPOSITIVOAVL_FN',sSql,SQLCODE,LV_des_error);
                    RETURN 'FALSE: NO SE PUDO OBTENER PIN DE DISPOSITIVO AVL-' || SQLERRM;                    
        END;

/*     Modificado 07/05/2010, gdsf, Incidencia 132938
        RETURN 'imei='||LV_num_imei||',pin='||LV_pin;
*/

        RETURN 'IMEIAVL='||LV_num_imei||',PINAVL='||LV_pin;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_DISPOSITIVOAVL_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_DISPOSITIVOAVL_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE DISPOSITIVO AVL-' || SQLERRM;
END;

FUNCTION IC_NUMEROFAX_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_NUMEROFAX_FN"
                Lenguaje="PL/SQL"
                Fecha creación="02-2010"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el numero de fax si aplica un servicio de FAX.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado    icc_movimiento.num_abonado%TYPE;
        LV_cad_servIC     icc_movimiento.cod_servicios%TYPE;
        LV_cadserv        icc_movimiento.cod_servicios%TYPE;
        LV_serv           icc_movimiento.cod_servicios%TYPE;
        LV_nivel          icc_movimiento.cod_servicios%TYPE;
        LN_SSfax          icg_servicio.cod_servicio%TYPE;
        LV_num_fax        varchar2(20);
        LN_Found          number(2);
        LN_pos            number:=0;
        LN_cod_retorno    GE_Errores_PG.coderror;
        LV_mens_retorno   GE_Errores_PG.msgerror;
        LN_num_evento     GE_Errores_PG.evento;
        LV_des_error      VARCHAR2(512);
        sSql              GE_Errores_PG.vQuery;

BEGIN

        sSql := 'SELECT num_abonado, NVL(cod_servicios,CHR(0))';
        sSql := sSql||' INTO LN_num_abonado, LV_cad_servIC';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;
       
        SELECT num_abonado, NVL(cod_servicios,CHR(0))
        INTO LN_num_abonado, LV_cad_servIC
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_mov;

        -- si no hay cod_servicios, no aplica, pero no es error.
        IF LV_cad_servIC = CHR(0) THEN
            RETURN CHR(0);
        END IF;


        -- Identifica el Servicio FAX.-
        sSql := 'SELECT to_number(val_parametro)';
        sSql := sSql||' INTO LN_SSfax';
        sSql := sSql||' FROM ged_parametros';
        sSql := sSql||' WHERE nom_parametro = '||CV_SS_FAX;
        sSql := sSql||' AND cod_modulo = '||CV_Modulo_GA;
        sSql := sSql||' AND cod_producto = '||CN_Producto;
      
        SELECT to_number(val_parametro) 
        INTO LN_SSfax
        FROM ged_parametros 
        WHERE nom_parametro = CV_SS_FAX
        AND cod_modulo = CV_Modulo_GA
        AND cod_producto = CN_Producto;


        -- Revisa los servicios de la cadena de servicios por si hay servicio FAX informado.
        LN_Found := 0;
        LN_pos :=1;
        -- Revisa servicio por servicio informado, para identificar si viene un servicio SDP.-
        WHILE (LN_pos< NVL(length(LV_cad_servIC),0)) LOOP
                LV_cadserv :=substr(LV_cad_servIC,LN_pos,6);
                LV_serv := substr(LV_cadserv,1,2);
                LV_nivel := substr(LV_cadserv,3,4);

                LN_Found := 0;

                -- Compara el servicio con el servicio FAX configurados en ged_parametros.
                IF TO_NUMBER(LV_serv) = LN_SSfax THEN
                    LN_Found := 1;  -- El servicio informado es un servicio FAX.-
                    EXIT;
                END IF;
                
                LN_pos:=LN_pos+6;
        END LOOP;


        LV_num_fax := CHR(0);
        
        IF LN_Found = 1 THEN
           LV_num_fax := GA_SERV911CORREOFAX_PG.getNumFax_FN(EN_num_mov);
        ELSE
           RETURN CHR(0);
        END IF;
        
        RETURN LV_num_fax;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_NUMEROFAX_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_NUMEROFAX_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE SERVICIO FAX-' || SQLERRM;
END;


FUNCTION IC_SEC_BOLSAS_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ABONADO_CADENA_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-2010"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener cadena o secuencia de bolsas de plata desde tabla ga_databonado_to.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado    icc_movimiento.num_abonado%TYPE;
        LN_num_movimiento icc_movimiento.num_movimiento%TYPE;
        LV_cadena         ga_databonado_to.cadena%TYPE;
        LN_cod_retorno    GE_Errores_PG.coderror;
        LV_mens_retorno   GE_Errores_PG.msgerror;
        LN_num_evento     GE_Errores_PG.evento;
        LV_des_error      VARCHAR2(512);
        sSql              GE_Errores_PG.vQuery;

BEGIN

        -- Identifica el numero de abonado.-
        sSql := 'SELECT num_abonado';
        sSql := sSql||' INTO LN_num_abonado';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;

        SELECT num_abonado
        INTO LN_num_abonado
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_mov;
        
         -- Identifica la cadena.-
        sSql := 'SELECT cadena';
        sSql := sSql||' INTO LV_cadena';
        sSql := sSql||' FROM ga_databonado_to';
        sSql := sSql||' WHERE nom_abonado = '||LN_num_abonado;

        SELECT  NVL(cadena,CHR(0))
        INTO LV_cadena
        FROM ga_databonado_to
        WHERE num_abonado =  LN_num_abonado;

        IF LV_cadena = CHR(0) THEN
            RETURN CHR(0);
        END IF;

        LV_cadena := replace(LV_cadena, '|', '$');
     
        RETURN LV_cadena;

EXCEPTION
        WHEN NO_DATA_FOUND  THEN
             RETURN CHR(0);
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_ABONADO_CADENA_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_ABONADO_CADENA_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER CADENA-' || SQLERRM;
END;


FUNCTION IC_PLANCOMVERSE_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_PLANCOMVERSE_FN" Lenguaje="PL/SQL" Fecha="20-05-2010" Versión"1.0.0" >
<Retorno>NA</Retorno>
<Descripción>Funcion para obtener el plan antiguo o actual desde tabla de abonado</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE">Numero de movimiento</param>
</Entrada>
<Salida>
<param nom="LV_cod_plantarif" Tipo="STRING">Codigo de plan tarifario actual</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
<Modificacion>
<version>2.0</version>
<fecha>26-09-2007</fecha>
<DESCMOD>Se agrega nueva query a la tabla ta_plantarif extrayendo el codigo pla el cual finalmete se retorna</DESCMOD>
</Modificacion>
*/
 
RETURN STRING IS
--
    LV_num_abonado       ga_abocel.num_abonado%TYPE;
    LV_cod_plantarif     ga_abocel.cod_plantarif%TYPE;
    LV_cod_plan_comverse ta_plantarif.cod_plan_comverse%TYPE;
    LN_cod_retorno       GE_Errores_PG.coderror;
    LV_mens_retorno      GE_Errores_PG.msgerror;
    LN_num_evento        GE_Errores_PG.evento;
    LV_des_error         VARCHAR2(512);
    sSql                 GE_Errores_PG.vQuery;


 
    error_proceso  EXCEPTION;
--
BEGIN
       SELECT icc.num_abonado
             INTO LV_num_abonado
         FROM icc_movimiento icc
        WHERE icc.num_movimiento = EN_NUM_MOV;
 
       BEGIN
          SELECT abo.cod_plantarif
            INTO LV_cod_plantarif
            FROM ga_abocel abo
           WHERE abo.num_abonado = LV_num_abonado;
 
          EXCEPTION
          WHEN NO_DATA_FOUND THEN
            BEGIN
               SELECT abo.cod_plantarif
               INTO LV_cod_plantarif
               FROM ga_aboamist abo
               WHERE abo.num_abonado = LV_num_abonado;
            EXCEPTION
               WHEN OTHERS THEN
                  RAISE error_proceso;
            END;
       END;
 
       BEGIN
               SELECT pla.cod_plan_comverse
                 INTO LV_cod_plan_comverse
                 FROM ta_plantarif pla
                 WHERE pla.cod_plantarif = LV_cod_plantarif;
       EXCEPTION   
            WHEN OTHERS THEN
                 RAISE error_proceso;
       END;
 
       RETURN LV_cod_plan_comverse;
 
EXCEPTION
    WHEN error_proceso THEN
      LN_cod_retorno := CN_Err_Cli;
      IF NOT GE_ERRORES_PG.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
         LV_mens_retorno := CV_Err_NoClasif;
      END IF;
      LV_des_error := 'IC_PARAMPROVISION_PG.IC_PLANCOMVERSE_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_ERRORES_PG.GRABARPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_PLANCOMVERSE_FN',sSql,SQLCODE,LV_des_error);
      RETURN 'FALSE: NO SE PUDO OBTENER DATOS DEL ABONADO';
 
    WHEN OTHERS THEN
      LN_cod_retorno := CN_Err_Cli;
      IF NOT GE_ERRORES_PG.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
         LV_mens_retorno := CV_Err_NoClasif;
      END IF;
      LV_des_error := 'IC_PARAMPROVISION_PG.IC_PLANCOMVERSE_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_ERRORES_PG.GRABARPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_PLANCOMVERSE_FN',sSql,SQLCODE,LV_des_error);
      RETURN 'FALSE: NO SE PUDO PROCESAR CONSULTAS DE PLAN';
 
END;


FUNCTION IC_FECCORTE_FN(EN_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_FECCORTE_FN"
                Lenguaje="PL/SQL"
                Fecha creación="10-2011"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener la fecha de corte del ciclo del abonado.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_fec_corte" Tipo="STRING">fecha de corte del ciclo</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
        LV_cod_ciclo     ga_abocel.cod_ciclo%TYPE;
        LV_num_abonado   ga_abocel.num_abonado%TYPE;
        LV_fec_corte     VARCHAR2(12);
        LV_fec_inisig    VARCHAR2(12);
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;
BEGIN

       sSql := 'SELECT icc.num_abonado';
       sSql := sSql||' INTO LN_num_abonado';
       sSql := sSql||' FROM icc_movimiento';
       sSql := sSql||' WHERE icc.num_movimiento = '||EN_num_mov;
    
       SELECT icc.num_abonado
       INTO LV_num_abonado
       FROM icc_movimiento icc
       WHERE icc.num_movimiento = EN_num_mov;

       BEGIN
          sSql := 'SELECT abo.cod_ciclo';
          sSql := sSql||' INTO LV_cod_ciclo';
          sSql := sSql||' FROM ga_abocel abo';
          sSql := sSql||' WHERE abo.num_abonado = '||LV_num_abonado;

          SELECT abo.cod_ciclo
          INTO LV_cod_ciclo
          FROM ga_abocel abo
          WHERE abo.num_abonado = LV_num_abonado;

       EXCEPTION
          WHEN NO_DATA_FOUND THEN

              BEGIN
                  sSql := 'SELECT abo.cod_ciclo';
                  sSql := sSql||' INTO LV_cod_ciclo';
                  sSql := sSql||' FROM ga_aboamist abo';
                  sSql := sSql||' WHERE abo.num_abonado = '||LV_num_abonado;

                  SELECT abo.cod_ciclo
                  INTO LV_cod_ciclo
                  FROM ga_aboamist abo
                  WHERE abo.num_abonado = LV_num_abonado;
              EXCEPTION
                  WHEN OTHERS THEN
                      LN_cod_retorno := CN_Err_Abo;
                      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                              LV_mens_retorno := CV_Err_NoClasif;
                      END IF;
                      LV_des_error := 'IC_PARAMPROVISION_PG.IC_FECCORTE_FN('||EN_num_mov||'); - ' || SQLERRM;
                      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_FECCORTE_FN',sSql,SQLCODE,LV_des_error);
                      RETURN 'FALSE: NO SE PUDO OBTENER ABONADO-' || SQLERRM;
              END;
       END;

        sSql := 'SELECT to_char(fac.fec_hastallam,''yyyymmdd''), to_char((fac.fec_hastallam + 1),''yyyymmdd'')';
        sSql := sSql||' INTO LV_fec_corte, LV_fec_inisig';
        sSql := sSql||' FROM fa_ciclfact fac';
        sSql := sSql||' WHERE fac.cod_ciclo = '||LV_cod_ciclo;
        sSql := sSql||' AND sysdate BETWEEN fac.fec_desdellam AND fac.fec_hastallam;';

        SELECT to_char(fac.fec_hastallam,'yyyymmdd'), to_char((fac.fec_hastallam + 1),'yyyymmdd')
        INTO LV_fec_corte, LV_fec_inisig
        FROM fa_ciclfact fac
        WHERE fac.cod_ciclo = LV_cod_ciclo
        AND sysdate BETWEEN fac.fec_desdellam AND fac.fec_hastallam;

        RETURN LV_fec_corte||',FEC_INISIG='||LV_fec_inisig;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_FECCORTE_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_FECCORTE_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER FECHAS-' || SQLERRM;
END;


END IC_PARAMPROVISION_PG; 
/
SHOW ERRORS
