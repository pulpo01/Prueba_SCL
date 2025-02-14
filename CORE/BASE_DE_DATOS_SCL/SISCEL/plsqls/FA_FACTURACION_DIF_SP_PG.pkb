CREATE OR REPLACE PACKAGE BODY FA_FACTURACION_DIF_SP_PG IS

GV_des_error                     ge_errores_pg.DesEvent;
GV_sSql                            ge_errores_pg.vQuery;
SALIDA_CON_ERROR        EXCEPTION;

-----------------------------------------------------------------
PROCEDURE FA_UP_FACTURACION_DIF_PR (
        EN_Num_Sec_Det        IN fa_det_facturacion_dif_to.num_sec_detalle_fd%TYPE,
        EN_Cod_CliAsoc        IN  fa_det_facturacion_dif_to.cod_cliente_asoc%TYPE,
        EN_Num_Abonado        IN  fa_det_facturacion_dif_to.num_abonado%TYPE,
        EV_Usuario        IN  fa_det_facturacion_dif_to.usuario%TYPE,
        SN_Cod_Retorno        OUT NOCOPY ge_errores_pg.coderror,
        SV_Mens_Retorno        OUT NOCOPY ge_errores_pg.msgerror,
        SN_Num_Evento        OUT NOCOPY ge_errores_pg.evento)
/*
   <Documentacion TipoDoc = "Procedimiento">
   <Elemento Nombre = "FA_UP_FACTURACION_DIF_PR" Lenguaje="PL/SQL" Fecha="10-10-2007  Version"1.0" Diseñador"****" Programador="Juan Gonzalez C." Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion> Procedimiento para dar de baja registros del detalle de Facturacion Diferenciada </Descripcion>
   <Parametros>
   <Entrada>
       <param nom="EN_Num_Sec_Detc" Tipo="NUMERIC"> Numero Secuencial del Detalle </param>
       <param nom="EN_Cod_CliAsoc" Tipo="NUMERIC"> Codigo de Cliente Asociado </param>
       <param nom="EN_Num_Abonado" Tipo="NUMERIC"> Numero de Abonado </param>
       <param nom="EV_Usuario" Tipo="STRING"> Usuario que invoco el servicio </param>
   </Entrada>
   <Salida>
       <param nom="SN_Cod_Retorno" Tipo="NUMERIC"> Codigo de error de salida </param>
       <param nom="SV_Mens_Retorno" Tipo="STRING"> Mensaje de error de salida </param>
       <param nom="SN_Num_Evento" Tipo="NUMERIC"> Codigo de Evento </param>
   </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
*/
IS
        LD_Fec_Cierre DATE := SYSDATE;

BEGIN
        SN_Cod_Retorno := 0;
        SV_Mens_Retorno := NULL;
        SN_Num_Evento := 0;

        IF TRIM(EN_Num_Sec_Det) IS NULL THEN
                SN_Cod_Retorno := 1585;
                RAISE SALIDA_CON_ERROR;
        END IF;

        IF TRIM(EN_Cod_CliAsoc) IS NULL THEN
                SN_Cod_Retorno := 1580;
                RAISE SALIDA_CON_ERROR;
        END IF;

        IF TRIM(EN_Num_Abonado) IS NULL THEN
                SN_Cod_Retorno := 1583;
                RAISE SALIDA_CON_ERROR;
        END IF;

        IF TRIM(EV_Usuario) IS NULL THEN
                SN_Cod_Retorno := 1586;
                RAISE SALIDA_CON_ERROR;
        END IF;

        GV_sSql := 'UPDATE fa_det_facturacion_dif_to';
        GV_sSql := GV_sSql ||' SET        fec_cierre_registro := '||LD_Fec_Cierre;
        GV_sSql := GV_sSql ||'             usuario := '||EV_Usuario;
        GV_sSql := GV_sSql ||' WHERE  num_sec_detalle_fd := '||EN_Num_Sec_Det;
        GV_sSql := GV_sSql ||' AND      cod_cliente_asoc := '||EN_Cod_CliAsoc;
        GV_sSql := GV_sSql ||' AND      num_abonado := '||EN_Num_Abonado;

        UPDATE fa_det_facturacion_dif_to
        SET        fec_cierre_registro = LD_Fec_Cierre,
                    usuario = EV_Usuario
        WHERE  num_sec_detalle_fd = EN_Num_Sec_Det
        AND      cod_cliente_asoc = EN_Cod_CliAsoc
        AND      num_abonado = EN_Num_Abonado;

EXCEPTION
        WHEN SALIDA_CON_ERROR  THEN
                IF NOT Ge_Errores_Pg.MensajeError( SN_Cod_Retorno, SV_Mens_Retorno ) THEN
                        SV_Mens_Retorno := GV_error_no_clasif;
                END IF;
                GV_des_error := 'FA_UP_FACTURACION_DIF_PR('||SV_Mens_Retorno||')';
                SN_Num_Evento:= Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_UP_FACTURACION_DIF_PR', GV_sSql, SQLCODE, GV_des_error );
        WHEN OTHERS THEN
                SN_Cod_Retorno := -1;
                SV_Mens_Retorno := GV_error_no_clasif||' - '||SQLERRM;
                GV_des_error := 'FA_UP_FACTURACION_DIF_PR('||EN_Num_Sec_Det||','||EN_Cod_CliAsoc||'); - ' || SQLERRM;
                SN_Num_Evento := Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_UP_FACTURACION_DIF_PR', GV_sSql, SQLCODE, GV_des_error );
END FA_UP_FACTURACION_DIF_PR;

-----------------------------------------------------------------
PROCEDURE FA_IN_FACTURACION_DIF_PR (
        EN_Cod_CliContra        IN  fa_enc_facturacion_dif_to.cod_cliente_contra%TYPE,
        ED_Fec_Ingreso        IN  fa_enc_facturacion_dif_to.fec_ingreso_registro%TYPE,
        ED_Fec_Cierre        IN  fa_enc_facturacion_dif_to.fec_cierre_registro%TYPE,
        EN_Cod_Ciclo        IN  fa_enc_facturacion_dif_to.cod_ciclo%TYPE,
        EN_Tip_Operacion        IN  fa_enc_facturacion_dif_to.tip_operacion%TYPE,
        EN_Tip_Modalidad        IN  fa_enc_facturacion_dif_to.tip_modalidad%TYPE,
        EN_Tip_Valor        IN  fa_enc_facturacion_dif_to.tip_valor%TYPE,
        EV_Usuario        IN  fa_enc_facturacion_dif_to.usuario%TYPE,
        SN_Num_Sec_Enc        OUT NOCOPY fa_enc_facturacion_dif_to.num_sec_encabezado_fd%TYPE,
        SN_Cod_Retorno        OUT NOCOPY ge_errores_pg.coderror,
        SV_Mens_Retorno        OUT NOCOPY ge_errores_pg.msgerror,
        SN_Num_Evento        OUT NOCOPY ge_errores_pg.evento)
