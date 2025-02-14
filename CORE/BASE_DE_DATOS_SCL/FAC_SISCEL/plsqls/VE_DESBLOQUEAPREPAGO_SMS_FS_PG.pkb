CREATE OR REPLACE PACKAGE BODY VE_DESBLOQUEAPREPAGO_SMS_FS_PG
IS

SN_cod_retornoau   ge_errores_pg.CodError;
SV_mens_retornoau  ge_errores_pg.MsgError;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_DESBLOQUEAPREPAGO_SMS_FS_PR (EN_codvendealer   IN         ve_vendealer.cod_vendealer%TYPE,
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
                                          EV_codarticulo    IN                  al_articulos.cod_articulo%TYPE,
                                          EV_NUMTELEFONO    IN         ge_clientes.tef_cliente1%TYPE := 0  ,
                                          EV_codprovincia   IN         ge_direcciones.COD_PROVINCIA%TYPE := ' ',
                                          EV_codciudad      IN         ge_direcciones.cod_ciudad%TYPE := ' ',
                                          EV_codcomuna      IN         ge_direcciones.COD_COMUNA%TYPE := ' ',
                                          EV_nomcalle       IN         ge_direcciones.nom_calle%TYPE := ' ',
                                          EV_observacion    IN         ge_direcciones.OBS_DIRECCION%TYPE := ' ',
                                          SN_codcliente     OUT NOCOPY ge_clientes.cod_cliente%TYPE,
                                          SN_numventa       OUT NOCOPY ga_ventas.num_venta%TYPE,
                                          SN_numcelular     OUT NOCOPY ga_aboamist.num_celular%TYPE,
                                          SD_fecalta        OUT NOCOPY ga_aboamist.fec_alta%TYPE,
                                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError)
AS
/*
<Documentaci¢n
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_DESBLOQUEAPREPAGO_SMS_FS_PR"
      Lenguaje="PL/SQL"
      Fecha="30-08-2005"
      Versi¢n="1.0"
      Dise¤ador="Rayen Ceballos"
          Programador="Roberto Perez"
      Migraci¢n="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripci¢n>Mascara para desbloqueo de prepago</Descripci¢n>
       <Par metros>
         <Entrada>
                        <param nom="EN_codvendealer" Tipo="NUMERICO">C¢digo del vendedor dealer</param>
                        <param nom="EV_tipident" Tipo="CARACTER">Tipo identidad del cliente</param>
                        <param nom="EV_numident" Tipo="CARACTER">Numero identidad del cliente</param>
                        <param nom="EV_icc" Tipo="CARACTER">Numero de la simcard</param>
                        <param nom="EV_imei" Tipo="CARACTER">Numero de serie</param>
                        <param nom="EV_apeclien1" Tipo="CARACTER">apellido paterno abonado</param>
                        <param nom="EV_codplantarif" Tipo="CARACTER">Plan tarifario</param>
                        <param nom="EV_canalvendedor" Tipo="CARACTER">Canal del vendedor</param>
         </Entrada>
         <Salida>
            <param nom="SN_codcliente"     Tipo="NUMERICO">C¢digo del cliente</param>
            <param nom="SN_numventa"       Tipo="NUMERICO">Nro de la venta</param>
            <param nom="SN_numcelular"     Tipo="NUMERICO">Nro celular</param>
            <param nom="SD_fecalta"        Tipo="FECHA">Fecha de alta del celular<param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
         </Salida>
      </Par metros>
  </Elemento>
</Documentaci¢n>
*/
    SN_num_evento     ge_errores_pg.Evento;
    LV_parametros_in  ge_auditoria_to.parametros_in%TYPE;
    ERR_AGAUDITORIA    EXCEPTION;
    ERR_MOAUDITORIA    EXCEPTION;
    nsNEvento          ge_errores_pg.Evento;
    SN_cod_retornoau   ge_errores_pg.coderror;
    SV_mens_retornoau  ge_errores_pg.msgerror;
    SN_num_eventoau    ge_errores_pg.Evento;
    SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
        LV_val_param       ged_parametros.val_parametro%TYPE;

        CV_codmodulo         CONSTANT VARCHAR2(2):='GA';
        CV_ejecuta_commit    CONSTANT ged_parametros.nom_parametro%TYPE:='EJEC_COMMIT_DESBLSMS';
        CN_codprod               CONSTANT NUMBER(1):=1;
    CV_si_ejecuta_commit CONSTANT ged_parametros.nom_parametro%TYPE:='SI';
        EN_desbloq_sms           NUMBER:= 1;

