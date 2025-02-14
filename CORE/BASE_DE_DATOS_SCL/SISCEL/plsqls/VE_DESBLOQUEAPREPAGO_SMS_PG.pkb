CREATE OR REPLACE PACKAGE BODY Ve_Desbloqueaprepago_Sms_Pg IS
--------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_VALIDA_IMEI_EXTERNO (
                                        EV_num_imei        IN         ga_aboamist.num_imei%TYPE,
                                        SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
                                        )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_VALIDA_IMEI_EXTERNO
        Lenguaje="PL/SQL"
        Fecha="30-11-2005"
        Versi줻="1.0"
        Dise풹dor="Jorge Mar죒"
        Programador="Jorge Mar죒"

        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Servicio de negocio para desbloqueo de prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_num_abonado"        Tipo="CARACTER">Numero de Abonado</param>
                </Entrada>
                <Salida>
                        <param nom="EN_codcliente_dist"  Tipo="VARCHAR2">C줰igo de cliente Dealer</param>
                        <param nom="EV_icc"              Tipo="VARCHAR2">Numero Simcard</param>
                        <param nom="EV_num_imei"         Tipo="VARCHAR2">N즡ero Imei</param>
                        <param nom="EV_indprocequi"      Tipo="VARCHAR2">Indicador de procedencia de equipo/param>
                        <param nom="SN_cod_retorno"      Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                        <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                        <param nom="SN_num_evento"       Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_digito_imei_ext   VARCHAR2(1);

        LV_digito_imei_ing   VARCHAR2(1);
        LV_des_error         ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
        LV_imei_uno          VARCHAR2(1);
        LN_largo_imei        NUMBER;
        error_imei           exception;
BEGIN
        SN_cod_retorno := 0;
        SN_num_evento  := 0;
        LV_imei_uno := SUBSTR(EV_num_imei,1,1);
        IF LV_imei_uno != '1' THEN
                LN_largo_imei := LENGTH(EV_num_imei);
                sSql:='LV_digito_imei_ext :=  GE_FN_LUHN(SUBSTR('||EV_num_imei||',1,'||LN_largo_imei||'-1));';
                LV_digito_imei_ext :=  GE_FN_LUHN(SUBSTR(EV_num_imei,1,LN_largo_imei-1));
                LV_digito_imei_ing :=  SUBSTR(EV_num_imei,LN_largo_imei,LN_largo_imei);
                IF LV_digito_imei_ext != LV_digito_imei_ing THEN
                        RAISE error_imei;
                END IF;
        END IF;