/*
   <Documentacion TipoDoc = "Procedimiento">
   <Elemento Nombre = "FA_IN_FACTURACION_DIF_PR" Lenguaje="PL/SQL" Fecha="10-10-2007  Version"1.0" Diseñador"****" Programador="Juan Gonzalez C." Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion> Procedimiento para insertar registros en encabezado de Facturacion Diferenciada </Descripcion>
   <Parametros>
   <Entrada>
       <param nom="EN_Cod_CliContra" Tipo="NUMERIC"> Codigo de Cliente Contratante </param>
       <param nom="ED_Fec_Ingreso" Tipo="DATE"> Fecha de ingreso del Registro </param>
       <param nom="ED_Fec_Cierre" Tipo="DATE"> Fecha de Baja del Registro </param>
       <param nom="EN_Cod_Ciclo" Tipo="NUMERIC"> Codigo de Ciclo </param>
       <param nom="EN_Tip_Operacion" Tipo="NUMERIC"> Tipo de Operacion </param>
       <param nom="EN_Tip_Modalidad" Tipo="NUMERIC"> Tipo de Modalidad </param>
       <param nom="EN_Tip_Valor" Tipo="NUMERIC"> Tipo de Valor </param>
       <param nom="EV_Usuario" Tipo="STRING"> Usuario que invoca el servicio </param>
   </Entrada>
   <Salida>
       <param nom="SN_Num_Sec_Enc" Tipo="NUMERIC"> Numero Secuencial del Encabezado </param>
       <param nom="SN_Cod_Retorno" Tipo="NUMERIC"> Codigo de error de salida </param>
       <param nom="SV_Mens_Retorno" Tipo="STRING"> Mensaje de error de salida </param>
       <param nom="SN_Num_Evento" Tipo="NUMERIC"> Codigo de Evento </param>
   </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
*/
IS
        LD_Fec_Ingreso DATE := SYSDATE;
        LD_Fec_Cierre DATE := TO_DATE('31/12/3000','DD/MM/YYYY');
        LN_Tip_Operacion NUMBER := 0;
        LN_Tip_Modalidad NUMBER := 0;
        LN_Tip_Valor NUMBER := 0;

BEGIN
        SN_Cod_Retorno := 0;
        SV_Mens_Retorno := NULL;
        SN_Num_Evento := 0;

        IF TRIM(EN_Cod_CliContra) IS NULL THEN
                SN_Cod_Retorno := 1581;
                RAISE SALIDA_CON_ERROR;
        END IF;

        IF TRIM(ED_Fec_Ingreso) IS NOT NULL THEN
                LD_Fec_Ingreso := ED_Fec_Ingreso;
        END IF;

        IF TRIM(ED_Fec_Cierre) IS NOT NULL THEN
                LD_Fec_Cierre := ED_Fec_Cierre;
        END IF;

        IF TRIM(EN_Cod_Ciclo) IS NULL THEN
                SN_Cod_Retorno := 1579;
                RAISE SALIDA_CON_ERROR;
        END IF;

        IF TRIM(EN_Tip_Operacion) IS NOT NULL THEN
                IF EN_Tip_Operacion <> 0 AND EN_Tip_Operacion <> 1 THEN
                        SN_Cod_Retorno := 1590;
                        RAISE SALIDA_CON_ERROR;
                ELSE
                        LN_Tip_Operacion := EN_Tip_Operacion;
                END IF;
        END IF;

        IF TRIM(EN_Tip_Modalidad) IS NOT NULL THEN
                IF EN_Tip_Modalidad <> 0 AND EN_Tip_Modalidad <> 1 THEN
                        SN_Cod_Retorno := 1589;
                        RAISE SALIDA_CON_ERROR;
                ELSE
                        LN_Tip_Modalidad := EN_Tip_Modalidad;
                END IF;
        END IF;

        IF TRIM(EN_Tip_Valor) IS NOT NULL THEN
                IF EN_Tip_Valor <> 0 AND EN_Tip_Valor <> 1 THEN
                        SN_Cod_Retorno := 1591;
                        RAISE SALIDA_CON_ERROR;
                ELSE
                        LN_Tip_Valor := EN_Tip_Valor;
                END IF;
        END IF;

        IF TRIM(EV_Usuario) IS NULL THEN
                SN_Cod_Retorno := 1586;
                RAISE SALIDA_CON_ERROR;
        END IF;

        GV_sSql := 'SELECT FA_ENFD_SQ.NEXTVAL INTO SN_Num_Sec_Enc FROM DUAL';

        SELECT FA_ENFD_SQ.NEXTVAL INTO SN_Num_Sec_Enc FROM DUAL;

        GV_sSql := 'INSERT INTO FA_ENC_FACTURACION_DIF_TO ( NUM_SEC_ENCABEZADO_FD, COD_CLIENTE_CONTRA,';
        GV_sSql := GV_sSql || ' FEC_INGRESO_REGISTRO, FEC_CIERRE_REGISTRO, COD_CICLO, TIP_OPERACION, TIP_MODALIDAD, TIP_VALOR, USUARIO )';
        GV_sSql := GV_sSql || ' VALUES ( '||SN_Num_Sec_Enc||','||EN_Cod_CliContra||','||ED_Fec_Ingreso||','||ED_Fec_Cierre||',';
        GV_sSql := GV_sSql || EN_Cod_Ciclo||','||EN_Tip_Operacion||','||EN_Tip_Modalidad||','||EN_Tip_Valor||','||EV_Usuario||' )';

        INSERT INTO FA_ENC_FACTURACION_DIF_TO
        (
                NUM_SEC_ENCABEZADO_FD,
                COD_CLIENTE_CONTRA,
                FEC_INGRESO_REGISTRO,
                FEC_CIERRE_REGISTRO,
                COD_CICLO,
                TIP_OPERACION,
                TIP_MODALIDAD,
                TIP_VALOR,
                USUARIO
        )
        VALUES
        (
                SN_Num_Sec_Enc,
                EN_Cod_CliContra,
                LD_Fec_Ingreso,
                LD_Fec_Cierre,
                EN_Cod_Ciclo,
                LN_Tip_Operacion,
                LN_Tip_Modalidad,
                LN_Tip_Valor,
                EV_Usuario
        );

EXCEPTION
        WHEN SALIDA_CON_ERROR  THEN
                IF NOT Ge_Errores_Pg.MensajeError( SN_Cod_Retorno, SV_Mens_Retorno ) THEN
                        SV_Mens_Retorno := GV_error_no_clasif;
                END IF;
                GV_des_error := 'FA_IN_FACTURACION_DIF_PR('||SV_Mens_Retorno||')';
                SN_Num_Evento:= Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_IN_FACTURACION_DIF_PR', GV_sSql, SQLCODE, GV_des_error );
        WHEN OTHERS THEN
                SN_Cod_Retorno := -1;
                SV_Mens_Retorno := GV_error_no_clasif||' - '||SQLERRM;
                GV_des_error := 'FA_IN_FACTURACION_DIF_PR('||SN_Num_Sec_Enc||','||EN_Cod_CliContra||'); - ' || SQLERRM;
                SN_Num_Evento := Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_IN_FACTURACION_DIF_PR', GV_sSql, SQLCODE, GV_des_error );
END FA_IN_FACTURACION_DIF_PR;