BEGIN

    LV_parametros_in := 'codvendealer = '|| EN_codvendealer || ',tipident = '|| EV_tipident;
    LV_parametros_in := LV_parametros_in || ',numident    = ' || EV_numident || ',icc         =  '|| EV_icc;
    LV_parametros_in := LV_parametros_in || ',num_imei    = ' || EV_num_imei || ',nomcliente  =  '|| EV_nomcliente;
    LV_parametros_in := LV_parametros_in || ',apeclien1   = ' || EV_apeclien1  || ',apeclien2   = ' || EV_apeclien2;
    LV_parametros_in := LV_parametros_in || ',codplantarif = '|| EV_codplantarif || ',canalvendedor = '|| EV_canalvendedor;
    LV_parametros_in := LV_parametros_in || ',indprocequi   = '|| EV_indprocequi;





    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, LV_parametros_in , CV_plataforma, CV_servicio, NULL,SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

        IF SN_cod_retornoau IS NULL THEN
       ve_desbloqueaprepago_sms_pg.ve_desbloqueo_pr(EN_codvendealer,
                                                    EV_tipident,
                                                    EV_numident,
                                                    EV_icc,
                                                    EV_num_imei,
                                                    EV_nomcliente,
                                                    EV_apeclien1,
                                                    EV_apeclien2,
                                                    EV_codplantarif,
                                                    EV_canalvendedor,
                                                    EV_indprocequi,
                                                    EV_codarticulo,
                                                    EV_NUMTELEFONO,
                                                    EV_codprovincia,
                                                    EV_codciudad,
                                                    EV_codcomuna,
                                                    EV_nomcalle,
                                                    EV_observacion,
                                                                EN_desbloq_sms,
                                                    SN_codcliente,
                                                    SN_numventa,
                                                    SN_numcelular,
                                                    SD_fecalta,
                                                    SN_cod_retorno,
                                                    SV_mens_retorno,
                                                    nsNEvento);

            ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;

                IF LV_val_param=CV_si_ejecuta_commit THEN
                   COMMIT;
                END IF;

    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

    EXCEPTION

        WHEN ERR_AGAUDITORIA THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;

        WHEN ERR_MOAUDITORIA  THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;
END VE_DESBLOQUEAPREPAGO_SMS_FS_PR;
-----------------------------------------------------------------------------------------------------------------
PROCEDURE VE_VALIDA_PLANTARIFARIO_PR(EV_codplantarif  IN         ta_plantarif.cod_plantarif%TYPE,
                                     SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE)
AS
/*
<Documentaci¢n TipoDoc = "procedure">
 <Elemento Nombre = "ve_valida_plantarifario_pr"
           Lenguaje="PL/SQL"
           Fecha="11-11-2005"
           Versi¢n="1.0.0"
           Dise¤ador="Vladimir Maureira"
           Programador="Vladimir Maureira"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA/Retorno>
   <Descripci¢n> Validacion plan tarifario /Descripci¢n>
    <Par metros>
     <Entrada>
      <param nom="EV_codplantarif" Tipo="STRING">Codigo del plan tarifario</param>
     </Entrada>
     <Salida>
      <param nom="SN_cod_retorno" Tipo="NUMBER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno" Tipo="STRING">Mensaje de Retorno</param>
     </Salida>
    </Par metros>
 </Elemento>
</Documentaci¢n>
*/
    ERR_AGAUDITORIA    EXCEPTION;
    ERR_MOAUDITORIA    EXCEPTION;
    nsNEvento          ge_errores_pg.Evento;
    SN_cod_retornoau   ge_errores_pg.coderror;
    SV_mens_retornoau  ge_errores_pg.msgerror;
    SN_num_eventoau    ge_errores_pg.Evento;
    SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
BEGIN

    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL,'cod_plantarif =' || EV_codplantarif , 'WEB', 'ECUCOL_007', NULL,
SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

    IF SN_cod_retornoau IS NULL THEN
       ve_desbloqueaprepago_sms_pg.ve_existe_plantarif_pr(EV_codplantarif,SN_cod_retorno, SV_mens_retorno, nsNEvento);
       ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', nsNEvento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau,
SN_num_eventoau);

       IF SN_cod_retornoau IS NOT NULL THEN
          RAISE ERR_MOAUDITORIA;
       END IF;

    ELSE
       RAISE ERR_AGAUDITORIA;
    END IF;

    EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END VE_VALIDA_PLANTARIFARIO_PR;
-----------------------------------------------------------------------------------------------------------------

END VE_DESBLOQUEAPREPAGO_SMS_FS_PG;
/
SHOW ERRORS