EXCEPTION
        WHEN error_imei THEN
                SN_cod_retorno:=778;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others:VE_desbloqueaprepago_sms_PG.VE_VALIDA_IMEI_EXTERNO('||EV_num_imei||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_VALIDA_IMEI_EXTERNO', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others:VE_desbloqueaprepago_sms_PG.VE_VALIDA_IMEI_EXTERNO('||EV_num_imei||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_VALIDA_IMEI_EXTERNO', sSql, SQLCODE, LV_des_error );
END VE_VALIDA_IMEI_EXTERNO;

PROCEDURE VE_VALIDA_USO   (
                        EN_codcliente_dist IN         ga_aboamist.cod_cliente_dist%TYPE,
                        EV_icc             IN         ga_aboamist.num_serie%TYPE,
                        EV_num_imei        IN         ga_aboamist.num_imei%TYPE,
                        EV_indprocequi    IN                    CHAR,
                        SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                        SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                        SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
                        )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VVE_VALIDA_USO"
        Lenguaje="PL/SQL"
        Fecha="30-11-2005"
        Versi줻="1.0"
        Dise풹dor="Jorge Mar죒"
        Programador="Jorge Mar죒"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Servicio de negocio para desbloqueo de prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_num_abonado"        Tipo="CARACTER">Numero de Abonado</param>
                </Entrada>
                <Salida>
                        <param nom="EN_codcliente_dist"  Tipo="VARCHAR2">C줰igo de cliente Dealer</param>
                        <param nom="EV_icc"              Tipo="VARCHAR2">Numero Simcard</param>
                        <param nom="EV_num_imei"         Tipo="VARCHAR2">N즡ero Imei</param>
                        <param nom="EV_indprocequi"      Tipo="VARCHAR2">Indicador de procedencia de equipo/param>
                        <param nom="SN_cod_retorno"      Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                        <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                        <param nom="SN_num_evento"       Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error                      ge_errores_pg.DesEvent;
        sSql                              ge_errores_pg.vQuery;
        LN_uso                            NUMBER;
        LV_situalta                       ga_situabo.cod_situacion%TYPE;
        LB_retorno                        BOOLEAN;
        LV_aplicmay                       ged_parametros.val_parametro%TYPE;
        LV_coduso                         al_series.cod_uso%TYPE;
        LV_desuso                         al_usos.des_uso%TYPE;
        LV_codart                         al_articulos.cod_articulo%TYPE;
        LV_desart                         al_articulos.des_articulo%TYPE;
        LV_errserv                        VARCHAR2(100);
        error_uso                        exception;
BEGIN
        SN_cod_retorno := 0;
        SN_num_evento  := 0;
        LV_situalta    :=CV_alta_act_abonado;

        IF CV_EquipoInterno = EV_indprocequi THEN
                sSql:='SELECT count(0)'||
                '  INTO  LN_uno '||
                '  FROM  ga_aboamist a , al_series b'||
                ' WHERE  a.cod_cliente  ='|| EN_codcliente_dist ||
                '   AND  a.cod_cliente  = a.cod_cliente_dist'||
                '   AND  a.num_serie    ='|| EV_icc ||
                '   AND  a.cod_situacion='|| LV_situalta ||
                '   AND  b.num_serie    ='|| EV_num_imei ||
                '   AND  b.cod_uso           = a.cod_uso';

                SELECT count(0)
                INTO  LN_uso
                FROM  ga_aboamist a , al_series b
                WHERE  a.cod_cliente  = EN_codcliente_dist
                AND  a.cod_cliente  = a.cod_cliente_dist
                AND  a.num_serie    = EV_icc
                AND  a.cod_situacion= LV_situalta
                AND  b.num_serie    = EV_num_imei
                AND  b.cod_uso    = a.cod_uso;
-- ***** P-VIR_06002 MAYORISTAS ****
                IF LN_uso = 0 THEN
                        LB_retorno:= ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn('APLICA_MODCRED_MAYOR', 'GA', 1, LV_aplicmay, SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                        IF NOT LB_retorno THEN
                                RAISE error_uso;
                        END IF;
                        IF TRIM(LV_aplicmay)='TRUE' THEN
                                NP_TRANSACCIONES_WEB_PG.NP_ORIGENVENTA_PR(EV_icc, 2, LV_coduso, LV_desuso, LV_codart, LV_desart, LV_errserv);
                                IF LV_coduso IS NOT NULL AND LV_desuso IS NOT NULL AND LV_codart IS NOT NULL AND LV_desart IS NOT NULL THEN
                                        SELECT count(0)
                                        INTO  LN_uso
                                        FROM  ga_aboamist a , al_series b
                                        WHERE  a.cod_cliente  = a.cod_cliente_dist
                                        AND  a.num_serie    = EV_icc
                                        AND  a.cod_situacion= LV_situalta
                                        AND  b.num_serie    = EV_num_imei
                                        AND  b.cod_uso    = a.cod_uso;
                                ELSE
                                        RAISE error_uso;
                                END IF;
                        END IF;
                END IF;
                -- ***** P-VIR_06002 MAYORISTAS ****
                IF LN_uso = 0 THEN
                        RAISE error_uso;
                END IF;
        END IF;

EXCEPTION
        WHEN error_uso THEN
                SN_cod_retorno:=758;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others:VE_desbloqueaprepago_sms_PG.VE_VALIDA_USO('||EN_codcliente_dist||','||EV_icc||','||EV_num_imei||','||EV_indprocequi||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_VALIDA_USO', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others:VE_desbloqueaprepago_sms_PG.VE_VALIDA_USO('||EN_codcliente_dist||','||EV_icc||','||EV_num_imei||','||EV_indprocequi||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_VALIDA_USO', sSql, SQLCODE, LV_des_error );
END VE_VALIDA_USO;


--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_OBTIENE_DATOS_ARTICULO (
                                        EV_codarticulo  IN      al_articulos.cod_articulo%TYPE,
                                        EV_indprocequi  IN      CHAR,
                                        SV_des_articulo OUT NOCOPY al_articulos.des_articulo%TYPE,
                                        SV_ind_equiacc  OUT NOCOPY al_articulos.ind_equiacc%TYPE,
                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                        )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_OBTIENE_DATOS_ARTICULO"
        Lenguaje="PL/SQL"
        Fecha="30-11-2005"
        Versi줻="1.0"
        Dise풹dor="Jorge Iba풽z"
        Programador="Jorge Iba풽z"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Servicio de negocio para desbloqueo de prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_codarticulo"        Tipo="al_articulos.cod_articulo">Codigo de articulo</param>
                        <param nom="EV_indprocequi"        Tipo="CARACTER">Indicador de proc. Equipo</param>
                </Entrada>
                <Salida>
                        <param nom="SV_des_articulo"   Tipo="VARCHAR2">Descripci줻 del Articulo</param>
                        <param nom="SV_ind_equiacc"    Tipo="NUMERICO">Indicador de Equipo</param>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                        <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error         ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
BEGIN
        SN_num_evento  := 0;
         SN_cod_retorno := 0;

        sSql:='SELECT DES_AERTICULO,IND_EQUIACC FROM AL_ARTICULOS WHERE COD_ARTICULO=' || EV_codarticulo;

        IF EV_indprocequi = 'I' THEN
                BEGIN
                        SELECT DES_ARTICULO,IND_EQUIACC
                        INTO SV_des_articulo,SV_ind_equiacc
                        FROM
                        AL_ARTICULOS
                        WHERE
                        COD_ARTICULO=EV_codarticulo;
                END;
        END IF;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=300111;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others:
                VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_ARTICULO('||EV_codarticulo||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_ARTICULO', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others:
                VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_ARTICULO('||EV_codarticulo||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_ARTICULO', sSql, SQLCODE, LV_des_error );
END VE_OBTIENE_DATOS_ARTICULO;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_IN_GA_EQUIPABOSER_PR(
                                        EN_numabonado      IN ga_equipaboser.num_abonado%TYPE,
                                        EV_num_serie       IN ga_equipaboser.num_serie%TYPE,
                                        EN_cod_producto    IN ga_equipaboser.cod_producto%TYPE,
                                        EV_ind_procequi    IN ga_equipaboser.ind_procequi%TYPE,
                                        EV_fec_alta          IN ga_equipaboser.fec_alta%TYPE,
                                        EV_ind_propiedad   IN ga_equipaboser.ind_propiedad%TYPE,
                                        EN_cod_bodega      IN ga_equipaboser.cod_bodega%TYPE,
                                        EN_tipstock        IN ga_equipaboser.tip_stock%TYPE,
                                        EN_codarticulo     IN ga_equipaboser.cod_articulo%TYPE,
                                        EV_indequiacc      IN ga_equipaboser.ind_equiacc%TYPE,
                                        EN_cod_modventa    IN ga_equipaboser.cod_modventa%TYPE,
                                        EV_tip_terminal    IN ga_equipaboser.tip_terminal%TYPE,
                                        EN_coduso          IN ga_equipaboser.cod_uso%TYPE,
                                        EV_cod_cuota       IN ga_equipaboser.cod_cuota%TYPE,
                                        EN_cod_estado      IN ga_equipaboser.cod_estado%TYPE,
                                        EN_capcode         IN ga_equipaboser.cap_code%TYPE,
                                        EV_cod_protocolo   IN ga_equipaboser.cod_protocolo%TYPE,
                                        EN_num_velocidad   IN ga_equipaboser.num_velocidad%TYPE,
                                        EN_cod_frecuencia  IN ga_equipaboser.cod_frecuencia%TYPE,
                                        EN_cod_version     IN ga_equipaboser.cod_version%TYPE,
                                        EV_num_seriemec    IN ga_equipaboser.num_seriemec%TYPE,
                                        EV_des_equipo      IN ga_equipaboser.des_equipo%TYPE,
                                        EN_cod_paquete     IN ga_equipaboser.cod_paquete%TYPE,
                                        EN_num_movimiento  IN ga_equipaboser.num_movimiento%TYPE,
                                        EV_cod_causa       IN ga_equipaboser.cod_causa%TYPE,
                                        EV_ind_eqprestado  IN ga_equipaboser.ind_eqprestado%TYPE,
                                        EV_num_imei              IN ga_equipaboser.num_imei%TYPE,
                                        EV_cod_tecnologia  IN ga_equipaboser.cod_tecnologia%TYPE,
                                        EN_imp_cargo             IN ga_equipaboser.imp_cargo%TYPE,
                                        EV_tip_dto               IN ga_equipaboser.tip_dto%TYPE,
                                        EV_val_dto               IN ga_equipaboser.val_dto%TYPE,
                                        SN_cod_retorno           OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno          OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento            OUT NOCOPY ge_errores_pg.Evento
                                        )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_IN_GA_EQUIPABOSER_PR"
        Lenguaje="PL/SQL"
        Fecha="02-09-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Insertar en Tabla Equipos Seriados de Abonados de Productos</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_numabonado"     Tipo="  " >Nro de Abonado</param>
                        <param nom="EV_num_serie"      Tipo="  " >Nro de serie</param>
                        <param nom="EN_cod_producto"   Tipo="  " >Codigo del producto</param>
                        <param nom="EV_ind_procequi"   Tipo="  " >Indicador de procedencia del equipo</param>
                        <param nom="EV_ind_propiedad"  Tipo="  " >Indicador de propiedad </param>
                        <param nom="EN_cod_bodega"     Tipo="  " >Codigo de bodega</param>
                        <param nom="EN_tipstock"       Tipo="  " >Tipo del stock del almacen</param>
                        <param nom="EN_codarticulo"    Tipo="  " >Codigo articulo</param>
                        <param nom="EV_indequiacc"     Tipo="  " >Indicativo equipo/accesorio</param>
                        <param nom="EN_cod_modventa"   Tipo="  " >Codigo modalidad de venta</param>
                        <param nom="EV_tip_terminal"   Tipo="  " >Tipo de terminal</param>
                        <param nom="EN_coduso"         Tipo="  " >Codigo de uso</param>
                        <param nom="EV_cod_cuota"      Tipo="  " >Codigo de la cuota</param>
                        <param nom="EN_cod_estado"     Tipo="  " >Estado del equipo</param>
                        <param nom="EN_capcode"        Tipo="  " >Codigo cap code beeper</param>
                        <param nom="EV_cod_protocolo"  Tipo="  " >Protocolo del equipo</param>
                        <param nom="EN_num_velocidad"  Tipo="  " >Velocidad </param>
                        <param nom="EN_cod_frecuencia" Tipo="  " >Codigo de frecuencia</param>
                        <param nom="EN_cod_version"    Tipo="  " >Codigo de version</param>
                        <param nom="EV_num_seriemec"   Tipo="  " >Serie mecanica del equipo</param>
                        <param nom="EV_des_equipo"     Tipo="  " >Propiedad del equipo</param>
                        <param nom="EN_cod_paquete"    Tipo="  " >Codigo del paquete</param>
                        <param nom="EN_num_movimiento" Tipo="  " >Nro de movimiento de stock</param>
                        <param nom="EV_cod_causa"      Tipo="  " >Codigo causa cambio de equipo</param>
                        <param nom="EV_ind_eqprestado" Tipo="  " >Indicador de equipo en prestamo</param>
                        <param nom="EV_num_imei"       Tipo="  " >Nro de terminal GSM</param>
                        <param nom="EV_cod_tecnologia" Tipo="  " >Codigo de tecnologia</param>
                        <param nom="EN_imp_cargo"      Tipo="  " >Cargo</param>
                        <param nom="EV_tip_dto"        Tipo="  " >Tipo dto</param>
                        <param nom="EV_val_dto"        Tipo="  " >Valor dto</param>
                </Entrada>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error      ge_errores_pg.DesEvent;
        sSql              ge_errores_pg.vQuery;
        /* Inicio CO-200603230013  (Soporte GSA 26/04/2006)  */
        SN_tip_stock      ged_parametros.val_parametro%TYPE;
        x_tip_stock    ga_equipaboser.tip_stock%TYPE;
        /* Fin CO-200603230013  (Soporte GSA 26/04/2006)     */

BEGIN
        /* Inicio CO-200603230013  (Soporte GSA 26/04/2006)  */
        Select val_parametro
        into SN_tip_stock
        from ged_parametros
        where
        nom_parametro='COD_TIPSTOCKMERC' and
        cod_modulo='GA' and
        cod_producto=1;

        if TRIM(EV_ind_procequi) <> 'E' then
        SN_tip_stock := EN_tipstock;
        end if;
        /* Fin CO-200603230013  (Soporte GSA 26/04/2006)  */

        SN_cod_retorno:=0;
        SN_num_evento:=0;

        sSql:='INSERT INTO ga_equipaboser (num_abonado, num_serie, cod_producto, ind_procequi, fec_alta, ind_propiedad,';
        sSql:=sSql || 'cod_bodega, tip_stock, cod_articulo, ind_equiacc, cod_modventa, tip_terminal, cod_uso, cod_cuota,';
        sSql:=sSql || 'cod_estado, cap_code, cod_protocolo, num_velocidad, cod_frecuencia, cod_version, num_seriemec,';
        sSql:=sSql || 'des_equipo, cod_paquete, num_movimiento, cod_causa, ind_eqprestado, num_imei, cod_tecnologia,';
        sSql:=sSql || 'imp_cargo, tip_dto, val_dto) VALUES (' || EN_numabonado || ',' || EV_num_serie || ',';
        sSql:=sSql || EN_cod_producto || ',' || TRIM(EV_ind_procequi)  || ', SYSDATE, ' || EV_ind_propiedad || ',';
        /* Inicio CO-200603230013  (Soporte GSA 26/04/2006)
        sSql:=sSql || EN_cod_bodega || ',' || EN_tipstock || ',' || EN_codarticulo || ',' || EV_indequiacc || ',';*/
        sSql:=sSql || EN_cod_bodega || ',' || SN_tip_stock || ',' || EN_codarticulo || ',' || EV_indequiacc || ',';
        /* Fin CO-200603230013  (Soporte GSA 26/04/2006)  */
        sSql:=sSql || EN_cod_modventa || ',' || EV_tip_terminal || ',' || EN_coduso || ',' || EV_cod_cuota || ',';
        sSql:=sSql || EN_cod_estado || ',' || EN_capcode || ',' || EV_cod_protocolo || ',' || EN_num_velocidad || ',';
        sSql:=sSql || EN_cod_frecuencia || EN_cod_version || ',' || EV_num_seriemec || ',' || EV_des_equipo || ',';
        sSql:=sSql || EN_cod_paquete || ',' || EN_num_movimiento || ',' || EV_cod_causa || ',' || EV_ind_eqprestado || ',';
        sSql:=sSql || EV_num_imei || ',' || EV_cod_tecnologia || ',' || EN_imp_cargo || ',' || EV_tip_dto || ',' || EV_val_dto || ')';

        INSERT INTO ga_equipaboser (num_abonado, num_serie, cod_producto, ind_procequi, fec_alta, ind_propiedad,
        cod_bodega, tip_stock, cod_articulo, ind_equiacc, cod_modventa, tip_terminal,
        cod_uso, cod_cuota, cod_estado, cap_code, cod_protocolo, num_velocidad,
        cod_frecuencia, cod_version, num_seriemec, des_equipo, cod_paquete, num_movimiento,
        cod_causa, ind_eqprestado, num_imei, cod_tecnologia, imp_cargo, tip_dto, val_dto)
        VALUES (EN_numabonado, EV_num_serie, EN_cod_producto, TRIM(EV_ind_procequi), SYSDATE, EV_ind_propiedad, EN_cod_bodega,
        /* Inicio CO-200603230013  (Soporte GSA 26/04/2006)
        EN_tipstock, EN_codarticulo, EV_indequiacc, EN_cod_modventa, EV_tip_terminal, EN_coduso, EV_cod_cuota, */
        SN_tip_stock, EN_codarticulo, EV_indequiacc, EN_cod_modventa, EV_tip_terminal, EN_coduso, EV_cod_cuota,
        /* Fin CO-200603230013  (Soporte GSA 26/04/2006)  */
        EN_cod_estado, EN_capcode, EV_cod_protocolo, EN_num_velocidad, EN_cod_frecuencia, EN_cod_version,
        EV_num_seriemec, EV_des_equipo, EN_cod_paquete, EN_num_movimiento, EV_cod_causa, EV_ind_eqprestado,
        EV_num_imei, EV_cod_tecnologia, EN_imp_cargo, EV_tip_dto, EV_val_dto);

EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
--                           LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_IN_GA_EQUIPABOSER_PR('||EN_numabonado||','||EV_num_serie||','||EV_num_imei||');- ' || SQLERRM;
                             LV_des_error:= SQLERRM;

                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_IN_GA_EQUIPABOSER_PR', sSql, SQLCODE, LV_des_error );
END VE_IN_GA_EQUIPABOSER_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_UPD_GA_EQUIPABOSER_PR(
                                        EN_numabonado      IN ga_equipaboser.num_abonado%TYPE,
                                        EV_num_serie       IN ga_equipaboser.num_serie%TYPE,
                                        EV_num_imei               IN ga_equipaboser.num_imei%TYPE,
                                        SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
                                        )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_UPD_GA_EQUIPABOSER_PR"
        Lenguaje="PL/SQL"
        Fecha="02-09-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Modificar Tabla Equipos Seriados de Abonados de Productos</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_numabonado" Tipo="NUMERICO">Nro del abonado</param>
                        <param nom="EV_num_serie" Tipo="CARACTER">Numero de serie</param>
                        <param nom="EV_num_imei" Tipo="CARACTER">Numero de la simcard</param>
                </Entrada>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error      ge_errores_pg.DesEvent;
        sSql              ge_errores_pg.vQuery;

BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        sSql:='UPDATE ga_equipaboser ';
        sSql:=sSql || 'SET num_imei=' || EV_num_imei;
        sSql:=sSql || ' WHERE  num_abonado=' || EN_numabonado;
        sSql:=sSql || ' AND num_serie=' || EV_num_serie;
        UPDATE ga_equipaboser
        SET num_imei=EV_num_imei
        WHERE num_abonado=EN_numabonado
        AND num_serie=EV_num_serie;

EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_UPD_GA_EQUIPABOSER_PR('||EN_numabonado||','||EV_num_serie||','||EV_num_imei||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_UPD_GA_EQUIPABOSER_PR', sSql, SQLCODE, LV_des_error );
END VE_UPD_GA_EQUIPABOSER_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_MOD_ABOAMIST_PR(
                                EN_numabonado    IN         ga_aboamist.num_abonado%TYPE,
                                EN_codusuario    IN         ga_aboamist.cod_usuario%TYPE,
                                EN_codcliente    IN        ga_aboamist.cod_cliente%TYPE,
                                EN_codcuenta     IN        ga_aboamist.cod_cuenta%TYPE,
                                EN_codvendedor   IN        ga_aboamist.cod_vendedor%TYPE,
                                EN_codvenderaiz  IN             ve_vendedores.cod_vende_raiz%TYPE,
                                EV_num_imei      IN        ga_aboamist.num_imei%TYPE,
                                EV_codplantarif  IN             ga_aboamist.cod_plantarif%TYPE,
                                EN_numventa      IN        ga_aboamist.num_venta%TYPE,
                                EN_codvendealer  IN             ga_aboamist.cod_vendealer%TYPE,
                                EV_indproceq      IN            ga_aboamist.ind_procequi%TYPE,
                                SN_IMEI_ES_PAK    IN            NUMBER,
                                SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_MOD_ABOAMIST_PR"
        Lenguaje="PL/SQL"
        Fecha="30-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Modificar abonado prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_numabonado"   Tipo="NUMERICO">Nro de abonado</param>
                        <param nom="EN_codusuario"   Tipo="NUMERICO">Codigo del usuario</param>
                        <param nom="EN_codcliente"   Tipo="NUMERICO">Codigo del cliente</param>
                        <param nom="EN_codcuenta"    Tipo="NUMERICO">Codigo de la cuenta</param>
                        <param nom="EN_codvendedor"  Tipo="NUMERICO">Codigo del vendedor</param>
                        <param nom="EN_codvenderaiz" Tipo="VARCHAR2">Codigo del vendedor Raiz</param>
                        <param nom="EN_numventa"     Tipo="NUMERICO">Nro de la venta</param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        error_ejecucion   exception;
        LV_des_error      ge_errores_pg.DesEvent;
        LV_val_param      ged_parametros.val_parametro%TYPE;
        sSql              ge_errores_pg.vQuery;
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        IF TRIM(EV_num_imei) IS NULL THEN
                sSql:='UPDATE ga_aboamist usuario '||
                '       SET    cod_usuario='||EN_codusuario||','||
                '              cod_cliente='||EN_codcliente||','||
                '                  cod_cuenta='||EN_codcuenta||','||
                '                  cod_vendedor='||EN_codvendedor||','||
                '                  num_venta='||EN_numventa||','||
                '                  nom_usuarora=USER, '||
                '                  fec_alta=SYSDATE, '||
                '                  fec_activacion=SYSDATE '||
                '         fec_acepventa=NULL, ' ||
                '                  cod_vendedor_agente=' || EN_codvenderaiz ||','||
                '                  cod_plantarif=' || EV_codplantarif ||
                '                 ind_telefono=7' ||
                '       WHERE  usuario.num_abonado='||EN_numabonado;

                UPDATE ga_aboamist usuario
                SET    cod_usuario=EN_codusuario,
                cod_cliente=EN_codcliente,
                cod_cuenta=EN_codcuenta,
                cod_vendedor=EN_codvendedor,
                cod_vendealer=EN_codvendealer,
                num_venta=EN_numventa,
                nom_usuarora=USER,
                fec_alta=SYSDATE,
                fec_activacion=SYSDATE,
                fec_acepventa=NULL,
                /* INICIO: RA-200511030057 ; FECHA: 11/11/2005 ; USER:JEIM*/
                cod_vendedor_agente=EN_codvenderaiz,
                /* FIN: RA-200511030057 ; FECHA: 11/11/2005 ; USER:JEIM*/
                cod_plantarif=EV_codplantarif
                WHERE  usuario.num_abonado=EN_numabonado;
        ELSE
                sSql:='UPDATE ga_aboamist usuario '||
                '       SET    cod_usuario='||EN_codusuario||','||
                '              cod_cliente='||EN_codcliente||','||
                '                  cod_cuenta='||EN_codcuenta||','||
                '                  cod_vendedor='||EN_codvendedor||','||
                '                  num_venta='||EN_numventa||','||
                '                  nom_usuarora=USER, '||
                '         num_imei=' || EV_num_imei || ',' ||
                '         ind_procequi=' || EV_indproceq ||','||
                '                  fec_alta=SYSDATE, ' ||
                '                  fec_activacion=SYSDATE '||
                '         fec_acepventa=NULL, ' ||
                '                  cod_vendedor_agente=' || EN_codvenderaiz ||','||
                '                  cod_plantarif=' || EV_codplantarif ||
                '                 ind_telefono=7' ||
                '       WHERE  usuario.num_abonado='||EN_numabonado;

                IF EV_indproceq IS NULL THEN
                        BEGIN
                                UPDATE ga_aboamist usuario
                                SET    cod_usuario=EN_codusuario,
                                cod_cliente=EN_codcliente,
                                cod_cuenta=EN_codcuenta,
                                cod_vendedor=EN_codvendedor,
                                num_venta=EN_numventa,
                                nom_usuarora=USER,
                                num_imei=EV_num_imei,
                                fec_alta=SYSDATE,
                                ind_procequi=EV_indproceq,
                                fec_activacion=SYSDATE,
                                cod_vendealer=EN_codvendealer,
                                fec_acepventa=NULL,
                                /* INICIO: RA-200511030057 ; FECHA: 11/11/2005 ; USER:JEIM*/
                                cod_vendedor_agente=EN_codvenderaiz,
                                /* FIN: RA-200511030057 ; FECHA: 11/11/2005 ; USER:JEIM*/
                                cod_plantarif=EV_codplantarif
                                WHERE  usuario.num_abonado=EN_numabonado;
                        END;
                ELSE
                        BEGIN
                                sSql:='UPDATE ga_aboamist usuario '||
                                '       SET    cod_usuario='||EN_codusuario||','||
                                '              cod_cliente='||EN_codcliente||','||
                                '                  cod_cuenta='||EN_codcuenta||','||
                                '                  cod_vendedor='||EN_codvendedor||','||
                                '                  num_venta='||EN_numventa||','||
                                '                  nom_usuarora=USER, '||
                                '                  fec_alta=SYSDATE, '||
                                '                  fec_activacion=SYSDATE '||
                                '         fec_acepventa=NULL, ' ||
                                '                  cod_vendedor_agente=' || EN_codvenderaiz ||','||
                                '                  cod_plantarif=' || EV_codplantarif ||
                                '                 ind_telefono=7' ||
                                '       WHERE  usuario.num_abonado='||EN_numabonado;

                                UPDATE ga_aboamist usuario
                                SET    cod_usuario=EN_codusuario,
                                cod_cliente=EN_codcliente,
                                cod_cuenta=EN_codcuenta,
                                cod_vendedor=EN_codvendedor,
                                cod_vendealer=EN_codvendealer,
                                num_venta=EN_numventa,
                                nom_usuarora=USER,
                                fec_alta=SYSDATE,
                                fec_activacion=SYSDATE,
                                fec_acepventa=NULL,
                                /* INICIO: HO-200511280036 -> XO-200512061027 ; FECHA: 11/11/2005 ; USER:JEIM*/
                                num_imei=EV_num_imei,
                                /* FIN: HO-200511280036 -> XO-200512061027 ; FECHA: 11/11/2005 ; USER:JEIM*/
                                /* INICIO: RA-200511030057 ; FECHA: 11/11/2005 ; USER:JEIM*/
                                cod_vendedor_agente=EN_codvenderaiz,
                                /* FIN: RA-200511030057 ; FECHA: 11/11/2005 ; USER:JEIM*/
                                cod_plantarif=EV_codplantarif
                                WHERE  usuario.num_abonado=EN_numabonado;
                        END;
                END IF;
        END IF;
        /*
        PERMITE DEJAR LAS TABLAS GA_ABOAMIST Y GA_VENTAS IGUALES
        COMO SI FUERA UNA VENTA ECHA POR AMISTAR.
        */
        sSql:='ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn(CAT_TRIB_FACT,'||CV_codmodulo||','||CN_codprod||')';
        IF (NOT Ve_Recuperaparametros_Sms_Pg.ve_recupera_parametros_fn('COD_AMI_TIPCONTRA',CV_codmodulo,CN_codprod,LV_val_param,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) OR LV_val_param IS NULL  THEN
                RAISE error_ejecucion;
        END IF;
        sSql := ' UPDATE GA_VENTAS SET COD_VENDEDOR= ' || EN_codvendedor || ',
        COD_VENDEDOR_AGENTE= ' || EN_codvenderaiz || ',
        COD_CLIENTE = ' || EN_codcliente || ',
        COD_TIPCONTRATO = ' || LV_val_param || ' WHERE NUM_VENTA= ' || EN_numventa;

        UPDATE GA_VENTAS SET
        COD_VENDEDOR=EN_codvendedor,
        COD_VENDEDOR_AGENTE=EN_codvenderaiz,
        COD_CLIENTE = EN_codcliente,
        COD_TIPCONTRATO = LV_val_param
        WHERE
        NUM_VENTA=EN_numventa;

EXCEPTION
        WHEN error_ejecucion THEN
                SN_cod_retorno:=764;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_MOD_ABOAMIST_PR('||EN_numabonado||','||EN_codusuario||','||EN_codcliente||','||EN_codcuenta||','||EN_codvendedor||','||EN_numventa||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_MOD_ABOAMIST_PR', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_MOD_ABOAMIST_PR('||EN_numabonado||','||EN_codusuario||','||EN_codcliente||','||EN_codcuenta||','||EN_codvendedor||','||EN_numventa||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_MOD_ABOAMIST_PR', sSql, SQLCODE, LV_des_error );
END VE_MOD_ABOAMIST_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_EXISTE_PLANTARIF_PR (
                                EV_codplantarif  IN         ta_plantarif.cod_plantarif%TYPE,
                                SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_EXISTE_PLANTARIF_PR"
        Lenguaje="PL/SQL"
        Fecha="16-11-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Igor Gonzalez"
        Migraci줻="""
        Ambiente Desarrollo="BD">
        <Retorno>BOOLEAN</Retorno>
        <Descripci줻>Validaci줻 si existe plan tarifario</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_codplantarif" Tipo="CARACTER">C줰igo del plan tarifario</param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error        ge_errores_pg.DesEvent;
        sSql                ge_errores_pg.vQuery;
        LV_existeplan       NUMBER;
        error_datos             EXCEPTION;
        CV_TIPPLAN_VALIDO   CONSTANT ged_parametros.nom_parametro%TYPE:='TIPPLAN_VALIDOS';
        LV_VAL_TIPLANVALID  ged_parametros.VAL_PARAMETRO%TYPE;
        LV_COMMA            CHAR(1):=' ';
        CV_SEPARADOR        CHAR(1):=',';
        LV_glosa_exito      ged_codigos.des_valor%TYPE;
        LB_retorno          BOOLEAN;
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        LV_existeplan:=0;
        LV_VAL_TIPLANVALID := ge_fn_devvalparam(CV_codmodulo, CN_codprod, CV_TIPPLAN_VALIDO );
        IF LV_VAL_TIPLANVALID='ERROR' THEN
                SN_cod_retorno:=156;  --No es posible ejecutar este servicio. . --
                RAISE error_datos;
        END IF;
        sSql:='SELECT COUNT(1)'||
        ' FROM  TA_PLANTARIF TARIF '||
        ' WHERE TARIF.COD_PLANTARIF=' || '''' || EV_CODPLANTARIF || '''';
        SELECT COUNT(1) INTO LV_existeplan
        FROM TA_PLANTARIF TARIF
        WHERE TARIF.COD_PLANTARIF= EV_CODPLANTARIF;

        IF LV_existeplan=0 THEN
                SN_cod_retorno:=232;  --C줰igo de plan no definido en SCL. --
                RAISE error_datos;
        END IF;
        LV_existeplan:=0;
        sSql:= sSql || ' AND SYSDATE BETWEEN TARIF.FEC_DESDE AND NVL(TARIF.FEC_HASTA, SYSDATE)';
        SELECT COUNT(1) INTO LV_existeplan
        FROM TA_PLANTARIF TARIF
        WHERE TARIF.COD_PLANTARIF= EV_CODPLANTARIF
        AND SYSDATE BETWEEN TARIF.FEC_DESDE AND NVL(TARIF.FEC_HASTA, SYSDATE);
        IF LV_existeplan=0 THEN
                SN_cod_retorno:=233;  --Plan no se encuentra vigente. --
                RAISE error_datos;
        END IF;
        LV_existeplan:=0;
        sSql:= sSql || ' AND TARIF.COD_TIPLAN IN (';
        WHILE INSTR(LV_VAL_TIPLANVALID, CV_SEPARADOR )>0 LOOP
                sSql:= sSql || LV_COMMA || '''' || SUBSTR( LV_VAL_TIPLANVALID,1 , INSTR(LV_VAL_TIPLANVALID, CV_SEPARADOR )-1) || '''';
                LV_VAL_TIPLANVALID := SUBSTR( LV_VAL_TIPLANVALID,INSTR(LV_VAL_TIPLANVALID, CV_SEPARADOR )+1) ;
                LV_COMMA := ',';
        END LOOP;
        sSql:= sSql || LV_COMMA || '''' || LV_VAL_TIPLANVALID || '''';
        sSql:= sSql || ')';
        EXECUTE IMMEDIATE sSql INTO LV_existeplan;
        IF LV_existeplan=0 THEN
                SN_cod_retorno:=528;  -- Tipo de plan no es valido. --
                RAISE error_datos;
        END IF;
        LB_retorno:=ve_recuperaparametros_sms_pg.ve_recupera_glosa_fn('GA', 'DESBLOQUEO_PREPAGO','PROCESO_EXITOSO', LV_glosa_exito,SN_cod_retorno,
        SV_mens_retorno, SN_num_evento);
        IF NOT LB_retorno THEN
                SN_cod_retorno:=0;
                SV_mens_retorno:=NULL;
        ELSE
                SV_mens_retorno:= LV_glosa_exito;
        END IF;
EXCEPTION
        WHEN  error_datos THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='error_datos: VE_desbloqueaprepago_sms_PG.VE_EXISTE_PLANTARIF_FN('|| EV_codplantarif || ');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0',USER,'VE_desbloqueaprepago_sms_PG.VE_EXISTE_PLANTARIF_FN', sSql, SQLCODE, LV_des_error );
        WHEN  OTHERS THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error:='Others VE_desbloqueaprepago_sms_PG.VE_EXISTE_PLANTARIF_FN('||EV_codplantarif||');- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0',USER,'VE_desbloqueaprepago_sms_PG.VE_EXISTE_PLANTARIF_FN', sSql, SQLCODE, LV_des_error );
                END VE_EXISTE_PLANTARIF_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_OBTIENE_DATOS_DEALER_PR(
                                EN_codvendealer           IN         ve_vendealer.cod_vendealer%TYPE,
                                EV_codcanal               IN  VARCHAR2,
                                SN_codclientedealer  OUT NOCOPY ve_vendedores.cod_cliente%TYPE,
                                SN_codvendedor            OUT NOCOPY ve_vendedores.cod_vendedor%TYPE,
                                SN_coddireccion           OUT NOCOPY ve_vendedores.cod_direccion%TYPE,
                                SV_codvenderaiz   OUT NOCOPY ve_vendedores.cod_vende_raiz%TYPE,
                                SN_cod_retorno            OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno           OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento             OUT NOCOPY ge_errores_pg.Evento
                                )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_OBTIENE_DATOS_DEALER_PR"
        Lenguaje="PL/SQL"
        Fecha="31-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Obtener datos del dealer</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_codvendealer" Tipo="NUMERICO">C줰igo del dealer</param>
                        <param nom=" EV_codcanal" Tipo="VARCHAR">C줰igo de canal (Indirecto/Directo)</param>
                </Entrada>
                <Salida>
                        <param nom="SN_codclientedealer" Tipo="NUMERICO">Codigo del cliente dealer</param>
                        <param nom="SN_codvendedor"     Tipo="NUMERICO">Codigo del vendedor dealer</param>
                        <param nom="SN_coddireccion"    Tipo="NUMERICO">Codigo de direccion del dealer</param>
                        <param nom="SV_codvenderaiz"    Tipo="CARACTER>Codigo Master Dealer</param>
                        <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"      Tipo="NUMERICO">Numero de Evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error      ge_errores_pg.DesEvent;
        sSql              ge_errores_pg.vQuery;
        error_datos              EXCEPTION;
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SN_codclientedealer:=NULL;
        SN_codvendedor:=NULL;
        SN_coddireccion:=NULL;

        IF TRIM(UPPER(EV_codcanal))='I' THEN

                sSql:='SELECT v.cod_cliente, v.cod_vendedor, v.cod_direccion '||
                '  INTO SN_codclientedealer, SN_codvendedor, SN_coddireccion '||
                '  FROM ve_vendealer d, ve_vendedores v '||
                ' WHERE d.cod_vendealer='||EN_codvendealer||
                '   AND v.cod_vendedor=d.cod_vendedor '||
                '   AND d.cod_tipcomis=v.cod_tipcomis ';

                SELECT v.cod_cliente, v.cod_vendedor, v.cod_direccion, v.cod_vende_raiz
                INTO SN_codclientedealer, SN_codvendedor, SN_coddireccion, SV_codvenderaiz
                FROM ve_vendealer d, ve_vendedores v
                WHERE d.cod_vendealer=EN_codvendealer
                AND v.cod_vendedor=d.cod_vendedor
                AND d.cod_tipcomis=v.cod_tipcomis;

                --Inicio Inc. 175777 - 13/10/2011 - FADL
                IF(SN_codclientedealer = 1 and SN_codvendedor<>SV_codvenderaiz) THEN

                    SN_codclientedealer := pv_busca_cliente_vendedor_fn(    SN_codvendedor,
                                                                            sn_cod_retorno,
                                                                            sv_mens_retorno,
                                                                            sn_num_evento
                                                                        );
                ELSE   
                    IF SN_codclientedealer = 1 THEN                                                                  
                        RAISE error_datos;
                    END IF;                                                                         
                END IF;
                --Fin Inc. 175777 - 13/10/2011 - FADL

        ELSIF TRIM(UPPER(EV_codcanal))='D' THEN

                sSql:='SELECT v.cod_cliente, v.cod_vendedor, v.cod_direccion '||
                '  INTO SN_codclientedealer, SN_codvendedor, SN_coddireccion '||
                '  FROM ve_vendedores v '||
                ' WHERE v.cod_vendedor='||EN_codvendealer;

                SELECT v.cod_cliente, v.cod_vendedor, v.cod_direccion, v.cod_vende_raiz
                INTO   SN_codclientedealer, SN_codvendedor, SN_coddireccion, SV_codvenderaiz
                FROM   ve_vendedores v
                WHERE  v.cod_vendedor=EN_codvendealer;

                --Inicio Inc. 175777 - 13/10/2011 - FADL
                IF(SN_codclientedealer = 1 and SN_codvendedor<>SV_codvenderaiz) THEN

                    SN_codclientedealer := pv_busca_cliente_vendedor_fn(    SN_codvendedor,
                                                                            sn_cod_retorno,
                                                                            sv_mens_retorno,
                                                                            sn_num_evento
                                                                        );
                ELSE                                                                        
                    IF SN_codclientedealer = 1 THEN                                                                  
                        RAISE error_datos;
                    END IF;    
                END IF;
                --Fin Inc. 175777 - 13/10/2011 - FADL

        END IF;
        IF SN_codclientedealer IS NULL THEN
                RAISE error_datos;
        END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=480; --ERROR_NO_DATA_VENDEALER_1
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='no_data_found: VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_DEALER_PR('||EN_codvendealer||')- '||SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_DEALER_PR', sSql, SQLCODE, LV_des_error );
        WHEN error_datos THEN
                SN_cod_retorno:=480; --ERROR_NO_DATA_VENDEALER_1
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='error_datos:VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_DEALER_PR('||EN_codvendealer||')';
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_DEALER_PR', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_DEALER_PR('||EN_codvendealer||')- '||SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_DEALER_PR', sSql, SQLCODE, LV_des_error );
END VE_OBTIENE_DATOS_DEALER_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_OBTIENE_CUENTA_PR(
                                EV_tipident      IN         ga_cuentas.cod_tipident%TYPE,
                                EV_numident      IN         ga_cuentas.num_ident%TYPE,
                                SN_codcuenta     OUT NOCOPY ga_cuentas.cod_cuenta%TYPE,
                                SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento>
        Nombre = "VE_OBTIENE_CUENTA_PR"
        Lenguaje="PL/SQL"
        Fecha="31-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻> Retorna el codigo de cuenta asociado a un num. ident.</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_tipident" Tipo="CARACTER">Tipo Identidad</param>
                        <param nom="EV_numident" Tipo="CARACTER">Num. Identidad</param>
                </Entrada>
                <Salida>
                        <param nom="SN_codcuenta"     Tipo="NUMERICO">Codigo cuenta</param>
                        <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error     ge_errores_pg.DesEvent;
        sSql             ge_errores_pg.vQuery;

BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SN_codcuenta:=NULL;

        sSql:='SELECT a.cod_cuenta INTO SN_codcuenta '||
        '  FROM ga_cuentas a '||
        ' WHERE a.cod_tipident='''||EV_tipident||''||
        '   AND a.num_ident='''||EV_numident||'';

        SELECT a.cod_cuenta INTO SN_codcuenta
        FROM ga_cuentas a
        WHERE a.cod_tipident=EV_tipident
        AND a.num_ident=EV_numident;

EXCEPTION
        WHEN NO_DATA_FOUND THEN -- NO es error por que al no existir cuenta el proceso genera una nueva para el abonado.
                                NULL;
        WHEN TOO_MANY_ROWS THEN -- NO es error por que al existir mas de una cuenta el proceso genera una nueva para el abonado.
                            NULL;
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others: VE_desbloqueaprepago_sms_PG.VE_OBTIENE_CUENTA_PR('||EV_tipident||','||EV_numident||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_CUENTA_PR', sSql, SQLCODE, LV_des_error );
END VE_OBTIENE_CUENTA_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_OBTIENE_CLIENTE_PR(
                                EV_tipident     IN  ga_cuentas.cod_tipident%TYPE,
                                EV_numident      IN  ga_cuentas.num_ident%TYPE,
                                EN_codcuenta     IN  ga_cuentas.cod_cuenta%TYPE,
                                SN_codcliente    OUT NOCOPY ge_clientes.cod_cliente%TYPE,
                                SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento>
        Nombre = "VE_OBTIENE_CLIENTE_PR"
        Lenguaje="PL/SQL"
        Fecha="31-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
          Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻> Retorna el codigo del cliente asociado a un num. ident.</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_tipident" Tipo="CARACTER">Tipo Identidad</param>
                        <param nom="EV_numident" Tipo="CARACTER">Num. Identidad</param>
                        <param nom="EN_codcuenta"     Tipo="NUMERICO">Codigo cuenta</param>
                </Entrada>
                <Salida>
                        <param nom="SN_codcliente"     Tipo="NUMERICO">Codigo del cliente</param>
                        <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error    ge_errores_pg.DesEvent;
        sSql            ge_errores_pg.vQuery;
        LN_cod_ciclo    ge_clientes.cod_cliente%TYPE;
        LV_val_param    ged_parametros.val_parametro%TYPE;
        error_datos     EXCEPTION;

BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SN_codcliente:=NULL;
        LN_cod_ciclo:=NULL;
        LV_val_param:=NULL;

        sSql:='ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn('||CV_ciclo_ami||','||CV_codmodulo||','||CN_codprod||')';
        IF (NOT ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn(CV_ciclo_ami,CV_codmodulo,CN_codprod,LV_val_param,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) OR TRIM(LV_val_param) IS NULL  THEN
                RAISE error_datos;
        END IF;

        sSql:='LN_cod_ciclo:=TO_NUMBER(TRIM(LV_val_param)) -- LV_val_param: '||LV_val_param;
        LN_cod_ciclo:=TO_NUMBER(TRIM(LV_val_param));

        sSql:='SELECT f.cod_cliente INTO SN_codcliente '||
        ' FROM ge_clientes f '||
        ' WHERE f.cod_cuenta='||EN_codcuenta||
        ' AND f.ind_agente=''N'||
        ' AND f.cod_ciclo='||LN_cod_ciclo||
        ' AND rownum<=1';

        SELECT f.cod_cliente  INTO SN_codcliente
        FROM ge_clientes f
        WHERE f.cod_cuenta=EN_codcuenta
        AND f.ind_agente='N'
        AND f.cod_ciclo=LN_cod_ciclo
        AND ROWNUM <=1;

EXCEPTION
        WHEN NO_DATA_FOUND THEN -- No es error puesto que al no existir cliente asociado se crea un nuevo
                NULL;
        WHEN error_datos THEN
                SN_cod_retorno:=764; --ERROR_NO_DATA_CICLO...
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='error_datos: VE_desbloqueaprepago_sms_PG.VE_OBTIENE_CLIENTE_PR('||EV_tipident||','||EV_numident||','||EN_codcuenta||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_CLIENTE_PR', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others: VE_desbloqueaprepago_sms_PG.VE_OBTIENE_CLIENTE_PR('||EV_tipident||','||EV_numident||','||EN_codcuenta||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_CLIENTE_PR', sSql, SQLCODE, LV_des_error );
END VE_OBTIENE_CLIENTE_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_OBTIENENUMABONADO_PR(
                                        EN_codcliente_dist IN         ga_aboamist.cod_cliente_dist%TYPE,
                                        EV_icc           IN         ga_aboamist.num_serie%TYPE,
                                        SN_numabonado      OUT NOCOPY ga_aboamist.num_abonado%TYPE,
                                        SV_codtecno        OUT NOCOPY ga_aboamist.cod_tecnologia%TYPE,
                                        SV_tipterminal     OUT NOCOPY ga_aboamist.tip_terminal%TYPE,
                                        SV_numseriehex     OUT NOCOPY ga_aboamist.num_seriehex%TYPE,
                                        SN_codcentral      OUT NOCOPY ga_aboamist.cod_central%TYPE,
                                        SN_numcelular      OUT NOCOPY ga_aboamist.num_celular%TYPE,
                                        SV_nummin          OUT NOCOPY ga_aboamist.num_min%TYPE,
                                        SV_indtelefono   OUT NOCOPY ga_aboamist.ind_telefono%TYPE,
                                        SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
                                        )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_OBTIENENUMABONADO_PR"
        Lenguaje="PL/SQL"
        Fecha="30-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Obtener datos del abonado prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_codcliente_dist" Tipo="NUMERICO">C줰igo del cliente distribuidor</param>
                        <param nom="EV_imsi"            Tipo="CARACTER">Imsi asociado al abonado (imei)</param>
                </Entrada>
                <Salida>
                        <param nom="SN_numabonado"     Tipo="NUMERICO">N즡ero de abonado</param>
                        <param nom="SV_codtecno"       Tipo="CARACTER">Tecnolog죂 abonado</param>
                        <param nom="SV_tipterminal"    Tipo="CARACTER">Tipo terminal abonado</param>
                        <param nom="SV_numseriehex"    Tipo="CARACTER">N즡ero de serie en base hexadecimal</param>
                        <param nom="SN_codcentral"     Tipo="NUMERICO">Central asociada al abonado</param>
                        <param nom="SN_numcelular"     Tipo="NUMERICO">N즡ero celular de abonado</param>
                        <param nom="SV_nummin"         Tipo="CARACTER">MIN</param>
                        <param nom="SV_indtelefono"    Tipo="CARACTER">Indicador de telefono</param>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error       ge_errores_pg.DesEvent;
        sSql               ge_errores_pg.vQuery;
        LV_situalta        ga_situabo.cod_situacion%TYPE;
        LB_retorno                 BOOLEAN;
        LV_aplicmay                ged_parametros.val_parametro%TYPE;
        LV_coduso                  al_series.cod_uso%TYPE;
        LV_desuso                  al_usos.des_uso%TYPE;
        LV_codart                  al_articulos.cod_articulo%TYPE;
        LV_desart                  al_articulos.des_articulo%TYPE;
        LV_errserv                 VARCHAR2(100);
        LN_postpago                NUMBER;
        ERR_EXISTE_POSPAGO EXCEPTION;
        LE_PARAM EXCEPTION;
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SN_numabonado:=NULL;
        SV_codtecno:=NULL;
        SV_tipterminal:=NULL;
        SV_numseriehex:=NULL;
        SN_codcentral:=NULL;
        SN_numcelular:=NULL;
        SV_nummin:=NULL;

        LV_situalta :=CV_alta_act_abonado;


        sSql:='SELECT count(0) INTO LN_postpago FROM ga_aboamist a '||
        ' WHERE a.cod_cliente='||EN_codcliente_dist||
        '   AND a.num_serie='''||EV_icc||
        '   AND a.cod_situacion=' || LV_situalta;

        SELECT count(0)
        INTO   LN_postpago
        FROM  ga_abocel a
        WHERE a.cod_cliente=EN_codcliente_dist
        AND a.num_serie=EV_icc
        AND a.cod_situacion=LV_situalta;

        IF LN_postpago = 0 THEN
                sSql:=' SELECT a.num_abonado, a.cod_tecnologia, a.tip_terminal, '||
                '        a.num_seriehex, a.cod_central, a.num_celular, '||
                '        a.num_min, a.ind_telefono'||
                '   INTO SN_numabonado, SV_codtecno, SV_tipterminal, '||
                '        SV_numseriehex, SN_codcentral, SN_numcelular, '||
                '        SV_nummin, SV_indtelefono '||
                '   FROM ga_aboamist a '||
                '  WHERE a.cod_cliente='||EN_codcliente_dist||
                '    AND a.cod_cliente=a.cod_cliente_dist '||
                '    AND a.num_serie='''||EV_icc||
                '    AND a.cod_situacion=' || LV_situalta;
                BEGIN
                        SELECT a.num_abonado, a.cod_tecnologia, a.tip_terminal,
                        a.num_seriehex, a.cod_central, a.num_celular,
                        a.num_min, a.ind_telefono
                        INTO SN_numabonado, SV_codtecno, SV_tipterminal,
                        SV_numseriehex, SN_codcentral, SN_numcelular,
                        SV_nummin, SV_indtelefono
                        FROM  ga_aboamist a
                        WHERE  a.cod_cliente=EN_codcliente_dist
                        AND  a.cod_cliente=a.cod_cliente_dist
                        AND  a.num_serie=EV_icc
                        AND  a.cod_situacion=LV_situalta;
                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        SN_numabonado:=NULL;
                END;
-- ***** P-VIR_06002 MAYORISTAS ****
                IF SN_numabonado IS NULL THEN
                        LB_retorno:= ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn('APLICA_MODCRED_MAYOR', 'GA', 1, LV_aplicmay, SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                        IF NOT LB_retorno THEN
                                RAISE LE_PARAM;
                        END IF;
                        IF TRIM(LV_aplicmay)='TRUE' THEN
                                NP_TRANSACCIONES_WEB_PG.NP_ORIGENVENTA_PR(EV_icc, 2, LV_coduso, LV_desuso, LV_codart, LV_desart, LV_errserv);
                                IF LV_coduso IS NOT NULL AND LV_desuso IS NOT NULL AND LV_codart IS NOT NULL AND LV_desart IS NOT NULL THEN
                                        SELECT a.num_abonado, a.cod_tecnologia, a.tip_terminal,
                                        a.num_seriehex, a.cod_central, a.num_celular,
                                        a.num_min, a.ind_telefono
                                        INTO SN_numabonado, SV_codtecno, SV_tipterminal,
                                        SV_numseriehex, SN_codcentral, SN_numcelular,
                                        SV_nummin, SV_indtelefono
                                        FROM  ga_aboamist a
                                        WHERE  a.cod_cliente=a.cod_cliente_dist
                                        AND  a.num_serie=EV_icc
                                        AND  a.cod_situacion=LV_situalta;
                                ELSE
                                        RAISE NO_DATA_FOUND;
                                END IF;
                        END IF;
                END IF;
-- ***** P-VIR_06002 MAYORISTAS ****
        ELSE
                RAISE ERR_EXISTE_POSPAGO;
        END IF;


EXCEPTION
WHEN ERR_EXISTE_POSPAGO THEN
                SN_cod_retorno:=758; -- Caso  de Uso
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_OBTIENENUMABONADO_PR('||EN_codcliente_dist||','||EV_icc||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENENUMABONADO_PR', sSql, SQLCODE, LV_des_error );
WHEN LE_PARAM THEN
                SN_cod_retorno:=156; --ERROR_NO_DATA_PARAM
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_OBTIENENUMABONADO_PR('||EN_codcliente_dist||','||EV_icc||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENENUMABONADO_PR', sSql, SQLCODE, LV_des_error );
WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=757; --ERROR_NO_DATA_ABONADO  --ERROR_TOO_MANY_ABONADO
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_OBTIENENUMABONADO_PR('||EN_codcliente_dist||','||EV_icc||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENENUMABONADO_PR', sSql, SQLCODE, LV_des_error );
WHEN TOO_MANY_ROWS THEN
                SN_cod_retorno:=760; --ERROR_NO_DATA_ABONADO  --ERROR_TOO_MANY_ABONADO
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_OBTIENENUMABONADO_PR('||EN_codcliente_dist||','||EV_icc||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENENUMABONADO_PR', sSql, SQLCODE, LV_des_error );
WHEN OTHERS THEN
                SN_cod_retorno:=156; --ERROR_NO_DATA_ABONADO  --ERROR_TOO_MANY_ABONADO
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_OBTIENENUMABONADO_PR('||EN_codcliente_dist||','||EV_icc||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENENUMABONADO_PR', sSql, SQLCODE, LV_des_error );
END VE_OBTIENENUMABONADO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_creacuenta_PR(
                                EV_descta         IN ga_cuentas.des_cuenta%TYPE,
                                EV_nomresp                IN ga_cuentas.nom_responsable%TYPE,
                                EV_tipident               IN ga_cuentas.cod_tipident%TYPE,
                                EV_numident               IN ga_cuentas.num_ident%TYPE,
                                EN_coddireccion           IN ga_cuentas.cod_direccion%TYPE,
                                SN_codcta                 OUT NOCOPY ga_cuentas.cod_cuenta%TYPE,
                                SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
                                )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_creacuenta_PR"
        Lenguaje="PL/SQL"
        Fecha="31-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Crea una cuenta nueva</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_DESCTA" Tipo="CARACTER>Descripcion Cuenta</param>
                        <param nom="EV_NOMRESP" Tipo="CARACETR">Nombre responsable de la cuenta</param>
                        <param nom="EV_TIPIDENT" Tipo="CARACTER">Tipo identidad del titular de la cuenta</param>
                        <param nom="EV_NUMIDENT" Tipo="CARACTER">Numero identidad del titular de la cuenta</param>
                        <param nom="EN_CODDIRECCION" Tipo="NUMERICO">Codigo de direccion del titular de la cuenta</param>
                </Entrada>
                <Salida>
                        <param nom="SN_codcta"     Tipo="NUMERICO">Codigo de la cuenta creada</param>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error      ge_errores_pg.DesEvent;
        sSql             ge_errores_pg.vQuery;
        /*INICIO : RA-200511010031 ; FECHA : 24/11/2005 ; USER: JEIM*/
        SN_CODCATEGORIA NUMERIC;
        SN_CODCATRIBUT  VARCHAR(1);
        /*FIN : RA-200511010031 ; FECHA : 24/11/2005 ; USER: JEIM*/
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SN_codcta:=NULL;
        /*INICIO : RA-200511010031 ; FECHA : 24/11/2005 ; USER: JEIM*/

        /*Ini PF-VE-025 hpg*/
        --SN_CODCATEGORIA:=3;
        sSql:='SELECT val_parametro INTO SN_CODCATEGORIA FROM ged_parametros WHERE nom_parametro = ''COD_CATEMP_DEFAULT''';
        SELECT val_parametro
        INTO SN_CODCATEGORIA
        FROM ged_parametros
        WHERE nom_parametro = 'COD_CATEMP_DEFAULT';
        /*Fin PF-VE-025 hpg */
        SN_CODCATRIBUT:='F';
        /*FIN : RA-200511010031 ; FECHA : 24/11/2005 ; USER: JEIM*/

        sSql:='SELECT ga_seq_cuentas.NEXTVAL INTO SN_codcta FROM dual';
        SELECT ga_seq_cuentas.NEXTVAL INTO SN_codcta FROM dual;

        sSql:='INSERT INTO ga_cuentas '||
        ' (cod_cuenta, des_cuenta, tip_cuenta, nom_responsable, cod_tipident, num_ident, '||
        '  cod_direccion, fec_alta, ind_estado, '||
        '  tel_contacto, ind_sector, cod_clascta,cod_catribut, cod_categoria, '||
        '  cod_sector, cod_subcategoria, '||
        '  ind_multuso,ind_cliepotencial, '||
        '  des_razon_social,fec_inivta_pac, cod_tipcomis,nom_usuario_asesor, fec_nacimiento) '||
        ' VALUES('||SN_codcta||','||EV_descta||','||CV_tipcuenta||','||EV_nomresp||','||EV_tipident||','||
        EV_numident||','||EN_coddireccion||', SYSDATE,'||CV_indestado||','||
        '  NULL, NULL, NULL, NULL, NULL,'||
        '  NULL, NULL,'||CV_indmuluso||','||CV_clienpoten||','||
        '  NULL, NULL, NULL, NULL, NULL)';

        INSERT INTO ga_cuentas
        (cod_cuenta, des_cuenta, tip_cuenta, nom_responsable, cod_tipident, num_ident,
        cod_direccion, fec_alta, ind_estado,
        tel_contacto, ind_sector, cod_clascta,cod_catribut, cod_categoria,
        cod_sector, cod_subcategoria,
        ind_multuso,ind_cliepotencial,
        des_razon_social,fec_inivta_pac, cod_tipcomis,nom_usuario_asesor, fec_nacimiento)
        VALUES(SN_codcta,EV_descta, CV_tipcuenta, EV_nomresp, EV_tipident, EV_numident,
        EN_coddireccion, SYSDATE, CV_indestado,
        NULL, NULL, NULL, SN_CODCATRIBUT, SN_CODCATEGORIA,
        NULL, NULL,
        CV_indmuluso, CV_clienpoten,
        NULL, NULL, NULL, NULL, NULL);

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=764; --ERROR_SEQ_CUENTA = no_data_found....
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others: VE_desbloqueaprepago_sms_PG.VE_creacuenta_PR('||EV_descta||','||EV_nomresp||','||EV_tipident||','||EV_numident||','||EN_coddireccion||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_creacuenta_PR', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156; --ERROR_SEQ_CUENTA = no_data_found....
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others: VE_desbloqueaprepago_sms_PG.VE_creacuenta_PR('||EV_descta||','||EV_nomresp||','||EV_tipident||','||EV_numident||','||EN_coddireccion||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_creacuenta_PR', sSql, SQLCODE, LV_des_error );
END VE_creacuenta_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_OBTIENE_DATOS_GENERALES_PR(
                                        SV_cod_calclien     OUT NOCOPY ga_datosgener.cod_calclien%TYPE,
                                        SV_cod_abc          OUT NOCOPY ga_datosgener.cod_abc%TYPE,
                                        SN_cod_123          OUT NOCOPY ga_datosgener.cod_123%TYPE,
                                        SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento       OUT NOCOPY ge_errores_pg.Evento
                                        )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_OBTIENE_DATOS_GENERALES_PR"
        Lenguaje="PL/SQL"
        Fecha="30-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Obtener datos desde la tabla de datos generales</Descripci줻>
                <Par퓅etros>
                <Entrada>
                </Entrada>
                <Salida>
                        <param nom="SV_cod_calclien"  Tipo="CARACTER">C줰igo de calidad de cliente defecto </param>
                        <param nom="SV_cod_abc"       Tipo="CARACTER">C줰igo inicial clasificaci줻 abc</param>
                        <param nom="SN_cod_123"       Tipo="NUMERICO">C줰igo inicial clasificaci줻 123</param>
                        <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error      ge_errores_pg.DesEvent;
        sSql             ge_errores_pg.vQuery;
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SV_cod_calclien:=NULL;
        SV_cod_abc:=NULL;
        SN_cod_123:=NULL;
        sSql:='SELECT m.cod_calclien, m.cod_abc, m.cod_123 '||
        ' INTO SV_cod_calclien,SV_cod_abc, SN_cod_123 '||
        ' FROM ga_datosgener m ';
        SELECT m.cod_calclien, m.cod_abc, m.cod_123
        INTO SV_cod_calclien,SV_cod_abc, SN_cod_123
        FROM ga_datosgener m;

EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno:=156; --ERROR_NO_DATA_DATOSGENER
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_GENERALES_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_GENERALES_PR', sSql, SQLCODE, LV_des_error );
END VE_OBTIENE_DATOS_GENERALES_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_INSERTAR_CLIENTE_PR(
                                EN_codcliente           IN ge_clientes.cod_cliente%TYPE,
                                EV_nomcliente           IN ge_clientes.nom_cliente%TYPE,
                                EV_codtipident          IN ge_clientes.cod_tipident%TYPE,
                                EV_numident             IN ge_clientes.num_ident%TYPE,
                                EV_codcalclien          IN ge_clientes.cod_calclien%TYPE,
                                EV_indsituacion         IN ge_clientes.ind_situacion%TYPE,
                                ED_fecalta              IN ge_clientes.fec_alta%TYPE,
                                EN_indfactur            IN ge_clientes.ind_factur%TYPE,
                                EV_indtraspaso          IN ge_clientes.ind_traspaso%TYPE,
                                EV_indagente            IN ge_clientes.ind_agente%TYPE,
                                ED_fecultmod            IN ge_clientes.fec_ultmod%TYPE,
                                EV_nomusuarora          IN ge_clientes.nom_usuarora%TYPE,
                                EV_indalta              IN ge_clientes.ind_alta%TYPE,
                                EN_codcuenta            IN ge_clientes.cod_cuenta%TYPE,
                                EV_indacepvent          IN ge_clientes.ind_acepvent%TYPE,
                                EV_codabc               IN ge_clientes.cod_abc%TYPE,
                                EN_cod123               IN ge_clientes.cod_123%TYPE,
                                EV_nomapeclien1         IN ge_clientes.nom_apeclien1%TYPE,
                                EN_codciclo             IN ge_clientes.cod_ciclo%TYPE,
                                EV_codidioma            IN ge_clientes.cod_idioma%TYPE,
                                EV_codoperadora         IN ge_clientes.cod_operadora%TYPE,
                                EV_nomapeclien2         IN ge_clientes.nom_apeclien2%TYPE,
                                EV_NUMTELEFONO          IN ge_clientes.tef_cliente1%TYPE,
                                SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento           OUT NOCOPY ge_errores_pg.Evento
                                )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento>
        Nombre = "VE_INSERTAR_CLIENYE_PR"
        Lenguaje="PL/SQL"
        Fecha="31-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Inserta un cliente en la ge_clientes</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_CODCLIENTE"            Tipo="NUMERICO">codigo cliente</param>
                        <param nom="EV_NOMCLIENTE"            Tipo="CARACTER">nombre cliente</param>
                        <param nom="EV_CODTIPIDENT"           Tipo="CARACTER">tipo cuenta</param>
                        <param nom="EV_NUMIDENT"              Tipo="CARACTER">numero identidad</param>
                        <param nom="EV_CODCALCLIEN"           Tipo="CARACTER">codigo calidad cliente</param>
                        <param nom="EV_INDSITUACION"          Tipo="CARACTER">indicador situacion</param>
                        <param nom="ED_FECALTA"               Tipo="FECHA">fecha alta</param>
                        <param nom="EN_INDFACTUR"             Tipo="NUMERICO">indicador facturacion</param>
                        <param nom="EV_INDTRASPASO"           Tipo="CARACTER">indicador traspaso</param>
                        <param nom="EV_INDAGENTE"             Tipo="CARACTER">indicador agente</param>
                        <param nom="ED_FECULTMOD"             Tipo="DATE">fecha ultima modificacion</param>
                        <param nom="EV_NOMUSUARORA"          Tipo="CARACTER">usuario oracle</param>
                        <param nom="EV_INDALTA"              Tipo="CARACTER">indicador alta</param>
                        <param nom="EV_CODCUENTA"            Tipo="NUMERICO">codigo cuenta</param>
                        <param nom="EV_INDACEPVENT"           Tipo="CARACTER">indicadior aceptacion venta</param>
                        <param nom="EV_CODABC"               Tipo="CARACTER">codigo clasificacion abc</param>
                        <param nom="EN_COD123"                Tipo="NUMERICO">codigo clasificacion 123</param>
                        <param nom="EV_NOMAPECLIEN1"         Tipo="CARACTER">apellido paterno cliente</param>
                        <param nom="EN_CODCICLO"            Tipo="NUMERICO">codigo ciclo</param>
                        <param nom="EV_CODIDIOMA"            Tipo="CARACTER"">codigo idioma</param>
                        <param nom="EV_CODOPERADORA"         Tipo="CARACTER"">codigo operadora</param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error            ge_errores_pg.DesEvent;
        sSql                    ge_errores_pg.vQuery;
        SV_IND_DEBITO           VARCHAR(1);
        SN_COD_SISPAGO          NUMERIC;
        SN_NUM_IDENTTRIB        ge_clientes.num_ident%TYPE;
        SN_COD_CATEGORIA        NUMERIC;
        LV_COLOR                GE_CLIENTES.COD_COLOR%TYPE;
        LV_CALIFICACION         GE_CLIENTES.COD_CALIFICACION%TYPE;
        LV_CREDITICIA           GE_CLIENTES.COD_CREDITICIA%TYPE;
        LV_SEGMENTO             GE_CLIENTES.COD_SEGMENTO%TYPE;
        LV_OFICINA                 GE_CLIENTES.COD_OFICINA%TYPE;

BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;

        select val_parametro
        into SN_COD_CATEGORIA
        from ged_parametros
        where
        nom_parametro='COD_CATEMP_DEFAULT' and
        cod_modulo='GA' and
        cod_producto=1;



        SV_IND_DEBITO:='M';
        SN_COD_SISPAGO:=1;
        SN_NUM_IDENTTRIB:=EV_numident;


        SELECT COD_DEFAULT
        INTO LV_COLOR
        FROM GE_INDDEFAULT_TD
        WHERE NOM_COLUMNA='COD_COLOR';

        SELECT COD_DEFAULT
        INTO LV_CALIFICACION
        FROM GE_INDDEFAULT_TD
        WHERE NOM_COLUMNA='COD_CALIFICACION';

        SELECT COD_DEFAULT
        INTO LV_CREDITICIA
        FROM GE_INDDEFAULT_TD
        WHERE NOM_COLUMNA='COD_CREDITICIA';

        SELECT COD_DEFAULT
        INTO LV_SEGMENTO
        FROM GE_INDDEFAULT_TD
        WHERE NOM_COLUMNA='COD_SEGMENTO'
        AND COD_WHERE='COD_TIPO = 3';
        
        SELECT COD_OFICINA
        INTO LV_OFICINA
        FROM VE_VENDEDORES
        WHERE COD_VENDEDOR=ncodvendealer; 


        sSql:='INSERT INTO ge_clientes (cod_cliente, nom_cliente, cod_tipident, num_ident, cod_calclien, ind_situacion,'||
        '               fec_alta, ind_factur, ind_traspaso, ind_agente, fec_ultmod,'||
        '               nom_usuarora, ind_alta, cod_cuenta, ind_acepvent, cod_abc, cod_123,'||
        '               nom_apeclien1,cod_ciclo,cod_idioma, cod_operadora)'||
        ' VALUES ('||EN_codcliente||','||EV_nomcliente||','||EV_codtipident||','||EV_numident||','||EV_codcalclien||','||EV_indsituacion||','||
        ED_fecalta||','||EN_indfactur||','||EV_indtraspaso||','||EV_indagente||','||ED_fecultmod||','||
        EV_nomusuarora||','||EV_indalta||','||EN_codcuenta||','||EV_indacepvent||','||EV_codabc||','||EN_cod123||','||
        EV_nomapeclien1||','||EN_codciclo||','||EV_codidioma||','||EV_codoperadora||')';

        INSERT INTO ge_clientes (cod_cliente, nom_cliente, cod_tipident, num_ident, cod_calclien, ind_situacion,
        fec_alta, ind_factur, ind_traspaso, ind_agente, fec_ultmod,
        nom_usuarora, ind_alta, cod_cuenta, ind_acepvent, cod_abc, cod_123,
        IND_DEBITO,COD_SISPAGO,COD_TIPIDTRIB,NUM_IDENTTRIB,COD_CATEGORIA,
        nom_apeclien1,cod_ciclo,cod_idioma, cod_operadora,nom_apeclien2,tef_cliente1,cod_oficina,cod_tipo,COD_COLOR,COD_CALIFICACION,COD_CREDITICIA, COD_SEGMENTO)
        VALUES (EN_codcliente, EV_nomcliente, EV_codtipident, EV_numident, EV_codcalclien, EV_indsituacion,
        ED_fecalta, EN_indfactur, EV_indtraspaso, EV_indagente, ED_fecultmod,
        EV_nomusuarora,EV_indalta, EN_codcuenta, EV_indacepvent, EV_codabc, EN_cod123,
        SV_IND_DEBITO,SN_COD_SISPAGO,EV_codtipident,SN_NUM_IDENTTRIB,SN_COD_CATEGORIA,
        EV_nomapeclien1,EN_codciclo,EV_codidioma,EV_codoperadora,EV_nomapeclien2,EV_NUMTELEFONO,LV_OFICINA,3,LV_COLOR,LV_CALIFICACION,LV_CREDITICIA,LV_SEGMENTO);

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=764;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_INSERTAR_CLIENTE_PR('||EN_codcliente||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_INSERTAR_CLIENTE_PR', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_INSERTAR_CLIENTE_PR('||EN_codcliente||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_INSERTAR_CLIENTE_PR', sSql, SQLCODE, LV_des_error );
END VE_INSERTAR_CLIENTE_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_creacliente_PR(
                                EN_codcta        IN ga_cuentas.cod_cuenta%TYPE,
                                EV_nomcliente     IN ge_clientes.nom_cliente%TYPE,
                                EV_tipident          IN ge_clientes.cod_tipident%TYPE,
                                EV_numident       IN ge_clientes.num_ident%TYPE,
                                EV_nomapeclien1   IN ge_clientes.nom_apeclien1%TYPE,
                                EV_nomapeclien2   IN ge_clientes.nom_apeclien2%TYPE,
                                EV_NUMTELEFONO    IN ge_clientes.tef_cliente1%TYPE,
                                SN_codcliente     OUT NOCOPY ge_clientes.cod_cliente%TYPE,
                                SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
                                )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_creacliente_PR"
        Lenguaje="PL/SQL"
        Fecha="31-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Crea un cliente nuevo</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_codcta" Tipo="NUMERICO">Codigo Cuenta</param>
                        <param nom="EV_nomcliente" Tipo="CARACTER">Nombre Cliente</param>
                        <param nom="EV_tipident" Tipo="CARACTER">Tipo identidad del cliente</param>
                        <param nom="EV_numident" Tipo="CARACTER">Numero identidad del cliente</param>
                </Entrada>
                <Salida>
                        <param nom="SN_codcliente"     Tipo="NUMERICO">Codigo del cliente cread</param>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        error_ejecucion              EXCEPTION;
        error_no_data_ciclo          EXCEPTION;
        error_no_data_operadora      EXCEPTION;
        LV_codoperadora              ge_operadora_scl.cod_operadora_scl%TYPE;
        LN_cod_ciclo                 ge_clientes.cod_cliente%TYPE;
        LV_val_param                 ged_parametros.val_parametro%TYPE;
        LV_cod_abc                   ga_datosgener.cod_abc%TYPE;
        LN_cod_123                   ga_datosgener.cod_123%TYPE;
        LV_cod_calclien              ga_datosgener.cod_calclien%TYPE;
        LV_des_error                 ge_errores_pg.DesEvent;
        sSql                         ge_errores_pg.vQuery;
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SN_codcliente:=NULL;
        LN_cod_ciclo:=NULL;
        LV_val_param:=NULL;
        LV_cod_calclien:=NULL;
        LV_cod_abc:=NULL;
        LN_cod_123:=NULL;
        LV_codoperadora:=NULL;


        --INI P-COL-05024 Asignacion codigo cliente
        SN_codcliente:=GE_SEQ_CLIENTES_FN(0);
        --FIN P-COL-05024 Asignacion codigo cliente

        sSql:='LV_codoperadora:=GE_FN_OPERADORA_SCL';
        --LV_codoperadora:=GE_FN_OPERADORA_SCL;
        LV_codoperadora:=GE_OBTIENE_OPERADORA_LOCAL_FN(SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF LV_codoperadora IS NULL THEN
                RAISE error_no_data_operadora;
        END IF;

        sSql:='ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn('||CV_ciclo_ami||','||CV_codmodulo||','||CN_codprod||')';
        IF (NOT ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn(CV_ciclo_ami,CV_codmodulo,CN_codprod,LV_val_param,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) OR LV_val_param IS NULL  THEN
                RAISE error_no_data_ciclo;
        END IF;

        sSql:='LN_cod_ciclo:=TO_NUMBER(TRIM(LV_val_param)) -- LV_val_param: '||LV_val_param;
        LN_cod_ciclo:=TO_NUMBER(TRIM(LV_val_param));

        sSql:='VE_OBTIENE_DATOS_GENERALES_PR();';
        VE_OBTIENE_DATOS_GENERALES_PR(LV_cod_calclien,LV_cod_abc,LN_cod_123,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<>0 THEN
                RAISE error_ejecucion;
        END IF;
        VE_INSERTAR_CLIENTE_PR(SN_codcliente, UPPER(EV_nomcliente), EV_tipident,EV_numident,LV_cod_calclien,CV_indsituacion, SYSDATE,CN_indfact,CV_indtraspaso,CV_indagente, SYSDATE,USER,CV_indalta, EN_codcta, CV_indacepta,LV_cod_abc,LN_cod_123,UPPER(EV_nomapeclien1),LN_cod_ciclo,CV_idioma,LV_codoperadora,UPPER(EV_nomapeclien2),EV_NUMTELEFONO,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<>0 THEN
                RAISE error_ejecucion;
        END IF;

EXCEPTION
        WHEN error_no_data_ciclo THEN
                SN_cod_retorno:=764; --ERROR_NO_DATA_CICLO
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='error_no_data_ciclo: VE_desbloqueaprepago_sms_PG.VE_creacliente_PR('||EN_codcta||','||EV_nomcliente||','||EV_tipident||','||EV_numident||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_creacliente_PR', sSql, SQLCODE, LV_des_error );
        WHEN error_no_data_operadora THEN
                SN_cod_retorno:=274; --ERROR_NO_DATA_OPERADORA
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='error_no_data_operadora: VE_desbloqueaprepago_sms_PG.VE_creacliente_PR('||EN_codcta||','||EV_nomcliente||','||EV_tipident||','||EV_numident||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_creacliente_PR', sSql, SQLCODE, LV_des_error );
        WHEN error_ejecucion THEN
                LV_des_error:='error_ejecucion: VE_desbloqueaprepago_sms_PG.VE_creacliente_PR('||EN_codcta||','||EV_nomcliente||','||EV_tipident||','||EV_numident||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_creacliente_PR', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others: VE_desbloqueaprepago_sms_PG.VE_creacliente_PR('||EN_codcta||','||EV_nomcliente||','||EV_tipident||','||EV_numident||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_creacliente_PR', sSql, SQLCODE, LV_des_error );
END VE_creacliente_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_MOD_USUAMIST_PR(
                                EV_numident IN      ga_usuamist.num_ident%TYPE,
                                EV_tipident      IN         ga_usuamist.cod_tipident%TYPE,
                                EV_nomusuario    IN         ga_usuamist.nom_usuario%TYPE,
                                EV_apeclien1     IN                     ga_usuamist.nom_apellido1%TYPE,
                                EV_apeclien2     IN                     ga_usuamist.nom_apellido2%TYPE,
                                EN_numabonado    IN         ga_usuamist.num_abonado%TYPE,
                                SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_MOD_USUAMIST_PR"
        Lenguaje="PL/SQL"
        Fecha="30-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Modifica el usuario de la tabla ga_usuamist</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_numident" Tipo="CARACTER">Num. Identidad</param>
                        <param nom="EV_tipident" Tipo="CARACTER">Tipo Identidad</param>
                        <param nom="EV_nomusuario" Tipo="CARACTER">Nombre usuario</param>
                        <param nom="EV_apeclien1" Tipo="CARACTER">Apellido 1 usuario</param>
                        <param nom="EV_apeclien2" Tipo="CARACTER">Apellido 2 usuario</param>
                        <param nom="EN_numabonado" Tipo="NUMERICO">Num. Abonado</param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error      ge_errores_pg.DesEvent;
        sSql             ge_errores_pg.vQuery;

BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;

        sSql:='UPDATE ga_usuamist usuario SET  num_ident='||EV_numident||','||
        ' cod_tipident='||EV_tipident||',fec_alta=SYSDATE,nom_usuario='||EV_nomusuario||
        ' WHERE usuario.num_abonado='||EN_numabonado;

        UPDATE ga_usuamist usuario
        SET  num_ident=EV_numident,
        cod_tipident=EV_tipident,
        fec_alta=SYSDATE,
        nom_usuario=EV_nomusuario,
        nom_apellido1=EV_apeclien1,
        nom_apellido2=EV_apeclien2
        WHERE usuario.num_abonado=EN_numabonado;

EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_MOD_USUAMIST_PR('||EV_numident||','||EV_tipident||','||EV_nomusuario||','||EN_numabonado||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_MOD_USUAMIST_PR', sSql, SQLCODE, LV_des_error );
END VE_MOD_USUAMIST_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_CONS_USUAMIST_PR(
                                EN_numabonado    IN         ga_usuamist.num_abonado%TYPE,
                                SN_cod_usuario   OUT NOCOPY ga_usuamist.cod_usuario%TYPE,
                                SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_CONS_USUAMIST_PR"
        Lenguaje="PL/SQL"
        Fecha="31-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Obtiene el codigo de usuario de un abonado/Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_numabonado" Tipo="NUMERICO>Num. Abonado</param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_usuario"     Tipo="NUMERICO">Codigo del usuario</param>
                        <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error      ge_errores_pg.DesEvent;
        sSql              ge_errores_pg.vQuery;
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SN_cod_usuario:=NULL;

        sSql:='SELECT  f.cod_usuario   '||
        '  INTO  SN_cod_usuario  '||
        ' FROM   ga_aboamist a,  '||
        '        ga_usuamist f   '||
        ' WHERE  a.num_abonado=  '||EN_numabonado||
        '   AND  a.cod_situacion='||CV_alta_act_abonado||
        '   AND  a.num_abonado  = f.num_abonado'||
        '   AND  f.fec_alta     = a.fec_alta';

        SELECT a.cod_usuario
        INTO   SN_cod_usuario
        FROM  ga_aboamist b,
        ga_usuamist a
        WHERE b.num_abonado =EN_numabonado
        AND b.cod_situacion =CV_alta_act_abonado
        AND b.num_abonado   = a.num_abonado
        AND a.fec_alta      = a.fec_alta;


EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=625; -- ERROR_NO_DATA_USUARIO,
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_CONS_USUAMIST_PR('||EN_numabonado||');-'|| SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno,'1.0',USER,'VE_desbloqueaprepago_sms_PG.VE_CONS_USUAMIST_PR', sSql, SQLCODE, LV_des_error );

        WHEN OTHERS THEN
                SN_cod_retorno:=156; -- ERROR_NO_DATA_USUARIO, ERROR_TOO_MANY_USUARIO
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_CONS_USUAMIST_PR('||EN_numabonado||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_CONS_USUAMIST_PR', sSql, SQLCODE, LV_des_error );
END VE_CONS_USUAMIST_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_OBTIENE_CENTRAL_TEC_PR(
                                        EV_codtecno         IN         ga_aboamist.cod_tecnologia%TYPE,
                                        SN_codactcen        OUT NOCOPY ga_actabo.cod_actcen%TYPE,
                                        SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento       OUT NOCOPY ge_errores_pg.Evento
                                        )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_OBTIENE_CENTRAL_TEC_PR"
        Lenguaje="PL/SQL"
        Fecha="30-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Obtener central para una tecnologia determinada</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_codtecno"     Tipo="CARACTER">Tecnolog죂</param>
                </Entrada>
                <Salida>
                        <param nom="SN_codactcen"     Tipo="NUMERICO">C줰igo de la central para un actabo</param>
                        <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error      ge_errores_pg.DesEvent;
        sSql              ge_errores_pg.vQuery;
        LN_cod_producto   ga_actabo.cod_producto%TYPE;
        error_datos               EXCEPTION;
        LV_val_param      ged_parametros.val_parametro%TYPE;
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SN_codactcen:=NULL;
        LV_val_param:=NULL;

        sSql:='ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn('||CV_prod_celular||','||CV_codmodulo||','||CN_codprod||')';
        IF (NOT ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn(CV_prod_celular,CV_codmodulo,CN_codprod,
        LV_val_param,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) OR
        LV_val_param IS NULL  THEN
        RAISE error_datos;
        END IF;

        sSql:='LN_cod_producto:=TO_NUMBER(TRIM(LV_val_param)) -- LV_val_param: '||LV_val_param;
        LN_cod_producto:=TO_NUMBER(TRIM(LV_val_param));

        sSql:='SELECT g.cod_actcen INTO SN_codactcen '||
        '  FROM ga_actabo g '||
        ' WHERE g.cod_producto='||LN_cod_producto||
        '   AND g.cod_modulo='||CV_codmodulo||
        '   AND g.cod_actabo='||CV_codactabo||
        '   AND g.cod_tecnologia='||EV_codtecno;

        SELECT g.cod_actcen INTO SN_codactcen
        FROM ga_actabo g
        WHERE g.cod_producto=LN_cod_producto
        AND g.cod_modulo=CV_codmodulo
        AND g.cod_actabo=CV_codactabo
        AND g.cod_tecnologia=EV_codtecno;

EXCEPTION
        WHEN error_datos THEN
                SN_cod_retorno:=124; --no_data CV_prod_celular
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='error_datos: VE_desbloqueaprepago_sms_PG.VE_OBTIENE_CENTRAL_TEC_PR('||EV_codtecno||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_CENTRAL_TEC_PR', sSql, SQLCODE, LV_des_error );
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=284; --ERROR_NO_DATA_COD_ACTCEN,
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_OBTIENE_CENTRAL_TEC_PR('||EV_codtecno||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_CENTRAL_TEC_PR', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156; --ERROR_NO_DATA_COD_ACTCEN,
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_OBTIENE_CENTRAL_TEC_PR('||EV_codtecno||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_CENTRAL_TEC_PR', sSql, SQLCODE, LV_des_error );
END VE_OBTIENE_CENTRAL_TEC_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_OBTIENE_NUM_IMSI(
                                EN_num_abonado    IN  NUMBER,
                                EV_imsi           OUT VARCHAR2,
                                SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
                                )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_OBTIENE_NUM_IMSI"
        Lenguaje="PL/SQL"
        Fecha="30-11-2005"
        Versi줻="1.0"
        Dise풹dor="Jorge Iba풽z"
        Programador="Jorge Iba풽z"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Servicio de negocio para desbloqueo de prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_num_abonado"        Tipo="CARACTER">Numero de Abonado</param>
                </Entrada>
                <Salida>
                        <param nom="EV_imsi"           Tipo="VARCHAR2">Codigo IMSI</param>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                        <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error         ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
BEGIN

                SN_cod_retorno := 0;
                SN_num_evento  := 0;

        sSql:='SELECT num_serie,num_imei,DECODE(cod_tecnologia,GSM,fn_recupera_imsi(num_serie),NULL) FROM   ga_aboamist WHERE  num_abonado= ' ||
                EN_num_abonado;

        SELECT DECODE(cod_tecnologia,'GSM',fn_recupera_imsi(num_serie),NULL)
        INTO   EV_imsi
        FROM   ga_aboamist
        WHERE  num_abonado=EN_num_abonado;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                NULL;
        WHEN OTHERS THEN
                SN_cod_retorno:=258;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others: VE_desbloqueaprepago_sms_PG.VE_OBTIENE_NUM_IMSI('||EN_num_abonado||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_NUM_IMSI', sSql, SQLCODE, LV_des_error );
END VE_OBTIENE_NUM_IMSI;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_IN_ICCMOVIMIENTO_PR(
                                        EN_num_movimiento     IN NUMBER,
                                        EN_num_abonado        IN NUMBER,
                                        EV_cod_modulo         IN VARCHAR2,
                                        EN_cod_estado         IN NUMBER,
                                        EN_cod_actuacion      IN NUMBER,
                                        EV_nom_usuarora       IN VARCHAR2,
                                        ED_fec_ingreso        IN DATE,
                                        EN_cod_central        IN NUMBER,
                                        EN_num_celular        IN NUMBER,
                                        EV_num_serie          IN VARCHAR2,
                                        EN_num_movpos         IN NUMBER,
                                        EN_num_movant         IN NUMBER,
                                        EV_tip_terminal       IN VARCHAR2,
                                        EV_cod_actabo         IN VARCHAR2,
                                        EV_num_min            IN VARCHAR2,
                                        EV_cod_servicios      IN VARCHAR2,
                                        EV_tip_tecnologia     IN VARCHAR2,
                                        EV_imsi               IN VARCHAR2,
                                        EV_imei               IN VARCHAR2,
                                        EV_icc                IN VARCHAR2,
                                        EV_plantarif               IN icc_movimiento.plan%TYPE,
                                        SN_cod_retorno        OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno       OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento         OUT NOCOPY ge_errores_pg.Evento
                                        )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_AGREGAR_ICCMOVIMIENTO_PR"
        Lenguaje="PL/SQL"
        Fecha="31-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Insertar en la ICC_movimientos</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_num_movimiento" Tipo="NUMERICO">numero movimiento</param>
                        <param nom="EN_num_abonado   " Tipo="NUMERICO">numero abonado</param>
                        <param nom="EV_cod_modulo    " Tipo="CARACTER">codigo modulo</param>
                        <param nom="EN_cod_estado    " Tipo="NUMERICO">codigo estado</param>
                        <param nom="EN_cod_actuacion " Tipo="NUMERICO">codigo actuacion</param>
                        <param nom="EV_nom_usuarora  " Tipo="CARACTER">user</param>
                        <param nom="ED_fec_ingreso   " Tipo="FECHA">fecha</param>
                        <param nom="EN_cod_central   " Tipo="NUMERICO">central</param>
                        <param nom="EN_num_celular   " Tipo="NUMERICO">numero celular</param>
                        <param nom="EV_num_serie     " Tipo="CARACTER">numero serie</param>
                        <param nom="EN_num_movpos    " Tipo="NUMERICO">numero movimiento posterior</param>
                        <param nom="EN_num_movant    " Tipo="NUMERICO">numero movimiento anterior</param>
                        <param nom="EV_tip_terminal  " Tipo="CARACTER">terminal</param>
                        <param nom="EV_cod_actabo    " Tipo="CARACTER">codigo actabo</param>
                        <param nom="EV_num_min       " Tipo="CARACTER">num min</param>
                        <param nom="EV_cod_servicios " Tipo="CARACTER">codigo servicio</param>
                        <param nom="EV_tip_tecnologia" Tipo="CARACTER">tecnologia</param>
                        <param nom="EV_imsi          " Tipo="CARACTER">imsi</param>
                        <param nom="EV_imei          " Tipo="CARACTER">imei</param>
                        <param nom="EV_icc           " Tipo="CARACTER">icc</param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error      ge_errores_pg.DesEvent;
        sSql              ge_errores_pg.vQuery;
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;

        sSql:='INSERT INTO ICC_MOVIMIENTO '||
        '    (num_movimiento,num_abonado,cod_modulo,cod_estado, '||
        '      cod_actuacion,nom_usuarora,fec_ingreso,cod_central, '||
        '      num_celular,num_serie,num_movpos,num_movant,tip_terminal, '||
        '      cod_actabo,num_min,cod_servicios,tip_tecnologia,imsi,imei,icc, plan) '||
        ' VALUES('||EN_num_movimiento||','||EN_num_abonado||','||EV_cod_modulo||','||
        EN_cod_estado||','||EN_cod_actuacion||','||EV_nom_usuarora||','||
        ED_fec_ingreso||','||EN_cod_central||','||EN_num_celular||','||
        EV_num_serie||','||EN_num_movpos||','||EN_num_movant||','||
        EV_tip_terminal||','||EV_cod_actabo||','||EV_num_min||','||EV_cod_servicios||','||
        EV_tip_tecnologia||','||EV_imsi||','||EV_imei||','||EV_icc|| ',' || EV_plantarif || ')';

        INSERT INTO ICC_MOVIMIENTO
        (num_movimiento,num_abonado,cod_modulo,cod_estado,
        cod_actuacion,nom_usuarora,fec_ingreso,cod_central,
        num_celular,num_serie,num_movpos,num_movant,tip_terminal,
        cod_actabo,num_min,cod_servicios,tip_tecnologia,imsi,imei,icc, plan)
        VALUES
        (EN_num_movimiento,EN_num_abonado,EV_cod_modulo,EN_cod_estado,
        EN_cod_actuacion,EV_nom_usuarora,ED_fec_ingreso,EN_cod_central,
        EN_num_celular,EV_num_serie,EN_num_movpos,EN_num_movant,
        EV_tip_terminal,EV_cod_actabo,EV_num_min,EV_cod_servicios,
        EV_tip_tecnologia,EV_imsi,EV_imei,EV_icc, EV_plantarif);
EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_AGREGAR_ICCMOVIMIENTO_PR('||EN_num_movimiento||','||EN_num_abonado||','||EV_cod_modulo||','||EN_cod_estado||','||EN_cod_actuacion||','||EV_nom_usuarora||','||ED_fec_ingreso||','||EN_cod_central||','||EN_num_celular||','||EV_num_serie||','||EN_num_movpos||','||EN_num_movant||','||EV_tip_terminal||','||EV_cod_actabo||','||EV_num_min||','||EV_cod_servicios||','||EV_tip_tecnologia||','||EV_imsi||','||EV_imei||','||EV_icc||')- '|| SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_AGREGAR_ICCMOVIMIENTO_PR', sSql, SQLCODE, LV_des_error );
END VE_IN_ICCMOVIMIENTO_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_IN_GAVENTAS_PR(
                                EN_numventa       IN ga_ventas.num_venta%TYPE,
                                EN_codproducto       IN ga_ventas.cod_producto%TYPE,
                                EV_codoficina        IN ga_ventas.cod_oficina%TYPE,
                                EV_codtipcomis       IN ga_ventas.cod_tipcomis%TYPE,
                                EN_codvendedor       IN ga_ventas.cod_vendedor%TYPE,
                                EN_codvendedoragente IN ga_ventas.cod_vendedor_agente%TYPE,
                                EN_numunidades       IN ga_ventas.num_unidades%TYPE,
                                ED_fecventa          IN ga_ventas.fec_venta%TYPE,
                                EV_codregion         IN ga_ventas.cod_region%TYPE,
                                EV_codprovincia      IN ga_ventas.cod_provincia%TYPE,
                                EV_codciudad         IN ga_ventas.cod_ciudad%TYPE,
                                EV_indestventa       IN ga_ventas.ind_estventa%TYPE,
                                EN_numtransaccion    IN ga_ventas.num_transaccion%TYPE,
                                EN_indpasocob        IN ga_ventas.ind_pasocob%TYPE,
                                EV_nomusuarvta       IN ga_ventas.nom_usuar_vta%TYPE,
                                EV_indventa          IN ga_ventas.ind_venta%TYPE,
                                EV_codmoneda         IN ga_ventas.cod_moneda%TYPE,
                                EV_codcausarec       IN ga_ventas.cod_causarec%TYPE,
                                EN_impventa          IN ga_ventas.imp_venta%TYPE,
                                EV_codtipcontrato    IN ga_ventas.cod_tipcontrato%TYPE,
                                EV_numcontrato       IN ga_ventas.num_contrato%TYPE,
                                EN_indtipventa       IN ga_ventas.ind_tipventa%TYPE,
                                EN_codcliente        IN ga_ventas.cod_cliente%TYPE,
                                EN_codmodventa       IN ga_ventas.cod_modventa%TYPE,
                                EN_tipvalor          IN ga_ventas.tip_valor%TYPE,
                                EV_codcuota          IN ga_ventas.cod_cuota%TYPE,
                                EV_codtiptarjeta     IN ga_ventas.cod_tiptarjeta%TYPE,
                                EV_numtarjeta        IN ga_ventas.num_tarjeta%TYPE,
                                EV_codauttarj        IN ga_ventas.cod_auttarj%TYPE,
                                ED_fecvencitarj      IN ga_ventas.fec_vencitarj%TYPE,
                                EV_codbancotarj      IN ga_ventas.cod_bancotarj%TYPE,
                                EV_numctacorr        IN ga_ventas.num_ctacorr%TYPE,
                                EV_numcheque         IN ga_ventas.num_cheque%TYPE,
                                EV_codbanco          IN ga_ventas.cod_banco%TYPE,
                                EV_codsucursal       IN ga_ventas.cod_sucursal%TYPE,
                                ED_feccumplimenta    IN ga_ventas.fec_cumplimenta%TYPE,
                                ED_fecrecdocum       IN ga_ventas.fec_recdocum%TYPE,
                                ED_fecaceprec        IN ga_ventas.fec_aceprec%TYPE,
                                EV_nomusuaracerec    IN ga_ventas.nom_usuar_acerec%TYPE,
                                EV_nomusuarrecdoc    IN ga_ventas.nom_usuar_recdoc%TYPE,
                                EV_nomusuarcumpl     IN ga_ventas.nom_usuar_cumpl%TYPE,
                                EV_indofiter         IN ga_ventas.ind_ofiter%TYPE,
                                EN_indchkdicom       IN ga_ventas.ind_chkdicom%TYPE,
                                EN_numconsulta       IN ga_ventas.num_consulta%TYPE,
                                EN_codvendealer      IN ga_ventas.cod_vendealer%TYPE,
                                EN_numfoldealer      IN ga_ventas.num_foldealer%TYPE,
                                EN_coddocdealer      IN ga_ventas.cod_docdealer%TYPE,
                                EN_inddoccomp        IN ga_ventas.ind_doccomp%TYPE,
                                EV_obsincump         IN ga_ventas.obs_incump%TYPE,
                                EN_codcausarep       IN ga_ventas.cod_causarep%TYPE,
                                ED_fecrecprov        IN ga_ventas.fec_recprov%TYPE,
                                EV_nomusuarrecprov   IN ga_ventas.nom_usuar_recprov%TYPE,
                                EN_numdias           IN ga_ventas.num_dias%TYPE,
                                EV_obsrecprov        IN ga_ventas.obs_recprov%TYPE,
                                EN_impabono          IN ga_ventas.imp_abono%TYPE,
                                EN_indabono          IN ga_ventas.ind_abono%TYPE,
                                ED_fecrecepadmvtas   IN ga_ventas.fec_recep_admvtas%TYPE,
                                EV_usurecepadmvtas   IN ga_ventas.usu_recep_admvtas%TYPE,
                                EV_obsgralcumpl      IN ga_ventas.obs_gralcumpl%TYPE,
                                EN_indconttelef      IN ga_ventas.ind_cont_telef%TYPE,
                                ED_fechaconttelef    IN ga_ventas.fecha_cont_telef%TYPE,
                                EV_usuarioconttelef  IN ga_ventas.usuario_cont_telef%TYPE,
                                EN_mtogarantia       IN ga_ventas.mto_garantia%TYPE,
                                EV_tipfoliacion      IN ga_ventas.tip_foliacion%TYPE,
                                EN_codtipdocum       IN ga_ventas.cod_tipdocum%TYPE,
                                EV_codplaza          IN ga_ventas.cod_plaza%TYPE,
                                EV_codoperadora      IN ga_ventas.cod_operadora%TYPE,
                                EN_numproceso        IN ga_ventas.num_proceso%TYPE,
                                SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento        OUT NOCOPY ge_errores_pg.Evento
                                )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_IN_GAVENTAS_PR"
        Lenguaje="PL/SQL"
        Fecha="31-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Descripci줻>Ingresar datos GA_VENTAS</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_NUMVENTA          "        Tipo="NUMERICO">numero de venta</param>
                        <param nom="EN_CODPRODUCTO       "        Tipo="NUMERICO">codigo producto</param>
                        <param nom="EV_CODOFICINA        "        Tipo="CARACTER">codigo oficina</param>
                        <param nom="EV_CODTIPCOMIS       "        Tipo="CARACTER">codigo tipo comisionista</param>
                        <param nom="EN_CODVENDEDOR       "        Tipo="NUMERICO">codigo vendedor</param>
                        <param nom="EN_CODVENDEDORAGENTE "        Tipo="NUMERICO">codigo vendedor agente/param>
                        <param nom="EN_NUMUNIDADES       "        Tipo="NUMERICO">numero de unidades</param>
                        <param nom="ED_FECVENTA          "        Tipo="FECHA">fecha venta</param>
                        <param nom="EV_CODREGION         "        Tipo="CARACTER">codigo region</param>
                        <param nom="EV_CODPROVINCIA      "        Tipo="CARACTER">codigo provincia</param>
                        <param nom="EV_CODCIUDAD         "        Tipo="CARACTER">codigo ciudad</param>
                        <param nom="EV_INDESTVENTA       "        Tipo="CARACTER">indicador estado venta</param>
                        <param nom="EN_NUMTRANSACCION    "        Tipo="NUMERICO">numero de transaccion</param>
                        <param nom="EN_INDPASOCOB        "        Tipo="NUMERICO">indicador paso cobros</param>
                        <param nom="EV_NOMUSUARVTA       "        Tipo="CARACTER">nombre usuario venta</param>
                        <param nom="EV_INDVENTA          "        Tipo="CARACTER">indicador venta</param>
                        <param nom="EV_CODMONEDA         "        Tipo="CARACTER">codigo moneda</param>
                        <param nom="EV_CODCAUSAREC       "        Tipo="CARACTER">codigo causa</param>
                        <param nom="EN_IMPVENTA          "        Tipo="NUMERICO">importe de la venta</param>
                        <param nom="EV_CODTIPCONTRATO    "        Tipo="CARACTER">codigo tipo contrato</param>
                        <param nom="EV_NUMCONTRATO       "        Tipo="CARACTER">numero contrato</param>
                        <param nom="EN_INDTIPVENTA       "        Tipo="NUMERICO">indicador tipo venta</param>
                        <param nom="EN_CODCLIENTE        "        Tipo="NUMERICO">codigo cliente</param>
                        <param nom="EN_CODMODVENTA       "        Tipo="NUMERICO">codigo modalidad venta</param>
                        <param nom="EN_TIPVALOR          "        Tipo="NUMERICO">tipo valor</param>
                        <param nom="EV_CODCUOTA          "        Tipo="CARACTER">codigo cuota</param>
                        <param nom="EV_CODTIPTARJETA     "        Tipo="CARACTER">codigo tipo tarjeta</param>
                        <param nom="EV_NUMTARJETA        "        Tipo="CARACTER">numero tarjeta</param>
                        <param nom="EV_CODAUTTARJ        "        Tipo="CARACTER">codigo autorizacion tarjeta</param>
                        <param nom="ED_FECVENCITARJ      "        Tipo="FECHA">fecha vencimiento tarjeta</param>
                        <param nom="EV_CODBANCOTARJ      "        Tipo="CARACTER">codigo banco tarjeta</param>
                        <param nom="EV_NUMCTACORR        "        Tipo="CARACTER">numero cuenta corriente</param>
                        <param nom="EV_NUMCHEQUE         "        Tipo="CARACTER">numero cheque</param>
                        <param nom="EV_CODBANCO          "        Tipo="CARACTER">codigo banco</param>
                        <param nom="EV_CODSUCURSAL       "        Tipo="CARACTER">codigo sucursal</param>
                        <param nom="ED_FECCUMPLIMENTA    "        Tipo="FECHA">fecha cumplimentacion</param>
                        <param nom="ED_FECRECDOCUM       "        Tipo="FECHA">fecha recepcion decumentos</param>
                        <param nom="ED_FECACEPREC        "        Tipo="FECHA">fecha aceptacion</param>
                        <param nom="EV_NOMUSUARACEREC    "        Tipo="CARACTER">nombre usuario aceptacion</param>
                        <param nom="EV_NOMUSUARRECDOC    "        Tipo="CARACTER">nombre usuario recepcion documentos</param>
                        <param nom="EV_NOMUSUARCUMPL     "        Tipo="CARACTER">nombre usuario cumplimentacion</param>
                        <param nom="EV_INDOFITER         "        Tipo="CARACTER">indicador oficina / terreno</param>
                        <param nom="EN_INDCHKDICOM       "        Tipo="NUMERICO">indicador dicom</param>
                        <param nom="EN_NUMCONSULTA       "        Tipo="NUMERICO">numero consulta dicom</param>
                        <param nom="EN_CODVENDEALER      "        Tipo="NUMERICO">codigo vendedor dealer</param>
                        <param nom="EN_NUMFOLDEALER      "        Tipo="NUMERICO">numero folio dealer</param>
                        <param nom="EN_CODDOCDEALER      "        Tipo="NUMERICO">codigo documento dealer/param>
                        <param nom="EN_INDDOCCOMP        "        Tipo="CARACTER">indicador documentacion</param>
                        <param nom="EV_OBSINCUMP         "        Tipo="NUMERICO">observacion</param>
                        <param nom="EV_CODCAUSAREP       "        Tipo="CARACTER">codigo causa</param>
                        <param nom="ED_FECRECPROV        "        Tipo="FECHA">fecha recepcion provisional</param>
                        <param nom="EV_NOMUSUARRECPROV   "        Tipo="CARACTER">nombre usuario recepcion provisional</param>
                        <param nom="EN_NUMDIAS           "        Tipo="NUMERICO">numero de dias/param>
                        <param nom="EV_OBSRECPROV        "        Tipo="CARACTER">observacion recepcion provisional</param>
                        <param nom="EN_IMPABONO          "        Tipo="NUMERICO">importe abono</param>
                        <param nom="EN_INDABONO          "        Tipo="NUMERICO">indicador abono/param>
                        <param nom="ED_FECRECEPADMVTAS   "        Tipo="FECHA">fecha recepcion adm. ventas</param>
                        <param nom="EV_USURECEPADMVTAS   "        Tipo="CARACTER">usuario recepcion adm. ventas</param>
                        <param nom="EV_OBSGRALCUMPL      "        Tipo="CARACTER">observacion cumplimentacion/param>
                        <param nom="EN_INDCONTTELEF      "        Tipo="NUMERICO">indicador contrato telefono</param>
                        <param nom="ED_FECHACONTTELEF    "        Tipo="FECHA">fecha contrato telefono</param>
                        <param nom="EV_USUARIOCONTTELEF  "        Tipo="CARACTER">usuario contrato telefono</param>
                        <param nom="EN_MTOGARANTIA       "        Tipo="NUMERICO">monto garantia</param>
                        <param nom="EV_TIPFOLIACION      "        Tipo="CARACTER">tipo foliacion</param>
                        <param nom="EN_CODTIPDOCUM       "        Tipo="NUMERICO">codigo tipo documento</param>
                        <param nom="EV_CODPLAZA          "        Tipo="CARACTER">codigo plaza</param>
                        <param nom="EV_CODOPERADORA      "        Tipo="CARACTER">codigo operadorate</param>
                        <param nom="EN_NUMPROCESO        "        Tipo="NUMERICO">numero proceso</param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error      ge_errores_pg.DesEvent;
        sSql              ge_errores_pg.vQuery;
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;

        sSql:='INSERT INTO ga_ventas(num_venta, cod_producto, cod_oficina, cod_tipcomis, cod_vendedor, '||
        '                           cod_vendedor_agente, num_unidades, fec_venta, cod_region,'||
        '                                   cod_provincia, cod_ciudad, ind_estventa, num_transaccion,'||
        '                                   ind_pasocob, nom_usuar_vta, ind_venta, cod_moneda, cod_causarec,'||
        '                                   imp_venta, cod_tipcontrato, num_contrato, ind_tipventa,'||
        '                                   cod_cliente, cod_modventa, tip_valor, cod_cuota, cod_tiptarjeta,'||
        '                                   num_tarjeta, cod_auttarj, fec_vencitarj, cod_bancotarj, num_ctacorr,'||
        '                                   num_cheque, cod_banco, cod_sucursal, fec_cumplimenta, fec_recdocum,'||
        '                                   fec_aceprec, nom_usuar_acerec,nom_usuar_recdoc, nom_usuar_cumpl,'||
        '                                   ind_ofiter, ind_chkdicom, num_consulta, cod_vendealer, num_foldealer,'||
        '                                   cod_docdealer, ind_doccomp, obs_incump, cod_causarep, fec_recprov,'||
        '                                   nom_usuar_recprov, num_dias, obs_recprov, imp_abono, ind_abono,'||
        '                                   fec_recep_admvtas, usu_recep_admvtas, obs_gralcumpl, ind_cont_telef,'||
        '                                   fecha_cont_telef, usuario_cont_telef, mto_garantia, tip_foliacion, '||
        '                                   cod_tipdocum, cod_plaza, cod_operadora, num_proceso) '||
        ' VALUES ('||EN_numventa||','||EN_codproducto||','||EV_codoficina||','||EV_codtipcomis||','||EN_codvendedor||','||EN_codvendedoragente||','||
        EN_numunidades||','||ED_fecventa||','||EV_codregion||','||EV_codprovincia||','||EV_codciudad||','||EV_indestventa||','||
        EN_numtransaccion||','||EN_indpasocob||','||EV_nomusuarvta||','||EV_indventa||','||EV_codmoneda||','||EV_codcausarec||','||
        EN_impventa||','||EV_codtipcontrato||','||EV_numcontrato||','||EN_indtipventa||','||EN_codcliente||','||EN_codmodventa||','||
        EN_tipvalor||','||EV_codcuota||','||EV_codtiptarjeta||','||EV_numtarjeta||','||EV_codauttarj||','||ED_fecvencitarj||','||
        EV_codbancotarj||','||EV_numctacorr||','||EV_numcheque||','||EV_codbanco||','||EV_codsucursal||','||ED_feccumplimenta||','||
        ED_fecrecdocum||','||ED_fecaceprec||','||EV_nomusuaracerec||','||EV_nomusuarrecdoc||','||EV_nomusuarcumpl||','||
        EV_indofiter||','||EN_indchkdicom||','||EN_numconsulta||','||EN_codvendealer||','||EN_numfoldealer||','||EN_coddocdealer||','||
        EN_inddoccomp||','||EV_obsincump||','||EN_codcausarep||','||ED_fecrecprov||','||EV_nomusuarrecprov||','||EN_numdias||','||
        EV_obsrecprov||','||EN_impabono||','||EN_indabono||','||ED_fecrecepadmvtas||','||EV_usurecepadmvtas||','||EV_obsgralcumpl||','||
        EN_indconttelef||','||ED_fechaconttelef||','||EV_usuarioconttelef||','||EN_mtogarantia||','||EV_tipfoliacion||','||
        EN_codtipdocum||','||EV_codplaza||','||EV_codoperadora||','||EN_numproceso||')';

        INSERT INTO ga_ventas(num_venta, cod_producto, cod_oficina, cod_tipcomis, cod_vendedor,
        cod_vendedor_agente, num_unidades, fec_venta, cod_region,
        cod_provincia, cod_ciudad, ind_estventa, num_transaccion,
        ind_pasocob, nom_usuar_vta, ind_venta, cod_moneda, cod_causarec,
        imp_venta, cod_tipcontrato, num_contrato, ind_tipventa,
        cod_cliente, cod_modventa, tip_valor, cod_cuota, cod_tiptarjeta,
        num_tarjeta, cod_auttarj, fec_vencitarj, cod_bancotarj, num_ctacorr,
        num_cheque, cod_banco, cod_sucursal, fec_cumplimenta, fec_recdocum,
        fec_aceprec, nom_usuar_acerec,nom_usuar_recdoc, nom_usuar_cumpl,
        ind_ofiter, ind_chkdicom, num_consulta, cod_vendealer, num_foldealer,
        cod_docdealer, ind_doccomp, obs_incump, cod_causarep, fec_recprov,
        nom_usuar_recprov, num_dias, obs_recprov, imp_abono, ind_abono,
        fec_recep_admvtas, usu_recep_admvtas, obs_gralcumpl, ind_cont_telef,
        fecha_cont_telef, usuario_cont_telef, mto_garantia, tip_foliacion,
        cod_tipdocum, cod_plaza, cod_operadora, num_proceso
        )
        VALUES (EN_numventa, EN_codproducto, EV_codoficina, EV_codtipcomis, EN_codvendedor, EN_codvendedoragente,
        EN_numunidades, ED_fecventa, EV_codregion, EV_codprovincia, EV_codciudad, EV_indestventa,
        EN_numtransaccion, EN_indpasocob, EV_nomusuarvta, EV_indventa, EV_codmoneda, EV_codcausarec,
        EN_impventa, EV_codtipcontrato, EV_numcontrato, EN_indtipventa, EN_codcliente, EN_codmodventa,
        EN_tipvalor, EV_codcuota, EV_codtiptarjeta, EV_numtarjeta, EV_codauttarj, ED_fecvencitarj,
        EV_codbancotarj, EV_numctacorr, EV_numcheque, EV_codbanco, EV_codsucursal, ED_feccumplimenta,
        ED_fecrecdocum, ED_fecaceprec, EV_nomusuaracerec, EV_nomusuarrecdoc, EV_nomusuarcumpl,
        EV_indofiter, EN_indchkdicom, EN_numconsulta, EN_codvendealer, EN_numfoldealer, EN_coddocdealer,
        EN_inddoccomp, EV_obsincump, EN_codcausarep, ED_fecrecprov, EV_nomusuarrecprov, EN_numdias,
        EV_obsrecprov, EN_impabono, EN_indabono, ED_fecrecepadmvtas, EV_usurecepadmvtas, EV_obsgralcumpl,
        EN_indconttelef, ED_fechaconttelef, EV_usuarioconttelef, EN_mtogarantia, EV_tipfoliacion,
        EN_codtipdocum, EV_codplaza, EV_codoperadora, EN_numproceso);
EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others: VE_desbloqueaprepago_sms_PG.VE_IN_GAVENTAS_PR('||EN_numventa||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_IN_GAVENTAS_PR', sSql, SQLCODE, LV_des_error );
END VE_IN_GAVENTAS_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_insertamovimiento_PR(
                                        EN_numabonado   IN  ga_aboamist.num_abonado%TYPE,
                                        EV_codtecno     IN  ga_aboamist.cod_tecnologia%TYPE,
                                        EV_tipterminal  IN  ga_aboamist.tip_terminal%TYPE,
                                        EN_codcentral   IN  ga_aboamist.cod_central%TYPE,
                                        EN_numcelular   IN  ga_aboamist.num_celular%TYPE,
                                        EV_codplantarif IN  ta_plantarif.cod_plantarif%TYPE,
                                        EV_nummin       IN  ga_aboamist.num_min%TYPE,
                                        EV_seriesim     IN  icc_movimiento.num_serie%TYPE,
                                        EV_imei         IN  icc_movimiento.imsi%TYPE,
                                        LV_num_imsi     OUT NOCOPY icc_movimiento.imsi%TYPE,
                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                        )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_OBTIENE_CENTRAL_TEC_PR"
        Lenguaje="PL/SQL"
        Fecha="30-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Lanzar ejecuci줻 de insert en icc_movimiento para desbloqueo</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_numabonado" Tipo="NUMERICO">Numero Abonado</param>
                        <param nom="EV_codtecno" Tipo="CARACTER">Codigo Tecnologia</param>
                        <param nom="EV_tipterminal" Tipo="CARACTER">Tipo de terminal</param>
                        <param nom="EV_numseriehex" Tipo="CARACTER">Numero de serie en base hexadecima�</param>
                        <param nom="EN_codcentral" Tipo="NUMERICO">Codigo de Central</param>
                        <param nom="EN_numcelular" Tipo="NUMERICO">Numero de Celular</param>
                        <param nom="EV_codplantarif" Tipo="CARACTER">Codigo de Plan Tarifario</param>
                        <param nom="EV_nummin" Tipo="CARACTER">Numero MIN</param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        error_ejecucion    EXCEPTION;
        LN_num_movimiento  icc_movimiento.num_movimiento%TYPE;
        LN_codactcen       ga_actabo.cod_actcen%TYPE;
        LV_des_error       ge_errores_pg.DesEvent;
        sSql               ge_errores_pg.vQuery;

BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        LN_codactcen:=NULL;
        LN_num_movimiento:=NULL;
        sSql:='VE_OBTIENE_NUM_IMSI(' || EN_numabonado || ',' || LV_num_imsi || ',' || SN_cod_retorno || ',' || SV_mens_retorno || ',' || SN_num_evento|| ')';
        VE_OBTIENE_NUM_IMSI(EN_numabonado,LV_num_imsi,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<>0 THEN
                RAISE error_ejecucion;
        END IF;
        sSql:='SELECT icc_seq_nummov.NEXTVAL INTO LN_num_movimiento FROM dual';
        SELECT icc_seq_nummov.NEXTVAL INTO LN_num_movimiento FROM dual;
        sSql:='VE_OBTIENE_CENTRAL_TEC_PR('||EV_codtecno||')';
        VE_OBTIENE_CENTRAL_TEC_PR(EV_codtecno,LN_codactcen,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<>0 THEN
                RAISE error_ejecucion;
        END IF;
        sSql:='VE_IN_ICCMOVIMIENTO_PR('||LN_num_movimiento||','||EN_numabonado||','||CV_codmodulo||','||CN_codestado||','||LN_codactcen||',USER,SYSDATE,'||EN_codcentral||','||EN_numcelular||','||EV_seriesim ||',NULL,NULL,'||EV_tipterminal||','||CV_codactabo||','||EV_nummin||',NULL,'||EV_codtecno||','|| ' NULL ,' || EV_imei || ','|| EV_seriesim || ',' || EV_codplantarif ||')';

        VE_IN_ICCMOVIMIENTO_PR(LN_num_movimiento,EN_numabonado,CV_codmodulo,CN_codestado,
        LN_codactcen,USER,SYSDATE,EN_codcentral,EN_numcelular,
        EV_seriesim,NULL,NULL,EV_tipterminal,CV_codactabo,
        EV_nummin,NULL,EV_codtecno,LV_num_imsi, EV_imei, EV_seriesim, EV_codplantarif, SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<>0 THEN
                RAISE error_ejecucion;
        END IF;
EXCEPTION
        WHEN error_ejecucion THEN
                LV_des_error:='error_ejecucion: VE_desbloqueaprepago_sms_PG.VE_insertamovimiento_PR('||EN_numabonado||','||EV_codtecno||','||EV_tipterminal||','||EV_seriesim||','||EN_codcentral||','||EN_numcelular||','||EV_codplantarif||','||EV_nummin||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_insertamovimiento_PR', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
        SN_cod_retorno:=156;--no_data_seq:nummov  ERROR_SEQ_NUMMOV
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
        END IF;
        LV_des_error:='Others: VE_desbloqueaprepago_sms_PG.VE_insertamovimiento_PR('||EN_numabonado||','||EV_codtecno||','||EV_tipterminal||','||EV_seriesim||','||EN_codcentral||','||EN_numcelular||','||EV_codplantarif||','||EV_nummin||');- ' || SQLERRM;
        SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_insertamovimiento_PR', sSql, SQLCODE, LV_des_error );
END VE_insertamovimiento_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_CONS_VENTA_PR(
                        EN_numabonado          IN         ga_usuamist.num_abonado%TYPE,
                        SN_codproducto         OUT NOCOPY ga_ventas.cod_producto%TYPE,
                        SV_codoficina          OUT NOCOPY ga_ventas.cod_oficina%TYPE,
                        SV_codtipcomis         OUT NOCOPY ga_ventas.cod_tipcomis%TYPE,
                        SN_codvendedor         OUT NOCOPY ga_ventas.cod_vendedor%TYPE,
                        SN_codvendedoragente   OUT NOCOPY ga_ventas.cod_vendedor_agente%TYPE,
                        SD_fecventa            OUT NOCOPY ga_ventas.fec_venta%TYPE,
                        SV_codregion           OUT NOCOPY ga_ventas.cod_region%TYPE,
                        SV_codprovincia        OUT NOCOPY ga_ventas.cod_provincia%TYPE,
                        SV_codciudad           OUT NOCOPY ga_ventas.cod_ciudad%TYPE,
                        SV_indestventa         OUT NOCOPY ga_ventas.ind_estventa%TYPE,
                        SN_numtransaccion      OUT NOCOPY ga_ventas.num_transaccion%TYPE,
                        SN_indpasocob          OUT NOCOPY ga_ventas.ind_pasocob%TYPE,
                        SV_nomusuarvta         OUT NOCOPY ga_ventas.nom_usuar_vta%TYPE,
                        SV_codmodventa         OUT NOCOPY ga_ventas.cod_modventa%TYPE,
                        SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                        SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                        SN_num_evento          OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_CONS_VENTA_PR"
        Lenguaje="PL/SQL"
        Fecha="31-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Obtiene datos de la venta </Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_numabonado" Tipo="NUMERICO>Num. Abonado</param>
                </Entrada>
                <Salida>
                        <param nom="SN_codproducto"        Tipo="NUMERICO">Codigo del producto</param>
                        <param nom="SV_codoficina"         Tipo="CARACTER">Codigo de oficina</param>
                        <param nom="SV_codtipcomis"        Tipo="CARACTER">Codigo tipo comision</param>
                        <param nom="SN_codvendedor"        Tipo="NUMERICO">Codigo del vendedor</param>
                        <param nom="SN_codvendedoragente"  Tipo="NUMERICO">Codigo del agente</param>
                        <param nom="SD_fecventa"           Tipo="FECHA">fecha de la venta</param>
                        <param nom="SV_codregion"          Tipo="CARACTER">Codigo de region</param>
                        <param nom="SV_codprovincia"       Tipo="CARACTER">Codigo de provincia</param>
                        <param nom="SV_codciudad"          Tipo="CARACTER">Codigo de ciudad</param>
                        <param nom="SV_indestventa"        Tipo="CARACTER">Indicador estado venta</param>
                        <param nom="SN_numtransaccion"     Tipo="NUMERICO">Nro de transaccion</param>
                        <param nom="SN_indpasocob"         Tipo="NUMERICO">Indicador paso a cobranza</param>
                        <param nom="SV_nomusuarvta"        Tipo="CARACTER">Usuario</param>            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"          Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error      ge_errores_pg.DesEvent;
        sSql              ge_errores_pg.vQuery;

BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SN_codproducto:=NULL;
        SV_codoficina:=NULL;
        SV_codtipcomis:=NULL;
        SN_codvendedor:=NULL;
        SN_codvendedoragente:=NULL;
        SD_fecventa:=NULL;
        SV_codregion:=NULL;
        SV_codprovincia:=NULL;
        SV_codciudad:=NULL;
        SV_indestventa:=NULL;
        SN_numtransaccion:=NULL;
        SN_indpasocob:=NULL;
        SV_nomusuarvta:=NULL;
        SV_codmodventa:=NULL;

        sSql:='SELECT v.cod_producto, v.cod_oficina, v.cod_tipcomis, '||
        '     v.cod_vendedor, v.cod_vendedor_agente,'||
        '         SYSDATE, v.cod_region, v.cod_provincia,'||
        '         v.cod_ciudad, v.ind_estventa, v.num_transaccion, v.ind_pasocob,'||
        '         v.nom_usuar_vta, v.cod_modventa '||
        ' INTO   SN_codproducto, SV_codoficina, SV_codtipcomis, SN_codvendedor, '||
        '     SN_codvendedoragente, SD_fecventa, SV_codregion, SV_codprovincia, '||
        '     SV_codciudad, SV_indestventa, SN_numtransaccion, SN_indpasocob, '||
        '     SV_nomusuarvta, SV_codmodventa '||
        ' FROM   ga_aboamist a, ga_ventas v '||
        ' WHERE  a.num_abonado='||EN_numabonado||
        ' AND  a.num_venta=v.num_venta';

        SELECT v.cod_producto, v.cod_oficina, v.cod_tipcomis,
        v.cod_vendedor, v.cod_vendedor_agente,
        SYSDATE, v.cod_region, v.cod_provincia,
        v.cod_ciudad, v.ind_estventa, v.num_transaccion, v.ind_pasocob,
        v.nom_usuar_vta, v.cod_modventa
        INTO SN_codproducto, SV_codoficina, SV_codtipcomis, SN_codvendedor,
        SN_codvendedoragente, SD_fecventa, SV_codregion, SV_codprovincia,
        SV_codciudad, SV_indestventa, SN_numtransaccion, SN_indpasocob,
        SV_nomusuarvta, SV_codmodventa
        FROM ga_aboamist a, ga_ventas v
        WHERE a.num_abonado=EN_numabonado
        AND a.num_venta=v.num_venta;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=761;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_CONS_VENTA_PR('||EN_numabonado||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_CONS_VENTA_PR', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_CONS_VENTA_PR('||EN_numabonado||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_CONS_VENTA_PR', sSql, SQLCODE, LV_des_error );
END VE_CONS_VENTA_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------

PROCEDURE VE_generaventacero_PR (
                                EN_numabonado           IN              ga_aboamist.num_abonado%TYPE,
                                EN_codvendealer         IN              ga_aboamist.cod_vendealer%TYPE,
                                EN_codcliente           IN              ga_aboamist.cod_cliente%TYPE,
                                EN_codvendedoragente    IN              ga_ventas.cod_vendedor_agente%TYPE,
                                SN_numventa             OUT NOCOPY      ga_aboamist.num_venta%TYPE,
                                SN_cod_retorno          OUT NOCOPY      ge_errores_pg.CodError,
                                SV_mens_retorno         OUT NOCOPY      ge_errores_pg.MsgError,
                                SN_num_evento           OUT NOCOPY      ge_errores_pg.Evento
                                )

/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_generaventacero_PR"
        Lenguaje="PL/SQL"
        Fecha="31-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Genera una venta con monto cero</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EN_numabonado" Tipo="NUMERICO">Numero Abonado</param>
                        <param nom="EN_codvendealer" Tipo="CARACTER">Codigo vendealer</param>
                        <param nom="EN_codcliente" Tipo="CARACTER">Codigo Cliente</param>
                        <param nom="EN_codvendedoragente" Tipo="CARACTER">Numero Abonado</param>
                </Entrada>
                <Salida>
                        <param nom="SN_numventa"   Tipo="NUMERICO">Nro de la venta generada</param>
                        <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
                        <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        error_ejecucion       EXCEPTION;
        error_ejecucionNull     EXCEPTION;
        LV_des_error          ge_errores_pg.DesEvent;
        sSql                  ge_errores_pg.vQuery;
        LV_ind_venta          ga_ventas.ind_venta%TYPE;
        LN_codproducto        ga_ventas.cod_producto%TYPE;
        LV_codoficina         ga_ventas.cod_oficina%TYPE;
        LV_codtipcomis        ga_ventas.cod_tipcomis%TYPE;
        LN_codvendedor        ga_ventas.cod_vendedor%TYPE;
        LN_codvendedoragente  ga_ventas.cod_vendedor_agente%TYPE;
        LD_fecventa           ga_ventas.fec_venta%TYPE;
        LV_codregion          ga_ventas.cod_region%TYPE;
        LV_codprovincia       ga_ventas.cod_provincia%TYPE;
        LV_codciudad          ga_ventas.cod_ciudad%TYPE;
        LV_indestventa        ga_ventas.ind_estventa%TYPE;
        LN_numtransaccion     ga_ventas.num_transaccion%TYPE;
        LN_indpasocob              ga_ventas.ind_pasocob%TYPE;
        LV_nomusuarvta        ga_ventas.nom_usuar_vta%TYPE;
        LV_val_param               ged_parametros.val_parametro%TYPE;
        LV_cod_modventa       ga_ventas.cod_modventa%TYPE;

BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        LN_codproducto:=NULL;
        LV_codoficina:=NULL;
        LV_codtipcomis:=NULL;
        LN_codvendedor:=NULL;
        LN_codvendedoragente:=NULL;
        LD_fecventa:=NULL;
        LV_codregion:=NULL;
        LV_codprovincia:=NULL;
        LV_codciudad:=NULL;
        LV_indestventa:=NULL;
        LN_numtransaccion:=NULL;
        LN_indpasocob:=NULL;
        LV_nomusuarvta:=NULL;
        LV_val_param:=NULL;
        LV_ind_venta:=NULL;

        sSql:='VE_CONS_VENTA_PR('||EN_numabonado||')';
        VE_CONS_VENTA_PR(EN_numabonado,LN_codproducto,LV_codoficina,LV_codtipcomis,LN_codvendedor,LN_codvendedoragente,LD_fecventa,LV_codregion,LV_codprovincia,LV_codciudad,LV_indestventa,LN_numtransaccion,LN_indpasocob,LV_nomusuarvta,LV_cod_modventa,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<>0 THEN
                RAISE error_ejecucion;
        END IF;
        sSql:='ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn('||CV_ind_vtacero||','||CV_codmodulo||','||CN_codprod||')';
        IF (NOT ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn(CV_ind_vtacero,CV_codmodulo,CN_codprod,LV_val_param,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) then
                RAISE error_ejecucion;
        END IF;
        IF     LV_val_param IS NULL  THEN
                RAISE error_ejecucionNull;
        END IF;
        LV_ind_venta:='V';
        sSql:='SELECT ga_seq_venta.NEXTVAL INTO SN_numventa FROM dual';
        SELECT ga_seq_venta.NEXTVAL INTO SN_numventa FROM dual;
        sSql:='VE_IN_GAVENTAS_PR('||SN_numventa||','||LN_codproducto||','||LV_codoficina||','||LV_codtipcomis||','||
                LN_codvendedor||','||EN_codvendedoragente||',1,'||LD_fecventa||','||
                LV_codregion||','||LV_codprovincia||','||LV_codciudad||','||LV_val_param ||','||
                LN_numtransaccion||','||LN_indpasocob||','||LV_nomusuarvta||','||LV_ind_venta||
                ',NULL, NULL, 0, NULL, NULL, NULL, ' || EN_codcliente || ','||
                LV_cod_modventa || ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,' ||
                ' NULL, NULL, NULL, NULL, NULL, NULL, O, NULL, NULL, NULL, NULL, NULL,'||
                ' NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,'||
                ' NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)';
        VE_IN_GAVENTAS_PR(SN_numventa,LN_codproducto,LV_codoficina,LV_codtipcomis,
                EN_codvendealer,EN_codvendedoragente,1,LD_fecventa,
                LV_codregion,LV_codprovincia,LV_codciudad,LV_val_param,
                LN_numtransaccion,LN_indpasocob,LV_nomusuarvta,LV_ind_venta, NULL, NULL, 0, NULL, NULL, NULL, EN_codcliente,
                LV_cod_modventa, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                NULL, NULL, NULL, NULL, NULL, NULL, 'O', NULL, NULL, EN_codvendealer, NULL, NULL,
                NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<>0 THEN
                RAISE error_ejecucion;
        END IF;

EXCEPTION
        WHEN error_ejecucion THEN
                        LV_des_error:='error_ejecucion: VE_desbloqueaprepago_sms_PG.VE_generaventacero_PR(' || EN_numabonado || ');- ' || SQLERRM;
                        SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_generaventacero_PR', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                        SN_cod_retorno:=156; --ERROR_SEQ_NUMVENTA  --RAISE error_no_data_vtacero ERROR_NO_DATA_EST_VEN
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno:=CV_error_no_clasif;
                        END IF;
                        LV_des_error:='Others: VE_desbloqueaprepago_sms_PG.VE_generaventacero_PR(' || EN_numabonado || ');;- ' || SQLERRM;
                        SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_generaventacero_PR', sSql, SQLCODE, LV_des_error );
END VE_generaventacero_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_crea_catimpclientes_PR(
                                EV_codcliente   IN  ge_clientes.cod_cliente%TYPE,
                                SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                )
AS
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_crea_catimpclientes_PR"
        Lenguaje="PL/SQL"
        Fecha="23-09-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Servicio de negocio para desbloqueo de prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_codcliente" Tipo="CARACTER">codigo de cliente</param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/

        LV_sql  VARCHAR(256);
        LV_codcatimpos VARCHAR(3);
        LV_des_error  ge_errores_pg.DesEvent;
        LD_fechasta   DATE;
BEGIN

        SN_cod_retorno := 0;
        SN_num_evento  := 0;

        LV_sql:='SELECT cod_catimpos FROM ge_datosgener';
        SELECT cod_catimpos
        INTO   LV_codcatimpos
        FROM   ge_datosgener;
        LD_fechasta:=TO_DATE('31-12-3000', 'DD-MM-YYYY');
        LV_sql:='INSERT INTO ge_catimpclientes (cod_cliente, fec_desde. fec_hasta, cod_catimpos) ' ||'VALUES (EV_codcliente, SYSDATE, ' || LD_fechasta || ',' || 'LV_codcatimpos)';
        INSERT INTO ge_catimpclientes(cod_cliente, fec_desde, fec_hasta, cod_catimpos)
        VALUES(EV_codcliente, SYSDATE, LD_fechasta, LV_codcatimpos);

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=762;
                LV_des_error:='NO_DATA_FOUND: VE_desbloqueaprepago_sms_PG.VE_crea_catimpclientes_PR(' || EV_codcliente || ');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_crea_catimpclientes_PR', LV_sql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others: VE_desbloqueaprepago_sms_PG.VE_crea_catimpclientes_PR(' || EV_codcliente || ');;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_crea_catimpclientes_PR', LV_sql, SQLCODE, LV_des_error );
END VE_crea_catimpclientes_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_crea_catributclie_PR(
                                EV_codcliente   IN  ge_clientes.cod_cliente%TYPE,
                                SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                )
AS
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_crea_catributclie_PR"
        Lenguaje="PL/SQL"
        Fecha="05-10-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Servicio de negocio para desbloqueo de prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_codcliente" Tipo="CARACTER">codigo de cliente</param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
        LV_sql                  VARCHAR(256);
        LV_codcattribu          ga_catributclie.cod_catribut%TYPE;
        LV_des_error            ge_errores_pg.DesEvent;
        LD_fechasta             DATE;
        LV_val_param            ged_parametros.val_parametro%TYPE;
        error_ejecucion         EXCEPTION;
        error_ejecucionNull     EXCEPTION;
BEGIN

        SN_cod_retorno := 0;
        SN_num_evento  := 0;

        LD_fechasta:=TO_DATE('31-12-3000', 'DD-MM-YYYY');
        LV_sql:='ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn(CAT_TRIB_FACT,'||CV_codmodulo||','||CN_codprod||')';
        IF (NOT ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn('CAT_TRIB_FACT',CV_codmodulo,CN_codprod, LV_val_param ,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) then
                RAISE error_ejecucion;
        END IF;
        IF LV_val_param IS NULL  THEN
                RAISE error_ejecucionNull;
        END IF;

        LV_sql:='INSERT INTO ga_catributclie (cod_cliente, fec_desde, fec_hasta, cod_catribut) VALUES('|| EV_codcliente || ',' || 'SYSDATE, ' || LD_fechasta || ',' || LV_val_param || ')';
        INSERT INTO ga_catributclie (cod_cliente, fec_desde, fec_hasta, cod_catribut)
        VALUES(EV_codcliente, SYSDATE, LD_fechasta, LV_val_param);

EXCEPTION
        WHEN error_ejecucion THEN
                LV_des_error:='error_ejecucion: VE_desbloqueaprepago_sms_PG.VE_crea_catributclie_PR(' || EV_codcliente || ');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_crea_catributclie_PR', LV_sql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156; --ERROR_SEQ_NUMVENTA  --RAISE error_no_data_vtacero ERROR_NO_DATA_EST_VEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others: VE_desbloqueaprepago_sms_PG.VE_crea_catributclie_PR(' || LV_des_error || ');;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_crea_catributclie_PR', LV_sql, SQLCODE, LV_des_error );
END VE_crea_catributclie_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_crea_cliente_pcom_PR(
                                EV_codcliente   IN  ge_clientes.cod_cliente%TYPE,
                                SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                )
AS
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_crea_cliente_pcom_PR"
        Lenguaje="PL/SQL"
        Fecha="23-09-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Servicio de negocio para desbloqueo de prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_codcliente" Tipo="CARACTER">codigo de cliente</param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
        LV_sql          VARCHAR2(256);
        LV_codplancom   VARCHAR2(4);
        LV_des_error    ge_errores_pg.DesEvent;

BEGIN

        SN_cod_retorno := 0;
        SN_num_evento  := 0;

        LV_sql:='SELECT MIN(cod_plancom) FROM ve_cabplancom';

        SELECT MIN(cod_plancom)
        INTO   LV_codplancom
        FROM   ve_cabplancom;

        LV_sql:='INSERT INTO ga_cliente_pcom(cod_cliente, cod_plancom, fec_desde, nom_usuarora, fec_hasta) ' || 'VALUES(' || EV_codcliente || ',' || LV_codplancom || ',SYSDATE, USER, NULL)';

        INSERT INTO ga_cliente_pcom(cod_cliente, cod_plancom, fec_desde, nom_usuarora, fec_hasta)
        VALUES(EV_codcliente, LV_codplancom, SYSDATE, USER, NULL);

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=322;
                LV_des_error:='NO_DATA_FOUND: VE_desbloqueaprepago_sms_PG.VE_crea_cliente_pcom_PR(' || EV_codcliente || ');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_crea_cliente_pcom_PR', LV_sql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others: VE_desbloqueaprepago_sms_PG.VE_crea_cliente_pcom_PR(' || EV_codcliente || ');;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_crea_cliente_pcom_PR', LV_sql, SQLCODE, LV_des_error );
END VE_crea_cliente_pcom_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_crea_dircliente_PR(
                                EV_codcliente   IN  ge_clientes.cod_cliente%TYPE,
                                EV_codvendealer IN  ve_vendealer.cod_vendealer%TYPE,
                                LN_coddireccion IN  ve_vendedores.cod_direccion%TYPE,
                                SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                )
AS
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_crea_dircliente_PR"
        Lenguaje="PL/SQL"
        Fecha="23-09-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Servicio de negocio para desbloqueo de prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_codcliente" Tipo="CARACTER">codigo de cliente</param>
                        <param nom="EV_codvendealer" Tipo="CARACTER">codigo de vendealer</param>
                        <param nom="LN_coddireccion" Tipo="CARACTER">direccion del vendedor</param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/

        CONTADOR     NUMBER;
        LV_sql       VARCHAR2(256);
        LV_des_error ge_errores_pg.DesEvent;

BEGIN

                SN_cod_retorno := 0;
                SN_num_evento  := 0;

        FOR CONTADOR IN 1..3 LOOP
                INSERT INTO ga_direccli(cod_cliente, cod_tipdireccion, cod_direccion)
                VALUES(EV_codcliente,CONTADOR,LN_coddireccion);
        END LOOP;

EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others: VE_desbloqueaprepago_sms_PG.VE_crea_dircliente_PR(' || EV_codcliente || ',' || EV_codvendealer || ');;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_crea_dircliente_PR', LV_sql, SQLCODE, LV_des_error );
END VE_crea_dircliente_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_valida_direccion(LN_coddireccion IN ve_vendedores.cod_direccion%TYPE,
                                                        SN_Existe_direccion OUT NOCOPY NUMBER,
                                                        SN_Cod_dir_Defecto  OUT NOCOPY ve_vendedores.cod_direccion%TYPE,
                                    SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                            SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                            SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
)
/*
  CREADOR: JORGE IBA쩋Z
  INCIDENCIA: XO-200510120861
  FECHA: 13/10/2005
  DESCRIPCION: VALIDA LA DIRECCION DEL CLIENTE PARA QUE SI EXISTE EN LA TABLA GE_DIRECCIONES CARGE POR DEFECTO UNA
                                                        INCLUDIDA EN LA TABLA DE PARAMETROS CON EL NOMBRE DE VARIABLE "COD_DIRECCION_SMS"
*/
AS
        LN_coddireccion1         ve_vendedores.cod_direccion%TYPE;
    LV_des_error     ge_errores_pg.DesEvent;
    sSql             ge_errores_pg.vQuery;

BEGIN

                SN_cod_retorno := 0;
                SN_num_evento  := 0;

                        SELECT VAL_PARAMETRO
                        INTO   LN_coddireccion1
                        FROM   GED_PARAMETROS
                        WHERE  NOM_PARAMETRO='COD_DIRECCION_SMS'
                        AND    COD_MODULO='GA'
                        AND    COD_PRODUCTO=1;

                    select count(1)
                        INTO SN_Existe_direccion
                        from ge_direcciones
            where cod_direccion = LN_coddireccion1;

                        SN_Cod_dir_Defecto:=LN_coddireccion1;
EXCEPTION
WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=764;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='error_datos: VE_desbloqueaprepago_sms_PG.VE_valida_direccion('||LN_coddireccion||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_valida_direccion', sSql, SQLCODE, LV_des_error );
WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_valida_direccion('||LN_coddireccion||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_valida_direccion', sSql, SQLCODE, LV_des_error );
END VE_valida_direccion;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_VALIDA_ICC_VS_COD_ARTICULO(
                                                          EV_cod_crticulo    IN al_articulos.cod_articulo%TYPE,
                                                          EV_icc                     IN ga_aboamist.num_serie%TYPE,
                                                          EV_num_imei        IN ga_aboamist.num_imei%TYPE,--iNICIO:RA-200512270444; USER:JEIM; FECHA:28/12/2005
                                                          SN_opcion                      OUT NOCOPY numeric,
                                      SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                              SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                              SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
)
/*
  CREADOR: JORGE IBA쩋Z
  INCIDENCIA: RA-200512160336
  FECHA: 21/12/2005
  DESCRIPCION: VALIDA LA CORRESPONDENCIA ENTRE LA ICC Y EL CODIGO DE ARTICULO DENTRO DE LA TABLA GA_ABOAMIST
  PARAMETROS OUT: SN_opcion ; VALORES: 0: FALSE , 1:TRUE

*/
AS
    LV_des_error                                        ge_errores_pg.DesEvent;
        LV_Num_Abonado                                          ga_aboamist.num_serie%TYPE;
        LV_cod_articulo_aux                             al_articulos.cod_articulo%TYPE;
    sSql                                                ge_errores_pg.vQuery;
        error_inconsistente                                     EXCEPTION;
        fin_exitoso                                                     EXCEPTION;
BEGIN

        SN_cod_retorno := 0;
        SN_num_evento  := 0;

        /*Rescata el numero de abonado de la tabla GA_ABOAMIST para hacer JOIN con la tabla GA_EQUIPABOSER*/
        SELECT a.num_abonado
        INTO   LV_Num_Abonado
        FROM   ga_aboamist a
        WHERE  a.num_serie=EV_icc;
        /*************************************************************************************************/

        /*Rescata el cod_articulo para poder hacer la comparacion de los codigos de articulos que se estan enviando*/
        BEGIN
                SELECT  cod_articulo
                INTO    LV_cod_articulo_aux
                FROM    GA_EQUIPABOSER
                WHERE   NUM_ABONADO= LV_Num_Abonado
                AND     NUM_SERIE  = EV_num_imei;--iNICIO:RA-200512270444; USER:NRCA; FECHA:29/12/2005
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        BEGIN
                                SELECT cod_articulo
                                INTO LV_cod_articulo_aux
                                FROM AL_SERIES
                                WHERE NUM_SERIE=EV_num_imei;--iNICIO:RA-200512270444; USER:NRCA; FECHA:29/12/2005
                        EXCEPTION
                                WHEN OTHERS THEN
                                        SN_opcion:=0;
                        SN_cod_retorno:=107;
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                             SV_mens_retorno:=CV_error_no_clasif;
                        END IF;
                        LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_VALIDA_ICC_VS_COD_ARTICULO('||EV_cod_crticulo||');- ' || SQLERRM;
                        SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                        'VE_desbloqueaprepago_sms_PG.VE_VALIDA_ICC_VS_COD_ARTICULO', sSql, SQLCODE, LV_des_error );
                        END;
        END;
        /***********************************************************************************************************/
        IF LV_cod_articulo_aux <> EV_cod_crticulo THEN
                BEGIN
                        SN_opcion:=0;
                        RAISE error_inconsistente;
                END;
        ELSE
                BEGIN
                        SN_opcion:=1;
                        RAISE fin_exitoso;
                END;
        END IF;

EXCEPTION
WHEN fin_exitoso THEN
        NULL;
WHEN error_inconsistente THEN
                SN_cod_retorno:=635;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='error_datos: VE_desbloqueaprepago_sms_PG.VE_VALIDA_ICC_VS_COD_ARTICULO('||EV_cod_crticulo||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                'VE_desbloqueaprepago_sms_PG.VE_VALIDA_ICC_VS_COD_ARTICULO', sSql, SQLCODE, LV_des_error );
WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_VALIDA_ICC_VS_COD_ARTICULO('||EV_cod_crticulo||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                'VE_desbloqueaprepago_sms_PG.VE_VALIDA_ICC_VS_COD_ARTICULO', sSql, SQLCODE, LV_des_error );
END  VE_VALIDA_ICC_VS_COD_ARTICULO;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_VALIDA_COR_ENTRE_ICC_IMEI(EV_icc IN ga_aboamist.num_serie%TYPE,
                                        EV_num_imei IN ga_aboamist.num_imei%TYPE,
                                        SN_SW_CANCEL_DESBLOQUEO OUT NOCOPY NUMERIC,
                                        SN_IMEI_ES_PAK OUT NOCOPY NUMERIC,
                                        SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                        )
/*
  CREADOR: JORGE IBA쩋Z
  INCIDENCIA: XO-200510140878
  FECHA: 18/10/2005
  DESCRIPCION: COMPRUEBA QUE LA ICC CORRESPONDA A UN "PACK" O NO Y SI CORRESPONDE COMPRUEBA QUE ESTE SEA EL QUE
                           ESTA ASOCIADO AL IMAI DE LA TABLA GA_ABOAMIST, DE NO SER ASI COMPRUEBA QUE EL IMAI NO ESTE
                           VACIO.
*/
AS
        LV_des_error     ge_errores_pg.DesEvent;
        sSql             ge_errores_pg.vQuery;

        error_datos                     EXCEPTION;
        error_icc_pak                   EXCEPTION;
        error_icc_vendida               EXCEPTION;
        error_imei_no_pertenece_a_icc   EXCEPTION;
        error_imei                      EXCEPTION;
        envio_null                      EXCEPTION;

	--Inc. 180815 JLGN 02-02-2012
        --SN_LOAD_IMEI_GA_ABOAMIST        NUMBER; 
        SN_LOAD_IMEI_GA_ABOAMIST        ga_aboamist.num_imei%TYPE;
        SN_LOAD_ICC_GA_ABOAMIST         NUMBER;
        SN_LOAD_COD_CLIENTE             NUMBER;
        SN_LOAD_COD_CLIENTE_DIST        NUMBER;
BEGIN

        SN_cod_retorno := 0;
        SN_num_evento  := 0;

/*SECCION DE QUERYS GENERALES*/
        /* COMPRUEBA QUE LA ICC QUE SE ENVIA TIENE UN IMEI ASOCIADO */
        SELECT NUM_IMEI
        INTO   SN_LOAD_IMEI_GA_ABOAMIST
        FROM   GA_ABOAMIST
        WHERE  NUM_SERIE=EV_icc
        AND    COD_SITUACION != 'BAP'
        AND    COD_SITUACION != 'BAA'; /* RA-200601160585  ; FECHA: 17/01/2006 */


/***********************************************************************/
/*CASO 1 : CUANDO LA ICC YA HABIA SIDO DESBLOQUEADA */
/*INICIO: RA-200511090075 ; FECHA: 11/11/2005 ; USER: JEIM*/
        SELECT COD_CLIENTE,COD_CLIENTE_DIST
        INTO   SN_LOAD_COD_CLIENTE,SN_LOAD_COD_CLIENTE_DIST
        FROM   GA_ABOAMIST
        WHERE  NUM_SERIE=EV_icc
        AND    COD_SITUACION != 'BAP'
        AND    COD_SITUACION != 'BAA'; /* RA-200601160585  ; FECHA: 17/01/2006 */

        IF  SN_LOAD_COD_CLIENTE <> SN_LOAD_COD_CLIENTE_DIST THEN
                SN_SW_CANCEL_DESBLOQUEO:=0;
                RAISE error_icc_vendida;
        END IF;
/*FIN: RA-200511090075 ; FECHA: 11/11/2005 ; USER: JEIM*/

/*CASO 2 : CUANDO EL NUMERO DE IMEI VIENE NULL Y SOLO SE ENVIA EL ICC */
        IF (EV_num_imei IS NULL OR length(TRIM(EV_num_imei)) is null ) AND EV_icc IS NOT NULL THEN
                IF SN_LOAD_IMEI_GA_ABOAMIST IS NULL THEN
                        SN_SW_CANCEL_DESBLOQUEO:=0;
                        RAISE error_imei;
                ELSE
                        SN_SW_CANCEL_DESBLOQUEO:=1;
                        SN_IMEI_ES_PAK:=1;--0 : Verdadero ; 1: Falso
                        RAISE envio_null;
                END IF;
        END IF;
/**********************************************************************/
/*CASO 3 : CUANDO EL IMEI Y EL ICC VIENEN Y SE PUEDE DAR QUE SEA UN PACK */
        IF EV_num_imei IS NOT NULL AND EV_icc IS NOT NULL THEN
                 /* CASO 3.1 : QUE LA ICC QUE ENVIAN NO TIENE UN IMEI ASOCIADO PERO SE ENVIA UNO*/
                IF SN_LOAD_IMEI_GA_ABOAMIST IS NULL THEN
                        SELECT COUNT(0)
                        INTO SN_LOAD_ICC_GA_ABOAMIST
                        FROM
                        GA_ABOAMIST
                        WHERE NUM_IMEI=EV_num_imei
                        AND COD_SITUACION != 'BAP' AND COD_SITUACION != 'BAA'; /* RA-200601160585  ; FECHA: 17/01/2006 */
                        IF SN_LOAD_ICC_GA_ABOAMIST > 0 THEN
                                /* CPRUEBA QUE EL ICC ESTA O NO ASOCIADO A OTRO IMEI */
                                SELECT NUM_SERIE
                                INTO SN_LOAD_ICC_GA_ABOAMIST
                                FROM
                                GA_ABOAMIST
                                WHERE NUM_IMEI=EV_num_imei
                                AND COD_SITUACION != 'BAP' AND COD_SITUACION != 'BAA'; /* RA-200601160585  ; FECHA: 17/01/2006 */
                                IF SN_LOAD_ICC_GA_ABOAMIST <> EV_icc THEN
                                        SN_SW_CANCEL_DESBLOQUEO:=0;
                                        SN_IMEI_ES_PAK:=1; --0 : Verdadero ; 1: Falso
                                        RAISE error_icc_pak;
                                ELSE
                                        --CONTINUA CON LAS OTRAS VALIDACIONES DEL DESBLOQUEO
                                        SN_SW_CANCEL_DESBLOQUEO:=1;
                                        SN_IMEI_ES_PAK:=0; --0 : Verdadero ; 1: Falso
                                        RAISE envio_null;
                                END IF;
                        ELSE
                                --CONTINUA CON LAS OTRAS VALIDACIONES DEL DESBLOQUEO
                                SN_SW_CANCEL_DESBLOQUEO:=1;
                                SN_IMEI_ES_PAK:=0; --0 : Verdadero ; 1: Falso
                                RAISE envio_null;
                        END IF;
                ELSE
                        IF SN_LOAD_IMEI_GA_ABOAMIST <> EV_num_imei THEN
                                SN_SW_CANCEL_DESBLOQUEO:=0;
                                SN_IMEI_ES_PAK:=1; --0 : Verdadero ; 1: Falso
                                RAISE error_icc_pak;
                        ELSE
                                --CONTINUA CON LAS OTRAS VALIDACIONES DEL DESBLOQUEO
                                SN_SW_CANCEL_DESBLOQUEO:=1;
                                SN_IMEI_ES_PAK:=1; --0 : Verdadero ; 1: Falso
                        END IF;
                END IF;
        END IF;
/**********************************************************************/
EXCEPTION

WHEN error_imei_no_pertenece_a_icc THEN
                SN_cod_retorno:=594;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='El imei enviado no pertenece a la ICC enviada' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_ICC_IMEI', sSql, SQLCODE, LV_des_error );

WHEN error_icc_vendida THEN
                SN_cod_retorno:=527;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='La ICC ya fue vendida' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_ICC_IMEI', sSql, SQLCODE, LV_des_error );

WHEN error_icc_pak THEN
                SN_cod_retorno:=521;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='ICC es un pack, no puede realizar venta tra죆o' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_ICC_IMEI', sSql, SQLCODE, LV_des_error );

WHEN error_imei THEN
                SN_cod_retorno:=522;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Venta traido, debe enviar IMEI' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_ICC_IMEI', sSql, SQLCODE, LV_des_error );


WHEN error_datos THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='error_datos: VE_desbloqueaprepago_sms_PG.VE_ICC_IMEI('||EV_icc||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_ICC_IMEI', sSql, SQLCODE, LV_des_error );
WHEN envio_null THEN
         NULL;

WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_ICC_IMEI('||EV_icc||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_ICC_IMEI', sSql, SQLCODE, LV_des_error );


END VE_VALIDA_COR_ENTRE_ICC_IMEI;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_OBTIENE_SECUENCIA_PR(
                                        EV_nomsecuencia IN VARCHAR2,
                                        SV_secuencia      OUT NOCOPY VARCHAR2,
                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                        )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_OBTIENE_SECUENCIA_PR"
        Lenguaje="PL/SQL"
        Fecha="15-11-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Servicio de negocio para desbloqueo de prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_nomsecuencia" Tipo="VARCHAR2>nombre de la secuencia a rescatar</param>
                </Entrada>
                <Salida>
                        <param nom="SV_secuencia"     Tipo="VARCHAR2">secuencia rescatada</param>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error      ge_errores_pg.DesEvent;
        sSql              ge_errores_pg.vQuery;
BEGIN

                SN_cod_retorno := 0;
                SN_num_evento  := 0;

        sSql:='SELECT ' || EV_nomsecuencia || '.NEXTVAL FROM DUAL';
        EXECUTE IMMEDIATE sSql INTO SV_Secuencia;
                EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_OBTIENE_SECUENCIA_PR('||EV_nomsecuencia||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_SECUENCIA_PR', sSql, SQLCODE, LV_des_error );
END VE_OBTIENE_SECUENCIA_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_OBTIENE_TIPOSTOCK_PR(
                                EV_num_serieequipo IN  al_series.num_serie%TYPE,
                                SV_cod_tipstock  OUT NOCOPY al_series.tip_stock%TYPE,
                                SV_codbodega             OUT NOCOPY al_series.cod_bodega%TYPE,
                                SV_codarticulo   OUT NOCOPY al_series.cod_articulo%TYPE,
                                SV_coduso                        OUT NOCOPY al_series.cod_uso%TYPE,
                                SV_codestado             OUT NOCOPY al_series.cod_estado%TYPE,
                                SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
                                )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_OBTIENE_TIPOSTOCK_PR"
        Lenguaje="PL/SQL"
        Fecha="15-11-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Servicio de negocio para desbloqueo de prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_NUM_SERIEEQUIPO" Tipo="VARCHAR2>Numero de Serie del Equipo</param>
                </Entrada>
                <Salida>
                        <param nom="SV_cod_tipstock"     Tipo="VARCHAR2">Codigo de Tipo de Stock del equipo</param>
                        <param nom="SV_codbodega"     Tipo="VARCHAR2">Codigo de Bodega</param>
                        <param nom="SV_codarticulo"     Tipo="VARCHAR2">Codigo de Articulo</param>
                        <param nom="SV_coduso"     Tipo="VARCHAR2">Codigo de Uso</param>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error      ge_errores_pg.DesEvent;
        sSql              ge_errores_pg.vQuery;
BEGIN

                SN_cod_retorno := 0;
                SN_num_evento  := 0;

        SV_cod_tipstock:=NULL;

        sSql:='SELECT a.tip_stock, a.cod_bodega, a.cod_articulo, a.cod_uso, a.cod_estado FROM al_series a ' ||
        'WHERE  a.num_serie=' || TRIM(EV_num_serieequipo);

        SELECT a.tip_stock, a.cod_bodega, a.cod_articulo, a.cod_uso, a.cod_estado
        INTO    SV_cod_tipstock, SV_codbodega, SV_codarticulo, SV_coduso, SV_codestado
        FROM   al_series a
        WHERE  a.num_serie=TRIM(EV_num_serieequipo);

EXCEPTION
        WHEN NO_DATA_FOUND THEN -- No Valida por ser los datos obtenidos en una etapa avanzada del proceso.
                NULL;
        WHEN TOO_MANY_ROWS THEN
                SN_cod_retorno:=529; --ERROR_TOO_MANY_SERIES
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_OBTIENE_TIPOSTOCK_PR('||EV_num_serieequipo||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_TIPOSTOCK_PR', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156; --ERROR_TOO_MANY_SERIES
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_OBTIENE_TIPOSTOCK_PR('||EV_num_serieequipo||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_TIPOSTOCK_PR', sSql, SQLCODE, LV_des_error );
END VE_OBTIENE_TIPOSTOCK_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_IN_GA_PRELIQUIDACION_PR(
                                        EV_numventa               IN ga_preliquidacion.num_venta%TYPE,
                                        EV_codmaster              IN ga_preliquidacion.cod_master_dealer%TYPE,
                                        EV_codvendealer   IN ga_preliquidacion.cod_dealer%TYPE,
                                        EV_codcliente             IN ga_preliquidacion.cod_cliente%TYPE,
                                        EV_indestvta              IN ga_preliquidacion.ind_estventa%TYPE,
                                        EV_codmodvta              IN ga_preliquidacion.cod_modventa%TYPE,
                                        EV_impvta                         IN ga_preliquidacion.imp_venta%TYPE,
                                        EV_indvta                         IN ga_preliquidacion.ind_venta%TYPE,
                                        EV_diasconsig             IN NUMBER,
                                        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
                                        )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_IN_GA_PRELIQUIDACION_PR"
        Lenguaje="PL/SQL"
        Fecha="17-11-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Servicio de negocio para desbloqueo de prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_numventa" Tipo="CARACTER">Numero de Venta</param>
                        <param nom="EV_codmaster" Tipo="CARACTER">Codigo Master dealer</param>
                        <param nom="EV_codvendealer" Tipo="CARACTER">Codigo de vendedor dealer</param>
                        <param nom="EV_codcliente" Tipo="CARACTER">Codigo de Cliente</param>
                        <param nom="EV_indestvta" Tipo="CARACTER">Indicador del estado de la venta</param>
                        <param nom="EV_codmodvta" Tipo="CARACTER">Codigo de modalidad de venta</param>
                        <param nom="EV_impvta" Tipo="CARACTER">Importe de la venta</param>
                        <param nom="EV_indvta" Tipo="CARACTER">Indicador de Venta</param>
                        <param nom="EV_diasconsig" Tipo="CARACTER">Dias vencimiento de consignacion</param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error         ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
        CV_unidades              NUMBER(1):=1;
        --INICIO : RA-200512200352; FECHA: 22/12/2005; USER: JEIM
        LV_Cod_Cliente2          ga_preliquidacion.cod_cliente%TYPE;
        --FIN : RA-200512200352; FECHA: 22/12/2005; USER: JEIM
BEGIN

        /*INICIO : RA-200512200352; FECHA: 22/12/2005; USER: JEIM
        Se remplaza el COD_Cliente por el Cod_Cliente2 para asegurarce de que el codigo de cliente que se incerte en la tabla sea el codigo de cliente del
        distribuidor.*/
        /*Select bb.cod_cliente
        into LV_Cod_Cliente2
        from
        (Select cod_vendedor
        from
        ve_vendealer
        where
        cod_vendealer=EV_codvendealer) aa,
        ve_vendedores bb
        where
        aa.cod_vendedor=bb.cod_vendedor;*/

SN_cod_retorno := 0;
SN_num_evento  := 0;

        Select distinct  cod_cliente
        into  LV_Cod_Cliente2
        from  ve_vendedores
        where cod_vendedor=EV_codvendealer;
        /*FIN : RA-200512200352; FECHA: 22/12/2005; USER: JEIM*/

        sSql:='INSERT INTO ga_preliquidacion (num_venta, cod_dealer, cod_master_dealer, ' ||
        'cod_cliente,ind_estventa, cod_modventa, num_unidades, imp_venta, ' ||
        'fec_venta, ind_venta) VALUES (' ||  EV_numventa || ',' || EV_codvendealer ||
        ',' || EV_codmaster || ',' || LV_Cod_Cliente2 || ',' || EV_indestvta || ',' ||
        EV_codmodvta || ',' || CV_unidades || ',' || EV_impvta || ',' || to_date(SYSDATE + EV_diasconsig)
        || ',' || EV_indvta || ')';

        INSERT INTO ga_preliquidacion
        (num_venta
        ,cod_dealer
        ,cod_master_dealer
        ,cod_cliente
        ,ind_estventa
        ,cod_modventa
        ,num_unidades
        ,imp_venta
        ,fec_venta
        ,ind_venta)
        VALUES (EV_numventa
        ,EV_codvendealer
        ,EV_codmaster
        ,LV_Cod_Cliente2
        ,EV_indestvta
        ,EV_codmodvta
        ,CV_unidades
        ,EV_impvta
        ,SYSDATE
        ,EV_indvta);

EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others:
                VE_desbloqueaprepago_sms_PG.VE_IN_GA_PRELIQUIDACION_PR('||EV_numventa||','||EV_codmaster||','||EV_codvendealer||','||EV_codcliente||','||EV_indestvta||','||EV_codmodvta||','||EV_impvta|| ',' || EV_indvta || ',' || EV_diasconsig ||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_IN_GA_PRELIQUIDACION_PR', sSql, SQLCODE, LV_des_error );
END VE_IN_GA_PRELIQUIDACION_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_IN_GA_DET_PRELIQ_PR(
                                        EV_numventa               IN ga_preliquidacion.num_venta%TYPE,
                                        EV_numabonado             IN ga_det_preliq.num_abonado%TYPE,
                                        EV_numcelular             IN ga_det_preliq.num_celular%TYPE,
                                        EV_numserie               IN ga_det_preliq.num_serie_orig%TYPE,
                                        EV_impcargo               IN ga_det_preliq.imp_cargo%TYPE,
                                        EV_impcargofinal          IN ga_det_preliq.imp_cargo_final%TYPE,
                                        LV_valdcto                IN ga_det_preliq.val_dto%TYPE,--Inicio: RA-200512260402; User: JEIM; Fecha:27/12/2005
                                        EV_codarticulo            IN ga_det_preliq.cod_articulo%TYPE,
                                        SN_cod_retorno            OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno           OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento             OUT NOCOPY ge_errores_pg.Evento

                                        )
/*<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_IN_GA_DET_PRELIQ_PR"
        Lenguaje="PL/SQL"
        Fecha="17-11-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Servicio de negocio para desbloqueo de prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_numventa" Tipo="CARACTER">Numero de Venta</param>
                        <param nom="EV_numabonado" Tipo="CARACTER">Numero de Abonado</param>
                        <param nom="EV_numcelular" Tipo="CARACTER">Numero de Celular</param>
                        <param nom="EV_numserie" Tipo="CARACTER">Numero de Serie</param>
                        <param nom="EV_codarticulo" Tipo="CARACTER">Codigo de articulo</param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error         ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
        CV_unidades NUMBER(1):=1;
BEGIN

                SN_cod_retorno := 0;
                SN_num_evento  := 0;

        sSql:='INSERT INTO ga_det_preliq (num_venta, num_item, num_abonado, num_celular, num_serie_orig, ' ||
        'imp_cargo, imp_cargo_final, cod_articulo) VALUES(' || EV_numventa || ',' || CV_unidades || ','
        || EV_numabonado || ',' || EV_numcelular || ',' || EV_numserie || ',' || EV_impcargo ||
        ',' || EV_impcargofinal || ',' || EV_codarticulo || ')';

        INSERT INTO ga_det_preliq (num_venta, num_item, num_abonado, num_celular, num_serie_orig,
        imp_cargo, imp_cargo_final, cod_articulo,val_dto)
        VALUES(EV_numventa, CV_unidades, EV_numabonado, EV_numcelular, EV_numserie,
        EV_impcargo, EV_impcargofinal, EV_codarticulo,LV_valdcto);

EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others:
                VE_desbloqueaprepago_sms_PG.VE_IN_GA_DET_PRELIQ_PR('||EV_numventa||','||EV_numabonado||','||EV_numcelular||','||EV_numserie||','||EV_codarticulo||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_IN_GA_DET_PRELIQ_PR', sSql, SQLCODE, LV_des_error );
END VE_IN_GA_DET_PRELIQ_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_OBTIENE_RETORNO(
                                EV_numtransac     IN ga_transacabo.num_transaccion%TYPE,
                                SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
                                )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_OBTIENE_RETORNO"
        Lenguaje="PL/SQL"
        Fecha="17-11-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Servicio de negocio para desbloqueo de prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_numtransac"         Tipo="CARACTER">Numero de Transaccion</param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                        <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                        <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error         ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
BEGIN

                SN_cod_retorno := 0;
                SN_num_evento  := 0;

        sSql:='SELECT a.cod_retorno, a.des_cadena FROM ga_transacabo a WHERE  a.num_transaccion=' || EV_numtransac;

        SELECT a.cod_retorno, a.des_cadena
        INTO    SN_cod_retorno, SV_mens_retorno
        FROM    ga_transacabo a
        WHERE  a.num_transaccion=EV_numtransac;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                NULL;
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others:
                VE_desbloqueaprepago_sms_PG.VE_OBTIENE_RETORNO('||EV_numtransac||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_RETORNO', sSql, SQLCODE, LV_des_error );
END VE_OBTIENE_RETORNO;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_OBTIENE_PRECIO_LISTA(
                                        EV_codarticulo  IN al_precios_venta.cod_articulo%TYPE,
                                        EV_tipstock             IN al_precios_venta.tip_stock%TYPE,
                                        EV_coduso                       IN al_precios_venta.cod_uso%TYPE,
                                        EV_codestado            IN al_precios_venta.cod_estado%TYPE,
                                        SV_precioventa  OUT NOCOPY al_precios_venta.prc_venta%TYPE,
                                        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
                                        )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_OBTIENE_PRECIO_LISTA"
        Lenguaje="PL/SQL"
        Fecha="17-11-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Servicio de negocio para desbloqueo de prepago</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_codarticulo" Tipo="CARACTER">C줰igo de articulo</param>
                        <param nom="EV_tipstock"        Tipo="CARACTER">Tipo stock</param>
                        <param nom="EV_coduso"          Tipo="CARACTER">codigo de uso</param>
                        <param nom="EV_codestado"       Tipo="CARACTER">codigo de estado</param>
                </Entrada>
                <Salida>
                        <param nom="SV_precioventa"  Tipo="FECHA">Precio Venta<param>
                        <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                        <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                        <param nom="SN_num_evento"   Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error         ge_errores_pg.DesEvent;
        LV_Cod_Categoria          ged_parametros.val_parametro%TYPE;
        sSql                 ge_errores_pg.vQuery;
        CV_indrecambio            VARCHAR2(1):='9';
BEGIN

                SN_cod_retorno := 0;
                SN_num_evento  := 0;

        SELECT VAL_PARAMETRO
        INTO  LV_Cod_Categoria
        FROM  GED_PARAMETROS
        WHERE nom_parametro = 'TIPO_CATEGORIA'
        AND   cod_modulo = 'GA'
        AND               cod_producto = 1;

        sSql:='SELECT a.prc_venta FROM al_precios_venta a WHERE a.cod_articulo=' || EV_codarticulo ||
        ' AND a.tip_stock=' || EV_tipstock || ' AND a.cod_uso=' || EV_coduso ||
        ' AND a.cod_estado=' || EV_codestado || 'AND IND_RECAMBIO=9 AND SYSDATE BETWEEN fec_desde AND NVL(fec_hasta, SYSDATE)';

        SELECT a.prc_venta
        INTO    SV_precioventa
        FROM   al_precios_venta a
        WHERE  a.cod_articulo=EV_codarticulo
        AND a.tip_stock=EV_tipstock
        AND a.cod_uso=EV_coduso
        AND a.cod_estado=EV_codestado
        AND a.ind_recambio=CV_indrecambio
        AND SYSDATE BETWEEN fec_desde
        AND NVL(fec_hasta, SYSDATE)
        AND a.cod_categoria=LV_Cod_Categoria; --INICIO: XO-200512061026 ; 09/12/2005; USER: JEIM

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=764;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:
                VE_desbloqueaprepago_sms_PG.VE_OBTIENE_PRECIO_LISTA('||EV_codarticulo|| ',' || EV_tipstock || ',' || EV_coduso || ',' || EV_codestado ||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_PRECIO_LISTA', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:
                VE_desbloqueaprepago_sms_PG.VE_OBTIENE_PRECIO_LISTA('||EV_codarticulo|| ',' || EV_tipstock || ',' || EV_coduso || ',' || EV_codestado ||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_PRECIO_LISTA', sSql, SQLCODE, LV_des_error );
END VE_OBTIENE_PRECIO_LISTA;
--------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_CREA_DIRECCIONES(   LN_codvendedor    IN         ve_vendedores.cod_vendedor%TYPE,
                                 LN_codprovincia   IN         ge_direcciones.COD_PROVINCIA%TYPE,
                                 LN_codciudad      IN         ge_direcciones.cod_ciudad%TYPE,
                                 LN_codcomuna      IN         ge_direcciones.COD_COMUNA%TYPE,
                                 LN_nomcalle       IN         ge_direcciones.nom_calle%TYPE,
                                 LN_observacion1   IN         ge_direcciones.OBS_DIRECCION%TYPE,
                                 SN_cod_direccion  OUT NOCOPY ge_direcciones.cod_direccion%TYPE,
                                 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
AS
        LN_COD_PROVINCIA_VE     GE_DIRECCIONES.COD_PROVINCIA%TYPE;
        LN_COD_REGION_VE                GE_DIRECCIONES.COD_REGION%TYPE;
        LN_COD_CIUDAD_VE                GE_DIRECCIONES.COD_CIUDAD%TYPE;
        LN_COD_COMUNA_VE                GE_DIRECCIONES.COD_COMUNA%TYPE;
        LN_CODDIRECCION                 VE_VENDEDORES.COD_DIRECCION%TYPE;
        LN_TIPO_CALLE                   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LN_CALLE                        GE_DIRECCIONES.NOM_CALLE%TYPE;
        LN_OBSERVACION                  GE_DIRECCIONES.OBS_DIRECCION%TYPE;
        LV_des_error                    ge_errores_pg.DesEvent;
        sSql                            ge_errores_pg.vQuery;

BEGIN
                SN_cod_retorno := 0;
                SN_num_evento  := 0;

        SN_cod_direccion:=NULL;
        VE_OBTIENE_SECUENCIA_PR('GE_SEQ_DIRECCIONES',SN_cod_direccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        -- Inicio Mantencion 37992 NRCA si estos valores son nulos se dejar� la direccion por defecto
        IF LN_codprovincia = ' ' OR LN_codciudad =  ' ' OR LN_codcomuna = ' ' OR LN_nomcalle = ' ' OR LN_observacion = ' ' THEN
        -- Fin Mantencion 37992 NRCA
                SELECT COD_PROVINCIA,COD_REGION,COD_CIUDAD,COD_COMUNA,A.COD_DIRECCION
                INTO LN_COD_PROVINCIA_VE,LN_COD_REGION_VE,LN_COD_CIUDAD_VE,LN_COD_COMUNA_VE,LN_CODDIRECCION
                FROM (SELECT COD_DIRECCION
                FROM     VE_VENDEDORES
                WHERE  COD_VENDEDOR=LN_codvendedor) A,
                GE_DIRECCIONES B
                WHERE A.COD_DIRECCION=B.COD_DIRECCION;
/*RESCATA LOS PARAMETROS CON LOS QUE INSERTARA EN LA GE_DIRECCIONES*/
                SELECT VAL_PARAMETRO
                INTO   LN_TIPO_CALLE
                FROM   GED_PARAMETROS
                WHERE  NOM_PARAMETRO='TIPO_CALLE_SMS'
                AND    COD_MODULO='GA'
                AND    COD_PRODUCTO=1;
                ---------------------------------------------------------------------
                SELECT VAL_PARAMETRO
                INTO   LN_CALLE
                FROM   GED_PARAMETROS
                WHERE  NOM_PARAMETRO='CALLE_SMS'
                AND    COD_MODULO='GA'
                AND        COD_PRODUCTO=1;
                ---------------------------------------------------------------------
                SELECT VAL_PARAMETRO
                INTO   LN_OBSERVACION
                FROM   GED_PARAMETROS
                WHERE  NOM_PARAMETRO='OBSERVACION_SMS'
                AND        COD_MODULO='GA'
                AND        COD_PRODUCTO=1;
                ---------------------------------------------------------------------
        ELSE
                -- Inicio Mantencion 37992 NRCA si estos valores son nulos se dejar� la direccion por defecto
                SELECT VAL_PARAMETRO
                INTO   LN_TIPO_CALLE
                FROM   GED_PARAMETROS
                WHERE  NOM_PARAMETRO='TIPO_CALLE_SMS'
                AND    COD_MODULO='GA'
                AND    COD_PRODUCTO=1;

                LN_COD_PROVINCIA_VE:=LN_codprovincia;
                LN_COD_CIUDAD_VE:=LN_codciudad;
                LN_COD_COMUNA_VE:=LN_codcomuna;
                LN_CALLE:=LN_nomcalle;
                LN_OBSERVACION:=LN_observacion1;

--INI INCIDENCIA 176739
--                SELECT COD_REGION
--                INTO LN_COD_REGION_VE
--                FROM GE_PROVINCIAS
--                WHERE COD_PROVINCIA = LN_COD_PROVINCIA_VE
--                AND ROWNUM=1;

                SELECT COD_REGION
                INTO LN_COD_REGION_VE
                FROM GE_COMUNAS
                WHERE COD_COMUNA = LN_COD_COMUNA_VE
                AND ROWNUM=1;
--FIN INCIDENCIA 176739

        END IF;
        -- Fin Mantencion 37992 NRCA

        /*INSERTA EN LA TABLA DE DIRECCIONES*/
        INSERT INTO GE_DIRECCIONES
        (COD_DIRECCION,COD_CIUDAD,COD_PROVINCIA,COD_REGION,ZIP,NOM_CALLE,OBS_DIRECCION,COD_COMUNA)
        VALUES
        (SN_cod_direccion,LN_COD_CIUDAD_VE,LN_COD_PROVINCIA_VE,LN_COD_REGION_VE,LN_TIPO_CALLE,LN_CALLE,LN_OBSERVACION,LN_COD_COMUNA_VE);

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=764;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others:
                VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_ARTICULO('||LN_codvendedor||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_ARTICULO', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others:
                VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_ARTICULO('||LN_codvendedor||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_ARTICULO', sSql, SQLCODE, LV_des_error );
END VE_CREA_DIRECCIONES;
------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_obtiene_precio_consig_PR(EN_importe_final IN OUT ga_det_preliq.imp_cargo_final%TYPE,
                                                                          EN_importe_vta   IN ga_det_preliq.imp_cargo%TYPE,
                                                                          EN_pctje_dcto    IN OUT NOCOPY ga_det_preliq.val_dto%TYPE,
                                              SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
                                                                         )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_obtiene_precio_consignacion_PR"
      Lenguaje="PL/SQL"
      Fecha="06-09-2006"
      Versi줻="1.0"
      Dise풹dor="Roberto P퓊ez"
          Programador="Roberto P퓊ez"
      Ambiente Desarrollo="DEIMOS_COL">
      <Retorno>NA</Retorno>
              <Descripci줻>Aplica descuentos adicionales dependiendo de parametro funcional</Descripci줻>
       <Par퓅etros>
         <Entrada>
                        <param nom="EN_importe_final" Tipo="NUMERICO">Monto al que se le aplican los descuentos</param>

         </Entrada>
         <Salida>
         </Salida>
      </Par퓅etros>
  </Elemento>
</Documentaci줻>
*/

AS
   LV_aplica_dcto_consig ged_parametros.val_parametro%TYPE;
   LN_comision_limite    ged_parametros.val_parametro%TYPE;
   LN_dcto_marginal              ged_parametros.val_parametro%TYPE;
   LV_des_error          ge_errores_pg.DesEvent;
   LN_PctjeDcto                  NUMBER(10);
BEGIN

                SN_cod_retorno := 0;
                SN_num_evento  := 0;

         LV_aplica_dcto_consig:= ge_fn_devvalparam(CV_codmodulo, CN_codprod, CV_Aplic_Preliq);

         IF TRIM(LV_aplica_dcto_consig)='TRUE' THEN

                 LN_dcto_marginal:= ge_fn_devvalparam(CV_codmodulo, CN_codprod, CV_dcto_marginal);
             LN_PctjeDcto:= (EN_importe_final*LN_dcto_marginal)/100;
                 LN_comision_limite:=ge_fn_devvalparam(CV_codmodulo, CN_codprod, CV_comision_lim);

                 IF LN_comision_limite<LN_PctjeDcto THEN
                        EN_importe_final:=EN_importe_final-LN_comision_limite;
                 ELSE
                        EN_importe_final:=EN_importe_final-LN_PctjeDcto;
                 END IF;

         END IF;
EXCEPTION
                 WHEN OTHERS THEN
                          SN_cod_retorno:=156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno:=CV_error_no_clasif;
              END IF;
              LV_des_error:='Others:
                          VE_desbloqueaprepago_sms_PG.VE_obtiene_precio_consig_PR('||EN_importe_final||');- ' || SQLERRM;
              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                          'VE_desbloqueaprepago_sms_PG.VE_obtiene_precio_consig_PR', '', SQLCODE, LV_des_error );
END VE_obtiene_precio_consig_PR;
--------------------------------------------------------------------------------------------------------------
PROCEDURE VE_VER_SUPERA_LIMITE_PR(EN_codcliente       IN ga_aboamist.cod_cliente%TYPE,
                                  EV_cod_tipident     IN VARCHAR2,
                                  EV_num_ident        IN VARCHAR2,
                                  EN_cod_cuenta       IN NUMBER,
                                  SN_vta_excepcionada OUT NOCOPY NUMBER,
                                  SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento       OUT NOCOPY ge_errores_pg.Evento
                                                                  )
/*
<Documentaci줻
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_VER_SUPERA_LIMITE
      Lenguaje="PL/SQL"
      Fecha="
      Versi줻="1.0"
      Dise풹dor=""
          Programador="
      Ambiente Desarrollo="BD">
      <Retorno>0:si no supera el limite. 1:si supera el limite</Retorno>
      <Descripci줻>Verifica control lineas de prepago</Descripci줻>
      <Par퓅etros>
      <Entrada>
      <param nom="EN_codcliente"           Tipo="NUMBER">Codigo de cliente</param>
      </Entrada>
      <Salida>
      <param nom="SN_cod_retorno"      Tipo="NUMERICO">Codigo error de negocio Retornado</param>
      <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje error de negocio Retornado</param>
      <param nom="SN_num_evento"       Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Par퓅etros>
  </Elemento>
</Documentaci줻>
*/
AS

  LN_supera_limite NUMBER;
  LN_tiene_rol     NUMBER;
  LV_des_error     ge_errores_pg.DesEvent;
  sSql             ge_errores_pg.vQuery;
  eSupLim          EXCEPTION;
  LV_cadena        VARCHAR2(500);
BEGIN
                SN_cod_retorno := 0;
                SN_num_evento  := 0;
                SN_vta_excepcionada := 0;

           --verifica si supera el limite de lineas permitidas

           sSql := 'LN_supera_limite := ve_ctrl_lineas_prepago_pg.ve_supera_limite2_fn('||EN_codcliente||','||EV_cod_tipident||','||EV_num_ident||',' || EN_cod_cuenta ||')';
           LV_cadena := ve_ctrl_lineas_prepago_pg.ve_supera_limite2_fn(EN_codcliente,EV_cod_tipident,EV_num_ident,EN_cod_cuenta);
           LN_supera_limite := TO_NUMBER(SUBSTR(LV_cadena,1,1));

           IF LN_supera_limite = 1 THEN--supera limite de lineas permitidas
                  --verifica que el usuario de ivr tenga rol de excepcion

                  --Inc  : 69989 Se modifica consulta para realizar la excepcion por codigo del proceso
                  --Fecha: 01-09-2008
                  --prog : JMC
                    sSql := 'SELECT COUNT(1) '
                                  ||'INTO LN_tiene_rol '
                                  ||'FROM ge_seg_grpusuario a, ge_seg_perfiles b '
                                  ||'WHERE a.cod_grupo = b.cod_grupo '
                                  ||'AND EXISTS (SELECT 1 '
                                  ||'FROM ged_parametros pa '
                                  ||'WHERE pa.val_parametro = b.cod_proceso '
                                  ||'AND pa.nom_parametro = '||CHR(39)||'COD_EXCEPCION'||CHR(39)||' '
                                  ||'AND pa.cod_modulo = '||CHR(39)||'GA'||CHR(39)||' '
                                  ||'AND pa.cod_producto = 1) '
                                  ||'AND gu.nom_usuario = '||CHR(39)||'USER'||CHR(39)||' '
                                  ||'AND ROWNUM <= 1';


                        SELECT COUNT(1)
                        INTO LN_tiene_rol
                        FROM ge_seg_grpusuario a, ge_seg_perfiles b
                        WHERE a.cod_grupo = b.cod_grupo
                        AND EXISTS (SELECT 1
                                          FROM ged_parametros pa
                                             WHERE pa.val_parametro = b.cod_proceso
                                               AND pa.nom_parametro = 'COD_EXCEPCION'
                                                   AND pa.cod_modulo = 'GA'
                                                   AND pa.cod_producto = 1)
                        AND a.nom_usuario = USER
                        AND ROWNUM <= 1;
                  --[Fin] Inc 69989

                        IF LN_tiene_rol = 0 THEN-- no tiene rol de excepcion
                           RAISE eSupLim;--se cancela el desbloqueo
                        ELSE
                           SN_vta_excepcionada := 1;-- se excepciona la venta
                        END IF;
           END IF;
EXCEPTION
        WHEN eSupLim THEN
                        SN_cod_retorno:=1219;
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno:=CV_error_no_clasif;
                        END IF;

                        LV_des_error:='Others:VE_desbloqueaprepago_sms_PG.VE_VER_SUPERA_LIMITE('||EN_codcliente||',null,null,' || EN_cod_cuenta ||');- ' || SQLERRM;
                        SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                        'VE_desbloqueaprepago_sms_PG.VE_VER_SUPERA_LIMITE', sSql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='Others:VE_desbloqueaprepago_sms_PG.VE_VER_SUPERA_LIMITE('||EN_codcliente||',null,null,' || EN_cod_cuenta ||');- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'VE_desbloqueaprepago_sms_PG.VE_VER_SUPERA_LIMITE', sSql, SQLCODE, LV_des_error );
END VE_VER_SUPERA_LIMITE_PR;


----------------------------------------------------------------------------------------------------------
PROCEDURE VE_REG_VENTA_EXCEP_PR(EN_numventa          ga_ventas.num_venta%TYPE,
                                SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
/*
<Documentaci줻
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_REG_VENTA_EXCEP
      Lenguaje="PL/SQL"
      Fecha="
      Versi줻="1.0"
      Dise풹dor=""
      Programador="
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripci줻>Registra la venta excepcionada</Descripci줻>
      <Par퓅etros>
      <Entrada>
      <param nom="EN_numventa"     Tipo="NUMBER">Numero de la venta</param>
      </Entrada>
      <Salida>
      <param nom="SN_cod_retorno"      Tipo="NUMERICO">Codigo error de negocio Retornado</param>
      <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje error de negocio Retornado</param>
      <param nom="SN_num_evento"       Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Par퓅etros>
  </Elemento>
</Documentaci줻>
*/
AS
  LN_transaccion NUMBER;
  LV_des_error   ge_errores_pg.DesEvent;
  LN_error       ga_transacabo.cod_retorno%TYPE := 0;
  sSql           ge_errores_pg.vQuery;
  n_num_celular   ga_aboamist.num_celular%TYPE;
  n_cod_plantarif ga_aboamist.cod_plantarif%TYPE;
  n_abonado       ga_aboamist.num_abonado%TYPE;
  n_cliente       ga_aboamist.cod_cliente%TYPE;
BEGIN
        sSql := 'SELECT ga_seq_transacabo.NEXTVAL INTO LN_transaccion FROM DUAL';

        SELECT ga_seq_transacabo.NEXTVAL
          INTO LN_transaccion
        FROM DUAL;

               sSql:=' SELECT aa.cod_cliente,';
               sSql:=sSql || ' aa.num_abonado,';
               sSql:=sSql || ' aa.cod_plantarif';
               sSql:=sSql || ' FROM ga_aboamist aa';
               sSql:=sSql || ' WHERE aa.num_celular IN (SELECT ga.num_celular FROM ga_aboamist ga';
               sSql:=sSql || ' WHERE ga.num_venta = ' || EN_numventa || ')';
               sSql:=sSql || ' AND ROWNUM <= 1;';

                SELECT aa.cod_cliente,
                           aa.num_abonado,
                           aa.cod_plantarif
                  INTO     n_cliente,
                           n_abonado,
                           n_cod_plantarif
                  FROM ga_aboamist aa
                 WHERE aa.num_celular IN (SELECT ga.num_celular FROM ga_aboamist ga
                                          WHERE ga.num_venta = EN_numventa)
                   AND ROWNUM <= 1;

                INSERT INTO ve_excepcion_vta_prepago_to
                        (cod_excepcion_vta,num_venta,cod_cliente,num_abonado,
                         cod_causa,fecha_venta, nom_usuario,
                         cod_plantarif)
                VALUES
                        (ve_venta_excepcionada_sq.NEXTVAL,EN_numventa, n_cliente,n_abonado,
                         0,SYSDATE,USER,n_cod_plantarif);

EXCEPTION
  WHEN OTHERS THEN
          SN_cod_retorno:=156;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='Others:VE_desbloqueaprepago_sms_PG.VE_REG_VENTA_EXCEP('||EN_numventa||');- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
          'VE_desbloqueaprepago_sms_PG.VE_REG_VENTA_EXCEP', sSql, SQLCODE, LV_des_error );
END VE_REG_VENTA_EXCEP_PR;


----------------------------------------------------------------------------------------------------------------
--JBS
PROCEDURE VE_desbloqueo_PR(                        EN_codvendealer   IN         ve_vendealer.cod_vendealer%TYPE,
                                                   EV_tipident       IN         ge_clientes.cod_tipident%TYPE,
                                                   EV_numident       IN         ge_clientes.num_ident%TYPE,
                                                   EV_icc            IN         ga_aboamist.num_serie%TYPE,
                                                   EV_num_imei       IN         ga_aboamist.num_imei%TYPE,
                                                   EV_nomcliente     IN         ge_clientes.nom_cliente%TYPE,
                                                   EV_apeclien1      IN         ge_clientes.nom_apeclien1%TYPE,
                                                   EV_apeclien2      IN         ge_clientes.nom_apeclien2%TYPE,
                                                   EV_codplantarif   IN         icc_movimiento.plan%TYPE,
                                                   EV_canalvendedor  IN         VARCHAR2,
                                                   EV_indprocequi    IN         CHAR,
                                                   EV_codarticulo    IN         al_articulos.cod_articulo%TYPE,
                                                   EV_NUMTELEFONO    IN         ge_clientes.tef_cliente1%TYPE := 0  ,
                                                   EV_codprovincia   IN         ge_direcciones.COD_PROVINCIA%TYPE := ' ',
                                                   EV_codciudad      IN         ge_direcciones.cod_ciudad%TYPE := ' ',
                                                   EV_codcomuna      IN         ge_direcciones.COD_COMUNA%TYPE := ' ',
                                                   EV_nomcalle       IN         ge_direcciones.nom_calle%TYPE := ' ',
                                                   EV_observacion    IN         ge_direcciones.OBS_DIRECCION%TYPE := ' ',
                                                   EN_desbloq_sms        IN                     NUMBER DEFAULT NULL,
                                                   SN_codcliente     OUT NOCOPY ge_clientes.cod_cliente%TYPE,
                                                   SN_numventa       OUT NOCOPY ga_ventas.num_venta%TYPE,
                                                   SN_numcelular     OUT NOCOPY ga_aboamist.num_celular%TYPE,
                                                   SD_fecalta        OUT NOCOPY ga_aboamist.fec_alta%TYPE,
                                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
                                                   )
/*
<Documentaci줻 TipoDoc = "Procedimiento">
   <Elemento
        Nombre = "VE_desbloqueo_PR"
        Lenguaje="PL/SQL"
        Fecha="30-08-2005"
        Versi줻="1.0"
        Dise풹dor="Rayen Ceballos"
        Programador="Roberto Perez"
        Migraci줻="Jubitza Villanueva G."
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Servicio de negocio para desbloqueo de prepago</Descripci줻>
        <Par퓅etros>
        <Entrada>
                <param nom="EN_codvendealer" Tipo="NUMERICO">C줰igo del vendedor dealer</param>
                <param nom="EV_tipident" Tipo="CARACTER">Tipo identidad del cliente</param>
                <param nom="EV_numident" Tipo="CARACTER">Numero identidad del cliente</param>
                <param nom="EV_icc" Tipo="CARACTER">Numero de la simcard</param>
                <param nom="EV_imei" Tipo="CARACTER">Numero de serie</param>
                <param nom="EV_apeclien1" Tipo="CARACTER">apellido paterno abonado</param>
                <param nom="EV_codplantarif" Tipo="CARACTER">Plan tarifario</param>
                <param nom="EV_canalvendedor" Tipo="CARACTER">Canal del vendedor</param>
                <param nom="EV_indprocequi" Tipo="CARACTER">Indicador de Procedencia del equipo I/E (interna/externa)</param>

                Ingresados por Mantenci줻 37992 NRCA
                <param nom="EV_NUMTELEFONO" Tipo="CARACTER">N즡ero de telefono del Cliente</param>
                <param nom="EV_codprovincia" Tipo="CARACTER">Codigo de Provincia </param>
                <param nom="EV_codciudad" Tipo="CARACTER">Codigo de Ciudad</param>
                <param nom="EV_codcomuna" Tipo="CARACTER"> Codigo de Comuna </param>
                <param nom="EV_nomcalle" Tipo="CARACTER">Nombre de calle</param>
                <param nom="EV_observacion" Tipo="CARACTER">Observaci줻</param>
         </Entrada>
         <Salida>
                <param nom="SN_codcliente"     Tipo="NUMERICO">C줰igo del cliente</param>
                <param nom="SN_numventa"       Tipo="NUMERICO">Nro de la venta</param>
                <param nom="SN_numcelular"     Tipo="NUMERICO">Nro celular</param>
                <param nom="SD_fecalta"        Tipo="FECHA">Fecha de alta del celular<param>
                <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Par퓅etros>
  </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error         ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
        LN_codclientedealer  ve_vendedores.cod_cliente%TYPE;
        LN_codvendedor       ve_vendedores.cod_vendedor%TYPE;
        LN_coddireccion      ve_vendedores.cod_direccion%TYPE;
        LN_coddireccion1     ve_vendedores.cod_direccion%TYPE;
        LN_codcuenta         ga_cuentas.cod_cuenta%TYPE;
        LN_cod_usuario       ga_usuamist.cod_usuario%TYPE;
        LN_numabonado        ga_aboamist.num_abonado%TYPE;
        LV_codtecno          ga_aboamist.cod_tecnologia%TYPE;
        LV_tipterminal       ga_aboamist.tip_terminal%TYPE;
        LV_numseriehex       ga_aboamist.num_seriehex%TYPE;
        LN_codcentral        ga_aboamist.cod_central%TYPE;
        LV_nummin            ga_aboamist.num_min%TYPE;
        LV_indtelefono           ga_aboamist.ind_telefono%TYPE;
        LV_cod_producto      ged_parametros.val_parametro%TYPE;
        LV_val_param         ged_parametros.val_parametro%TYPE;
        LV_stockmerdea           ged_parametros.val_parametro%TYPE;
        LV_stockconsig           ged_parametros.val_parametro%TYPE;
        LV_diasvencconsig        ged_parametros.val_parametro%TYPE;
        LV_valdcto                       ged_parametros.val_parametro%TYPE;
        LV_valdctoCdesc          ged_parametros.val_parametro%TYPE;     -- 36734
        LV_codtipstock           al_series.tip_stock%TYPE;
        LV_codbodega             al_series.cod_bodega%TYPE;
        LV_codarticulo           al_series.cod_articulo%TYPE;
        LV_coduso                        al_series.cod_uso%TYPE;
        LV_codestado             al_series.cod_estado%TYPE;
        LV_codvenderaiz          ve_vendedores.cod_vende_raiz%TYPE;
        LV_importevta            ga_preliquidacion.imp_venta%TYPE;
        LV_importevtaCdesc               ga_preliquidacion.imp_venta%TYPE; -- 36734
        LV_importevta_aux        ga_preliquidacion.imp_venta%TYPE;
        LV_secuencia             VARCHAR(16);
        LV_num_imsi                      gsm_det_simcard_to.val_campo%TYPE;
        LV_modventa                  ge_modventa.cod_modventa%TYPE;
        LV_des_articulo      al_articulos.des_articulo%TYPE;
        LV_ind_equiacc       al_articulos.ind_equiacc%TYPE;
        exception_fin            EXCEPTION;
        error_validacion         EXCEPTION;
        error_no_data_commit EXCEPTION;
        SN_Existe_direccion NUMBER;
        SN_SW_CANCEL_DESBLOQUEO NUMERIC;
        SN_IMEI_ES_PAK NUMBER;
        LN_importefinal NUMBER;
        CV_nom_stockmerdea VARCHAR2(20):='COD_TIPSTOCKDEAL';
        CV_nom_stockconsig VARCHAR2(20):='STOCK_CONSIGNACION';
        CV_nomsecuencia    VARCHAR2(20):='GA_SEQ_TRANSACABO';
        CV_nomdiasconsig   VARCHAR2(20):='DIAS_VENC_CONSIG';
        CV_nomparamdcto    VARCHAR2(20):='DCTO_VTA_CONSIG';
        CV_tipmovsaldef    CHAR:='1'; -- Movimiento de Salida Definitiva
        CV_tipmovreserva   CHAR:='4'; -- Movimiento de Reserva
        CV_indestvtapre    VARCHAR2(2):='VP';
        CV_codmodvta       VARCHAR2(1):='1';
        CV_indvta                  VARCHAR2(1):='V';
        LV_uso_prepago     al_series.cod_uso%TYPE:=3; -- Diego Mej죂s 25/05/2006 CO --200605240159 --
        LN_supera_limite   NUMBER; --P-MIX-06003 control de lineas de prepago
        LN_tiene_rol       NUMBER;  --P-MIX-06003 control de lineas de prepago
        LN_transaccion     NUMBER;  --P-MIX-06003 control de lineas de prepago
        SN_vta_excepcionada NUMBER;  --P-MIX-06003 control de lineas de prepago

BEGIN

        SN_cod_retorno:=0;
        SN_num_evento:=0;

        LN_codclientedealer:=NULL;
        LN_codvendedor:=NULL;
        LN_coddireccion:=NULL;
        LN_codcuenta:=NULL;
           --         SN_codcliente:=NULL;
        LN_numabonado:=NULL;
        LV_codtecno:=NULL;
        LV_tipterminal:=NULL;
        LV_numseriehex:=NULL;
        LN_codcentral:=NULL;
        LV_nummin:=NULL;
        LN_cod_usuario:=NULL;
        LV_val_param:=NULL;
        SN_numcelular:=NULL;
        SN_codcliente:=NULL;
        SN_numventa:=NULL;
        SD_fecalta:=NULL;
        LV_num_imsi:=NULL;

        sSql:='TRIM(UPPER('''||EV_canalvendedor||'''))<>''D'' AND TRIM(UPPER('''||EV_canalvendedor||'''))<>''I''';
        IF TRIM(UPPER(EV_canalvendedor))<>'I' AND  TRIM(UPPER(EV_canalvendedor))<>'D' THEN
                RAISE error_validacion;
        END IF;
        sSql:='TRIM(UPPER('''||EV_indprocequi||'''))<>''E'' AND TRIM(UPPER('''||EV_indprocequi||'''))<>''I''';
        IF TRIM(UPPER(EV_indprocequi))<>'E' AND TRIM(UPPER(EV_indprocequi))<>'I' THEN
                RAISE error_validacion;
        END IF;
        sSql:='VE_OBTIENE_DATOS_DEALER_PR('||EN_codvendealer|| ',' || EV_canalvendedor || ')';
        VE_OBTIENE_DATOS_DEALER_PR(EN_codvendealer, EV_canalvendedor, LN_codclientedealer,LN_codvendedor, LN_coddireccion, LV_codvenderaiz,SN_cod_retorno, SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<>0 THEN
                RAISE exception_fin;
        END IF;
        --sSql:='VE_VALIDA_USO('||LN_codclientedealer||','||EV_icc||','||EV_num_imei||','||EV_indprocequi||')';
        --VE_VALIDA_USO   (LN_codclientedealer,EV_icc,EV_num_imei,EV_indprocequi,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        --IF  SN_cod_retorno<>0 THEN
        --        RAISE exception_fin;
        --END IF;
--INICIO:XO-200510140878 ; USER: JEIM; 17/10/2005
        ncodvendealer:=EN_codvendealer;
        VE_VALIDA_COR_ENTRE_ICC_IMEI(EV_icc,EV_num_imei,SN_SW_CANCEL_DESBLOQUEO,SN_IMEI_ES_PAK,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_SW_CANCEL_DESBLOQUEO = 0 or SN_cod_retorno<>0 THEN
                RAISE exception_fin;
        END IF;
--FIN:XO-200510140878 ; USER: JEIM; 17/10/2005

--INICIO:RA-200601040483; USER: JEIM; FECHA: 9/1/2006
        sSql:='VE_CREA_DIRECCIONES(' || LN_codvendedor || ', ' || LN_coddireccion || ')';
        VE_CREA_DIRECCIONES(LN_codvendedor,EV_codprovincia,EV_codciudad,EV_codcomuna,EV_nomcalle,EV_observacion,LN_coddireccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        --FIN:RA-200601040483; USER: JEIM; FECHA: 9/1/2006
        IF SN_cod_retorno<>0 THEN
                RAISE exception_fin;
        END IF;
        sSql:='VE_OBTIENE_CUENTA_PR('||EV_tipident||','||EV_numident||')';
        VE_OBTIENE_CUENTA_PR(EV_tipident,EV_numident,LN_codcuenta,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<>0 THEN
                RAISE exception_fin;
        END IF;

        sSql:='VE_OBTIENE_CLIENTE_PR('||EV_tipident||','||EV_numident||','||LN_codcuenta||')';
        VE_OBTIENE_CLIENTE_PR(EV_tipident,EV_numident,LN_codcuenta,SN_codcliente,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<>0 THEN
                RAISE exception_fin;
        END IF;

        sSql:='VE_OBTIENENUMABONADO_PR('||LN_codclientedealer||','||EV_icc||')';
        VE_OBTIENENUMABONADO_PR(LN_codclientedealer,EV_icc,LN_numabonado,LV_codtecno,LV_tipterminal,LV_numseriehex,LN_codcentral,SN_numcelular,LV_nummin, LV_indtelefono, SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<>0 THEN
                RAISE exception_fin;
        END IF;

        IF TRIM(LN_codcuenta) IS NULL THEN --Cuenta no existe...
                sSql:='VE_creacuenta_PR('||EV_nomcliente || ',' ||EV_apeclien1||','||EV_apeclien2||','||EV_tipident||','||EV_numident||','||LN_coddireccion||')';
                VE_creacuenta_PR(EV_nomcliente ||' ' ||EV_apeclien1||' '||EV_apeclien2,EV_nomcliente ||' ' ||EV_apeclien1||' '||EV_apeclien2,EV_tipident, EV_numident,LN_coddireccion,LN_codcuenta,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno<>0 THEN
                        RAISE exception_fin;
                END IF;
                sSql:='VE_creacliente_PR('||LN_codcuenta||','||EV_apeclien1||','||EV_tipident||','||EV_numident||')';
                VE_creacliente_PR(LN_codcuenta,EV_nomcliente,EV_tipident,EV_numident, EV_apeclien1, EV_apeclien2,EV_NUMTELEFONO,SN_codcliente,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno<>0 THEN
                        RAISE exception_fin;
                END IF;
                sSql:='VE_crea_cliente_pcom_PR('|| SN_codcliente || ')';
                VE_crea_cliente_pcom_PR(SN_codcliente,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno<>0 THEN
                        RAISE exception_fin;
                END IF;
                sSql:='VE_crea_catimpclientes_PR('|| SN_codcliente || ')';
                VE_crea_catimpclientes_PR(SN_codcliente,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno<>0 THEN
                        RAISE exception_fin;
                END IF;
                sSql:='VE_crea_catributclie_PR('|| SN_codcliente || ')';
                VE_crea_catributclie_PR(SN_codcliente, SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno<>0 THEN
                        RAISE exception_fin;
                END IF;
                sSql:='VE_crea_dircliente_PR(' || SN_codcliente || ', ' || EN_codvendealer || ')';
                VE_crea_dircliente_PR(SN_codcliente, EN_codvendealer, LN_coddireccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno<>0 THEN
                        RAISE exception_fin;
                END IF;

        ELSIF TRIM(LN_codcuenta) IS NOT NULL AND TRIM(SN_codcliente) IS NULL THEN -- Cuenta Existe / Cliente NO Existe
                sSql:='VE_creacliente_PR('||LN_codcuenta||','||EV_apeclien1||','||EV_tipident||','||EV_numident||')';
                VE_creacliente_PR(LN_codcuenta,EV_nomcliente,EV_tipident,EV_numident,EV_apeclien1, EV_apeclien2,EV_NUMTELEFONO,SN_codcliente,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno<>0 THEN
                        RAISE exception_fin;
                END IF;
                sSql:='VE_crea_cliente_pcom_PR('|| SN_codcliente || ')';
                VE_crea_cliente_pcom_PR(SN_codcliente,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno<>0 THEN
                        RAISE exception_fin;
                END IF;
                sSql:='VE_crea_catimpclientes_PR('|| SN_codcliente || ')';
                VE_crea_catimpclientes_PR(SN_codcliente,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno<>0 THEN
                        RAISE exception_fin;
                END IF;
                sSql:='VE_crea_catributclie_PR('|| SN_codcliente || ')';
                VE_crea_catributclie_PR(SN_codcliente,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno<>0 THEN
                        RAISE exception_fin;
                END IF;
                sSql:='VE_crea_dircliente_PR(' || SN_codcliente || ', ' || EN_codvendealer || ')';
                VE_crea_dircliente_PR(SN_codcliente, EN_codvendealer, LN_coddireccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                IF SN_cod_retorno<>0 THEN
                        RAISE exception_fin;
                END IF;
        END IF;
        --P-MIX-06003 control lineas de prepago
        --solo para el caso de desbloqueo por SMS segun parametro.
              --  sSql := 'VE_VER_SUPERA_LIMITE_PR('||SN_codcliente||','||SN_vta_excepcionada||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
              --  VE_VER_SUPERA_LIMITE_PR(SN_codcliente,EV_tipident,EV_numident,LN_codcuenta,SN_vta_excepcionada, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
              --  IF SN_cod_retorno<>0 THEN
              --     RAISE exception_fin;
              --  END IF;
        sSql:='VE_MOD_USUAMIST_PR('||EV_numident||','||EV_tipident||','||EV_apeclien1||','||LN_numabonado||')';
        VE_MOD_USUAMIST_PR(EV_numident,EV_tipident,EV_nomcliente, EV_apeclien1,EV_apeclien2,LN_numabonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<>0 THEN
                RAISE exception_fin;
        END IF;
        sSql:='VE_generaventacero_PR('||LN_numabonado||')';
        VE_generaventacero_PR (LN_numabonado,EN_codvendealer,SN_codcliente,LV_codvenderaiz,SN_numventa,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<>0 THEN
                RAISE exception_fin;
        END IF;

        IF (TRIM(UPPER(EV_indprocequi))='I') THEN
            LV_stockmerdea:=ge_fn_devvalparam(CV_codmodulo, CN_codprod, CV_nom_stockmerdea);
            LV_stockconsig:=ge_fn_devvalparam('AL', CN_codprod, CV_nom_stockconsig);

            VE_OBTIENE_TIPOSTOCK_PR(EV_num_imei, LV_codtipstock, LV_codbodega,LV_codarticulo, LV_coduso, LV_codestado,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
            IF SN_cod_retorno<>0 THEN
               RAISE exception_fin;
            END IF;
                --RA-200601260644  Comienzo

         IF LV_codarticulo IS NOT NULL THEN
               VE_OBTIENE_SECUENCIA_PR(CV_nomsecuencia, LV_secuencia, SN_cod_retorno,SV_mens_retorno, SN_num_evento);
               IF SN_cod_retorno<>0 THEN
                  RAISE exception_fin;
               END IF;
               VE_OBTIENE_DATOS_ARTICULO(LV_codarticulo, EV_indprocequi,LV_des_articulo, LV_ind_equiacc,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
               IF SN_cod_retorno<>0 THEN
                  RAISE exception_fin;
               END IF;

               p_ga_interal(LV_secuencia, CV_tipmovreserva, LV_codtipstock, LV_codbodega,LV_codarticulo, LV_coduso, LV_codestado, SN_numventa, 1,TRIM(EV_num_imei), LV_indtelefono);

               VE_OBTIENE_RETORNO(LV_secuencia, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
               IF SN_cod_retorno <> 0 THEN
                  RAISE exception_fin;
               END IF;
               SN_cod_retorno:=NULL;
               VE_OBTIENE_SECUENCIA_PR(CV_nomsecuencia, LV_secuencia, SN_cod_retorno,SV_mens_retorno, SN_num_evento);
               IF SN_cod_retorno<>0 THEN
                  RAISE exception_fin;
               END IF;
               p_ga_interal(LV_secuencia, CV_tipmovsaldef, LV_codtipstock, LV_codbodega,LV_codarticulo, LV_coduso, LV_codestado, SN_numventa, 1,TRIM(EV_num_imei), LV_indtelefono);
               VE_OBTIENE_RETORNO(LV_secuencia, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
               IF SN_cod_retorno <> 0 THEN
                  RAISE exception_fin;
               END IF;


               IF LV_codtipstock=LV_stockconsig THEN --ES CONSIGNACION
                  LV_diasvencconsig:=ge_fn_devvalparam(CV_codmodulo, CN_codprod, CV_nomdiasconsig);
                  IF LV_diasvencconsig IS NULL THEN
                     LV_diasvencconsig:='0';
                  END IF;
                  VE_OBTIENE_PRECIO_LISTA(LV_codarticulo, LV_codtipstock, LV_coduso,LV_codestado,LV_importevta, SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                  IF SN_cod_retorno<>0 THEN
                     RAISE exception_fin;
                  END IF;
                  LV_valdcto:=ge_fn_devvalparam('VE', CN_codprod, CV_nomparamdcto);
                     IF LV_valdcto IS NULL THEN
                        RAISE exception_fin;
                     END IF;
    --*** Inicio 36734  Mauricio 21-3-2007 **************************************************************************
                    --  Incidencia 39671 31-05-2007
                    --VE_OBTIENE_PRECIO_DESCUENTO('VE',SN_codcliente,LN_numabonado,LV_codarticulo,LV_importevta,
                    --                                                      LV_importevtaCdesc,LV_valdctoCdesc, SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                    --  Fin Incidencia 39671 31-05-2007
                 VE_OBTIENE_PRECIO_DESCUENTO('VP',SN_codcliente,LN_numabonado,LV_codarticulo,LV_importevta,LV_importevtaCdesc,LV_valdctoCdesc, SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                    IF SN_cod_retorno<>0 THEN
                       RAISE exception_fin;
                    END IF;
    --*** Final 36734  Mauricio 21-3-2007 ***************************************************************************
                    VE_IN_GA_PRELIQUIDACION_PR(SN_numventa, LV_codvenderaiz, LN_codvendedor,SN_codcliente, CV_indestvtapre, CV_codmodvta,LV_importevtaCdesc, CV_indvta, LV_diasvencconsig,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                    IF SN_cod_retorno<>0 THEN
                            RAISE exception_fin;
                    END IF;
                    LV_importevta_aux:=LV_importevtaCdesc; --LV_importevta;
                    LN_importefinal:=LV_importevtaCdesc; --V_importevta - ((LV_importevta*LV_valdcto)/100);

                    VE_IN_GA_DET_PRELIQ_PR(SN_numventa, LN_numabonado, SN_numcelular, EV_num_imei,LV_importevtaCdesc, LN_importefinal, LV_valdctoCdesc,LV_codarticulo,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                    IF SN_cod_retorno<>0 THEN
                            RAISE exception_fin;
                    END IF;

               END IF;  -- Es consignaci줻
         END IF;
         ELSE
                sSql:='ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn(USO_PREPAGO,'||CV_codmodulo||','||CN_codprod||')';
                IF (NOT Ve_Recuperaparametros_Sms_Pg.ve_recupera_parametros_fn('USO_PREPAGO',CV_codmodulo,CN_codprod,LV_coduso,SN_cod_retorno,SV_mens_retorno,SN_num_evento))  THEN
                        LV_coduso := LV_uso_prepago;
                END IF;
-- Fin Diego Mej죂s 25/05/2006 CO-200605240159--
        END IF;   -- Procedencia del Equipo


        sSql:='VE_CONS_USUAMIST_PR('||LN_numabonado||','||LN_cod_usuario||')';

        VE_CONS_USUAMIST_PR(LN_numabonado,LN_cod_usuario, SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<>0 THEN
                RAISE exception_fin;
        END IF;
        sSql:='VE_MOD_ABOAMIST_PR('||LN_numabonado||','||LN_cod_usuario||','||SN_codcliente||','|| LN_codcuenta||','||LN_codvendedor||','||LV_codvenderaiz||','||EV_num_imei ||','||SN_numventa||','||EV_codplantarif||')';
        VE_MOD_ABOAMIST_PR(LN_numabonado, LN_cod_usuario, SN_codcliente, LN_codcuenta,LN_codvendedor, LV_codvenderaiz, EV_num_imei, EV_codplantarif, SN_numventa,EN_codvendealer, EV_indprocequi, SN_IMEI_ES_PAK,SN_cod_retorno, SV_mens_retorno,SN_num_evento);

        IF SN_cod_retorno<>0 THEN
                RAISE exception_fin;
        END IF;

        --Se registra la excepcion cuando corresponda
        --p-col-06003 control lineas de prepago
                --IF SN_vta_excepcionada = 1 THEN
                --        sSql := 'VE_REG_VENTA_EXCEP_PR('||SN_numventa||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';

--                        VE_REG_VENTA_EXCEP_PR(SN_numventa,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                        /*IF SN_cod_retorno<>0 THEN
                                RAISE exception_fin;
                        END IF;*/
--                END IF;


        sSql:='ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn('||CV_mod_venta||','||CV_codmodulo||','||CN_codprod||')';
        IF (NOT Ve_Recuperaparametros_Sms_Pg.ve_recupera_parametros_fn(CV_mod_venta,CV_codmodulo,CN_codprod,LV_modventa,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) OR TRIM(LV_modventa) IS NULL  THEN
                RAISE exception_fin;
        END IF;

--INICIO:XO-200510120861 ; USER: JEIM; 13/10/2005
        IF TRIM(EV_num_imei) IS NOT NULL AND SN_IMEI_ES_PAK <> 1 THEN
--FIN:XO-200510120861 ; USER: JEIM; 13/10/2005

                sSql:='VE_UPD_GA_EQUIPABOSER_PR(' || LN_numabonado || ',' || EV_icc || ',' || EV_num_imei || ')';
                VE_UPD_GA_EQUIPABOSER_PR(LN_numabonado, EV_icc, EV_num_imei, SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno<>0 THEN

                        RAISE exception_fin;
                END IF;
                LV_cod_producto:=EV_codarticulo;
                sSql:='ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn('||CV_prod_celular||','||CV_codmodulo||','||CN_codprod||')';

                IF (NOT ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn(CV_prod_celular,CV_codmodulo,CN_codprod,LV_cod_producto,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) OR TRIM(LV_cod_producto) IS NULL  THEN

                        RAISE exception_fin;
                END IF;
--INICIO: XO-200511290995 ; 09/12/2005; USER:JEIM
                LV_tipterminal:='T';
--FIN: XO-200511290995 ; 09/12/2005; USER:JEIM
                sSql:='VE_IN_GA_EQUIPABOSER_PR(' || LN_numabonado    ||',' || EV_num_imei || ',' || LV_cod_producto || ',';
                sSql:=sSql || EV_indprocequi ||','||CV_ind_propiedad ||',' || LV_codbodega || ',' || LV_codtipstock || ',' || EV_codarticulo || ',' ||LV_ind_equiacc ||',' || LV_modventa    ||',' || LV_tipterminal || ',' || LV_coduso ||', NULL,'|| LV_codestado ||', NULL, NULL, NULL,NULL,';
                sSql:=sSql || 'NULL,'|| LV_des_articulo ||', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL';
--INICIO:RA-200601040482; USER:JEIM; FECHA:06/01/2006

                IF TRIM(UPPER(EV_indprocequi))='I' THEN

                        VE_IN_GA_EQUIPABOSER_PR(LN_numabonado, EV_num_imei, LV_cod_producto, EV_indprocequi,SYSDATE, CV_ind_propiedad, LV_codbodega,LV_codtipstock, LV_codarticulo, LV_ind_equiacc,LV_modventa, LV_tipterminal, LV_coduso, NULL, LV_codestado, NULL, NULL, NULL, NULL, NULL, NULL, LV_des_articulo,NULL, LV_secuencia, NULL, NULL, NULL, LV_codtecno, NULL, NULL, NULL, SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                ELSE
                        VE_IN_GA_EQUIPABOSER_PR(LN_numabonado, EV_num_imei, LV_cod_producto, EV_indprocequi,SYSDATE, CV_ind_propiedad, LV_codbodega,LV_codtipstock, EV_codarticulo, LV_ind_equiacc,LV_modventa, LV_tipterminal, LV_coduso, NULL, LV_codestado, NULL, NULL, NULL, NULL, NULL, NULL, LV_des_articulo,NULL, LV_secuencia, NULL, NULL, NULL, LV_codtecno, NULL, NULL, NULL, SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                END IF;
--FIN:RA-200601040482; USER:JEIM; FECHA:06/01/2006
                IF SN_cod_retorno<>0 THEN

                        RAISE exception_fin;
                END IF;
        END IF;


        sSql:='VE_insertamovimiento_PR('||LN_numabonado||','||LV_codtecno||','||LV_tipterminal||','||','||LN_codcentral||','||SN_numcelular||','||EV_codplantarif||','||LV_nummin||')';
        VE_insertamovimiento_PR(LN_numabonado,LV_codtecno,LV_tipterminal, LN_codcentral,SN_numcelular, EV_codplantarif,LV_nummin, EV_icc,EV_num_imei, LV_num_imsi,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF SN_cod_retorno<>0 THEN
                RAISE exception_fin;
        END IF;

        sSql:='ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn('||CV_ejecuta_commit||','||CV_codmodulo||','||CN_codprod||')';
        IF NOT ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn(CV_ejecuta_commit,CV_codmodulo,CN_codprod,LV_val_param,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN

                RAISE error_no_data_commit;
        END IF;

        sSql:='IF LV_val_param=CV_si_ejecuta_commit THEN -- LV_val_param: '||LV_val_param;

        IF LV_val_param=CV_si_ejecuta_commit THEN
                COMMIT;

        END IF;
        sSql:='ve_recuperaparametros_sms_pg.VE_recupera_glosa_FN('||CV_codmodulo||','||CV_nom_tabla||','||CV_nom_columna||')';
        IF NOT ve_recuperaparametros_sms_pg.VE_recupera_glosa_FN(CV_codmodulo,CV_nom_tabla,CV_nom_columna,SV_mens_retorno,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                SN_cod_retorno:=0;
                SV_mens_retorno:=NULL;

        END IF;

        SD_fecalta:=SYSDATE;

EXCEPTION
        WHEN error_validacion THEN
                SN_cod_retorno:=477;--'ERROR_VEND_INTERNO';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='error_validacion: VE_desbloqueaprepago_sms_PG.VE_desbloqueo_PR('||EN_codvendealer||','||EV_tipident||','||EV_numident||','||EV_icc||','||EV_apeclien1||','||EV_codplantarif||','||EV_canalvendedor||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_desbloqueo_PR', sSql, SQLCODE, LV_des_error );
                SV_mens_retorno:=SV_mens_retorno||'.Para mayor detalle ver n즡ero del evento :'||SN_num_evento||' correspondiente a ge_evento_to';
                ROLLBACK;
        WHEN exception_fin THEN
                LV_des_error:='exception_fin: VE_desbloqueaprepago_sms_PG.VE_desbloqueo_PR('||EN_codvendealer||','||EV_tipident||','||EV_numident||','||EV_icc||','||EV_apeclien1||','||EV_codplantarif||','||EV_canalvendedor||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_desbloqueo_PR', sSql, SQLCODE, LV_des_error );
                SV_mens_retorno:=SV_mens_retorno||'.Para mayor detalle ver n즡ero del evento :'||SN_num_evento||' correspondiente a ge_evento_to';
                ROLLBACK;
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='Others: VE_desbloqueaprepago_sms_PG.VE_desbloqueo_PR('||EN_codvendealer||','||EV_tipident||','||EV_numident||','||EV_icc||','||EV_apeclien1||','||EV_codplantarif||','||EV_canalvendedor||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_desbloqueo_PR', sSql, SQLCODE, LV_des_error );
                SV_mens_retorno:=SV_mens_retorno||'Para mayor detalle ver numero del evento :'||SN_num_evento||' que correspondiente ge_evento_to';
                ROLLBACK;
END VE_desbloqueo_PR;
/************************************************************************************************************************************************************************/

PROCEDURE VE_OBTIENE_PRECIO_DESCUENTO(
                                        EV_COD_OPERACION     IN gad_descuentos.COD_OPERACION%TYPE,
                                        EV_COD_CLIENTE            IN ga_aboamist.COD_CLIENTE%TYPE,
                                        EV_NUM_ABONADO            IN ga_aboamist.NUM_ABONADO%TYPE,
                                        EV_COD_ARTICULO      IN gad_descuentos.COD_ARTICULO%TYPE,
                                        EV_PRECIO_VENTA           IN al_precios_venta.prc_venta%TYPE,
                                        SN_PRECIO_VENTA           OUT NOCOPY al_precios_venta.prc_venta%TYPE,
                                        SN_VAL_DESCUENTO          OUT NOCOPY gad_descuentos.VAL_DESCUENTO%TYPE,
                                        SN_cod_retorno            OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento             OUT NOCOPY ge_errores_pg.Evento
                                        )
 /*
<Documentaci줻 TipoDoc = "Procedimiento">
        <Elemento
        Nombre = "VE_OBTIENE_DATOS_DEALER_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi줻="1.0"
        Dise풹dor="Mauricio"
        Programador="Moya"
        Migraci줻="Camus"
        Ambiente Desarrollo="BD">
        <Retorno>NA</Retorno>
        <Descripci줻>Obtener valor del descuento</Descripci줻>
                <Par퓅etros>
                <Entrada>
                        <param nom="EV_COD_OPERACION" Tipo="">C줰igo de operaci줻</param>
                        <param nom="EV_COD_CLIENTE" Tipo="">C줰igo de cliente</param>
                        <param nom="EV_NUM_ABONADO" Tipo="">Numero abonado</param>
                        <param nom="EV_COD_ARTICULO" Tipo="">C줰igo de articulo</param>
                        <param nom="EV_PRC_VENTA" Tipo="">Precio venta</param>
                </Entrada>
                <Salida>
                        <param nom="SN_PRECIO_VENTA"  Tipo="NUMERICO">Precio Venta con descuento<param>
                        <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo error de negocio Retornado</param>
                        <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje error de negocio Retornado</param>
                        <param nom="SN_num_evento"   Tipo="ge_errores_pg.Evento">Nro de evento</param>
                </Salida>
                </Par퓅etros>
        </Elemento>
</Documentaci줻>
*/
AS
        LV_des_error      ge_errores_pg.DesEvent;
        V_CLASE_DESCUENTO                               GAD_DESCUENTOS.CLASE_DESCUENTO%TYPE;
        V_COD_PLANTARIF                                 GA_ABOAMIST.COD_PLANTARIF%TYPE;
        V_COD_TIPCONTRATO                               GA_ABOAMIST.COD_TIPCONTRATO%TYPE;
        V_NUM_MESES                                     GA_PERCONTRATO.NUM_MESES%TYPE;
        V_COD_ANTIGUEDAD                                VARCHAR(2);
        V_COD_VENDEDOR                                  GA_ABOAMIST.COD_VENDEDOR%TYPE;
        V_COD_VENDEALER                                 GA_ABOAMIST.COD_VENDEALER%TYPE;
        V_COD_CAUSA_VENTA                               GA_ABOAMIST.COD_CAUSA_VENTA%TYPE;
        V_COD_MODVENTA                                  GA_ABOAMIST.COD_MODVENTA%TYPE;
        V_IND_VTA_EXTERNA                               VE_TIPCOMIS.IND_VTA_EXTERNA%TYPE;
        V_COD_CATEGORIA                                 VE_CATPLANTARIF.COD_CATEGORIA%TYPE;
        V_COD_TIPLAN                                    TA_PLANTARIF.COD_TIPLAN%TYPE;
        v_tip_descuento                                 gad_descuentos.tip_descuento%type;
        v_cod_moneda                                    gad_descuentos.cod_moneda%type;
        v_val_descuento                                 gad_descuentos.val_descuento%type;
        v_cod_concepto_dscto                    gad_descuentos.cod_concepto_dscto%type;
        V_COD_CONCEPTO                                  AL_ARTICULOS.COD_CONCEPTOART%TYPE;
        error_datos      EXCEPTION;
        NO_DATA_CON_ART  EXCEPTION;

BEGIN
        select COD_CONCEPTOART
        into V_COD_CONCEPTO
        from AL_ARTICULOS
        where COD_ARTICULO = EV_COD_ARTICULO;

        SELECT val_parametro
        INTO V_CLASE_DESCUENTO
        FROM ged_parametros
        WHERE nom_parametro = 'CLASE_DESCUENTO'
        AND cod_modulo = 'GA'
        AND cod_producto = 1;

        SELECT
        A.COD_PLANTARIF,A.COD_TIPCONTRATO,P.NUM_MESES, '01' COD_ANTIGUEDAD,
        A.COD_VENDEDOR,A.COD_VENDEALER,A.COD_CAUSA_VENTA,
        A.COD_MODVENTA, T.IND_VTA_EXTERNA,C.COD_CATEGORIA, F.COD_TIPLAN
        INTO
        V_COD_PLANTARIF, V_COD_TIPCONTRATO,     V_NUM_MESES, V_COD_ANTIGUEDAD,
        V_COD_VENDEDOR, V_COD_VENDEALER, V_COD_CAUSA_VENTA,
        V_COD_MODVENTA, V_IND_VTA_EXTERNA,V_COD_CATEGORIA, V_COD_TIPLAN
        FROM
        GA_ABOAMIST A, GA_PERCONTRATO P,
        VE_TIPCOMIS T, VE_VENDEDORES V,
        VE_CATPLANTARIF C, TA_PLANTARIF F
        WHERE A.NUM_ABONADO = EV_NUM_ABONADO
       -- AND A.COD_CLIENTE = EV_COD_CLIENTE
        AND A.COD_TIPCONTRATO = P.COD_TIPCONTRATO
        AND P.COD_PRODUCTO = 1
        AND A.COD_VENDEDOR = V.COD_VENDEDOR
        AND T.COD_TIPCOMIS = V.COD_TIPCOMIS
        AND A.COD_PLANTARIF = C.COD_PLANTARIF
        AND A.COD_PLANTARIF = F.COD_PLANTARIF;
        -- /*agregado por Marcelo Miranda*/
        IF V_COD_CAUSA_VENTA IS NULL THEN
                   SELECT val_parametro
                INTO  V_COD_CAUSA_VENTA
                FROM  ged_parametros
                WHERE nom_parametro = 'COD_CAUSA_DSCTO_AMI'
                AND cod_modulo = 'GA'
                   AND cod_producto = 1;
        END IF;

        IF V_CLASE_DESCUENTO = 'ART' THEN
                BEGIN
                        SELECT a.tip_descuento, a.cod_moneda, a.val_descuento , a.cod_concepto_dscto
                        INTO v_tip_descuento, v_cod_moneda, v_val_descuento, v_cod_concepto_dscto
                        FROM   gad_descuentos a
                        WHERE  a.cod_operacion       =  EV_COD_OPERACION
                        AND    a.tip_contrato_actual =  V_COD_TIPCONTRATO
                        AND    a.num_meses_actual    =  V_NUM_MESES
                        AND    a.cod_antiguedad      =  V_COD_ANTIGUEDAD
                        AND    a.cod_tipcontrato_nuevo = V_COD_TIPCONTRATO
                        AND    a.num_meses_nuevo       = V_NUM_MESES
                        AND    a.cod_articulo          = EV_COD_ARTICULO
                        AND    sysdate BETWEEN a.fec_desde AND nvl(a.fec_hasta, sysdate)
                        AND    a.clase_descuento       = V_CLASE_DESCUENTO;
                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                            v_val_descuento := 0;
                         --     RAISE NO_DATA_CON_ART;
                END;
        ELSE
                --CON
                BEGIN
                        SELECT a.tip_descuento, a.cod_moneda, a.val_descuento , a.cod_concepto_dscto
                        INTO v_tip_descuento, v_cod_moneda, v_val_descuento, v_cod_concepto_dscto
                        FROM   gad_descuentos a
                        WHERE  a.cod_operacion         = EV_COD_OPERACION
                        AND    a.cod_antiguedad        = V_COD_ANTIGUEDAD
                        AND    a.cod_tipcontrato_nuevo = V_COD_TIPCONTRATO
                        AND    a.num_meses_nuevo       = V_NUM_MESES
                        AND    sysdate  BETWEEN a.fec_desde AND nvl(a.fec_hasta, sysdate)
                        AND    a.ind_vta_externa       = V_IND_VTA_EXTERNA
                        AND    a.cod_causa_dscto       = V_COD_CAUSA_VENTA
                        AND    a.cod_categoria         = V_COD_CATEGORIA
                        AND    a.cod_modventa          = V_COD_MODVENTA
                        AND    a.tip_producto          = V_COD_TIPLAN
                        AND    a.cod_concepto          = V_COD_CONCEPTO
                        AND    a.clase_descuento       = V_CLASE_DESCUENTO;
                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                             v_val_descuento := 0;
                        --      RAISE NO_DATA_CON_ART;
                END;

        END IF;

        SN_VAL_DESCUENTO:=v_val_descuento;
        If v_val_descuento > 0 Then
                If v_tip_descuento = '1' Then
                        SN_PRECIO_VENTA := EV_PRECIO_VENTA - (EV_PRECIO_VENTA * (v_val_descuento / 100));
                Else
                        SN_PRECIO_VENTA := EV_PRECIO_VENTA - v_val_descuento;
                End If;
        else
                SN_PRECIO_VENTA := EV_PRECIO_VENTA;
        End If;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=476;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='no_data_found: VE_desbloqueaprepago_sms_PG.VE_OBTIENE_PRECIO_DESCUENTO('||EV_NUM_ABONADO||')- '||SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_PRECIO_DESCUENTO', '', SQLCODE, LV_des_error );
        WHEN NO_DATA_CON_ART THEN
                SN_cod_retorno:=476; --ERROR_NO_DATA_VENDEALER_1
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='error_datos:VE_desbloqueaprepago_sms_PG.VE_OBTIENE_PRECIO_DESCUENTO('||EV_NUM_ABONADO||')';
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_PRECIO_DESCUENTO', '', SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_OBTIENE_PRECIO_DESCUENTO('||EV_NUM_ABONADO||')- '||SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_PRECIO_DESCUENTO', '', SQLCODE, LV_des_error );

END VE_OBTIENE_PRECIO_DESCUENTO;

/************************************************************************************************************************************************************************/
--Inicio Inc. 175777 - 13/10/2011 - FADL
FUNCTION pv_busca_cliente_vendedor_fn (
    en_cod_vendedor   IN              ve_vendedores.cod_vendedor%TYPE,
    sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
    sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
    sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
)
  /*
  <Documentacion TipoDoc = "Function">
     <Elemento
        Nombre = "pv_busca_cliente_vendedor_fn"
        Fecha modificacion=" "
        Fecha creacion="11/10/2011"
        Programador=Felipe Diaz Lineros
        Dise�ador=""
        Ambiente Desarrollo="BD">
        <Retorno>N/A</Retorno>
        <Descripcion>Busca cliente y vendedor raiz</Descripcion>
        <Parametros>
           <Entrada>
          <param nom="ev_num_desviado" Tipo="VARCHAR2">Numero de desvio</param>
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
RETURN NUMBER
IS
    lv_codigo_vendedor       ve_vendedores.cod_vendedor%TYPE;
    lv_codigo_cliente        ve_vendedores.cod_cliente%TYPE;
    lv_codigo_vendedor_raiz  ve_vendedores.cod_vende_raiz%TYPE;
    sSql                     ge_errores_pg.vQuery;
    LV_des_error         ge_errores_pg.DesEvent;

BEGIN

    sSql := 'SELECT cod_vendedor, cod_cliente, cod_vende_raiz';
    sSql := sSql || 'FROM ve_vendedores';
    sSql := sSql || 'WHERE cod_vendedor = ' || en_cod_vendedor;

    SELECT cod_vendedor, cod_cliente, cod_vende_raiz
    INTO lv_codigo_vendedor, lv_codigo_cliente,lv_codigo_vendedor_raiz
    FROM ve_vendedores
    WHERE cod_vendedor = en_cod_vendedor;

    WHILE lv_codigo_cliente=1
        LOOP

        SELECT cod_vendedor, cod_cliente, cod_vende_raiz
        INTO lv_codigo_vendedor, lv_codigo_cliente,lv_codigo_vendedor_raiz
        FROM ve_vendedores
        WHERE cod_vendedor = lv_codigo_vendedor_raiz;

        END LOOP;

    RETURN lv_codigo_cliente;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
            SN_cod_retorno:=476; --ERROR_NO_DATA_VENDEALER_1
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='no_data_found: VE_desbloqueaprepago_sms_PG.pv_busca_cliente_vendedor_fn('||en_cod_vendedor||')- '||SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.pv_busca_cliente_vendedor_fn', sSql, SQLCODE, LV_des_error );

    WHEN OTHERS THEN
            SN_cod_retorno:=156;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='VE_desbloqueaprepago_sms_PG.pv_busca_cliente_vendedor_fn('||en_cod_vendedor||')- '||SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER, 'VE_desbloqueaprepago_sms_PG.pv_busca_cliente_vendedor_fn', sSql, SQLCODE, LV_des_error );

END pv_busca_cliente_vendedor_fn;
--Fin Inc. 175777 - 13/10/2011 - FADL

END VE_desbloqueaprepago_sms_PG;
/