-----------------------------------------------------------------
PROCEDURE FA_IN_DET_FACTURACION_DIF_PR (
        EN_Num_Sec_Enc        IN  fa_det_facturacion_dif_to.num_sec_encabezado_fd%TYPE,
        EN_Cod_CliAsoc        IN  fa_det_facturacion_dif_to.cod_cliente_asoc%TYPE,
        EN_Num_Abonado        IN  fa_det_facturacion_dif_to.num_abonado%TYPE,
        EN_Cod_Concep        IN  fa_det_facturacion_dif_to.cod_concepto%TYPE,
        EN_Mto_Concep        IN  fa_det_facturacion_dif_to.mnt_concepto_asoc%TYPE,
        ED_Fec_Ingreso        IN  fa_det_facturacion_dif_to.fec_ingreso_registro%TYPE,
        ED_Fec_Cierre        IN  fa_det_facturacion_dif_to.fec_cierre_registro%TYPE,
        EV_Usuario        IN  fa_det_facturacion_dif_to.usuario%TYPE,
        SN_Num_Sec_Det        OUT NOCOPY fa_det_facturacion_dif_to.num_sec_detalle_fd%TYPE,
        SN_Cod_Retorno        OUT NOCOPY ge_errores_pg.coderror,
        SV_Mens_Retorno        OUT NOCOPY ge_errores_pg.msgerror,
        SN_Num_Evento        OUT NOCOPY ge_errores_pg.evento)
/*
   <Documentacion TipoDoc = "Procedimiento">
   <Elemento Nombre = "FA_IN_DET_FACTURACION_DIF_PR" Lenguaje="PL/SQL" Fecha="10-10-2007  Version"1.0" Diseñador"****" Programador="Juan Gonzalez C." Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion> Procedimiento para insertar registros en detallle de Facturacion Diferenciada </Descripcion>
   <Parametros>
   <Entrada>
       <param nom="EN_Num_Sec_Enc" Tipo="NUMERIC">Numero Secuencial del Encabezado </param>
       <param nom="EN_Cod_CliAsoc" Tipo="NUMERIC"> Codigo de Cliente Asociado </param>
       <param nom="EN_Num_Abonado" Tipo="NUMERIC"> Numero de Abonado </param>
       <param nom="EN_Cod_Concep" Tipo="NUMERIC"> Codigo Concepto Asociado </param>
       <param nom="EN_Mto_Concep" Tipo="NUMERIC"> Monto del Concepto Asociado </param>
       <param nom="ED_Fec_Ingreso" Tipo="DATE"> Fecha de ingreso del Registro </param>
       <param nom="ED_Fec_Cierre" Tipo="DATE"> Fecha de Baja del Registro </param>
       <param nom="EV_Usuario" Tipo="STRING"> Usuario que invoco el servicio </param>
   </Entrada>
   <Salida>
       <param nom="SN_Num_Sec_Det" Tipo="NUMERIC"> Numero Secuencial del Detalle </param>
       <param nom="SN_Cod_Retorno" Tipo="NUMERIC"> Codigo de error de salida </param>
       <param nom="SV_Mens_Retorno" Tipo="STRING"> Mensaje de error de salida </param>
       <param nom="SN_Num_Evento" Tipo="NUMERIC"> Codigo de Evento </param>
   </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
*/
IS
        LD_Fec_Ingreso DATE := SYSDATE;
        LD_Fec_Cierre DATE := TO_DATE('31/12/3000','DD/MM/YYYY');
        LN_Mto_Concep NUMBER := 0;
        LN_Existe_Det NUMBER := 0;

BEGIN
        SN_Cod_Retorno := 0;
        SV_Mens_Retorno := NULL;
        SN_Num_Evento := 0;

        IF TRIM(EN_Num_Sec_Enc) IS NULL THEN
                SN_Cod_Retorno := 1585;
                RAISE SALIDA_CON_ERROR;
        END IF;

        IF TRIM(EN_Cod_CliAsoc) IS NULL THEN
                SN_Cod_Retorno := 1580;
                RAISE SALIDA_CON_ERROR;
        END IF;

        IF TRIM(EN_Num_Abonado) IS NULL THEN
                SN_Cod_Retorno := 1583;
                RAISE SALIDA_CON_ERROR;
        END IF;

        IF TRIM(EN_Cod_Concep) IS NULL THEN
                SN_Cod_Retorno := 1582;
                RAISE SALIDA_CON_ERROR;
        END IF;

        IF TRIM(EN_Mto_Concep) IS NOT NULL THEN
                LN_Mto_Concep := EN_Mto_Concep;
        END IF;

        IF TRIM(ED_Fec_Ingreso) IS NOT NULL THEN
                LD_Fec_Ingreso := ED_Fec_Ingreso;
        END IF;

        IF TRIM(ED_Fec_Cierre) IS NOT NULL THEN
                LD_Fec_Cierre := ED_Fec_Cierre;
        END IF;

        IF TRIM(EV_Usuario) IS NULL THEN
                SN_Cod_Retorno := 1586;
                RAISE SALIDA_CON_ERROR;
        END IF;

        SELECT  COUNT(1)
        INTO    LN_Existe_Det
        FROM   fa_det_facturacion_dif_to
        WHERE num_sec_encabezado_fd = EN_Num_Sec_Enc
        AND     num_abonado = EN_Num_Abonado
        AND     cod_concepto = EN_Cod_Concep
        AND     fec_cierre_registro = TO_DATE('31/12/3000', 'DD/MM/YYYY');

        IF LN_Existe_Det > 0 THEN
                SN_Cod_Retorno := 1592;
                RAISE SALIDA_CON_ERROR;
        END IF;

        GV_sSql := 'SELECT FA_DEFD_SQ.NEXTVAL INTO SN_Num_Sec_Enc FROM DUAL';

        SELECT FA_DEFD_SQ.NEXTVAL INTO SN_Num_Sec_Det FROM DUAL;

        GV_sSql := 'INSERT INTO FA_DET_FACTURACION_DIF_TO ( NUM_SEC_ENCABEZADO_FD, NUM_SEC_DETALLE_FD, COD_CLIENTE_ASOC, NUM_ABONADO, COD_CONCEPTO,';
        GV_sSql := GV_sSql || ' FEC_INGRESO_REGISTRO, FEC_CIERRE_REGISTRO, MNT_CONCEPTO_ASOC, IND_ORDENTOTAL, USUARIO )';
        GV_sSql := GV_sSql || ' VALUES ( '||EN_Num_Sec_Enc||','||SN_Num_Sec_Det||','||EN_Cod_CliAsoc||','||EN_Num_Abonado||','||EN_Cod_Concep||',';
        GV_sSql := GV_sSql || LD_Fec_Ingreso||LD_Fec_Cierre||','||EN_Mto_Concep||', 0,'||EV_Usuario||' )';

        INSERT INTO FA_DET_FACTURACION_DIF_TO
        (
                NUM_SEC_ENCABEZADO_FD,
                NUM_SEC_DETALLE_FD,
                COD_CLIENTE_ASOC,
                NUM_ABONADO,
                COD_CONCEPTO,
                FEC_INGRESO_REGISTRO,
                FEC_CIERRE_REGISTRO,
                MNT_CONCEPTO_ASOC,
                IND_ORDENTOTAL,
                USUARIO
        )
        VALUES
        (
                EN_Num_Sec_Enc,
                SN_Num_Sec_Det,
                EN_Cod_CliAsoc,
                EN_Num_Abonado,
                EN_Cod_Concep,
                LD_Fec_Ingreso,
                LD_Fec_Cierre,
                EN_Mto_Concep,
                0,
                EV_Usuario
        );

