CREATE OR REPLACE PACKAGE VE_DESBLOQUEAPREPAGO_SMS_FS_PG
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "VE_DESBLOQUEAPREPAGO_SMS_FS_PG"
    Lenguaje="PL/SQL"
    Fecha="30-08-2005"
    Versión="1.0"
    Diseñador="Rayen Ceballos"
        Programador="Roberto Perez"
    Migración="Jubitza Villanueva G."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Mascara para desbloqueo de prepago</Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS
  CV_version                CONSTANT  VARCHAR2(10):='1.0';
  CV_error_no_clasif        CONSTANT  VARCHAR2(30):='Error no clasificado';
  CV_servicio               CONSTANT  VARCHAR2(10):='ECUCOL_005';
  CV_plataforma             CONSTANT  VARCHAR2(10):='WEB';
  TYPE refcursor IS REF CURSOR;
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
                                                                                  EV_codarticulo    IN             al_articulos.cod_articulo%TYPE,
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
                                                                                  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_VALIDA_PLANTARIFARIO_PR(EV_codplantarif  IN         ta_plantarif.cod_plantarif%TYPE,
                                     SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE);
-----------------------------------------------------------------------------------------------------------------
END VE_DESBLOQUEAPREPAGO_SMS_FS_PG;
/
SHOW ERRORS