EXCEPTION
        WHEN SALIDA_CON_ERROR  THEN
                IF NOT Ge_Errores_Pg.MensajeError( SN_Cod_Retorno, SV_Mens_Retorno ) THEN
                        SV_Mens_Retorno := GV_error_no_clasif;
                END IF;
                GV_des_error := 'FA_IN_DET_FACTURACION_DIF_PR('||SV_Mens_Retorno||')';
                SN_Num_Evento:= Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_IN_DET_FACTURACION_DIF_PR', GV_sSql, SQLCODE, GV_des_error );
        WHEN OTHERS THEN
                SN_Cod_Retorno := -1;
                SV_Mens_Retorno := GV_error_no_clasif||' - '||SQLERRM;
                GV_des_error := 'FA_IN_DET_FACTURACION_DIF_PR(,'||EN_Cod_CliAsoc||','||EN_Num_Abonado||'); - ' || SQLERRM;
                SN_Num_Evento := Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_IN_DET_FACTURACION_DIF_PR', GV_sSql, SQLCODE, GV_des_error );
END FA_IN_DET_FACTURACION_DIF_PR;

-----------------------------------------------------------------
PROCEDURE FA_SEL_INFO_FD_PR (
        EN_Cod_CliContra        IN ge_clientes.cod_cliente%TYPE,
        SC_Info_FD          OUT NOCOPY ref_cursor,
        SN_Cod_Retorno              OUT NOCOPY ge_errores_pg.coderror,
        SV_Mens_Retorno              OUT NOCOPY ge_errores_pg.msgerror,
        SN_Num_Evento              OUT NOCOPY ge_errores_pg.evento)
/*
   <Documentacion TipoDoc = "Procedimiento">
   <Elemento Nombre = "FA_SEL_INFO_FD_PR" Lenguaje="PL/SQL" Fecha="11-10-2007  Version"1.0" Diseñador"****" Programador="Cristian Cortes M." Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion> Procedimiento para obtener los registros de la relacion Cliente Contratante-Clientes Asociados-Abonados </Descripcion>
   <Parametros>
   <Entrada>
       <param nom="EN_Cod_CliContra" Tipo="NUMERIC"> Codigo de Cliente Contratante </param>
   </Entrada>
   <Salida>
       <param nom="SC_Info_FD" Tipo="CURSOR"> Codigo del Cliente Asociado, Nombre del Cliente Asociado, Numero del Abonado, Numero de Celular, Nombre de Usuario,
                                                                        Codigo del Concepto, Descripcion del Concepto, Monto del Concepto, Numero Secuencial del Detalle </param>
       <param nom="SN_Cod_Retorno" Tipo="NUMERIC"> Codigo de error de salida </param>
       <param nom="SV_Mens_Retorno" Tipo="STRING"> Mensaje de error de salida </param>
       <param nom="SN_Num_Evento" Tipo="NUMERIC"> Codigo de Evento </param>
   </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
*/
IS
BEGIN
        SN_Cod_Retorno := 0;
        SV_Mens_Retorno := NULL;

        IF TRIM(EN_Cod_CliContra) IS NULL THEN
                SN_Cod_Retorno := 1581;
                RAISE SALIDA_CON_ERROR;
        END IF;

        GV_sSql := 'SELECT factdifdet.cod_cliente_asoc, clientes.nom_cliente||clientes.nom_apeclien1||clientes.nom_apeclien2 nom_cliente,';
        GV_sSql := GV_sSql || ' factdifdet.num_abonado, abocel.num_celular, usuarios.nom_usuario||usuarios.nom_apellido1||usuarios.nom_apellido2 nom_usuario,';
        GV_sSql := GV_sSql || ' factdifdet.cod_concepto, conceptos.des_concepto, factdifdet.mnt_concepto_asoc, factdifdet.num_sec_detalle_fd numsec';
        GV_sSql := GV_sSql || ' FROM fa_enc_facturacion_dif_to factdifenc, fa_det_facturacion_dif_to factdifdet, ge_clientes clientes, ga_abocel abocel, ga_usuarios usuarios,';
        GV_sSql := GV_sSql || ' fa_conceptos conceptos';
        GV_sSql := GV_sSql || ' WHERE factdifenc.cod_cliente_contra = ' || EN_Cod_CliContra;
        GV_sSql := GV_sSql || ' AND factdifdet.cod_cliente_asoc = clientes.cod_cliente';
        GV_sSql := GV_sSql || ' AND factdifdet.num_sec_encabezado_fd = factdifenc.num_sec_encabezado_fd';
        GV_sSql := GV_sSql || ' AND factdifdet.num_abonado = abocel.num_abonado';
        GV_sSql := GV_sSql || ' AND (factdifdet.fec_cierre_registro = TO_DATE('''||'31/12/3000'||''''||','||''''||'DD/MM/YYYY'||''') OR factdifdet.fec_cierre_registro IS NULL)';
        GV_sSql := GV_sSql || ' AND abocel.cod_usuario = usuarios.cod_usuario';
        GV_sSql := GV_sSql || ' AND factdifdet.cod_concepto = conceptos.cod_concepto';
        GV_sSql := GV_sSql || ' ORDER BY factdifdet.num_sec_detalle_fd';

        OPEN SC_Info_FD  FOR
                SELECT  factdifdet.cod_cliente_asoc, clientes.nom_cliente||' '||clientes.nom_apeclien1||' '||clientes.nom_apeclien2 nom_cliente,
                            factdifdet.num_abonado, abocel.num_celular, usuarios.nom_usuario||' '||usuarios.nom_apellido1||' '||usuarios.nom_apellido2 nom_usuario,
                            factdifdet.cod_concepto, conceptos.des_concepto, factdifdet.mnt_concepto_asoc, factdifdet.num_sec_detalle_fd numsec
                FROM   fa_enc_facturacion_dif_to factdifenc, fa_det_facturacion_dif_to factdifdet, ge_clientes clientes, ga_abocel abocel, ga_usuarios usuarios,
                            fa_conceptos conceptos
                WHERE factdifenc.cod_cliente_contra = EN_Cod_CliContra
                AND     factdifdet.cod_cliente_asoc = clientes.cod_cliente
                AND     factdifdet.num_sec_encabezado_fd = factdifenc.num_sec_encabezado_fd
                AND     factdifdet.num_abonado = abocel.num_abonado
                AND    (factdifdet.fec_cierre_registro = TO_DATE('31/12/3000','DD/MM/YYYY') OR factdifdet.fec_cierre_registro IS NULL)
                AND     abocel.cod_usuario = usuarios.cod_usuario
                AND     factdifdet.cod_concepto = conceptos.cod_concepto
                ORDER BY factdifdet.num_sec_detalle_fd;

EXCEPTION
        WHEN SALIDA_CON_ERROR  THEN
                IF NOT Ge_Errores_Pg.MensajeError( SN_Cod_Retorno, SV_Mens_Retorno ) THEN
                        SV_Mens_Retorno := GV_error_no_clasif;
                END IF;
                GV_des_error := 'FA_SEL_INFO_FD_PR('||SV_Mens_Retorno||')';
                SN_Num_Evento:= Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_SEL_INFO_FD_PR', GV_sSql, SQLCODE, GV_des_error );
        WHEN OTHERS THEN
                SN_Cod_Retorno := -1;
                SV_Mens_Retorno := GV_error_no_clasif||' - '||SQLERRM;
                GV_des_error := 'FA_SEL_INFO_FD_PR('||EN_Cod_CliContra||'); - ' || SQLERRM;
                SN_Num_Evento := Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_SEL_INFO_FD_PR', GV_sSql, SQLCODE, GV_des_error );
END FA_SEL_INFO_FD_PR;

-----------------------------------------------------------------
PROCEDURE FA_SEL_CLI_CONTRATA_PR (
        EN_Cod_CliContra        IN ge_clientes.cod_cliente%TYPE,
        SV_Nom_Cliente        OUT NOCOPY ge_clientes.nom_cliente%TYPE,
        SV_Cod_Tipident          OUT NOCOPY ge_clientes.cod_tipident%TYPE,
        SV_Num_Ident          OUT NOCOPY ge_clientes.num_ident%TYPE,
        SN_Cod_Cuenta          OUT NOCOPY ge_clientes.cod_cuenta%TYPE,
        SV_Nom_Apeclien1      OUT NOCOPY ge_clientes.nom_apeclien1%TYPE,
        SV_Nom_Apeclien2      OUT NOCOPY ge_clientes.nom_apeclien2%TYPE,
        SN_Cod_Ciclo          OUT NOCOPY ge_clientes.cod_ciclo%TYPE,
        SN_Num_Sec_Enc        OUT NOCOPY fa_enc_facturacion_dif_to.num_sec_encabezado_fd%TYPE,
        SN_Tip_Valor        OUT NOCOPY fa_enc_facturacion_dif_to.tip_valor%TYPE,
        SN_Cod_Retorno        OUT NOCOPY ge_errores_pg.coderror,
        SV_Mens_Retorno       OUT NOCOPY ge_errores_pg.msgerror,
        SN_Num_Evento         OUT NOCOPY ge_errores_pg.evento)
/*
   <Documentacion TipoDoc = "Procedimiento">
   <Elemento Nombre = "FA_SEL_CLI_CONTRATA_PR" Lenguaje="PL/SQL" Fecha="11-10-2007  Version"1.0" Diseñador"****" Programador="Cristian Cortes M." Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion> Procedimiento para obtener informacion del Cliente Contratante </Descripcion>
   <Parametros>
   <Entrada>
       <param nom="EN_Cod_CliContra" Tipo="NUMERIC"> Codigo del Cliente Contratante </param>
   </Entrada>
   <Salida>
       <param nom="SV_Nom_Cliente" Tipo="STRING"> Nombre del Cliente </param>
       <param nom="SV_Cod_Tipident" Tipo="STRING"> Tipo de Identificador del Cliente </param>
       <param nom="SV_Num_Ident" Tipo="STRING"> Numero de Identificador del Cliente </param>
       <param nom="SN_Cod_Cuenta" Tipo="NUMERIC"> Codigo de Cuenta del Cliente </param>
       <param nom="SV_Nom_Apeclien1" Tipo="STRING"> Apellido 1 del Cliente </param>
       <param nom="SV_Nom_Apeclien2" Tipo="STRING"> Apellido 2 del Cliente </param>
       <param nom="SN_Cod_Ciclo" Tipo="NUMERIC"> Codigo de Ciclo </param>
       <param nom="SN_Num_Sec_Enc" Tipo="NUMERIC"> Numero Secuencial del Encabezado </param>
       <param nom="SN_Cod_Retorno" Tipo="NUMERIC"> Codigo de error de salida </param>
       <param nom="SV_Mens_Retorno" Tipo="STRING"> Mensaje de error de salida </param>
       <param nom="SN_Num_Evento" Tipo="NUMERIC"> Codigo de Evento </param>
   </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
*/
IS
        LN_Cat_Cliente NUMBER := 0;
        LN_Cli_Contrat NUMBER := 0;
        LN_Cli_Moroso NUMBER := 0;

BEGIN
        SN_Cod_Retorno := 0;
        SV_Mens_Retorno := NULL;
        SN_Num_Evento := 0;

        IF TRIM(EN_Cod_CliContra) IS NULL THEN
                SN_Cod_Retorno := 1581;
                RAISE SALIDA_CON_ERROR;
        END IF;

        GV_sSql := 'SELECT UNIQUE a.nom_cliente, a.cod_tipident, a.num_ident, a.cod_cuenta, a.nom_apeclien1, a.nom_apeclien2, a.cod_ciclo, a.cod_categoria,';
        GV_sSql := GV_sSql || ' NVL(d.num_sec_encabezado_fd, 0), NVL(d.tip_valor, 0)';
        GV_sSql := GV_sSql || ' FROM ge_clientes a, fa_parametros_multiples_vw b, fa_enc_facturacion_dif_to d';
        GV_sSql := GV_sSql || ' WHERE a.od_cliente = ' || EN_Cod_CliContra;
        GV_sSql := GV_sSql || ' AND b.nom_parametro = ''' || GV_CatDobleCliCont || '''';
        GV_sSql := GV_sSql || ' AND b.valor_numerico = a.cod_categoria';
        GV_sSql := GV_sSql || ' AND d.cod_cliente_contra (+) = a.cod_cliente';

        BEGIN
                SELECT  UNIQUE a.nom_cliente, a.cod_tipident, a.num_ident, a.cod_cuenta, a.nom_apeclien1, a.nom_apeclien2, a.cod_ciclo, a.cod_categoria,
                            NVL(d.num_sec_encabezado_fd, 0), NVL(d.tip_valor, 0)
                INTO    SV_Nom_Cliente, SV_Cod_Tipident, SV_Num_Ident, SN_Cod_Cuenta, SV_Nom_Apeclien1, SV_Nom_Apeclien2, SN_Cod_Ciclo, LN_Cat_Cliente,
                            SN_Num_Sec_Enc, SN_Tip_Valor
                FROM   ge_clientes a, fa_enc_facturacion_dif_to d
                WHERE a.cod_cliente = EN_Cod_CliContra
                AND     d.cod_cliente_contra (+) = a.cod_cliente;

        EXCEPTION
                WHEN NO_DATA_FOUND  THEN
                        SN_Cod_Retorno := 1247; -- 'Cliente no existe' --
                        RAISE SALIDA_CON_ERROR;
        END;

        GV_sSql := 'SELECT  COUNT(1) ';       
        GV_sSql := GV_sSql || ' FROM   FA_PARAMETROS_MULTIPLES_VW b ';
        GV_sSql := GV_sSql || ' WHERE   b.nom_parametro = ''' || GV_CatDobleCliCont || '''';
        GV_sSql := GV_sSql || ' AND     b.valor_numerico = ''' || LN_Cat_Cliente || '''';

        SELECT  COUNT(1)
        INTO    LN_Cli_Contrat
        FROM    FA_PARAMETROS_MULTIPLES_VW b
        WHERE   b.nom_parametro = GV_CatDobleCliCont
        AND     b.valor_numerico = LN_Cat_Cliente;


        IF LN_Cli_Contrat = 0 THEN
                SN_Cod_Retorno := 1649; -- 'Categoria del Cliente no asociada a Clientes Contratantes.' --
                RAISE SALIDA_CON_ERROR;
        END IF;

        --INI|PAN-71377|07-10-2008|DVG
        /*SELECT  COUNT(1)
        INTO    LN_Cli_Moroso
        FROM   co_morosos c
        WHERE c.cod_cliente = EN_Cod_CliContra;

        IF LN_Cli_Moroso > 0 THEN
                SN_Cod_Retorno := 466; -- 'Cliente se encuentra moroso' --
                RAISE SALIDA_CON_ERROR;
        END IF;*/
        --FIN|PAN-71377|07-10-2008|DVG

EXCEPTION
        WHEN SALIDA_CON_ERROR  THEN
                IF NOT Ge_Errores_Pg.MensajeError( SN_Cod_Retorno, SV_Mens_Retorno ) THEN
                        SV_Mens_Retorno := GV_error_no_clasif;
                END IF;
                GV_des_error := 'FA_SEL_CLI_CONTRATA_PR('||SV_Mens_Retorno||')';
                SN_Num_Evento:= Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_SEL_CLI_CONTRATA_PR', GV_sSql, SQLCODE, GV_des_error );
        WHEN OTHERS THEN
                SN_Cod_Retorno := -1;
                SV_Mens_Retorno := GV_error_no_clasif||' - '||SQLERRM;
                GV_des_error := 'FA_SEL_CLI_CONTRATA_PR(,'||EN_Cod_CliContra||'); - ' || SQLERRM;
                SN_Num_Evento := Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_SEL_CLI_CONTRATA_PR', GV_sSql, SQLCODE, GV_des_error );
END FA_SEL_CLI_CONTRATA_PR;

-----------------------------------------------------------------
PROCEDURE FA_SEL_CONCEPTOS_PR (
    SC_Conceptos          OUT NOCOPY ref_cursor,
    SN_Cod_Retorno              OUT NOCOPY ge_errores_pg.coderror,
    SV_Mens_Retorno              OUT NOCOPY ge_errores_pg.msgerror,
    SN_Num_Evento              OUT NOCOPY ge_errores_pg.evento)
/*
   <Documentacion TipoDoc = "Procedimiento">
   <Elemento Nombre = "FA_SEL_CONCEPTOS_PR" Lenguaje="PL/SQL" Fecha="11-10-2007  Version"1.0" Diseñador"****" Programador="Cristian Cortes M." Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion> Procedimiento para obtener Conceptos Asociados que se puedan seleccionar en la Facturacion Diferenciada </Descripcion>
   <Parametros>
   <Entrada>
   </Entrada>
   <Salida>
       <param nom="SC_Conceptos" Tipo="CURSOR"> Codigo del Concepto, Descripcion del Concepto </param>
       <param nom="SN_Cod_Retorno" Tipo="NUMERIC"> Codigo de error de salida </param>
       <param nom="SV_Mens_Retorno" Tipo="STRING"> Mensaje de Error de Salida </param>
       <param nom="SN_Num_Evento" Tipo="NUMERIC"> Codigo de Evento </param>
   </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
*/
IS
BEGIN
        SN_Cod_Retorno := 0;
        SV_Mens_Retorno := NULL;
        SN_Num_Evento := 0;

        GV_sSql := 'SELECT rel_conceptos.cod_concepto_orig, conceptos.des_concepto';
        GV_sSql := GV_sSql || ' FROM fa_corig_cdesc_cdest_td rel_conceptos , fa_conceptos conceptos';
        GV_sSql := GV_sSql || ' WHERE rel_conceptos.cod_concepto_orig = conceptos.cod_concepto';
        GV_sSql := GV_sSql || ' AND rel_conceptos.ind_activo = ''' || GV_ind_activo || '''';

        OPEN SC_Conceptos  FOR
                SELECT rel_conceptos.cod_concepto_orig, conceptos.des_concepto
                FROM fa_corig_cdesc_cdest_td rel_conceptos , fa_conceptos conceptos
                WHERE rel_conceptos.cod_concepto_orig = conceptos.cod_concepto
                AND rel_conceptos.ind_activo = GV_ind_activo;

EXCEPTION
        WHEN SALIDA_CON_ERROR  THEN
                IF NOT Ge_Errores_Pg.MensajeError( SN_Cod_Retorno, SV_Mens_Retorno ) THEN
                        SV_Mens_Retorno := GV_error_no_clasif;
                END IF;
                GV_des_error := 'FA_SEL_CONCEPTOS_PR('||SV_Mens_Retorno||')';
                SN_Num_Evento:= Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_SEL_CONCEPTOS_PR', GV_sSql, SQLCODE, GV_des_error );
        WHEN OTHERS THEN
                SN_Cod_Retorno := -1;
                SV_Mens_Retorno := GV_error_no_clasif||' - '||SQLERRM;
                GV_des_error := 'FA_SEL_CONCEPTOS_PR(); - ' || SQLERRM;
                SN_Num_Evento := Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_SEL_CONCEPTOS_PR', GV_sSql, SQLCODE, GV_des_error );
END FA_SEL_CONCEPTOS_PR;

-----------------------------------------------------------------
PROCEDURE FA_SEL_CLIENTES_PR (
        EN_cod_cliente        IN ge_clientes.cod_cliente%TYPE,
        EV_num_ident          IN ge_clientes.num_ident%TYPE,
        EV_nom_cliente        IN ge_clientes.nom_cliente%TYPE,
        EV_nom_apeclien1      IN ge_clientes.nom_apeclien1%TYPE,
        EV_nom_apeclien2      IN ge_clientes.nom_apeclien2%TYPE,
        EN_cod_ciclo          IN ge_clientes.cod_ciclo%TYPE,
        SC_Clientes          OUT NOCOPY ref_cursor,
        SN_Cod_Retorno              OUT NOCOPY ge_errores_pg.coderror,
        SV_Mens_Retorno              OUT NOCOPY ge_errores_pg.msgerror,
        SN_Num_Evento              OUT NOCOPY ge_errores_pg.evento)
/*
   <Documentacion TipoDoc = "Procedimiento">
   <Elemento Nombre = "FA_SEL_CLIENTES_PR" Lenguaje="PL/SQL" Fecha="10-10-2007  Version"1.0" Diseñador"****" Programador="Juan Gonzalez C." Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion> Procedimiento para obtener Clientes Asociados segun criterio de busqueda </Descripcion>
   <Parametros>
   <Entrada>
       <param nom="EN_cod_cliente" Tipo="NUMERIC"> Codigo de Cliente Contratante </param>
       <param nom="EV_num_ident" Tipo="STRING"> Identificador del Cliente </param>
       <param nom="EV_nom_cliente" Tipo="STRING"> Nombre del Cliente </param>
       <param nom="EV_nom_apeclien1" Tipo="STRING"> Apellido 1 del Cliente </param>
       <param nom="EV_nom_apeclien2" Tipo="STRING"> Apellido 2 del Cliente </param>
       <param nom="EN_Cod_Ciclo" Tipo="NUMERIC"> Codigo de Ciclo </param>
   </Entrada>
   <Salida>
       <param nom="SC_Clientes" Tipo="CURSOR"> Codigo del Cliente, Identificador del Cliente, Nombre del Cliente, Apellidos del Cliente </param>
       <param nom="SN_Cod_Retorno" Tipo="NUMERIC"> Codigo de Error de Salida </param>
       <param nom="SV_Mens_Retorno" Tipo="STRING"> Mensaje de Error de Salida </param>
       <param nom="SN_Num_Evento" Tipo="NUMERIC"> Codigo de Evento </param>
   </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
*/
IS
        LN_Cod_Ciclo NUMBER := 0;
        LN_Cat_Cliente NUMBER := 0;
        LN_Cli_Asoc NUMBER := 0;
        LN_Cli_Moroso NUMBER := 0;

BEGIN
        SN_Cod_Retorno := 0;
        SV_Mens_Retorno := NULL;
        SN_Num_Evento := 0;

        IF TRIM(EN_cod_ciclo) IS NULL THEN
                SN_Cod_Retorno := 1579;
                RAISE SALIDA_CON_ERROR;
        END IF;

        IF EN_cod_cliente IS NOT NULL THEN
                BEGIN
                        SELECT  a.cod_ciclo, a.cod_categoria
                        INTO    LN_Cod_Ciclo, LN_Cat_Cliente
                        FROM   ge_clientes a
                        WHERE a.cod_cliente = EN_cod_cliente;

                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                SN_Cod_Retorno := 1247; -- 'Cliente no existe' --
                                RAISE SALIDA_CON_ERROR;
                END;

                SELECT  COUNT(1)
                INTO    LN_Cli_Asoc
                FROM   FA_PARAMETROS_MULTIPLES_VW b
                WHERE b.nom_parametro = GV_CatDobleCliAsoc
                AND     b.valor_numerico = LN_Cat_Cliente;

                IF LN_Cli_Asoc = 0 THEN
                        SN_Cod_Retorno := 1650; -- 'Categoria del Cliente no asociada a Clientes Asociados.' --
                        RAISE SALIDA_CON_ERROR;
                END IF;

                IF LN_Cod_Ciclo <> EN_cod_ciclo THEN
                        SN_Cod_Retorno := 1651; -- 'Cliente no pertenece al mismo Ciclo del Cliente Contratante' --
                        RAISE SALIDA_CON_ERROR;
                END IF;

                --INI|PAN-71377|07-10-2008|DVG
                /*SELECT  COUNT(1)
                INTO    LN_Cli_Moroso
                FROM   co_morosos c
                WHERE c.cod_cliente = EN_cod_cliente;

                IF LN_Cli_Moroso > 0 THEN
                        SN_Cod_Retorno := 466; -- 'Cliente se encuentra moroso' --
                        RAISE SALIDA_CON_ERROR;
                END IF;*/
                --FIN|PAN-71377|07-10-2008|DVG
        END IF;

        GV_sSql := 'SELECT UNIQUE a.cod_cliente, a.num_ident, a.nom_cliente, a.nom_apeclien1, a.nom_apeclien2';
        GV_sSql := GV_sSql || ' FROM ge_clientes a, fa_parametros_multiples_vw b';
        GV_sSql := GV_sSql || ' WHERE a.cod_ciclo = ' || EN_cod_ciclo;

        IF EN_cod_cliente IS NOT NULL THEN
                GV_sSql := GV_sSql || ' AND a.cod_cliente = ' || EN_cod_cliente;
        END IF;

        IF EV_num_ident IS NOT NULL THEN
                GV_sSql := GV_sSql || ' AND TRIM(a.num_ident) = ''' || TRIM(EV_num_ident) || '''';
        END IF;

        IF EV_nom_cliente IS NOT NULL THEN
                GV_sSql := GV_sSql || ' AND TRIM(a.nom_cliente) = ''' || TRIM(EV_nom_cliente) || '''';
        END IF;

        IF EV_nom_apeclien1 IS NOT NULL THEN
                GV_sSql := GV_sSql || ' AND TRIM(a.nom_apeclien1) = ''' || TRIM(EV_nom_apeclien1) || '''';
        END IF;

        IF EV_nom_apeclien2 IS NOT NULL THEN
                GV_sSql := GV_sSql || ' AND TRIM(a.nom_apeclien2) = ''' || TRIM(EV_nom_apeclien2) || '''';
        END IF;

        GV_sSql := GV_sSql || ' AND b.nom_parametro = ''' || GV_CatDobleCliAsoc || '''';
        GV_sSql := GV_sSql || ' AND b.valor_numerico = a.cod_categoria';

        --GV_sSql := GV_sSql || ' AND NOT EXISTS ( SELECT c.cod_cliente FROM co_morosos c WHERE c.cod_cliente = a.cod_cliente )';   PAN-71377|07-10-2008|DVG

        OPEN SC_Clientes  FOR GV_sSql;

EXCEPTION
        WHEN SALIDA_CON_ERROR  THEN
                
                IF SN_cod_retorno=1651 THEN 
                   SV_Mens_Retorno :='Cliente no pertenece al mismo Ciclo del Cliente Contratante';
                ELSE
                   IF NOT Ge_Errores_Pg.MensajeError( SN_Cod_Retorno, SV_Mens_Retorno ) THEN
                          SV_Mens_Retorno := GV_error_no_clasif;
                   END IF;
                END IF;   
                GV_des_error := 'FA_SEL_CLIENTES_PR('||SV_Mens_Retorno||')';
                SN_Num_Evento:= Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_SEL_CLIENTES_PR', GV_sSql, SQLCODE, GV_des_error );
        WHEN OTHERS THEN
                SN_Cod_Retorno := -1;
                SV_Mens_Retorno := GV_error_no_clasif||' - '||SQLERRM;
                GV_des_error := 'FA_SEL_CLIENTES_PR('||EN_cod_ciclo||', '||EN_cod_cliente||', '||EV_num_ident||', '||EV_nom_cliente||', '||'); - ' || SQLERRM;
                SN_Num_Evento := Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_SEL_CLIENTES_PR', GV_sSql, SQLCODE, GV_des_error );
END FA_SEL_CLIENTES_PR;

-----------------------------------------------------------------
PROCEDURE FA_SEL_ABONADOS_PR (
        EN_cod_cliente        IN ga_abocel.cod_cliente%TYPE,
        EN_num_celular        IN ga_abocel.num_celular%TYPE,
        SC_Abonados          OUT NOCOPY ref_cursor,
        SN_Cod_Retorno              OUT NOCOPY ge_errores_pg.coderror,
        SV_Mens_Retorno              OUT NOCOPY ge_errores_pg.msgerror,
        SN_Num_Evento              OUT NOCOPY ge_errores_pg.evento)
/*
   <Documentacion TipoDoc = "Procedimiento">
   <Elemento Nombre = "FA_SEL_ABONADOS_PR" Lenguaje="PL/SQL" Fecha="17-10-2007  Version"1.0" Diseñador"****" Programador="Juan Gonzalez C." Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion> Procedimiento para obtener informacion de Abonados segun Codigo de Cliente y Numero de Celular </Descripcion>
   <Parametros>
   <Entrada>
       <param nom="EN_cod_cliente" Tipo="NUMERIC"> Codigo del Cliente </param>
       <param nom="EN_num_celular" Tipo="NUMERIC"> Numero de Celular </param>
   </Entrada>
   <Salida>
       <param nom="SC_Abonados" Tipo="CURSOR"> Codigo del Abonado, Nombre del Abonado, Apellidos del Abonado, Numero de Celular, Numero de Abonado </param>
       <param nom="SN_Cod_Retorno" Tipo="NUMERIC"> Codigo de Error de Salida </param>
       <param nom="SV_Mens_Retorno" Tipo="STRING"> Mensaje de Error de Salida </param>
       <param nom="SN_Num_Evento" Tipo="NUMERIC"> Codigo de Evento </param>
   </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
*/
IS
BEGIN
        SN_Cod_Retorno := 0;
        SV_Mens_Retorno := NULL;
        SN_Num_Evento := 0;

        IF TRIM(EN_cod_cliente) IS NULL THEN
                SN_Cod_Retorno := 1581;
                RAISE SALIDA_CON_ERROR;
        END IF;

        GV_sSql := 'SELECT  b.cod_usuario, b.nom_usuario, b.nom_apellido1, b.nom_apellido2, a.num_celular, a.num_abonado';
        GV_sSql := GV_sSql || ' FROM   ga_abocel a, ga_usuarios b';
        GV_sSql := GV_sSql || ' WHERE a.cod_cliente = ' || EN_cod_cliente;

        IF TRIM(EN_num_celular) IS NOT NULL THEN
                GV_sSql := GV_sSql || ' AND     a.num_celular = ' || EN_num_celular;
        END IF;

        GV_sSql := GV_sSql || ' AND     a.cod_situacion = ''' || GV_Alta || '''';
        GV_sSql := GV_sSql || ' AND     a.cod_usuario = b.cod_usuario';

        OPEN SC_Abonados FOR GV_sSql;

EXCEPTION
        WHEN SALIDA_CON_ERROR  THEN
                IF NOT Ge_Errores_Pg.MensajeError( SN_Cod_Retorno, SV_Mens_Retorno ) THEN
                        SV_Mens_Retorno := GV_error_no_clasif;
                END IF;
                GV_des_error := 'FA_SEL_ABONADOS_PR('||SV_Mens_Retorno||')';
                SN_Num_Evento:= Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_SEL_ABONADOS_PR', GV_sSql, SQLCODE, GV_des_error );
        WHEN OTHERS THEN
                SN_Cod_Retorno := -1;
                SV_Mens_Retorno := GV_error_no_clasif||' - '||SQLERRM;
                GV_des_error := 'FA_SEL_ABONADOS_PR('||EN_num_celular||'); - ' || SQLERRM;
                SN_Num_Evento := Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_SEL_ABONADOS_PR', GV_sSql, SQLCODE, GV_des_error );
END FA_SEL_ABONADOS_PR;

-----------------------------------------------------------------
PROCEDURE FA_UP_FACTURACION_DIF_M_PR (
        EN_Num_Sec_Enc        IN fa_enc_facturacion_dif_to.num_sec_encabezado_fd%TYPE,
        EV_Usuario        IN  fa_enc_facturacion_dif_to.usuario%TYPE,
        SN_Cod_Retorno        OUT NOCOPY ge_errores_pg.coderror,
        SV_Mens_Retorno        OUT NOCOPY ge_errores_pg.msgerror,
        SN_Num_Evento        OUT NOCOPY ge_errores_pg.evento)
/*
   <Documentacion TipoDoc = "Procedimiento">
   <Elemento Nombre = "FA_UP_FACTURACION_DIF_M_PR" Lenguaje="PL/SQL" Fecha="27-11-2007  Version"1.0" Diseñador"****" Programador="Juan Gonzalez C." Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion> Procedimiento para reallizar Baja Masiva por Cliente Contratante, para Detalle y Cabecera de Facturacion Diferenciada </Descripcion>
   <Parametros>
   <Entrada>
       <param nom="EN_Num_Sec_Encc" Tipo="NUMERIC"> Numero Secuencial del Encabezado </param>
       <param nom="EV_Usuario" Tipo="STRING"> Usuario que invoco el servicio </param>
   </Entrada>
   <Salida>
       <param nom="SN_Cod_Retorno" Tipo="NUMERIC"> Codigo de error de salida </param>
       <param nom="SV_Mens_Retorno" Tipo="STRING"> Mensaje de error de salida </param>
       <param nom="SN_Num_Evento" Tipo="NUMERIC"> Codigo de Evento </param>
   </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
*/
IS
        LD_Fec_Cierre DATE := SYSDATE;

BEGIN
        SN_Cod_Retorno := 0;
        SV_Mens_Retorno := NULL;
        SN_Num_Evento := 0;

        IF TRIM(EN_Num_Sec_Enc) IS NULL THEN
                SN_Cod_Retorno := 1585;
                RAISE SALIDA_CON_ERROR;
        END IF;

        IF TRIM(EV_Usuario) IS NULL THEN
                SN_Cod_Retorno := 1586;
                RAISE SALIDA_CON_ERROR;
        END IF;

        -- Dando de baja el detalle --
        GV_sSql := 'UPDATE fa_det_facturacion_dif_to';
        GV_sSql := GV_sSql ||' SET        fec_cierre_registro := '||LD_Fec_Cierre;
        GV_sSql := GV_sSql ||'             usuario := '||EV_Usuario;
        GV_sSql := GV_sSql ||' WHERE  num_sec_encabezado_fd := '||EN_Num_Sec_Enc;

        UPDATE fa_det_facturacion_dif_to
        SET        fec_cierre_registro = LD_Fec_Cierre,
                    usuario = EV_Usuario
        WHERE  num_sec_encabezado_fd = EN_Num_Sec_Enc;

        -- Dando de baja la cabecera --
        GV_sSql := 'UPDATE fa_enc_facturacion_dif_to';
        GV_sSql := GV_sSql ||' SET        fec_cierre_registro := '||LD_Fec_Cierre;
        GV_sSql := GV_sSql ||'             usuario := '||EV_Usuario;
        GV_sSql := GV_sSql ||' WHERE  num_sec_encabezado_fd := '||EN_Num_Sec_Enc;

        UPDATE fa_enc_facturacion_dif_to
        SET        fec_cierre_registro = LD_Fec_Cierre,
                    usuario = EV_Usuario
        WHERE  num_sec_encabezado_fd = EN_Num_Sec_Enc;

EXCEPTION
        WHEN SALIDA_CON_ERROR  THEN
                IF NOT Ge_Errores_Pg.MensajeError( SN_Cod_Retorno, SV_Mens_Retorno ) THEN
                        SV_Mens_Retorno := GV_error_no_clasif;
                END IF;
                GV_des_error := 'FA_UP_FACTURACION_DIF_M_PR('||SV_Mens_Retorno||')';
                SN_Num_Evento:= Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_UP_FACTURACION_DIF_M_PR', GV_sSql, SQLCODE, GV_des_error );
        WHEN OTHERS THEN
                SN_Cod_Retorno := -1;
                SV_Mens_Retorno := GV_error_no_clasif||' - '||SQLERRM;
                GV_des_error := 'FA_UP_FACTURACION_DIF_M_PR('||EN_Num_Sec_Enc||'); - ' || SQLERRM;
                SN_Num_Evento := Ge_Errores_Pg.Grabarpl( SN_Num_Evento, GV_cod_modulo, SV_Mens_Retorno, '1.0', USER, 'FA_FACTURACION_DIF_SP_PG.FA_UP_FACTURACION_DIF_M_PR', GV_sSql, SQLCODE, GV_des_error );
END FA_UP_FACTURACION_DIF_M_PR;

END FA_FACTURACION_DIF_SP_PG;
/
SHOW ERRORS